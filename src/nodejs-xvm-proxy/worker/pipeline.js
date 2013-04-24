var cluster = require("cluster"),
    db = require("./../db"),
    factoryDb = require("./factoryDb"),
    settings = require("./../settings"),
    utils = require("./../utils");

var httpInfo;

exports.generic = function(ids, callback) {
    var parsedIds = _parseStatRequest(ids),
        responseCallback = callback;

    factoryDb.getPlayersData(parsedIds, function(error, procData) {

        /*processData = procData;
        processData.rqData = parsedIds.data;*/
        var processData = procData;

        if(error) {
            responseCallback(error, processData);
            return;
        }

        if(!Object.keys(procData.rqData).length) {
            //console.log("[WORKER:" + cluster.worker.id + "] " + JSON.stringify(processData));
            httpCallback({ }, processData, responseCallback);
            return;
        }

        var httpResults = { },
            pendingPlayers = [ ],
            httpTimeout;

        var messageHandler = function(msg) {
            //console.log("[WORKER:" + cluster.worker.id + "] " + JSON.stringify(msg));
            if(msg.cmd !== "update_done")
                return;

            var indexOfPlayer = pendingPlayers.indexOf(msg.id);
            //console.log("[WORKER:" + cluster.worker.id + "] " + pendingPlayers, indexOfPlayer);
            if(indexOfPlayer === -1)
                return;

            pendingPlayers.splice(indexOfPlayer, 1);
            // TODO special case for failed result?
            httpResults[msg.id] = msg.data;

            if(pendingPlayers.length === 0) {
                clearTimeout(httpTimeout);
                process.removeListener("message", messageHandler);
                httpCallback(httpResults, processData, responseCallback);
            }
        };

        process.on("message", messageHandler);

        for(var id in procData.rqData) {
            pendingPlayers.push(id);
            utils.send({ type: "cmd", cmd: "update", id: id, rqData: procData.rqData[id] });
        }

        httpTimeout = setTimeout(function() {
            process.removeListener("message", messageHandler);
            httpCallback(httpResults, processData, responseCallback);
        }, settings.httpMaxTime);
    });
};

var _parseStatRequest = function(ids) {
    var parsedIds = [ ],
        data = { };

    ids.forEach(function(a) {
        var x = a.split("="),
            id = parseInt(x[0], 10);

        // Skip wrong id and non-working servers
        var servers = utils.getStatServers(id);
        if(servers) {
            parsedIds.push(id);
            data[id] = { vname: x[1] ? x[1].toUpperCase() : null, servers: servers };
            if(x[2] === "1" && settings.updateUsers) {
                db.updateUsers(id);
            }
        } else {
            data[id] = { vname: x[1] ? x[1].toUpperCase() : null, status: "bad_id" };
        }
    });

    return { ids: parsedIds, data: data };
};

var httpCallback = function(results, processData, responseCallback) {
    var now = new Date();
    var result = {
        players: [ ],
        info: httpInfo,
        server: settings.serverName
    };

    // add processData.dbData items to result
    for(var i in processData.dbData) {
        result.players.push(_cacheToResult(processData.dbData[i]));
        utils.send({ type: "usage", cached: 1 });
    }
    // TODO for why?
    processData.dbData = null;

    // process retrieved items
    for(var id in processData.rqData) {
        var item = results[id];

        if(!item) {
            // TODO _prepareFallbackRes?
            result.players.push({id: id, status: "fail", date: now});
            utils.send({ type: "usage", updatesFailed: 1 });
            continue;
        }

        // check for errors
        if(item.__status) {
            result.players.push(_prepareFallbackRes(processData.rqData[id], id, item.__status));
            continue;
        }

        // check for errors from stat server
        if(item.status === "error") {
            var res = _prepareFallbackRes(processData.rqData[id], id, "error");
            switch(item.status_code) {
                case "API_UNKNOWN_SERVER_ERROR":
                    res.status = "api_error";
                    break;
                case "ACCOUNTS_PROFILE_CLOSED":
                    res.status = "closed";
                    break;
                case "ACCOUNTS_ACCOUNT_MISSING_OR_UNINITIALIZED":
                    res.status = "not_init";
                    break;
                default:
                    res.status = "fail";
                    res.status_code = "Unknown status code: " + item.status_code;
                    break;
            }
            result.players.push(res);
            continue;
        }

        // check for no error
        if(item.status !== "ok" || item.status_code !== "NO_ERROR") {
            res = _prepareFallbackRes(processData.rqData[id], id, "ok");
            res.status = item.status;
            res.status_code = item.status_code;
            result.players.push(res);
            continue;
        }

        // check for correct id
        var _id = parseInt(id, 10);

        if(!_id || _id <= 0) {
            res = _prepareFallbackRes(processData.rqData[id], id, "ok");
            res.status = "bad_id";
            result.players.push(res);
            continue;
        }

        var pdata = _parseNewPlayerData(_id, item.data);

        // updating db
        db.updatePlayersData(_id, pdata);
        utils.send({ type: "usage", updated: 1 });

        if(settings.updateMissed === true)
            db.removeMissed(_id);

        if(processData.rqData[id].vname)
            pdata.vname = processData.rqData[id].vname;

        result.players.push(_cacheToResult(pdata));
    }

    // return response to client
    responseCallback(undefined, result);
};

var _cacheToResult = function(item) {
    var res = {
        id: item._id,
        date: item.dt,
        cr: item.cr,
        up: item.up,
        vname: item.vname,
        status: item.st,
        name: item.nm,
        battles: item.b,
        wins: item.w,
        spo: item.spo,
        hip: item.hip,
        cap: item.cap,
        dmg: item.dmg,
        frg: item.frg,
        def: item.def,
        lvl: item.lvl,
        eff: item.e,
        wn: item.wn,
        twr: Math.round(item.twr)
    };

    if(item.vname && item.v)
        res.v = item.v.name ? item.v : utils.filterVehicleData(item, item.vname);
    return res;
};

var _prepareFallbackRes = function(item, id, status) {
    id = parseInt(id, 10);

    if(!item.cache) {
        utils.send({ type: "usage", missed: 1 });
        if(settings.updateMissed)
            db.insertMissed(id, true);
        return {id: id, date: new Date(), status: status};
    }

    utils.send({ type: "usage", updatesFailed: 1 });
    if(settings.updateMissed)
        db.insertMissed(id, false);
    var res = _cacheToResult(item.cache);
    res.status = status;
    return res;
};

var _parseNewPlayerData = function(id, data) {
    // fill global info
    var pdata = {
        _id: parseInt(id),
        st: "ok",
        dt: new Date(),
        cr: parseInt(data.created_at),
        up: parseInt(data.updated_at),
        nm: data.name,
        b: data.summary.battles_count,
        w: data.summary.wins,
        spo: data.battles.spotted,
        hip: data.battles.hits_percents,
        cap: data.battles.capture_points,
        dmg: data.battles.damage_dealt,
        frg: data.battles.frags,
        def: data.battles.dropped_capture_points,
        v: {}
    };

    // fill vehicle data
    for(var i in data.vehicles) {
        var vdata = data.vehicles[i];
        pdata.v[vdata.name.toUpperCase()] = {
            cl: utils.getVehicleType(vdata.class),
            l: vdata.level,
            b: vdata.battle_count,
            w: vdata.win_count,
            d: vdata.damageDealt,
            f: vdata.frags,
            s: vdata.spotted,
            u: vdata.survivedBattles
        };
    }

    // Average Tier
    pdata.lvl = utils.calculateAvgLevel(pdata.v);

    // EFF - wot-news efficiency rating
    pdata.e = utils.calculateEfficiency(pdata);

    // WN - WN rating http://forum.worldoftanks.com/index.php?/topic/184017-
    pdata.wn = utils.calculateWN(pdata);

    // TWR - tourist1984 win rate (aka T-Calc)
    try {
        pdata.twr = parseFloat(utils.tcalc(pdata, false).result.toFixed(2));
    } catch(e) {
        utils.log(e);
    }

    pdata.lvl = parseFloat(pdata.lvl.toFixed(3));

    return pdata;
};

exports.setHttpInfo = function(newHttpInfo) {
    httpInfo = newHttpInfo;
};