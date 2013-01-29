var settings = require("./settings").settings,
    utils = require("./utils"),
    db = require("./worker_db");

// Get stat command:
//   111111
//   111111,222222,333333
//   111111=MS-1
//   111111=MS-1,222222=MS-1=1,333333=LTRAKTOR
// Custom commands:
//   0,WN=nick
//   0,TWR=nick
exports.processRequest = function(request, response) {
    var url = require("url");
    var times = [ { "n": "start", "t": new Date() } ];

    try {
        var query = url.parse(request.url).query;
        if (!query || !query.match(/^((\d)|(\d[\dA-Za-z_\-,=/]*))$/))
            throw "query match error: " + query;

        if (query == "001" || query == "test") {
            response.end('{"players":[{"id":1,"status":"ok"}],"server":"' + settings.serverName + '"}');
            return;
        }

        var qarr = query.split(",");
        if (qarr[0] == "0") {
            qarr.shift();
            require("./worker_cmd").processCommand(response, qarr);
            return;
        }

        processStatRequest(qarr, response, times);
    } catch(e) {
        response.statusCode = 403; // Forbidden
        var errText = "wrong request: " + e;
        if(request.url.toLowerCase() != "/favicon.ico")
            errText += ", url=" + request.url;
        response.end(errText + "\nserver=" + settings.serverName);
        return;
    }
}

// PRIVATE

var processStatRequest = function(qarr, response, times)
{
    var rq = parseStatRequest(qarr);

    process.send({ usage: 1, requests: 1, players: rq.ids.length });

    db.getPlayersData(rq.ids, function(error, db_data) { return onPlayersData(error, db_data, rq.data, response, times); });
}

var getStatServers = function(id) {
    var serverId = Math.floor(id / 500000000);
    if (serverId < 0 || serverId >= settings.statServers.length)
        return null;
    var servers = settings.statServers[serverId];
    if (!servers || servers.length == 0)
        return null;
    var res = [ ];
    for (var i in servers) {
        var srv = settings.servers[servers[i]];
        srv.id = servers[i];
        res.push(srv);
    }
    return res;
}

var parseStatRequest = function(qarr)
{
    var ids = [ ];
    var data = { };
    qarr.forEach(function(a) {
        var x = a.split("=");
        var id = parseInt(x[0]);

        // Skip wrong id and non-working servers
        var servers = getStatServers(id);
        if (servers) {
            ids.push(id);
            data[id] = { vname: x[1] ? x[1].toUpperCase() : null, servers: servers };
            if(x[2] == "1" && settings.updateUsers == true)
                db.updateUsers(id);
        } else {
            data[id] = { vname: x[1] ? x[1].toUpperCase() : null, status: "bad_id" };
        }
    });
    return { ids: ids, data: data };
}

// response from db
var onPlayersData = function(error, db_data, rq_data, response, times) {
    if (error) {
//        response.statusCode = error.statusCode;
        response.end('{"error":"' + error.text + '","server":"' + settings.serverName + '"}');
        //utils.log(error.text);
        return;
    }

    try {
        var now = new Date();
        times.push({"n":"find","t":now});

        for (var i in db_data) {
            var item = db_data[i];
            var pdata = rq_data[item._id];

            // Filter vehicle data
            item.vname = pdata.vname;
            item.v = utils.filterVehicleData(item, pdata.vname);

            // check expire date
            if ((now - item.dt) < settings.cacheTtl) {
                item.st = "cache";
                // remove cached item from request
                delete rq_data[item._id];
            } else {
                item.st = "expired";
                rq_data[item._id].cache = item;
                delete db_data[i];
            }
        }

        // process items with bad id
        for (var i in rq_data) {
            var pdata = rq_data[i];
            if (pdata.status == "bad_id") {
                db_data.push({_id:i,st:pdata.status});
                delete rq_data[i];
            }
        }

        //response.end("DEBUG:\nupdate: " + JSON.stringify(rq_data) + "\ncache: " + JSON.stringify(db_data)); return;

        // db_data - cached items
        // rq_data - items for update from statistics host
        require("./worker_get").processRemotes(db_data, rq_data, response, times);
    } catch(e) {
//        response.statusCode = 500;
        response.end('{"error":"' + e + '","server":"' + settings.serverName + '"}');
        utils.log("Error: " + e);
    }
}
