/**
 * Module dependencies.
 */

var db = require("./db"),
    express = require("express"),
    generic = require("./../routes/generic"),
    command = require("./../routes/command"),
    http = require("http"),
    path = require("path"),
    pipeline = require("./pipeline"),
    settings = require("./../settings"),
    stat = require("./../routes/stat"),
    tcalcBase = require("./../tcalc/tcalc_base");

var app = express();

app.configure(function() {
    app.set("port", settings.port);
    app.set("views", path.join(__dirname + "./../views"));
    app.set("view engine", "jade");
    app.use(express.favicon());
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(app.router);
    app.use(express.static(path.join(__dirname, "./../public")));
});

app.configure("development", function() {
    app.use(express.logger("dev"));
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure("production", function() {
    app.enable("trust proxy");
    app.use(express.errorHandler());
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
        };
    }
});

app.get("/TEST", generic.test);
app.get("/001", generic.test);

// TODO is it optimal?
app.param("ids", /(\d+(?:=[\w-]*(?:=[\w-]*)?)?)/g);
app.get("/:ids", generic.stat);

app.param("playerId", /^\d+$/);
app.get("/WN/:playerId", command.wn);
app.get("/INFO/ID/:playerId", command.infoById);

app.param("playerName", /^\w+$/);
app.param("region", /^(RU)|(EU)|(US)|(NA)|(SEA)|(VTC)|(KR)$/);
app.get("/INFO/:region/:playerName", command.infoByName);
app.get("/INFO/:playerName", command.infoByNameId);

app.get("/STAT", stat.performance);

process.on("message", function(msg) {
    if(msg.info)
        pipeline.setHttpInfo(msg.info);
    else if(msg.twrbase)
        tcalcBase.parseTWRBase(msg.twrbase);
});

db.ctor(function() {
    http.createServer(app).listen(app.get("port"), function() {
        console.log("Express server listening on port " + app.get("port"));
    });
});