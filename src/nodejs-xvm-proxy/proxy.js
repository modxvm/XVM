var http = require("http"),
    url = require("url"),
    async = require("async"),
    utils = require("./utils"),
    settings = require("./settings"),
    mongo = require("mongodb"),
    collection,
    missed_collection,
    serverOptions = {
        auto_reconnect: true,
        poolSize: 50
    },
    db = new mongo.Db(settings.dbName, new mongo.Server("localhost", 27017, serverOptions));

// Global vars
var lastErrors = {},
    waiting_shown = false,
    error_shown = false;


// Main

utils.log("Starting server");

// Connect to database
db.open(function(error, client) {
    if(error) {
        utils.log("DB connection error!");
        return;
    }
    utils.log("MongoDB Connected");
    collection = new mongo.Collection(client, settings.collectionName);
    missed_collection = new mongo.Collection(client, settings.missedCollectionName);
});

// WG Server Statistics retrieve

// execute request for single player id
var makeSingleRequest = function(id, callback) {
    var now = new Date();
    var statHostId = Math.floor(id / 500000000);
    var lastError = lastErrors["s" + statHostId] || null;

    // Do not execute requests some time after error responce
    if (lastError != null) {
        if ((now - lastError) < settings.lastErrorTtl) {
            if (!waiting_shown) {
                waiting_shown = true;
                utils.debug("waiting " + Math.round((settings.lastErrorTtl - (now - lastError)) / 1000) + " s id=" + id);
            }
            callback(null, null);
            return;
         } else {
            lastErrors["s" + statHostId] = null;
            waiting_shown = false;
            error_shown = false;
         }
    }

    // Select proper server by player id
    if (statHostId >= settings.statHosts.length) {
        callback(null, null);
        return;
    }

    var options = {
        host: settings.statHosts[statHostId],
        port: 80,
        path: "/uc/accounts/" + id + "/api/" + settings.wotApiVersion + "/?source_token=Intellect_Soft-WoT_Mobile-unofficial_stats"
    };

    var reqTimeout = setTimeout(function() {
        callback(null, {__error:"Timeout"});
     }, 5000);

     request = http.get(options, function(res) {
        var responseData = "";
        res.setEncoding("utf8");
        res.on("data", function(chunk) {
            responseData += chunk;
        });
        res.on("end", function() {
            clearTimeout(reqTimeout);
            try {
                var result = JSON.parse(responseData);
//                utils.debug("responseData.length = " + responseData.length);
                callback(null, result);
            } catch(e) {
                utils.debug("JSON.parse error: length=" + responseData.length);
                callback(null, {__error:"JSON.parse error: " + e});
            }
        });
    });
    request.on("error", function(e) {
        clearTimeout(reqTimeout);
        callback(false, {__error:"Http error: " + e});
    });

    request.shouldKeepAlive = false;
}

var processRemotes = function(inCache, forUpdate, forUpdateVNames, response) {
    var urls = { };

    forUpdate.forEach(function(id) {
        urls[id] = function(callback) {
            makeSingleRequest(id, callback);
        };
    });

    async.parallel(urls, function(err, results) {

        var now = new Date();

        var result = {
            players: [ ],
            info: settings.info
        };

        // process retrieved items
        var updated = 0;
        for (var i = 0; i < forUpdate.length; ++i) {
            var id = forUpdate[i];
            var vname = forUpdateVNames[i];

            var curResult = results[id];
            var resultItem = { id: id, status: "fail", date: now };

            if (curResult)
            {
                if (curResult.__error) {
                    resultItem.status = "error";
                    lastErrors["s" + Math.floor(id / 500000000)] = now;
                    if (!error_shown) {
                         error_shown = true;
                         utils.debug("S" + Math.floor(id / 500000000) + ": " + curResult.__error);
                    }
                } else if (curResult.status === "ok" && curResult.status_code === "NO_ERROR") {
                    // fill global info
                    resultItem.status = "ok";
                    resultItem.name = curResult.data.name;
                    resultItem.battles = curResult.data.summary.battles_count;
                    resultItem.wins = curResult.data.summary.wins;
                    resultItem.eff = utils.calculateEfficiency(curResult.data);

                    // fill vehicle data
                    resultItem.v = [];
                    for (var j = 0; j < curResult.data.vehicles.length; ++j) {
                        var vdata = curResult.data.vehicles[j];
                        resultItem.v.push({
                            name: vdata.name,
                            l: vdata.level,
                            b: vdata.battle_count,
                            w: vdata.win_count,
                            s: vdata.spotted,
                            d: vdata.damageDealt,
                            //survivedBattles: vdata.survivedBattles,
                            f: vdata.frags//,
                            //cl: vdata.class
                        });
                    }

                    // updating db
                    collection.update({ id: id }, resultItem, { upsert: true });
                    updated++;
                }
            }

            if (vname)
                resultItem.vname = vname;

            result.players.push(resultItem);
        }
        //utils.debug("updated: " + updated + " / " + forUpdate.length);

        // add cached items and set expired data for players with error stat
        inCache.forEach(function(player) {
            var skip = false;
            for (var i = 0; i < result.players.length; ++i) {
                if (result.players[i].id == player.id) {
                    if (result.players[i].status != "ok") {
                        result.players[i] = player;
                    }
                    skip = true;
                    break;
                }
            }
            if (!skip)
                result.players.push(player);
        });

        // print debug info & remove useless data from result
        var missed_count = 0;
        var missed_ids = [];
        result.players.forEach(function(player) {
            if (player.status != "ok") {
                if (missed_count < 5)
                  missed_ids.push(player.id);
                missed_count++;
                missed_collection.update({ id: player.id }, { id: player.id }, { upsert: true });
            } else {
                // Return only one vehicle data
                if (player.v)
                {
                    var vs = player.v;
                    delete player.v;
                    if (player.vname) {
                        for (var i = 0; i < vs.length; ++i) {
                            if (vs[i].name.toUpperCase() == player.vname)
                            {
                                player.v = vs[i];
                                break;
                            }
                        }
                    }
                }
            }
        });
        if (missed_count > 0 && result.players.length > 1) {
            utils.debug("missed stat: " + missed_count + " / " + result.players.length + 
                ". ids: " + missed_ids.join(",") + (missed_count > 5 ? ",..." : ""));
        }

        // return response to client
        response.end(JSON.stringify(result));
    });
};

// Create http server

http.createServer(function(request, response) {
    // parse request
    var ids = [ ];
    try {
        var query = url.parse(request.url).query;
        if(!query || !query.match(/^((\d)|(\d[\dA-Z_\-,=]*))$/))
            throw "query match error: " + query;

        if (query == "001" || query == "test") {
            response.end('{"players":[{"id":1,"status":"fail"}]}');
            return;
        }

        ids = query.split(",").map(function(id) { return parseInt(id.split("=")[0]); });
        vehicles = query.split(",").map(function(id) { return id.split("=")[1]; });
    } catch(e) {
        response.statusCode = 500;
        var errText = "wrong request: " + e;
        if (request.url.toLowerCase() != "/favicon.ico")
            errText += " url=" + request.url;
        response.end(errText);
        return;
    }

    // Select required data from cache
    var cursor = collection.find({ id: { $in: ids }}, { _id:0, id:1, status:1, date:1, name:1, battles:1, wins:1, eff:1, v:1 });
    cursor.toArray(function(error, inCache) {
        try {
            if (error)
                throw "MongoDB find error: " + error;

            var forUpdate = [ ];
            var forUpdateVNames = [ ];
            var now = new Date();

            for (var a = 0; a < ids.length; ++a) {
                var id = ids[a];
                var vname = vehicles[a] ? vehicles[a].toUpperCase() : null;
                // Check cache data
                var found = false;
                for (var i = 0; i < inCache.length; ++i) {
                    if (inCache[i].id != id)
                        continue;
                    if (vname)
                        inCache[i].vname = vname;
                    if ((now - inCache[i].date) < settings.cacheTtl)
                        found = true;
                    break;
                }

                // Add missed or expired ids for update
                if (!found) {
                    forUpdate.push(id);
                    forUpdateVNames.push(vname);
                }
            }

            utils.debug("total: " + (ids.length < 10 ? " " : "") + ids.length +
                "   from cache: " + (inCache.length < 10 ? " " : "") + inCache.length +
                "   to retrieve: " + (forUpdate.length < 10 ? " " : "") + forUpdate.length);
            processRemotes(inCache, forUpdate, forUpdateVNames, response);
        } catch(e) {
            response.statusCode = 500;
            response.end("Error: " + e);
            utils.debug("Error: " + e);
        }
    });
}).listen(settings.port, settings.host);

utils.log("Server running at http://" + settings.host + ":" + settings.port + "/");
