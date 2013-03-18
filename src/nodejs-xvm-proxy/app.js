// Create cluster
var cluster = require('cluster');

if (cluster.isMaster)
    require("./master").main();
else {
    require("./" + process.env.type + "/" + process.env.type);
}