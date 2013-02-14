module.exports = (function() {
    var includer = require("./includer"),
        settings = includer.settings(),
        utils = includer.utils(),
        db = includer.db(),
        url = includer.url(),
        worker_cmd = includer.cmd(),
        worker_get = includer.get(),
        tcalc = includer.tcalc();

    // Get stat command:
    //   111111
    //   111111,222222,333333
    //   111111=MS-1
    //   111111=MS-1,222222=MS-1=1,333333=LTRAKTOR
    // Custom commands:
    //   0,WN=nick
    //   0,TWR=nick
    var processRequest = function(request, response) {
        var times = [
            { "n": "start", "t": new Date() }
        ];

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
                worker_cmd.processCommand(response, qarr);
                return;
            }
            _processStatRequest(qarr, response, times);
        } catch(e) {
            response.statusCode = 403; // Forbidden
            var errText = "wrong request: " + e;
            if(request.url.toLowerCase() != "/favicon.ico")
                errText += ", url=" + request.url;
            response.end(errText + "\nserver=" + settings.serverName);
            return;
        }
    };

    // PRIVATE

    var _processStatRequest = function(qarr, response, times) {
        var rq = _parseStatRequest(qarr);

        process.send({ usage: 1, requests: 1, players: rq.ids.length });

        db.getPlayersData(rq.ids, function(error, db_data) {
            var processData = {
                dbData: db_data,
                rqData: rq.data,
                response: response,
                times: times
            };

            return _onPlayersData(error, processData);
        });
    };

    var _getStatServers = function(id) {
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
    };

    var _parseStatRequest = function(qarr) {
        var ids = [ ];
        var data = { };
        qarr.forEach(function(a) {
            var x = a.split("=");
            var id = parseInt(x[0]);

            // Skip wrong id and non-working servers
            var servers = _getStatServers(id);
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
    };

    var _fixData = function(data) {
    //    if (Math.floor(Math.random()*30) != 0)
    //        return;

        var ok = false;
        var lvl = false;
        if (data.lvl == undefined) {
            // Average Tier
            lvl = true;
            data.lvl = utils.calculateAvgLevel(data.v);
        }

        // fix eff FIXIT: REMOVE after 14.02.2013
        if (data.dt < new Date("2013-02-09 14:50")) {
            data.e = utils.calculateEfficiency(data);
        }

        if (data.wn == undefined) {
            // WN - WN rating http://forum.worldoftanks.com/index.php?/topic/184017-
            data.wn = utils.calculateWN(data);
            ok = true;
            utils.log("id=" + data._id + " wn=" + data.wn);
        }

        if (data.twr == undefined) {
            // TWR - tourist1984 win rate (aka T-Calc)
            try {
                data.twr = parseFloat(tcalc.calc(data, false).result.toFixed(2));
                ok = true;
    //            utils.log("id=" + data._id + " twr=" + data.twr);
            } catch (e) { utils.log(e); }
        }

        if (lvl) {
            data.lvl = parseFloat(data.lvl.toFixed(1));
            ok = true;
            utils.log("id=" + data._id + " lvl=" + data.lvl);
        }

        // updating db
        if (ok && Math.floor(Math.random()*1) == 0) {
    //        utils.log("update id=" + data._id);
            db.updatePlayersData(data._id, data);
        }
    };

    // response from db
    var _onPlayersData = function(error, processData) {
        if (error) {
    //        processData.response.statusCode = error.statusCode;
            processData.response.end('{"error":"' + error.text + '","server":"' + settings.serverName + '"}');
            //utils.log(error.text);
            return;
        }

        try {
            var now = new Date();

            processData.times.push({"n":"find","t":now});

            for(var dbi in processData.dbData) {
                var item = processData.dbData[dbi],
                    pdata = processData.rqData[item._id];

                // check expire date
                var cache = (now - item.dt) < settings.cacheTtl;

                if (cache) {
                    // fix data (recalculate missed items)
                    if (settings.fixData == true)
                        _fixData(item);
                }

                // Filter vehicle data
                item.vname = pdata.vname;
                item.v = utils.filterVehicleData(item, pdata.vname);
                if (cache) {
                    item.st = "cache";
                    // remove cached item from request
                    delete processData.rqData[item._id];
                } else {
                    item.st = "expired";
                    processData.rqData[item._id].cache = item;
                    delete processData.dbData[dbi];
                }
            }

            if (settings.fixData == true)
                processData.times.push({"n":"fix","t":now});

            // process items with bad id
            for(var rqi in processData.rqData) {
                var pdata = processData.rqData[rqi];
                if (pdata.status == "bad_id") {
                    processData.dbData.push({_id: rqi, st:pdata.status});
                    delete processData.rqData[rqi];
                }
            }

            //response.end("DEBUG:\nupdate: " + JSON.stringify(rq_data) + "\ncache: " + JSON.stringify(db_data)); return;

            // db_data - cached items
            // rq_data - items for update from statistics host
            worker_get.processRemotes(processData);
        } catch(e) {
    //        response.statusCode = 500;
            processData.response.end('{"error":"' + e + '","server":"' + settings.serverName + '"}');
            utils.log("Error: " + e);
        }
    };

    return {
        processRequest: processRequest
    }
})();
