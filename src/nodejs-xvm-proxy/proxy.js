var cluster = require('cluster'),
    worker = require("./worker");

// Create cluster
if (!cluster.isMaster) {
    worker.createWorker();
    return;
}

//////////////////////////////
// Master thread

var numCPUs = require('os').cpus().length,
    utils = require("./utils"),
    settings = require("./settings");

// String.lpad
String.prototype.lpad = function(padString, length) {
    var str = this;
    while (str.length < length)
        str = padString + str;
    return str;
}

utils.log("Starting server");

var usageStat = {
    start: new Date(),
    requests: 0,
    players: 0,
    cached: 0,
    updated: 0,
    missed: 0,
    updatesFailed: 0,
    connections: [],
    maxConnections: []
};

    // Fork workers.
for (var i = 0; i < /*numCPUs*/ 1; i++) {
    var w = cluster.fork();

    w.on('message', function(msg) {
        if (msg.usage == 1) {
            if (msg.requests) usageStat.requests += msg.requests;
            if (msg.players) usageStat.players += msg.players;
            if (msg.cached) usageStat.cached += msg.cached;
            if (msg.updated) usageStat.updated += msg.updated;
            if (msg.missed) usageStat.missed += msg.missed;
            if (msg.updatesFailed) usageStat.updatesFailed += msg.updatesFailed;
            if (msg.connections) usageStat.connections[msg.hostId] = (usageStat.connections[msg.hostId] || 0) + msg.connections;
            if (msg.maxConnections && usageStat.maxConnections[msg.hostId] != msg.maxConnections) {
                usageStat.maxConnections[msg.hostId] = msg.maxConnections;
//                utils.log("> connections limits: [" + usageStat.maxConnections.join(", ") + "]");
            }
        } else if (msg.cmd == "cmd") {
            //w.send({ chat: 'Ok worker, Master got the message! Over and out!' });
        }
    });
}

// show usage stat
setInterval(function() {
    var uptime = Math.round((new Date() - usageStat.start) / 1000);
    var d = parseInt(uptime / (60 * 60 * 24));
    var h = String(parseInt((uptime / 3600) % 24)).lpad("0", 2);
    var m = String(parseInt((uptime / 60) % 60)).lpad("0", 2);
    utils.log("> uptime  requests  rq/s   players  pl/s  cached updated  missed updfail connections/limits");
    utils.log(">" +
        ((d == 0 ? "" : d + "d") + h + "h" + m).lpad(" ", 7) +
        String(usageStat.requests).lpad(" ", 10) + " " + (usageStat.requests / uptime).toFixed().lpad(" ", 5) +
        String(usageStat.players).lpad(" ", 10) + " " + (usageStat.players / uptime).toFixed().lpad(" ", 5) +
        ((usageStat.cached / usageStat.players * 100).toFixed(2) + "%").lpad(" ", 8) +
        ((usageStat.updated / usageStat.players * 100).toFixed(2) + "%").lpad(" ", 8) +
        ((usageStat.missed / usageStat.players * 100).toFixed(2) + "%").lpad(" ", 8) +
        ((usageStat.updatesFailed / usageStat.players * 100).toFixed(2) + "%").lpad(" ", 8) +
        " [" + usageStat.connections.join(", ") + "]/[" + usageStat.maxConnections.join(", ") + "]");
}, settings.usageStatShowPeriod);
