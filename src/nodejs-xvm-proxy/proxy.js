// Create cluster
if (require('cluster').isMaster)
    require("./master").main();
else
    require("./worker").createWorker();
