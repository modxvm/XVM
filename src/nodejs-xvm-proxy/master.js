//////////////////////////////
// Master thread
var cluster = require("cluster"),
    db = require("./db"),
    http = require("http"),
    settings = require("./settings"),
    utils = require("./utils");

var updater;

exports.main = function() {
    utils.log("Starting server");

    updater = createWorker({type: "updater"});
    // Fork workers.
    for(var i = 0; i < settings.numNodes; i++) {
        createWorker({type: "worker"});
    }

    cluster.on("exit", function(worker, code, signal) {
        utils.log("worker " + worker.process.pid + " died (code:" + code + ", signal:" + signal + "). restarting...");
        var wt = worker.process.env.type,
            w = createWorker({type: wt});

        if(wt === "updater")
            updater = w;
    });

    db.ctor(function() {
        setInterval(saveUsageStat, settings.usageStatShowPeriod);
    });

    getInfoContent();
    setInterval(getInfoContent, 3600 * 1000); // every 1 hour

    getTWRBaseContent();
    setInterval(getTWRBaseContent, 3600 * 1000); // every 1 hour
};

var createWorker = function(env) {
    var w = cluster.fork(env);

    w.on("message", messageHandler);
    return w;
};

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
    connections: [ ]
};

var _lastLogMsg = "",
    _skipLogMsgCounter = 0;

var messageHandler = function(msg) {
    if(!msg.type) {
        console.log("!!!!!!!!!!!!!! no msg.type - ", msg);
        return;
    }
    switch(msg.type) {
        case "cmd":
            processCommand(msg);
            break;
    }
};

var processCommand = function(command) {
    switch(command.cmd) {
        case "update":
            updater.send(command);
            break;
        case "update_done":
            cluster.workers[command.src].send(command);
            break;
        default:
            console.log("[MASTER] unhandled command " +command);
    }
};

var saveUsageStat = function() {
    utils.performanceReport(usageStat);
    usageStat.requests_current = 0;
    usageStat.players_current = 0;
};

// setup "info" update interval
var getInfoContent = function() {
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
    var options = {
        host: "wot-xvm.googlecode.com",
        port: 80,
        path: "/svn/wiki/TWRBase.wiki"
    };

    http.get(options, function(res) {
        if(res.statusCode !== 200) {
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
                if(responseData) {
                    utils.log("[getTWRBaseContent] TWR Base updated");
                    // TODO
                    /*workers.forEach(function(worker) {
                        worker.send({ twrbase: responseData });
                    });*/
                }
            } catch(e) {
                utils.debug("> [getTWRBaseContent] ERROR: " + e +
                    "\nlength=" + responseData.length + ", data=" + responseData, "");
            }
        });
    });
};