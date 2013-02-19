module.exports = (function() {
    var http;
    this.http = function() {
        if(!http) {
            http = require("http");
        }
        return http;
    };
    this.setHttp = function(newHttp) {
        http = newHttp;
    };

    var mongo;
    this.mongo = function() {
        if(!mongo) {
            mongo = require("mongodb");
        }
        return mongo;
    };
    this.setMongo = function(newMongo) {
        mongo = newMongo;
    };

    var async;
    this.async = function() {
        if(!async) {
            async = require("async");
        }
        return async;
    };

    var utils;
    this.utils = function() {
        if(!utils) {
            utils = require("./utils");
        }
        return utils;
    };

    var settings;
    this.settings = function() {
        if(!settings) {
            settings = require("./settings").settings;
        }
        return settings;
    };

    var status;
    this.status = function() {
        if(!status) {
            status = require("./worker_status");
        }
        return status;
    };

    var db;
    this.db = function() {
        if(!db) {
            db = require("./worker_db");
        }
        return db;
    };

    var get;
    this.get = function() {
        if(!get) {
            get = require("./worker_get");
        }
        return get;
    };

    var req;
    this.req = function() {
        if(!req) {
            req = require("./worker_req");
        }
        return req;
    };

    var cmd;
    this.cmd = function() {
        if(!cmd) {
            cmd = require("./worker_cmd");
        }
        return cmd;
    };

    var url;
    this.url = function() {
        if(!url) {
            url = require("url");
        }
        return url;
    };

    var tcalc;
    this.tcalc = function() {
        if(!tcalc) {
            tcalc = require("./tcalc/tcalc");
        }
        return tcalc;
    };

    var tcalcBase;
    this.tcalcBase = function() {
        if(!tcalcBase) {
            tcalcBase = require("./tcalc/tcalc_base");
        }
        return tcalcBase;
    };

    return this;
})();