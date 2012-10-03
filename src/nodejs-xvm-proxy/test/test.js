var assert = require("assert"),
    request = require('supertest'),
    worker = require("../worker");

describe("basic", function() {
    it("should return JSON", function(done) {
        request(worker)
            .get("/?1184151,324811,3044017")
            .expect("Content-Type", /json/)
            .expect(200, done);
    })
});