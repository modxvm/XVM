limit = 0
//limit = 10000
toplen = 100

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
            if (!v.d)
                continue;

            var key = {
                region: 0, // Math.floor(doc._id / 500000000),
                vname: v.name.toUpperCase()
            }

            if (!data[key.region][key.vname]) {
                data[key.region][key.vname] = {
                    region: region[key.region],
                    vname: key.vname,
                    hp: hp[key.vname.replace(/-/g, "_")],
                    cl: v.cl,
                    l: v.l,
                    cnt:0, b:0, d:0, f:0, s:0, w:0,
                    topD:[], topED:[], topF:[], topS:[]
                };
            }

            var d = data[key.region][key.vname];
            d.cnt++;
            d.b += v.b || 0;
            d.w += v.w || 0;
            d.d += v.d || 0;
            d.f += v.f || 0;
            d.s += v.s || 0;
            if (v.b > 100)
            {
//                if (d.vname == "T1_E6") {
                updateTopData(d.topD, (v.d || 0) / v.b);
                if (d.hp > 0)
                    updateTopData(d.topED, (v.d || 0) / v.b / d.hp);
                updateTopData(d.topF, (v.f || 0) / v.b);
                updateTopData(d.topS, (v.s || 0) / v.b);
//                printjson(d.topD);
//                }
            }
        }
    });
}

var hp = {

_105_LEFH18B2: 260,
A_20: 340,
A_32: 360,
AMX_105AM: 240,
AMX_12T: 600,
AMX_13_75: 900,
AMX_13_90: 1100,
AMX_13F3AM: 300,
AMX_50_100: 1400,
AMX_50_120: 1750,
AMX_50FOSH_155: 1850,
AMX_AC_MLE1946: 820,
AMX_AC_MLE1948: 1000,
AMX_M4_1945: 1200,
AMX38: 220,
AMX40: 300,
AMX50_FOCH: 1550,
ARL_44: 820,
ARL_V39: 610,
AT_1: 125,
B1: 420,
B_1BIS_CAPTURED: 400,
BAT_CHATILLON155: 620,
BAT_CHATILLON25T: 1800,
BDR_G1B: 650,
BISON_I: 140,
BT_2: 160,
BT_7: 220,
BT_SV: 240,
CH01_TYPE59: 1300,
CH01_TYPE59_GOLD: 1300,
CH02_TYPE62: 690,
CH03_WZ_111: 1550,
CH04_T34_1: 1100,
CH05_T34_2: 1350,
CH06_RENAULT_NC31: 105,
CH07_VICKERS_MKE_TYPE_BT26: 170,
CH08_TYPE97_CHI_HA: 250,
CH09_M5: 340,
CH10_IS2: 1280,
CH11_110: 1550,
CH12_111_1_2_3: 1850,
CH13_111_4_5: 2400,
CH15_59_16: 580,
CH16_WZ_131: 900,
CH17_WZ131_1_WZ132: 1100,
CH18_WZ_120: 1650,
CH19_121: 1950,
CH20_TYPE58: 750,
CH21_T34: 450,
CHURCHILL_LL: 700,
D1: 170,
D2: 230,
DICKERMAX: 550,
E_100: 2700,
E_50: 1750,
E50_AUSF_M: 2050,
E_75: 1920,
ELC_AMX: 400,
F10_AMX_50B: 2100,
FCM_36PAK40: 180,
FCM_50T: 1500,
FERDINAND: 1200,
G_E: 660,
G_PANTHER: 410,
G_TIGER: 570,
G20_MARDER_II: 165,
GAZ_74B: 260,
GB01_MEDIUM_MARK_I: 140,
GB03_CRUISER_MK_I: 170,
GB04_VALENTINE: 340,
GB05_VICKERS_MEDIUM_MK_II: 190,
GB06_VICKERS_MEDIUM_MK_III: 280,
GB07_MATILDA: 370,
GB08_CHURCHILL_I: 700,
GB09_CHURCHILL_VII: 880,
GB10_BLACK_PRINCE: 1450,
GB11_CAERNARVON: 1600,
GB12_CONQUEROR: 1950,
GB13_FV215B: 2600,
GB20_CRUSADER: 450,
GB21_CROMWELL: 750,
GB22_COMET: 1150,
GB23_CENTURION: 1450,
GB24_CENTURION_MK3: 1720,
GB58_CRUISER_MK_III: 150,
GB59_CRUISER_MK_IV: 230,
GB60_COVENANTER: 340,
GB63_TOG_II: 1400,
GB68_MATILDA_BLACK_PRINCE: 610,
GB69_CRUISER_MK_II: 240,
GB70_FV4202_105: 1950,
GB71_AT_15A: 880,
GRILLE: 240,
H39_CAPTURED: 160,
HETZER: 270,
HOTCHKISS_H35: 140,
HUMMEL: 320,
IS: 1230,
IS_3: 1500,
IS_4: 2500,
IS_7: 2150,
IS8: 1800,
ISU_152: 1010,
JAGDPANTHER: 850,
JAGDPANTHERII: 1150,
JAGDPZ_E100: 2200,
JAGDPZIV: 600,
JAGDTIGER: 1800,
JAGDTIGER_SDKFZ_185: 1300,
KV: 660,
KV1: 640,
KV_13: 1120,
KV_1S: 810,
KV2: 860,
KV_220: 690,
KV_220_ACTION: 690,
KV_3: 1400,
KV4: 1650,
KV_5: 1780,
LORRAINE155_50: 400,
LORRAINE155_51: 540,
LORRAINE39_L_AM: 160,
LORRAINE40T: 1550,
LOWE: 1650,
LTRAKTOR: 130,
M10_WOLVERINE: 360,
M103: 1850,
M12: 400,
M18_HELLCAT: 570,
M2_LT: 160,
M2_MED: 210,
M22_LOCUST: 250,
M24_CHAFFEE: 580,
M3_GRANT: 310,
M3_STUART: 240,
M3_STUART_LL: 220,
M36_SLAGGER: 590,
M37: 160,
M4_SHERMAN: 460,
M40M43: 530,
M41: 300,
M46_PATTON: 1700,
M48A1: 2000,
M4A2E4: 480,
M4A3E8_SHERMAN: 750,
M5_STUART: 340,
M6: 870,
M6A2E1: 1500,
M7_MED: 440,
M7_PRIEST: 240,
M8A1: 265,
MATILDA_II_LL: 610,
MAUS: 3000,
MS_1: 100,
MTLS_1G14: 250,
OBJECT_212: 560,
OBJECT_261: 650,
OBJECT_704: 1600,
OBJECT252: 1550,
OBJECT263: 1900,
OBJECT268: 1950,
OBSERVER: 90,
PANTHER_II: 1450,
PANTHER_M10: 1300,
PANZERJAGER_I: 120,
PERSHING: 1440,
PZ35T: 180,
PZ38_NA: 340,
PZ38T: 250,
PZII: 170,
PZII_J: 260,
PZII_LUCHS: 230,
PZIII: 350,
PZIII_A: 240,
PZIII_IV: 440,
PZIV: 460,
PZIV_HYDRO: 580,
PZIV_SCHMALTURM: 730,
PZV: 1270,
PZV_PZIV: 870,
PZV_PZIV_AUSF_ALFA: 870,
PZVI: 1450,
PZVI_TIGER_P: 1450,
PZVIB_TIGER_II: 1600,
RAM_II: 610,
RENAULTBS: 140,
RENAULTFT: 115,
RENAULTFT_AC: 120,
RENAULTUE57: 150,
S_35CA: 330,
S35_CAPTURED: 260,
S_51: 380,
SHERMAN_JUMBO: 760,
SOMUA_SAU_40: 280,
ST_I: 1900,
STUGIII: 350,
STURMPANZER_II: 160,
SU_85I: 380,
SU_100: 580,
SU100M1: 830,
SU100Y: 700,
SU_101: 990,
SU122_44: 840,
SU122_54: 1530,
SU_14: 460,
SU_152: 870,
SU_18: 140,
SU_26: 150,
SU_5: 230,
SU_76: 155,
SU_8: 310,
SU_85: 350,
T_50_2: 560,
T1_CUNNINGHAM: 115,
T1_E6: 170,
T1_HVY: 660,
T110: 2200,
T110E3: 2050,
T110E4: 2000,
T_127: 250,
T14: 690,
T_15: 260,
T150: 880,
T18: 125,
T2_LT: 150,
T2_MED: 170,
T20: 1100,
T21: 590,
T23: 1440,
T_25: 610,
T25_2: 850,
T25_AT: 840,
T_26: 180,
T26_E4_SUPERPERSHING: 1450,
T28: 1150,
T_28: 350,
T28_PROTOTYPE: 1150,
T29: 1250,
T30: 1650,
T32: 1550,
T_34: 450,
T34_HVY: 1500,
T_34_85: 720,
T40: 275,
T_43: 1100,
T_44: 1300,
T_46: 250,
T49: 360,
T_50: 360,
T_54: 1650,
T54E1: 1750,
T57: 140,
T57_58: 2150,
T62A: 1950,
T69: 1350,
T71: 840,
T82: 160,
T92: 630,
T95: 1700,
TETRARCH_LL: 140,
VALENTINE_LL: 380,
VK1602: 390,
VK2801: 610,
VK3001H: 750,
VK3001P: 710,
VK3002DB: 1250,
VK3601H: 850,
VK4502A: 1570,
VK4502P: 1950,
WESPE: 160

}

go()
save_data();
