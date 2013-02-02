var serverStatus = exports.serverStatus = [ ];
var info = exports.info = {};

exports.initialize = function() {
    var settings = require("./settings").settings;

    // http status and balancer
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

/*
    // fix connection counter sticking
    setInterval(function() {
        for(var i = 0; i < serverStatus.length; ++i) {
            var n = serverStatus[i].connections || 0;
            if(n >= serverStatus[i].maxConnections)
                serverStatus[i].connections = n - 1;
        }
//    utils.log("conn[worker]: " + serverStatus[0].connections + "/" + serverStatus[0].maxConnections);
    }, 60000);
*/
}
