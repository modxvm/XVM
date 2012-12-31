var http = require("http"),
    url = require("url"),
    settings = require("./settings"),
    port = 2080,
    host = "127.0.0.1";

var getStatHostId = function(id) {
    var result = Math.floor(id / 500000000);
    return (result >= 0 && result < settings.statHosts.length) ? result : -1;
};

var processRequest = function(req, res) {
    var id = url.parse(req.url).query;

    if(!id || !id.match(/^\d+$/)) {
        res.statusCode = 403; // Forbidden
        res.end("Invalid player ID");
        return;
    }

    var statHostId = getStatHostId(id);

    var reqTimeout = setTimeout(function() {
        res.statusCode = 503; // Service Unavailable
        res.end("Service Unavailable");
    }, settings.statHostsTimeouts[statHostId]);

    var options = {
        host: settings.statHosts[statHostId],
        port: 80,
        path: "/uc/accounts/" + id + "/api/" + settings.wotApiVersion + "/?source_token=Intellect_Soft-WoT_Mobile-unofficial_stats"
    };

    var request = http.get(options, function(response) {
        var responseData = "";
        response.setEncoding("utf8");
        response.on("data", function(chunk) {
            responseData += chunk;
        });
        response.on("end", function() {
            clearTimeout(reqTimeout);
            res.end(responseData);
        });
    });
    request.on("error", function(e) {
        clearTimeout(reqTimeout);
        res.statusCode = 503; // Service Unavailable
        res.end("Service Unavailable");
    });

    request.shouldKeepAlive = false;
};

http.createServer(processRequest).listen(port, host);
console.log("Server running at http://" + host + ":" + port + "/");