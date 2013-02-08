////////////////////
// Worker thread

module.exports = (function() {
    var settings = require("./settings").settings,
        utils = require("./utils"),
        status = require("./worker_status"),
        db = require("./worker_db"),
        http;

    var createWorker = function(fakeMongo, fakeHttp) {
        // fakes is for test applications only
        http = fakeHttp || require("http");

        //handler for messages from master thread
        process.on("message", function(msg) {
            if(msg.info)
                status.info = msg.info;
        });

        // initialize submodules
        status.initialize();
        db.initialize(_createHttpServer, fakeMongo);
        require("./tcalc/tcalc_base").parseBaseCsv();
    };

    var _createHttpServer = function() {
        // Set max client connections (5 by default)
        http.globalAgent.maxSockets = settings.maxSockets;

        var worker_req = require("./worker_req");

        http.createServer(worker_req.processRequest).listen(settings.port, settings.host);
        utils.log("Server running at http://" + settings.host + ":" + settings.port + "/");
    };

    return {
        createWorker: createWorker
    }
})();
