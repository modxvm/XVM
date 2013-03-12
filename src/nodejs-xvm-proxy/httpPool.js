var settings = require("./settings").settings,
    utils = require("./utils");

var serverStatus = [ ];

exports.getFreeConnection = function(servers) {
    var now = new Date();
    var totalAvail = 0;
    var wait = true;
    var srvs = utils.clone(servers);

    for(var srvId in srvs) {
        var srv = srvs[srvId];
        var sst = serverStatus[srv.id];

        // Do not execute requests some time after error response
        if(sst.lastErrorDate) {
            if((now - sst.lastErrorDate) < settings.lastErrorTtl) {
                srv.avail = 0;
                continue;
            }
            if(settings.lastErrorTtl > 1000)
                utils.log("INFO:  [" + sst.name + "] resumed");
            sst.lastErrorDate = null;
            sst.error_shown = false;
        }

        wait = false;
        srv.avail = Math.max(0, sst.maxConnections - sst.connections);
        totalAvail += srv.avail;
    }

    if(wait)
        return {error: "wait"};

    if(totalAvail <= 0)
        return {error: "max_conn"};

    var n = Math.floor(Math.random() * totalAvail);

    for(var i in srvs) {
        srv = srvs[i];
        if(srv.avail > n) {
            serverStatus[srv.id].connections++;
            return srv;
        }
        n -= srv.avail;
    }

    utils.log("getFreeConnection(): internal error");
    return {error: "fail"};
};

exports.serverStatus = serverStatus;
exports.info = { };

for(var i = 0; i < settings.servers.length; ++i) {
    serverStatus.push({
        name: settings.servers[i].name,
        lastErrorDate: null,
        error_shown: false,
        connections: 0,
        maxConnections: Math.floor(settings.servers[i].maxconn / 2), // initial connections limit
        lastMaxConnectionUpdate: null
    });
}
