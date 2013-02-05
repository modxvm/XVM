////////////////////
// Worker thread

var settings = require("./settings").settings,
    utils = require("./utils"),
    status = require("./worker_status"),
    db = require("./worker_db"),
    http = require("http");

exports.createWorker = function(fakeMongo, fakeHttp) {
    // fakeHttp is for test applications only
    if (fakeHttp)
        http = fakeHttp;

    //handler for messages from master thread
    process.on("message", function(msg) {
        if(msg.info)
            status.info = msg.info;
    });

    // initialize submodules
    status.initialize();
    db.initialize(createHttpServer, fakeMongo);
    require("./tcalc/tcalc_base").parseBaseCsv();
}

// PRIVATE

var createHttpServer = function() {
    // Set max client connections (5 by default)
    http.globalAgent.maxSockets = settings.maxSockets;

    var worker_req = require("./worker_req");
    http.createServer(worker_req.processRequest).listen(settings.port, settings.host);
    utils.log("Server running at http://" + settings.host + ":" + settings.port + "/");
}
