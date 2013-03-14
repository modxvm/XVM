var pipeline = require("../pipeline");

exports.stat = function(req, res) {
    var ids = req.params.ids;

    process.send({usage: 1, req_in: 1});

    pipeline.generic(ids, function(error, result) {

        process.send({usage: 1, req_out: 1});

        res.json(result);

    });
};

exports.test = function(req, res) {
    res.json({
        id: 1,
        status: "ok"
    });
};