/**
 * Module dependencies.
 */

var cluster = require('cluster')
    , express = require("express")
    //, routes = require("./routes")
    , generic = require("./routes/generic")
    , command = require("./routes/command")
    , http = require("http")
    , httpPool = require("./httpPool")
    , path = require("path")
    , settings = require("./settings").settings
    , stat = require("./routes/stat")
    , tcalcBase = require("./tcalc/tcalc_base");

if(cluster.isMaster) {
    require("./master").main();
    return;
}

var app = express();

app.configure(function() {
    app.set("port", settings.port || 3000);
    app.set("views", __dirname + "/views");
    app.set("view engine", "jade");
    app.use(express.favicon());
    app.use(express.logger("dev"));
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(app.router);
    app.use(express.static(path.join(__dirname, "public")));
});

app.configure("development", function() {
    app.use(express.errorHandler());
});

app.configure("production", function() {
    app.enable("trust proxy");
});

app.param(function(name, fn) {
    if(fn instanceof RegExp) {
        return function(req, res, next, val) {
            var group;

            if(fn.global) {
                var captures = [ ];

                while((group = fn.exec(String(val))) !== null) {
                    captures.push(group[0]);
                }
                if(captures.length) {
                    req.params[name] = captures;
                    next();
                    return;
                }
            } else {
                group = fn.exec(String(val));
                if(group) {
                    req.params[name] = group[0];
                    next();
                    return;
                }
            }

            next("route");
        }
    }
});

app.get("/TEST", generic.test);

// TODO is it optimal?
app.param("ids", /(\d+(?:=[\w-]*(?:=[\w-]*)?)?)/g);
app.get("/:ids", generic.stat);

app.param("playerId", /^\d+$/);
app.get("/WN/:playerId", command.wn);
app.get("/INFO/ID/:playerId", command.infoById);

app.param("playerName", /^\w+/);
app.param("region", /(RU)|(EU)|(US)|(NA)|(SEA)|(VTC)|(KR)$/);
app.get("/INFO/:region/:playerName", command.infoByName);
app.get("/INFO/:playerName", command.infoByNameId);

app.get("/STAT", stat.performance);

process.on("message", function(msg) {
    if(msg.info)
        httpPool.info = msg.info;
    else if(msg.twrbase)
        tcalcBase.parseTWRBase(msg.twrbase);
});

http.createServer(app).listen(app.get("port"), function() {
    console.log("Express server listening on port " + app.get("port"));
});