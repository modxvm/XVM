limit = 0
//limit = 10000
toplen = 100
minB = 100

var region = [ "RU", "EU", "US" ];
var data = [ {}, {}, {} ];

var save_data = function() {
    print("Save data into DB...");

    db.vstat.drop();
    for (var cl in data)
    {
        for (var v in data[cl])
            db.vstat.insert(data[cl][v]);
    }
    db.vstat.ensureIndex({region:1, vname: 1});

    print("Done.");
}

var updateTopData = function(top, value) {
    if (top.length > toplen)
    {
        if (top[0] >= value)
            return;
        top.shift();
    }
    top.push(value);
    top = top.sort(function(a,b){ return a>b?1:a<b?-1:0 });
}


var go = function() {
    var n = 0;

    db.players.find({_id:{$lt:500000000}}).sort({_id:1}).limit(limit).forEach(function(doc) {
        n++;
        if (n % 1000 == 0)
            print(n + ": " + doc._id);
        if (n % 10000 == 0)
            save_data();

        if (doc.v == null)
            return;

        for (i in doc.v) {
            var v = doc.v[i];

            // skip items without data
            if (!v.l || !v.b || v.b < (minB*v.l/10) || !v.w || !v.d || !v.f || ! v.s)
                continue;

            var key = {
                region: 0, // Math.floor(doc._id / 500000000),
                vname: v.name.toUpperCase()
            }

            if (!data[key.region][key.vname]) {
                var hp = HP[key.vname.replace(/-/g, "_")];
                if (!hp)
                    print("Warning: no HP for " + key.vname.replace(/-/g, "_"));
                data[key.region][key.vname] = {
                    region: region[key.region],
                    vname: key.vname,
                    hp: hp,
                    cl: v.cl,
                    l: v.l,
                    cnt:0, b:0, d:0, f:0, s:0, w:0,
                    topD:[], topED:[], topF:[], topS:[]
                };
            }

            var d = data[key.region][key.vname];
            d.cnt++;
            d.b += v.b;
            d.w += v.w;
            d.d += v.d;
            d.f += v.f;
            d.s += v.s;

            if (v.b > minB)
            {
//            if (d.vname == "T1_E6") {
                var D = v.d / v.b;
                if (D > 4000)
                    print("[D>4000]: " + doc._id + "[" + v.name + "]: D=" + D.toFixed(0) + " B=" + v.b);

                updateTopData(d.topD, D);
                if (d.hp > 0)
                    updateTopData(d.topED, D / d.hp);
                updateTopData(d.topF, v.f / v.b);
                updateTopData(d.topS, v.s / v.b);
//                printjson(d.topD);
//            }
            }
        }
    });
}

var HP = {

MS_1: 100,
LTRAKTOR: 130,
T1_CUNNINGHAM: 115,
RENAULTFT: 115,
CH06_RENAULT_NC31: 110,
GB01_MEDIUM_MARK_I: 140,
BT_2: 160,
T_26: 180,
TETRARCH_LL: 140,
H39_CAPTURED: 160,
PZ35T: 180,
PZII: 170,
M2_LT: 160,
T1_E6: 160,
T2_LT: 150,
D1: 170,
HOTCHKISS_H35: 140,
GB03_CRUISER_MK_I: 170,
GB58_CRUISER_MK_III: 150,
CH07_VICKERS_MKE_TYPE_BT26: 170,
T2_MED: 170,
GB05_VICKERS_MEDIUM_MK_II: 190,
AT_1: 125,
PANZERJAGER_I: 120,
T18: 125,
RENAULTFT_AC: 120,
SU_18: 100,
BISON_I: 120,
T57: 115,
RENAULTBS: 110,
BT_7: 220,
BT_SV: 240,
M3_STUART_LL: 220,
T_127: 250,
T_46: 250,
PZ38T: 250,
PZII_J: 260,
PZII_LUCHS: 230,
PZIII_A: 240,
T_15: 260,
M22_LOCUST: 250,
M3_STUART: 240,
MTLS_1G14: 250,
AMX38: 220,
GB59_CRUISER_MK_IV: 230,
GB69_CRUISER_MK_II: 240,
CH08_TYPE97_CHI_HA: 240,
S35_CAPTURED: 260,
M2_MED: 210,
D2: 230,
GB06_VICKERS_MEDIUM_MK_III: 280,
SU_76: 155,
G20_MARDER_II: 165,
T82: 160,
FCM_36PAK40: 180,
RENAULTUE57: 150,
SU_26: 140,
STURMPANZER_II: 160,
WESPE: 170,
M37: 150,
LORRAINE39_L_AM: 140,
A_20: 340,
T_50: 360,
VALENTINE_LL: 380,
PZ38_NA: 340,
VK1602: 390,
M5_STUART: 340,
AMX40: 300,
GB04_VALENTINE: 340,
GB60_COVENANTER: 340,
CH09_M5: 340,
A_32: 360,
T_28: 350,
PZIII: 350,
M3_GRANT: 310,
GB07_MATILDA: 370,
B_1BIS_CAPTURED: 400,
B1: 420,
GAZ_74B: 260,
HETZER: 270,
M8A1: 265,
T40: 275,
SOMUA_SAU_40: 280,
SU_5: 180,
GRILLE: 220,
M7_PRIEST: 210,
_105_LEFH18B2: 260,
AMX_105AM: 200,
T_50_2: 560,
VK2801: 610,
M24_CHAFFEE: 580,
ELC_AMX: 400,
GB20_CRUSADER: 450,
MATILDA_II_LL: 610,
T_34: 450,
PZIII_IV: 440,
PZIV: 460,
PZIV_HYDRO: 580,
T_25: 610,
M4_SHERMAN: 460,
M4A2E4: 480,
M7_MED: 440,
RAM_II: 610,
GB68_MATILDA_BLACK_PRINCE: 610,
CH21_T34: 450,
CHURCHILL_LL: 700,
KV: 660,
KV1: 640,
KV_220: 690,
KV_220_ACTION: 690,
T1_HVY: 660,
T14: 690,
BDR_G1B: 650,
GB08_CHURCHILL_I: 700,
SU_85I: 380,
SU_85: 350,
STUGIII: 350,
M10_WOLVERINE: 360,
T49: 360,
S_35CA: 330,
SU_8: 260,
HUMMEL: 280,
M41: 250,
AMX_13F3AM: 240,
T21: 590,
AMX_12T: 600,
CH15_59_16: 580,
T_34_85: 720,
PZIV_SCHMALTURM: 730,
PZV_PZIV: 870,
PZV_PZIV_AUSF_ALFA: 870,
VK3001H: 750,
VK3001P: 710,
VK3601H: 850,
M4A3E8_SHERMAN: 750,
SHERMAN_JUMBO: 760,
GB21_CROMWELL: 750,
CH20_TYPE58: 750,
KV_1S: 810,
KV2: 860,
T150: 880,
M6: 870,
ARL_44: 820,
GB09_CHURCHILL_VII: 880,
GB63_TOG_II: 1400,
SU_100: 580,
SU100Y: 700,
DICKERMAX: 550,
JAGDPZIV: 600,
M18_HELLCAT: 570,
M36_SLAGGER: 590,
ARL_V39: 610,
S_51: 310,
SU_14: 370,
G_PANTHER: 350,
M12: 340,
LORRAINE155_50: 330,
T71: 840,
AMX_13_75: 900,
CH02_TYPE62: 880,
CH16_WZ_131: 880,
KV_13: 1120,
T_43: 1100,
PANTHER_M10: 1300,
PZV: 1270,
VK3002DB: 1250,
T20: 1100,
GB22_COMET: 1150,
CH04_T34_1: 1050,
IS: 1230,
KV_3: 1400,
PZVI: 1450,
PZVI_TIGER_P: 1450,
T29: 1250,
AMX_M4_1945: 1200,
GB10_BLACK_PRINCE: 1450,
CH10_IS2: 1280,
SU100M1: 830,
SU122_44: 840,
SU_152: 870,
JAGDPANTHER: 850,
T25_2: 850,
T25_AT: 840,
AMX_AC_MLE1946: 820,
GB71_AT_15A: 850,
OBJECT_212: 460,
G_TIGER: 470,
M40M43: 410,
LORRAINE155_51: 400,
AMX_13_90: 1100,
CH17_WZ131_1_WZ132: 1050,
T_44: 1300,
PANTHER_II: 1450,
PERSHING: 1440,
T23: 1440,
T26_E4_SUPERPERSHING: 1450,
T69: 1350,
GB23_CENTURION: 1450,
CH01_TYPE59: 1300,
CH01_TYPE59_GOLD: 1300,
CH05_T34_2: 1300,
IS_3: 1500,
KV4: 1650,
KV_5: 1780,
OBJECT252: 1550,
LOWE: 1650,
PZVIB_TIGER_II: 1600,
VK4502A: 1570,
M6A2E1: 1500,
T32: 1550,
T34_HVY: 1500,
AMX_50_100: 1400,
FCM_50T: 1500,
GB11_CAERNARVON: 1600,
CH03_WZ_111: 1550,
CH11_110: 1550,
ISU_152: 1010,
SU_101: 990,
FERDINAND: 1200,
JAGDPANTHERII: 1150,
JAGDTIGER_SDKFZ_185: 1300,
T28: 1150,
T28_PROTOTYPE: 1150,
AMX_AC_MLE1948: 1000,
OBJECT_261: 520,
G_E: 580,
T92: 500,
BAT_CHATILLON155: 480,
T_54: 1650,
E_50: 1750,
M46_PATTON: 1700,
T54E1: 1750,
LORRAINE40T: 1550,
GB24_CENTURION_MK3: 1720,
CH18_WZ_120: 1650,
IS8: 1800,
ST_I: 1900,
E_75: 1920,
VK4502P: 1950,
M103: 1850,
AMX_50_120: 1750,
GB12_CONQUEROR: 1950,
CH12_111_1_2_3: 1850,
OBJECT_704: 1600,
SU122_54: 1530,
JAGDTIGER: 1800,
T30: 1650,
T95: 1700,
AMX50_FOCH: 1550,
T62A: 1950,
E50_AUSF_M: 2050,
M48A1: 2000,
BAT_CHATILLON25T: 1800,
GB70_FV4202_105: 1950,
CH19_121: 1950,
IS_4: 2500,
IS_7: 2150,
E_100: 2700,
MAUS: 3000,
T110: 2200,
T57_58: 2250,
F10_AMX_50B: 2100,
GB13_FV215B: 2500,
CH22_113: 2300,
OBJECT263: 1900,
OBJECT268: 1950,
JAGDPZ_E100: 2200,
T110E3: 2050,
T110E4: 2000,
AMX_50FOSH_155: 1850

}

go()
save_data();
