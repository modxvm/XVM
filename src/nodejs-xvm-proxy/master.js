//////////////////////////////
// Master thread
var cluster = require("cluster");

exports.main = function() {
    utils.log("Starting server");

    // Fork workers.
    for(var i = 0; i < settings.numNodes; i++) {
        var w = cluster.fork();
        workers.push(w);
        w.on("message", processWorkerMessage);
    }

    cluster.on("exit", function(worker, code, signal) {
        var exitCode = worker.process.exitCode;
        utils.log("worker " + worker.process.pid + " died (" +exitCode+ "). restarting...");
        cluster.fork();
    });

    setInterval(saveUsageStat, settings.usageStatShowPeriod);

    getInfoContent();
    setInterval(getInfoContent, 3600 * 1000); // every 1 hour

    getTWRBaseContent();
    setInterval(getTWRBaseContent, 3600 * 1000); // every 1 hour
};

// PRIVATE

var settings = require("./settings").settings,
    utils = require("./utils");

var workers = [ ];

// usage stat
var usageStat = {
    start: new Date(),
    requests: 0,
    requests_current: 0,
    players: 0,
    players_current: 0,
    cached: 0,
    updated: 0,
    missed: 0,
    updatesFailed: 0,
    max_conn: 0,
    mongorq: 0,
    mongorq_max: settings.dbMaxConnections * settings.numNodes,
    connections: [ ],
    req_in: 0,
    req_out: 0
};

var _lastLogMsg = "",
    _skipLogMsgCounter = 0;

var processWorkerMessage = function(msg) {
    if(msg.usage == 1) {
        if(msg.requests) {
            usageStat.requests += msg.requests;
            usageStat.requests_current += msg.requests;
        }
        if(msg.players) {
            usageStat.players += msg.players;
            usageStat.players_current += msg.players;
        }
        if(msg.cached)
            usageStat.cached += msg.cached;
        if(msg.updated)
            usageStat.updated += msg.updated;
        if(msg.missed)
            usageStat.missed += msg.missed;
        if(msg.updatesFailed)
            usageStat.updatesFailed += msg.updatesFailed;
        if(msg.max_conn)
            usageStat.max_conn += msg.max_conn;
        if(msg.max_db)
            usageStat.max_db += msg.max_db;
        if(msg.mongorq)
            usageStat.mongorq += msg.mongorq;
        if(msg.mongorq_max) {
            usageStat.mongorq_max += msg.mongorq_max;
            utils.log("mongorq_max: " + usageStat.mongorq_max);
        }
        if(msg.cmd_info)
            usageStat.cmd_info += msg.cmd_info;
        if(msg.connections) {
            if (!usageStat.connections[msg.serverId])
                usageStat.connections[msg.serverId] = {cur:0, max:settings.servers[msg.serverId].maxconn, total:0, fail:0};
            usageStat.connections[msg.serverId].cur += msg.connections;
            if (msg.connections > 0)
                usageStat.connections[msg.serverId].total += msg.connections;
            if (msg.fail)
                usageStat.connections[msg.serverId].fail -= msg.connections;
        }
        if(msg.maxConnections) {
            if (!usageStat.connections[msg.serverId])
                usageStat.connections[msg.serverId] = {cur:0, max:settings.servers[msg.serverId].maxconn, total:0, fail:0};
            usageStat.connections[msg.serverId].max += msg.maxConnections;
        }
        if(msg.req_in) {
            usageStat.req_in += msg.req_in;
        }
        if(msg.req_out) {
            usageStat.req_out += msg.req_out;
        }
    } else if(msg.log == 1) {
        if (msg.msg != _lastLogMsg) {
            if (_skipLogMsgCounter > 0)
                utils.log("(skipped " + _skipLogMsgCounter + " message" + (_skipLogMsgCounter == 1 ? "" : "s") +")");
            utils.log(msg.msg);
            _lastLogMsg = msg.msg;
            _skipLogMsgCounter = 0;
        } else {
            _skipLogMsgCounter++;
        }
    }
};

var saveUsageStat = function() {
    utils.performanceReport(usageStat);
    usageStat.requests_current = 0;
    usageStat.players_current = 0;
};

// setup "info" update interval
var getInfoContent = function() {
    var http = require("http");

    var options = {
        host: "wot-xvm.googlecode.com",
        port: 80,
        path: "/svn/wiki/ReleaseInfo.wiki"
    };

    http.get(options, function(res) {
        var responseData = "";
        res.setEncoding("utf8");
        res.on("data", function(chunk) {
            responseData += chunk;
        });
        res.on("end", function() {
            try {
                var newInfo = JSON.parse(responseData);
                utils.log("[getInfoContent] Info updated");
                workers.forEach(function(worker) {
                    worker.send({ info: newInfo });
                });
            } catch(e) {
                utils.debug("> [getInfoContent] JSON.parse error:" + e +
                    "\nlength=" + responseData.length + ", data=" + responseData.replace(/[\n\r]/g, ""));
            }
        });
    });
};

// setup "info" update interval
var getTWRBaseContent = function() {
    var http = require("http");

    var options = {
        host: "wot-xvm.googlecode.com",
        port: 80,
        path: "/svn/wiki/TWRBase.wiki"
    };

    http.get(options, function(res) {
        if (res.statusCode != 200) {
            utils.log("[getTWRBaseContent] ERROR: bad status code: " + res.statusCode);
            return;
        }
        var responseData = "";
        res.setEncoding("utf8");
        res.on("data", function(chunk) {
            responseData += chunk;
        });
        res.on("end", function() {
            try {
                if (responseData) {
                    utils.log("[getTWRBaseContent] TWR Base updated");
                    workers.forEach(function(worker) {
                        worker.send({ twrbase: responseData });
                    });
                }
            } catch(e) {
                utils.debug("> [getTWRBaseContent] ERROR: " + e +
                    "\nlength=" + responseData.length + ", data=" + responseData, "");
            }
        });
    });
};