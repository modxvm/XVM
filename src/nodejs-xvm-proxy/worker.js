////////////////////
// Worker thread

module.exports = (function() {
    var includer = require("./includer"),
        settings = includer.settings(),
        utils = includer.utils(),
        status = includer.status(),
        db = includer.db(),
        tcalc_base = includer.tcalcBase();

    var createWorker = function(fakeMongo, fakeHttp) {
        //handler for messages from master thread
        process.on("message", function(msg) {
            if(msg.info)
                status.info = msg.info;
            else if(msg.twrbase)
                tcalc_base.parseTWRBase(msg.twrbase);
        });

        // initialize submodules
        status.initialize();
        db.initialize(_createHttpServer, fakeMongo);
    };

    var _createHttpServer = function() {
        // Set max client connections (5 by default)
        includer.http().globalAgent.maxSockets = settings.maxSockets;

        var worker_req = includer.req();

        includer.http().createServer(worker_req.processRequest).listen(settings.port, settings.host);
        utils.log("Server running at http://" + settings.host + ":" + settings.port + "/");
    };

    return {
        createWorker: createWorker
    }
})();
