/**
 * XVM Config - "minimap" section
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.types.cfg
{
    public dynamic class CMinimap extends Object
    {
        //minimap: {
            //enabled: true,
            //mapBackgroundImageAlpha: 100,
            //selfIconAlpha: 100,
            //cameraAlpha: 100,
            //iconScale: 1,
            //zoom: {
              //pixelsBack: 160,
              //centered: true
            //},
            //labels: {
              //vehicleclassmacro: {
                //light: "\u2022",
                //medium: "\u2022",
                //heavy: "\u2022",
                //td: "\u2022",
                //spg: "\u25AA",
                //superh: "\u2022"
              //},
              //units: {
                //revealedEnabled: true,
                //lostEnemyEnabled: true,
                //format: {
                  //ally:           "<span class='mm_a'>{{vehicle}}</span>",
                  //teamkiller:     "<span class='mm_t'>{{vehicle}}</span>",
                  //enemy:          "<span class='mm_e'>{{vehicle}}</span>",
                  //squad:          "<textformat leading='-2'><span class='mm_s'><i>{{nick%.5s}}</i>\n{{vehicle}}</span><textformat>",
                  //oneself:        "",
                  //lostally:       "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_la'><i>{{vehicle}}</i></span>",
                  //lostteamkiller: "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_lt'><i>{{vehicle}}</i></span>",
                  //lost:           "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_l'><i>{{vehicle}}</i></span>",
                  //lostsquad:      "<textformat leading='-4'><span class='mm_dot'>{{vehicle-class}}</span><span class='mm_ls'><i>{{nick%.5s}}</i>\n   {{vehicle}}</span><textformat>",
                  //deadally:       "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_da'></span>",
                  //deadteamkiller: "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_dt'></span>",
                  //deadenemy:      "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_de'></span>",
                  //deadsquad:      "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_ds'><i>{{nick%.5s}}</i></span>"
                //},
                //css: {
                  //ally:            ".mm_a{font-family:$FieldFont; font-size:8px; color:#C8FFA6;}",
                  //teamkiller:      ".mm_t{font-family:$FieldFont; font-size:8px; color:#A6F8FF;}",
                  //enemy:           ".mm_e{font-family:$FieldFont; font-size:8px; color:#FCA9A4;}",
                  //squad:           ".mm_s{font-family:$FieldFont; font-size:8px; color:#FFC099;}",
                  //lost:            ".mm_l{font-family:$FieldFont; font-size:8px; color:#FCA9A4;} .mm_dot{font-family:Arial; font-size:17px; color:#FCA9A4;}",
                  //oneself:         ".mm_o{font-family:$FieldFont; font-size:8px; color:#FFFFFF;}",
                  //lostally:       ".mm_la{font-family:$FieldFont; font-size:8px; color:#C8FFA6;} .mm_dot{font-family:Arial; font-size:17px; color:#B4E595;}",
                  //lostteamkiller: ".mm_lt{font-family:$FieldFont; font-size:8px; color:#A6F8FF;} .mm_dot{font-family:Arial; font-size:17px; color:#00D2E5;}",
                  //lost:            ".mm_l{font-family:$FieldFont; font-size:8px; color:#FCA9A4;} .mm_dot{font-family:Arial; font-size:17px; color:#E59995;}",
                  //lostsquad:      ".mm_ls{font-family:$FieldFont; font-size:8px; color:#FFD099;} .mm_dot{font-family:Arial; font-size:17px; color:#E5BB8A;}",
                  //deadally:       ".mm_da{font-family:$FieldFont; font-size:8px; color:#6E8C5B;} .mm_dot{font-family:Arial; font-size:17px; color:#004D00;}",
                  //deadteamkiller: ".mm_dt{font-family:$FieldFont; font-size:8px; color:#5B898C;} .mm_dot{font-family:Arial; font-size:17px; color:#043A40;}",
                  //deadenemy:      ".mm_de{font-family:$FieldFont; font-size:8px; color:#996763;} .mm_dot{font-family:Arial; font-size:17px; color:#4D0300;}",
                  //deadsquad:      ".mm_ds{font-family:$FieldFont; font-size:8px; color:#997C5C;} .mm_dot{font-family:Arial; font-size:17px; color:#663800;}"
                //},
                //shadow: {
                  //ally:
                   //{ enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 4 },
                  //teamkiller:
                   //{ enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 4 },
                  //enemy:
                   //{ enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 4 },
                  //squad:
                   //{ enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 4 },
                  //oneself:
                   //{ enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 4 },
                  //lostally:
                   //{ enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 6, strength: 4 },
                  //lostteamkiller:
                   //{ enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 6, strength: 4 },
                  //lost:
                   //{ enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 6, strength: 4 },
                  //lostsquad:
                   //{ enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 6, strength: 4 },
                  //deadally:
                   //{ enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 3 },
                  //deadteamkiller:
                   //{ enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 3 },
                  //deadenemy:
                   //{ enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 3 },
                  //deadsquad:
                   //{ enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 3 }
                //},
                //offset: {
                  //ally:           {x: 3, y: -1},
                  //teamkiller:     {x: 3, y: -1},
                  //enemy:          {x: 3, y: -1},
                  //squad:          {x: 3, y: -2},
                  //oneself:        {x: 0, y: 0},
                  //lostally:       {x: -5, y: -11},
                  //lostteamkiller: {x: -5, y: -11},
                  //lost:           {x: -5, y: -11},
                  //lostsquad:      {x: -5, y: -11},
                  //deadally:       {x: -5, y: -11},
                  //deadteamkiller: {x: -5, y: -11},
                  //deadenemy:      {x: -5, y: -11},
                  //deadsquad:      {x: -5, y: -11}
                //},
                //alpha : {
                  //ally: 100,
                  //teamkiller: 100,
                  //enemy: 100,
                  //squad: 100,
                  //oneself: 100,
                  //lostally: 70,
                  //lostteamkiller: 70,
                  //lost: 70,
                  //lostsquad: 70,
                  //deadally: 50,
                  //deadteamkiller: 50,
                  //deadenemy: 0,
                  //deadsquad: 50
                //}
              //},
              //mapSize: {
                //enabled: true,
                //format: "<b>{{cellsize}}0 m</b>",
                //css: "font-size:10px; color:#FFCC66;",
                //alpha: 80,
                //offsetX: 0,
                //offsetY: 0,
                //shadow: {
                  //enabled: true,
                  //color: "0x000000",
                  //distance: 0,
                  //angle: 0,
                  //alpha: 80,
                  //blur: 2,
                  //strength: 3
                //},
                //width: 100,
                //height: 30
              //}
            //},
            //circles: {
              //enabled: true,
              //major: [
                //{ enabled: true, distance: 445, thickness: 0.75, alpha: 45, color: 0xFFCC66 },
                //{ enabled: false, distance: 50, thickness: 1, alpha: 100, color: 0xFFFFFF }
              //],
              //special: [
                // level 2
                  //{ su_18:                {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 500 } },
                  //{ gw_mk_vie:            {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 850 } },
                  //{ t57:                  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 553 } },
                  //{ renaultbs:            {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 483 } },
                  //{ gb25_loyd_carrier:    {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 509 } },
                // level 3
                  //{ su_26:                {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1218} },
                  //{ bison_i:              {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 602 } },
                  //{ wespe:                {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 989 } },
                  //{ m7_priest:            {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 989 } },
                  //{ lorraine39_l_am:      {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 983 } },
                  //{ gb27_sexton:          {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1051} },
                  //{ gb78_sexton_i:        {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1051} },
                // level 4
                  //{ su_5:                 {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 613 } },
                  //{ sturmpanzer_ii:       {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 602 } },
                  //{ pz_sfl_ivb:           {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 989 } },
                  //{ m37:                  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 989 } },
                  //{ amx_ob_am105:         {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1288} },
                  //{ gb26_birch_gun:       {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1051} },
                // level 5
                  //{ su122a:               {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1201} },
                  //{ grille:               {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 836 } },
                  //{ m41:                  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1294} },
                  //{ amx_105am:            {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1288} },
                  //{ _105_lefh18b2:        {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1000} },
                  //{ gb28_bishop:          {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 500 } },
                // level 6
                  //{ su_8:                 {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1345} },
                  //{ hummel:               {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1260} },
                  //{ m44:                  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1294} },
                  //{ amx_13f3am:           {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1381} },
                  //{ gb77_fv304:           {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 500 } },
                // level 7
                  //{ s_51:                 {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1264} },
                  //{ su14_1:               {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1264} },
                  //{ g_panther:            {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1300} },
                  //{ m12:                  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1413} },
                  //{ lorraine155_50:       {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1350} },
                  //{ gb29_crusader_5inch:  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1327} },
                // level 8
                  //{ su_14:                {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1264} },
                  //{ gw_tiger_p:           {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1333} },
                  //{ m40m43:               {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1336} },
                  //{ lorraine155_51:       {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1368} },
                  //{ gb79_fv206:           {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1405} },
                // level 9
                  //{ object_212:           {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1264} },
                  //{ g_tiger:              {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1333} },
                  //{ m53_55:               {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1291} },
                  //{ bat_chatillon155_55:  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1413} },
                  //{ gb30_fv3805:          {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1354} },
                // level 10
                  //{ object_261:           {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1470} },
                  //{ g_e:                  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1333} },
                  //{ t92:                  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1411} },
                  //{ bat_chatillon155_58:  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1413} },
                  //{ gb31_conqueror_gun:   {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1007} }
              //]
            //},
            //square: {
              //enabled: false,
              //artilleryEnabled: false,
              //thickness: 0.7,
              //alpha: 40,
              //color: "0xFFFFFF"
            //},
            //lines: {
              //enabled: true,
              //vehicle: [
                //{ enabled: false, from: 20,  to: 300, inmeters: false, thickness: 0.4, alpha: 35, color: 0xFFCC66 }
              //],
              //camera: [
                //{ enabled: false, from: 50,  to: 100, inmeters: true, thickness: 2,   alpha: 60, color: 0xEE0044},
                //{ enabled: false, from: 200, to: 300, inmeters: true, thickness: 1.5, alpha: 45, color: 0xEE0044},
                //{ enabled: false, from: 350, to: 445, inmeters: true, thickness: 1,   alpha: 30, color: 0xEE0044}
              //],
              //traverseAngle: [
                //{ enabled: true, from: 20,  to: 300, inmeters: false, thickness: 0.4, alpha: 35, color: 0xFFCC66}
              //]
            //}
        //},
    }
}
