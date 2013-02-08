module.exports = (function() {
    var http = require("http"),
        async = require("async"),
        utils = require("./utils"),
        settings = require("./settings").settings,
        db = require("./worker_db"),
        tcalc = require("./tcalc/tcalc"),
        status = require("./worker_status");

    var processRemotes = function(processData) {
        processData.times.push({ "n":"process","t":new Date() });
        http = processData.fakeHttp || http;
        //console.log("fakeHttp: ", processData);

        // FIXIT: why this don't work?
        //    for (var id in processData.rqData) ...
        // symptoms: makeSingleRequest args are wrong (always the last item values)
        var urls = { },
            up = [ ];

        for (var id in processData.rqData)
            up.push(id);
        up.forEach(function(id) {
            var pdata = processData.rqData[id];
            var srv = _getFreeConnection(pdata.servers);

            if (srv.error) {
                if (pdata.cache)
                    pdata.cache.st = srv.error;
                else
                    pdata.cache = {_id:id,st:srv.error};
                processData.dbData[id] = pdata.cache;
                delete processData.rqData[id];
                process.send({usage:1, max_conn:1});
                return;
            }

            delete pdata.servers;
            pdata.server = srv;
            urls[id] = function(callback) { _makeSingleRequest(id, srv, callback); }
        });

        async.parallel(urls, function(err, results) { _asyncCallback(err, results, processData); });
    };

    // find free connection (connections balancer)
    // TODO: make single instance for all threads
    var _getFreeConnection = function(servers) {
        var now = new Date();
        var totalAvail = 0;
        var wait = true;
        var srvs = utils.clone(servers);

        for (var srvId in srvs)
        {
            var srv = srvs[srvId];
            var sst = status.serverStatus[srv.id];

            // Do not execute requests some time after error response
            if (sst.lastErrorDate) {
                if ((now - sst.lastErrorDate) < settings.lastErrorTtl) {
                    srv.avail = 0;
                    continue;
                }
                if (settings.lastErrorTtl > 1000)
                    utils.log("INFO:  [" + sst.name + "] resumed");
                sst.lastErrorDate = null;
                sst.error_shown = false;
            }

            wait = false;
            srv.avail = Math.max(0, sst.maxConnections - sst.connections);
            totalAvail += srv.avail;
        }

        if (wait)
            return {error:"wait"};

        if (totalAvail <= 0)
            return {error:"max_conn"};

        var n = Math.floor(Math.random()*totalAvail);

        for (var i in srvs)
        {
            var srv = srvs[i];
            if (srv.avail > n) {
                status.serverStatus[srv.id].connections++;
                return srv;
            }
            n -= srv.avail;
        }

        utils.log("getFreeConnection(): internal error");
        return {error:"fail"};
    };


    // execute request for single player id
    var _makeSingleRequest = function(id, server, callback) {
        process.send({usage:1, serverId:server.id, connections:1});

        var options = server.options;

        options.path = (options.path || "") + "/uc/accounts/" + id + "/api/" + server.api + "/?source_token=Intellect_Soft-WoT_Mobile-unofficial_stats";
        if (!options.headers)
            options.headers = {};
        options.headers.connection = "close"; // "keep-alive"

        var done = false;
        var reqTimeout = setTimeout(function() {
            var err = "[" + server.name + "] Http timeout: " + server.timeout;

            done = true;
            _onRequestDone(server, err);
            callback(null, { __status: "timeout" });
        }, server.timeout);

        http.get(options, function(res) {
            if (res.statusCode != 200) {
                clearTimeout(reqTimeout);
                if (done)
                    return;

                var err = "[" + server.name + "] Http error: bad status code: " + res.statusCode;

                _onRequestDone(server, err);
                callback(null, { __status: res.statusCode });
                return;
            }

            res.setEncoding("utf8");
            var responseData = "";
            res.on("data", function(chunk) {
                // TODO check valid JSON string and terminate immediately if not
                responseData += chunk;
            });
            res.on("end", function() {
                clearTimeout(reqTimeout);
                if (done)
                    return;
                try {
                    var result = JSON.parse(responseData);
                } catch(e) {
                    var str;
                    if (responseData[0] != "{")
                        str = "(binary)";
                    else {
                        str = responseData.replace(/[ \t\n\r\x00-\x1F]/g, "");
                        str = str.substr(0, 45) + "~" + str.substr(str.length - 11, 10);
                    }
                    var err = "[" + server.name + "] JSON.parse:  l=" + responseData.length + ", d=\"" + str + "\"";
                    _onRequestDone(server, err);
                    callback(null, { __status: "parse" });
                    return;
                }
                _onRequestDone(server);
                callback(null, result);
            });
        }).on("error", function(e) {
            clearTimeout(reqTimeout);
            if (done)
                return;
            done = true;

            var err = "[" + server.name + "] Http error: " + e;

            _onRequestDone(server, err);
            callback(null, { __status: "error" });
        });
    };

    var _onRequestDone = function(server, error) {
        var now = new Date();
        var sst = status.serverStatus[server.id];
        sst.connections--;
        process.send({usage:1, serverId:server.id, connections:-1, fail:error?true:false});

        // HTTP connections balancer
        if(!sst.lastMaxConnectionUpdate || (now - sst.lastMaxConnectionUpdate) > (error ? 1000 : 5000)) {
            sst.lastMaxConnectionUpdate = now;
            var oldMaxConn = sst.maxConnections;
            sst.maxConnections = Math.max(1, Math.min(server.maxconn, sst.maxConnections + (error ? -5 : 1)));
            process.send({usage:1, serverId:server.id, maxConnections:sst.maxConnections-oldMaxConn});
        }

        if (error) {
            sst.lastErrorDate = now;
            if(!sst.error_shown) {
                sst.error_shown = true;
                //utils.log("ERROR: " + error);
                process.send({log:1, msg:"ERROR: "+error});
            }
        }
    };

    // process received data, update db
    var _asyncCallback = function(err, results, processData) {
        processData.times.push({"n":"rqdone","t":new Date()});

        var now = new Date();
        var result = {
            players: [ ],
            info: status.info,
            server: settings.serverName
        };

        // add processData.dbData items to result
        for(var i in processData.dbData) {
            result.players.push(_cacheToResult(processData.dbData[i]));
            process.send({usage:1, cached:1});
        }
        processData.dbData = null;

        // process retrieved items
        for(var id in processData.rqData) {
            var item = results[id];
            if (!item) {
                utils.log("internal error in worker_get.js:asyncCallback(): !item, id=" + id + ", err= " + err);
                result.players.push({id:id, status:"fail", date:now});
                continue;
            }

            // check for errors
            if (item.__status) {
                result.players.push(_prepareFallbackRes(processData.rqData[id], id, item.__status));
                continue;
            }

            // check for errors from stat server
            if (item.status == "error") {
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
                        utils.log("WARNING: Unknown status code: " + item.status_code + ", id=" + id);
                        break;
                }
                result.players.push(res);
                continue;
            }

            // check for no error
            if (item.status != "ok" || item.status_code != "NO_ERROR") {
                var res = _prepareFallbackRes(processData.rqData[id], id, "ok");
                res.status = item.status;
                res.status_code = item.status_code;
                result.players.push(res);
                utils.log("internal error: unknown status: " + item.status + ", status_code: " + item.status_code);
                continue;
            }

            // check for correct id
            var _id = parseInt(id);

            if (!_id || _id <= 0) {
                var res = _prepareFallbackRes(processData.rqData[id], id, "ok");
                res.status = "bad_id";
                result.players.push(res);
                utils.log("internal error: invalid id: " + id);
                continue;
            }

            var pdata = _parseNewPlayerData(_id, item.data);

            // updating db
            db.updatePlayersData(_id, pdata);
            process.send({usage:1, updated:1});

            if (settings.updateMissed == true)
                db.removeMissed(_id);

            if(processData.rqData[id].vname)
                pdata.vname = processData.rqData[id].vname;

            result.players.push(_cacheToResult(pdata));
         }

        processData.times.push({"n":"processed","t":new Date()});

        _printDebugInfo(result.players, processData.times);

        // return response to client
        processData.response.end(JSON.stringify(result));
    };

    // service functions

    var _cacheToResult = function(item) {
        var res = {
            id: item._id,
            date: item.dt,
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

        if (item.vname && item.v)
            res.v = item.v.name ? item.v : utils.filterVehicleData(item, item.vname);
        return res;
    };

    var _parseNewPlayerData = function(id, data) {
        // fill global info
        var pdata = {
            _id: parseInt(id),
            dt: new Date(),
            st: "ok",
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
        for (var i in data.vehicles) {
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
            }
        }

        // Average Tier
        pdata.lvl = utils.calculateAvgLevel(pdata.v);

        // EFF - wot-news efficiency rating
        pdata.e = utils.calculateEfficiency(pdata);

        // WN - WN rating http://forum.worldoftanks.com/index.php?/topic/184017-
        pdata.wn = utils.calculateWN(pdata);

        // TWR - tourist1984 win rate (aka T-Calc)
        try {
            pdata.twr = parseFloat(tcalc.calc(pdata, false).result.toFixed(2));
        } catch (e) { utils.log(e); }

        pdata.lvl = parseFloat(pdata.lvl.toFixed(1));

        return pdata;
    };

    var _prepareFallbackRes = function(item, id, status) {
        id = parseInt(id);

        if (!item.cache) {
            process.send({usage:1, missed:1});
            if (settings.updateMissed == true)
                db.insertMissed(id, true);
            return {id:id, date:new Date(), status:status};
        }

        process.send({usage:1, updatesFailed:1});
        if (settings.updateMissed == true)
            db.insertMissed(id, false);
        var res = _cacheToResult(item.cache);
        res.status = status;
        return res;
    };

    var _printDebugInfo = function(items, times) {
        var now = new Date();
        var duration = now - times[0].t;
        if (duration > 6000) {
            times.push({"n":"end","t":now});
            var str = "";
            for(var i = 1; i < times.length; ++i) {
                if(str != "")
                    str += " ";
                str += times[i].n + ":" + String(times[i].t - times[i - 1].t);
            }
            utils.debug("times: " + str);
        }
    };

    return {
        processRemotes: processRemotes
    }
})();
