var settings = require("./../settings"),
    utils = require("./../utils");

var statServersStatus = [ ];

exports.getFreeConnection = function(srvs) {
    var now = new Date(),
        totalAvail = 0,
        wait = true,
        servers = utils.clone(srvs);

    for(var serverId in servers) {
        var server = servers[serverId],
            serverStatus = statServersStatus[server.id];

        // Do not execute requests some time after error response
        if(serverStatus.lastErrorDate) {
            if((now - serverStatus.lastErrorDate) < settings.lastErrorTtl) {
                server.avail = 0;
                continue;
            }
            if(settings.lastErrorTtl > 1000)
                utils.log("INFO:  [" + serverStatus.name + "] resumed");
            serverStatus.lastErrorDate = null;
            serverStatus.error_shown = false;
        }

        wait = false;
        server.avail = Math.max(0, serverStatus.maxConnections - serverStatus.connections);
        totalAvail += server.avail;
    }

    if(wait)
        return {error: "wait"};

    if(totalAvail <= 0)
        return {error: "max_conn"};

    var n = Math.floor(Math.random() * totalAvail);

    for(var i in servers) {
        server = servers[i];
        if(server.avail > n) {
            statServersStatus[server.id].connections++;
            return server;
        }
        n -= server.avail;
    }

    utils.log("getFreeConnection(): internal error");
    return {error: "fail"};
};

exports.serverStatus = statServersStatus;
exports.info = { };

for(var i = 0; i < settings.servers.length; ++i) {
    statServersStatus.push({
        name: settings.servers[i].name,
        lastErrorDate: null,
        error_shown: false,
        connections: 0,
        maxConnections: Math.floor(settings.servers[i].maxconn / 2), // initial connections limit
        lastMaxConnectionUpdate: null
    });
}
