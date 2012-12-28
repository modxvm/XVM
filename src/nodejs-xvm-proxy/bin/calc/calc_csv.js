limit=10000
print("id;name;battles;wins;tank;Tlevel;Tclass;Tbattles;Twins;Tdamage;Tfrags")

var go = function() {

    var id = Math.round(Math.random() * 20000000);
    var ok = false;
    db.players.find({_id:id}).limit(limit).forEach(function(doc) {
        if (doc.v == null)
            return;

        var s = doc._id + ";" + doc.nm + ";" + doc.b + ";" + doc.w;
        var s2 = "";
        for (i in doc.v) {
            var v = doc.v[i];

            // skip items without data
            if (!v.d || !v.b || !v.cl || !v.l)
                continue;

            print(s + ";" + v.name.toLowerCase() + ";" + v.l + ";" + v.cl + ";" + v.b + ";" + v.w + ";" + v.d + ";" + v.f);
            ok = true;
        }
    });

    return ok;
}

//go()
n = 0;
while(n < limit) {
    if (go() == true)
        n++;
}
