module.exports = (function()
{

var http = require("http"),
    url = require("url"),
    async = require("async"),
    utils = require("./utils"),
    settings = require("./settings"),
    mongo = require("mongodb");

// Mongo
var collection,
    missed_collection,
    users_collection,
    mongoOptions = {
        auto_reconnect: true,
        poolSize: 50
    };

// Global vars
var hostData = [];
for (var i = 0; i < settings.statHosts.length; ++i) {
    hostData.push({
        lastError: null,
        waiting: null,
        error_shown: false,
        connections: 0
    });
}

// Main functions

var getStatHostId = function(id) {
    return Math.max(0, Math.min(Math.floor(id / 500000000), settings.statHosts.length - 1));
}

// WG Server Statistics retrieve

// execute request for single player id
var makeSingleRequest = function(id, callback, force) {
    var now = new Date();
    var statHostId = getStatHostId(id);
    var hd = hostData[statHostId];

    // Do not execute requests some time after error responce
    if (hd.lastError && !force) {
        if ((now - hd.lastError) < settings.lastErrorTtl) {
            var wait_sec = Math.round((settings.lastErrorTtl - (now - hd.lastError)) / 1000);
            if (wait_sec > 0) {
                if (!hd.waiting)
                    hd.waiting = wait_sec;
                if (hd.waiting - 5 >= wait_sec) {
                    hd.waiting = wait_sec;
                    utils.debug("waiting Server_" + statHostId + ": " + wait_sec + " s");
                }
            }
            callback(null, null);
            return;
         } else {
            utils.debug("resuming Server_" + statHostId);
            hd.lastError = null;
            hd.waiting = null;
            hd.error_shown = false;
         }
    }

    // Select proper server by player id
    if (statHostId >= settings.statHosts.length) {
        callback(null, null);
        return;
    }

    if (hd.connections >= settings.statHostMaxConnections)
    {
        callback(null, null);
        return;
    }

    hd.connections++;
    process.send({ usage: 1, hostId: statHostId, connections: 1 });

    var reqTimeout = setTimeout(function() {
        callback(null, {__error:"Timeout"});
     }, settings.statHostsTimeouts[statHostId]);

    var options = {
        host: settings.statHosts[statHostId],
        port: 80,
        path: "/uc/accounts/" + id + "/api/" + settings.wotApiVersion + "/?source_token=Intellect_Soft-WoT_Mobile-unofficial_stats"//,
 //       agent: agent
    };

    var request = http.get(options, function(res) {
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
                utils.debug("JSON.parse error: length=" + responseData.length + ", data=" + responseData.substr(0, 70).replace(/[\n\r]/g, ""));
                callback(null, {__error:"JSON.parse error"});
            }
        });
    });
    request.on("error", function(e) {
        clearTimeout(reqTimeout);
        callback(null, {__error:"Http error: " + e});
    });

    request.shouldKeepAlive = false;
}

var processRemotes = function(inCache, forUpdate, forUpdateVNames, response, start) {
    var urls = { };

    forUpdate.forEach(function(id) {
        urls[id] = function(callback) {
            makeSingleRequest(id, callback, /*forUpdate.length == 1*/ false);
        };
    });

//    async.series(urls, function(err, results) {
    async.parallel(urls, function(err, results) {

        var now = new Date();

        var result = {
            players: [ ],
            info: settings.info
        };

        // process retrieved items
        var forUpdate_length = forUpdate.length;
        for (var i = 0; i < forUpdate_length; ++i) {
            var id = forUpdate[i];
            var vname = forUpdateVNames[i];
            var statHostId = getStatHostId(id);
            var hd = hostData[statHostId];

            var curResult = results[id];
            var resultItem = { _id: id, st: "fail", dt: now };

            if (curResult)
            {
                hd.connections--;
                process.send({ usage: 1, hostId: statHostId, connections: -1 });

                if (curResult.__error) {

                    resultItem.st = "error";
                    hd.lastError = now;
                    if (!hd.error_shown) {
                         hd.error_shown = true;
                         utils.debug("Server_" + statHostId + ": " + curResult.__error);
                    }
                } else if (curResult.status === "ok" && curResult.status_code === "NO_ERROR") {
                    // fill global info
                    resultItem.st = "ok";
                    resultItem.nm = curResult.data.name;
                    resultItem.b = curResult.data.summary.battles_count;
                    resultItem.w = curResult.data.summary.wins;
                    resultItem.e = utils.calculateEfficiency(curResult.data);

                    // fill vehicle data
                    resultItem.v = [];
                    var vehicles_length = curResult.data.vehicles.length;
                    for (var j = 0; j < vehicles_length; ++j) {
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
                    collection.update({ _id: id }, resultItem, { upsert: true });
                    process.send({ usage: 1, updated: 1 });
                }
            }

            var pl = {
                id: resultItem._id,
                date: resultItem.dt,
                vname: vname,
                status: resultItem.st,
                name: resultItem.nm,
                battles: resultItem.b,
                wins: resultItem.w,
                eff: resultItem.e,
                v: resultItem.v,
            };
            result.players.push(pl);
        }

        // add cached items and set expired data for players with error stat
        var failed_count = 0;
        inCache.forEach(function(player) {
            var skip = false;
            var pl = {
                id: player._id,
                date: player.dt,
                vname: player.vname,
                status: player.st,
                name: player.nm,
                battles: player.b,
                wins: player.w,
                eff: player.e,
                v: player.v,
            };
            var players_length = result.players.length;
            for (var i = 0; i < players_length; ++i) {
                if (result.players[i].id == pl.id) {
                    if (result.players[i].status != "ok") {
                        result.players[i] = pl;
                        process.send({ usage: 1, cached: 1, updatesFailed: 1 });
                        failed_count++;
                    }
                    skip = true;
                    break;
                }
            }
            if (!skip) {
                result.players.push(pl);
                process.send({ usage: 1, cached: 1 });
            }
        });

        // print debug info & remove useless data from result
        var missed_count = 0;
        var missed_ids = [];
        result.players.forEach(function(player) {
            if (player.status != "ok") {
                if (missed_count < 3)
                  missed_ids.push(player.id);
                missed_count++;
                missed_collection.update({ _id: player.id }, { _id: player.id }, { upsert: true });
            } else {
                // Return only one vehicle data
                if (player.v)
                {
                    var vs = player.v;
                    delete player.v;
                    if (player.vname) {
                        var vs_length = vs.length;
                        for (var i = 0; i < vs_length; ++i) {
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

        // Temporary disabled (log overfilled)
        if (false && (missed_count > 0 || failed_count > 0) && forUpdate.length > 0 && result.players.length > 1) {
            var duration = String(new Date() - start);
            while (duration.length < 4)
                duration = " " + duration;
            utils.debug(
                "S" + (statHostId == undefined ? "c" : statHostId) + " " + duration + " ms" +
                "  total: " + (result.players.length < 10 ? " " : "") + result.players.length +
                "  cache: " + (inCache.length < 10 ? " " : "") + inCache.length +
                "  retrieve: " + (forUpdate.length < 10 ? " " : "") + forUpdate.length +
                "  failed: " + (failed_count < 10 ? " " : "") + failed_count +
                "  missed: " + (missed_count < 10 ? " " : "") + missed_count +
                (missed_count > 0 ? ". ids: " : "") + missed_ids.join(",") + (missed_count > 5 ? ",..." : ""));
        }

        process.send({ usage: 1, missed: missed_count });

        // return response to client
        response.end(JSON.stringify(result));
    });
};

// Create http server
var createWorker = function() {

    // Set max client connections (5 by default)
    http.globalAgent.maxSockets = settings.maxSockets;

    // Connect to database
    var db = new mongo.Db(settings.dbName, new mongo.Server("localhost", 27017, mongoOptions));
    db.open(function(error, client) {
        if(error) {
            utils.log("DB connection error!");
            return;
        }
        utils.log("MongoDB Connected");
        collection = new mongo.Collection(client, settings.collectionName);
        missed_collection = new mongo.Collection(client, settings.missedCollectionName);
        users_collection = new mongo.Collection(client, settings.usersCollectionName);
    });

    http.createServer(function(request, response) {
        // parse request
        var ids = [ ];
        var vehicles = [ ];
        var start = new Date();
        try {
            var query = url.parse(request.url).query;
            if(!query || !query.match(/^((\d)|(\d[\dA-Z_\-,=]*))$/))
                throw "query match error: " + query;

            if (query == "001" || query == "test") {
                response.end('{"players":[{"id":1,"status":"ok"}]}');
                return;
            }

            query.split(",").forEach(function(a) {
                var x = a.split("=");
                var id = parseInt(x[0]);
                ids.push(id);
                vehicles.push(x[1]);
                if (x[2] == "1")
                    users_collection.update({ _id: id }, { $inc : { counter: 1 } }, { upsert: true });

            });
        } catch(e) {
            response.statusCode = 500;
            var errText = "wrong request: " + e;
            if (request.url.toLowerCase() != "/favicon.ico")
                errText += " url=" + request.url;
            response.end(errText);
            return;
        }

        process.send({ usage: 1, requests: 1, players: ids.length });

        // Select required data from cache
        var cursor = collection.find({ _id: { $in: ids }}, { _id:1, st:1, dt:1, nm:1, b:1, w:1, e:1, v:1 });
        cursor.toArray(function(error, inCache) {
            try {
                if (error)
                    throw "MongoDB find error: " + error;

                var forUpdate = [ ];
                var forUpdateVNames = [ ];
                var now = new Date();

                var ids_length = ids.length;
                for (var a = 0; a < ids_length; ++a) {
                    var id = ids[a];
                    var vname = vehicles[a] ? vehicles[a].toUpperCase() : null;
//if (!vname)
//{
//    utils.debug("a:" + a);
//    utils.debug("ids:" + ids.join(","));
//    utils.debug("vehicles:" + vehicles.join(","));
//    utils.debug("query: " + url.parse(request.url).query);
//}
                    // Check cache data
                    var found = false;
                    var inCache_length = inCache.length;
                    for (var i = 0; i < inCache_length; ++i) {
                        if (inCache[i]._id != id)
                            continue;
                        if (vname)
                            inCache[i].vname = vname;
                        if ((now - inCache[i].dt) < settings.cacheTtl)
                            found = true;
                        break;
                    }

                    // Add missed or expired ids for update
                    if (!found) {
                            forUpdate.push(id);
                            forUpdateVNames.push(vname);
                    }
                }

                processRemotes(inCache, forUpdate, forUpdateVNames, response, start);
            } catch(e) {
                response.statusCode = 500;
                response.end("Error: " + e);
                utils.debug("Error: " + e);
            }
        });
    }).listen(settings.port, settings.host);

    utils.log("Server running at http://" + settings.host + ":" + settings.port + "/");
}

    // exports
    return {
        createWorker: createWorker
    }
})();
