import com.xvm.ColorPalette;
import com.xvm.Defines;
import com.xvm.Locale;
import com.xvm.VehicleInfo;

class com.xvm.DefaultConfig
{
    public static function get config(): Object
    {
        var d:Date = new Date();
        var a:Object =
        {
            configVersion: Defines.CONFIG_VERSION,
            editorVersion: Defines.EDITOR_VERSION,
            definition: {
                author: "XVM",
                description: "Default settings for XVM",
                url: "http://code.google.com/p/wot-xvm/",
                date: (d.getDate() < 10 ? "0" : "") + d.getDate() + "." +
                    (d.getMonth() < 9 ? "0" : "") + (d.getMonth() + 1) + "." + d.getFullYear(),
                gameVersion: Defines.WOT_VERSION,
                modMinVersion: Defines.XVM_VERSION
            },
            language: Defines.LOCALE_AUTO_DETECTION,
            login: {
                // Show ping to the servers
                pingServers: {
                    enabled: false,
                    showPingOnGameLoading: true,
                    updateInterval: 10000, // msec
                    x: 15,
                    y: 35,
                    alpha: 80,
                    delimiter: ": ",
                    maxRows: 4,
                    columnGap: 10,
                    fontStyle: {
                        name: "$FieldFont",
                        size: 12,
                        bold: false,
                        italic: false,
                        color: {
                            great: "0xFFCC66",
                            good: "0xE5E4E1",
                            poor: "0x96948F",
                            bad: "0xD64D4D"
                        }
                    },
                    threshold: {
                        great: 30,
                        good: 60,
                        poor: 100
                    },
                    shadow: {
                        enabled: true,
                        color: "0x000000",
                        distance: 0,
                        angle: 0,
                        alpha: 70,
                        blur: 4,
                        strength: 2
                    }
                }
            },
            hangar: {
                hideTutorial: false,
                xwnInCompany: true,
                widgetsEnabled: false,
                // Show ping to the servers
                pingServers: {
                    enabled: false,
                    updateInterval: 10000, // msec
                    x: 170,
                    y: 35,
                    alpha: 80,
                    delimiter: ": ",
                    maxRows: 4,
                    columnGap: 10,
                    fontStyle: {
                        name: "$FieldFont",
                        size: 12,
                        bold: false,
                        italic: false,
                        color: {
                            great: "0xFFCC66",
                            good: "0xE5E4E1",
                            poor: "0x96948F",
                            bad: "0xD64D4D"
                        }
                    },
                    threshold: {
                        great: 30,
                        good: 60,
                        poor: 100
                    },
                    shadow: {
                        enabled: true,
                        color: "0x000000",
                        distance: 0,
                        angle: 0,
                        alpha: 70,
                        blur: 4,
                        strength: 2
                    }
                }
            },
            battle: {
                mirroredVehicleIcons: true,      // Set false for alternative tank icon mirroring.
                showPostmortemTips: true,        // Popup tooltip panel after death.
                removePanelsModeSwitcher: false, // Set true to hide mouse modes switcher.
                highlightVehicleIcon: true,      // False - disable highlighting of selected vehicle icon and squad.
                useStandardMarkers: false,       // Use original wot markers.
                // Show the clock on the Debug Panel (near FPS).
                // Format: Y:year, M:month, D:day, H:hour, N:minutes, S:seconds.
                clockFormat: "H:N",
                clanIconsFolder: "clanicons/",   // Folder with clan icons
                // Visual elements
                elements: []
            },
            rating: {
                showPlayersStatistics: true,    // Global switch. Handles whole statisctics module.
                loadEnemyStatsInFogOfWar: true, // Load players data in "fog of war".
                enableStatisticsLog: false,     // Enable saving statistics to "xvm-stat.log" file
                enableUserInfoStatistics: true, // Enable statistics in the user info window
                enableCompanyStatistics: true   // Enable statistics in the company window
            },
            squad: {
                enabled: true,     // Global switch
                romanNumbers: true, // Roman level numbers
                showClan: true,     // Show player clan
                leftLvlBorder: "",  // Grille [4
                rightLvlBorder: ""  // Grille 4]
            },
            userInfo: {
                showFilters: true,              // Show tank filters
                filterFocused: true,            // Set the default focus to the filter text input
                inHangarFilterEnabled: false,   // Enable In hangar radio button by default
                showEColumn: false,             // Show column for per-vehicle efficiency
                sortColumn: 6                   // Number of column for sorting
            },
            fragCorrelation: {
                hideTeamTextFields: true
            },
            hotkeys: {
                minimapZoom: { enabled: false, onHold: true, keyCode: 17 } // 17 - Ctrl
                /*
                minimapExtended: { enabled: true, onHold: true, keycode: 16 } // 16 - Alt?
                messages: [
                  {  enabled: true, keycode: 113, text: "ШАНСЫ 5% АЙДА ТАПИЦА" }, // F2
                  {  enabled: true, keycode: 114, text: "☆\nhey!\n☆" } // .split("\n")
                ]
                */
            },
            battleLoading: {
                // Show clock at Battle Loading Screen.
                // ### Is there a clock:on\off switch variable supposed to be? ###
                // A: No, it is possible to set clockFormat: "" to disable clock.

                // Format: Y:year, M:month, D:day, H:hour, N:minutes, S:seconds.
                clockFormat: "H:N:S",
                showChances: false,     // Show game round win chances percentage.
                showChancesExp: false,  // Show experimental "chance to win" formula.
                removeSquadIcon: false, // Hide squad icon.
                // Playes/clan icon parameters.
                clanIcon: { show: true, x: 0, y: 6, xr: 0, yr: 6, h: 16, w: 16, alpha: 90 },
                // Dispay format. Macro-substitutiones allowed.
                formatLeft: "{{vehicle}}<font face='Lucida Console' size='12'> <font color='{{c:kb}}'>{{kb:3}}</font> <font color='{{c:xwn}}'>{{xwn}}</font> <font color='{{c:rating}}'>{{rating:3}}</font></font>",
                formatRight: "<font face='Lucida Console' size='12'><font color='{{c:rating}}'>{{rating:3}}</font> <font color='{{c:xwn}}'>{{xwn}}</font> <font color='{{c:kb}}'>{{kb:3}}</font> </font>{{vehicle}}"
            },
            statisticForm: {
                showChances: false,     // Show game round win chances percentage.
                showChancesExp: false,  // Show experimental "chance to win" formula.
                removeSquadIcon: false, // Hide squad icon.
                // Playes/clan icon parameters.
                clanIcon: { show: true, x: 0, y: 6, xr: 0, yr: 6, h: 16, w: 16, alpha: 90 },
                // Dispay format.
                formatLeft: "{{vehicle}}<font face='Lucida Console' size='12'> <font color='{{c:kb}}'>{{kb:3}}</font> <font color='{{c:xwn}}'>{{xwn}}</font> <font color='{{c:rating}}'>{{rating:3}}</font></font>",
                formatRight: "<font face='Lucida Console' size='12'><font color='{{c:rating}}'>{{rating:3}}</font> <font color='{{c:xwn}}'>{{xwn}}</font> <font color='{{c:kb}}'>{{kb:3}}</font> </font>{{vehicle}}"
            },
            playersPanel: {
                alpha: 60,              // Side panel transparency. 0 - transparent, 100 - opaque.
                iconAlpha: 100,         // Side panel icons transparency. 0 - transparent, 100 - opaque.
                removeSquadIcon: false, // Hide squad icon.
                // Playes/clan icon parameters.
                clanIcon: { show: true, x: 0, y: 6, xr: 0, yr: 6, h: 16, w: 16, alpha: 90 },
                // Display options for icons of never seen enemies
                enemySpottedMarker: {
                  enabled: false,
                  Xoffset: -22,
                  Yoffset: -2,
                  format: {
                    neverSeen: "<FONT FACE=\"$FieldFont\" SIZE=\"24\" COLOR=\"#DDDDDD\">*</FONT>",
                    lost: "",
                    revealed: "",
                    dead: "",
                    artillery: {
                      neverSeen: "",
                      lost: "",
                      revealed: "",
                      dead: ""
                    }
                  }
                },
                // Medium1 mode.
                medium: {
                    // 0..250 - player name field width.
                    width: 46,
                    // Dispay format.
                    formatLeft: "<font color='{{c:xwn}}'>{{nick}}</font>",
                    formatRight: "<font color='{{c:xwn}}'>{{nick}}</font>"
                },
                // Medium2 mode.
                medium2: {
                    // 0..250 - player name field width.
                    width: 65,
                    // Dispay format.
                    formatLeft: "<font color='{{c:xwn}}'>{{vehicle}}</font>",
                    formatRight: "<font color='{{c:xwn}}'>{{vehicle}}</font>"
                },
                // Large mode.
                large: {
                    // 0..250 - player name field width.
                    width: 170,
                    // Dispay format.
                    nickFormatLeft: "<font color='{{c:rating}}'>{{rating}}</font> {{nick}}",
                    nickFormatRight: "{{nick}} <font color='{{c:rating}}'>{{rating}}</font>",
                    vehicleFormatLeft: "<font color='{{c:xwn}}'>{{vehicle}}</font>",
                    vehicleFormatRight: "<font color='{{c:xwn}}'>{{vehicle}}</font>"
                }
            },
            finalStatistic: {
                startPage: 1,
                sortColumn: 6, // XP
                showChances: false,
                showChancesExp: false
            },
            turretMarkers: {
                highVulnerability: "*",
                lowVulnerability: "'"
            },
            expertPanel: {
              delay: 15,
              scale: 150
            },
            minimap: {
                enabled: true,
                mapBackgroundImageAlpha: 100,
                selfIconAlpha: 100,
                cameraAlpha: 100,
                iconScale: 1,
                zoom: {
                  pixelsBack: 160,
                  centered: true
                },
                labels: {
                  nickShrink: 5,
                  vehicleclassmacro: {
                    light: "\u2022",
                    medium: "\u2022",
                    heavy: "\u2022",
                    td: "\u2022",
                    spg: "\u25AA",
                    superh: "\u2022"
                  },
                  units: {
                    revealedEnabled: true,
                    lostEnemyEnabled: true,
                    format: {
                      ally:           "<span class='mm_a'>{{vehicle}}</span>",
                      teamkiller:     "<span class='mm_t'>{{vehicle}}</span>",
                      enemy:          "<span class='mm_e'>{{vehicle}}</span>",
                      squad:          "<textformat leading='-2'><span class='mm_s'><i>{{short-nick}}</i>\n{{vehicle}}</span><textformat>",
                      oneself:        "",
                      lostally:       "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_la'><i>{{vehicle}}</i></span>",
                      lostteamkiller: "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_lt'><i>{{vehicle}}</i></span>",
                      lost:           "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_l'><i>{{vehicle}}</i></span>",
                      lostsquad:      "<textformat leading='-4'><span class='mm_dot'>{{vehicle-class}}</span><span class='mm_ls'><i>{{short-nick}}</i>\n   {{vehicle}}</span><textformat>",
                      deadally:       "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_da'></span>",
                      deadteamkiller: "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_dt'></span>",
                      deadenemy:      "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_de'></span>",
                      deadsquad:      "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_ds'><i>{{short-nick}}</i></span>"
                    },
                    css: {
                      ally:            ".mm_a{font-family:$FieldFont; font-size:8px; color:#C8FFA6;}",
                      teamkiller:      ".mm_t{font-family:$FieldFont; font-size:8px; color:#A6F8FF;}",
                      enemy:           ".mm_e{font-family:$FieldFont; font-size:8px; color:#FCA9A4;}",
                      squad:           ".mm_s{font-family:$FieldFont; font-size:8px; color:#FFC099;}",
                      lost:            ".mm_l{font-family:$FieldFont; font-size:8px; color:#FCA9A4;} .mm_dot{font-family:Arial; font-size:17px; color:#FCA9A4;}",
                      oneself:         ".mm_o{font-family:$FieldFont; font-size:8px; color:#FFFFFF;}",
                      lostally:       ".mm_la{font-family:$FieldFont; font-size:8px; color:#C8FFA6;} .mm_dot{font-family:Arial; font-size:17px; color:#B4E595;}",
                      lostteamkiller: ".mm_lt{font-family:$FieldFont; font-size:8px; color:#A6F8FF;} .mm_dot{font-family:Arial; font-size:17px; color:#00D2E5;}",
                      lost:            ".mm_l{font-family:$FieldFont; font-size:8px; color:#FCA9A4;} .mm_dot{font-family:Arial; font-size:17px; color:#E59995;}",
                      lostsquad:      ".mm_ls{font-family:$FieldFont; font-size:8px; color:#FFD099;} .mm_dot{font-family:Arial; font-size:17px; color:#E5BB8A;}",
                      deadally:       ".mm_da{font-family:$FieldFont; font-size:8px; color:#6E8C5B;} .mm_dot{font-family:Arial; font-size:17px; color:#004D00;}",
                      deadteamkiller: ".mm_dt{font-family:$FieldFont; font-size:8px; color:#5B898C;} .mm_dot{font-family:Arial; font-size:17px; color:#043A40;}",
                      deadenemy:      ".mm_de{font-family:$FieldFont; font-size:8px; color:#996763;} .mm_dot{font-family:Arial; font-size:17px; color:#4D0300;}",
                      deadsquad:      ".mm_ds{font-family:$FieldFont; font-size:8px; color:#997C5C;} .mm_dot{font-family:Arial; font-size:17px; color:#663800;}"
                    },
                    shadow: {
                      ally:
                       { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 4 },
                      teamkiller:
                       { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 4 },
                      enemy:
                       { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 4 },
                      squad:
                       { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 4 },
                      oneself:
                       { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 4 },
                      lostally:
                       { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 6, strength: 4 },
                      lostteamkiller:
                       { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 6, strength: 4 },
                      lost:
                       { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 6, strength: 4 },
                      lostsquad:
                       { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 6, strength: 4 },
                      deadally:
                       { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 3 },
                      deadteamkiller:
                       { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 3 },
                      deadenemy:
                       { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 3 },
                      deadsquad:
                       { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 3 }
                    },
                    offset: {
                      ally:           {x: 3, y: -1},
                      teamkiller:     {x: 3, y: -1},
                      enemy:          {x: 3, y: -1},
                      squad:          {x: 3, y: -2},
                      oneself:        {x: 0, y: 0},
                      lostally:       {x: -5, y: -11},
                      lostteamkiller: {x: -5, y: -11},
                      lost:           {x: -5, y: -11},
                      lostsquad:      {x: -5, y: -11},
                      deadally:       {x: -5, y: -11},
                      deadteamkiller: {x: -5, y: -11},
                      deadenemy:      {x: -5, y: -11},
                      deadsquad:      {x: -5, y: -11}
                    },
                    alpha : {
                      ally: 100,
                      teamkiller: 100,
                      enemy: 100,
                      squad: 100,
                      oneself: 100,
                      lostally: 70,
                      lostteamkiller: 70,
                      lost: 70,
                      lostsquad: 70,
                      deadally: 50,
                      deadteamkiller: 50,
                      deadenemy: 0,
                      deadsquad: 50
                    }
                  },
                  mapSize: {
                    enabled: true,
                    format: "<b>{{cellsize}}0 m</b>",
                    css: "font-size:10px; color:#FFCC66;",
                    alpha: 80,
                    offsetX: 0,
                    offsetY: 0,
                    shadow: {
                      enabled: true,
                      color: "0x000000",
                      distance: 0,
                      angle: 0,
                      alpha: 80,
                      blur: 2,
                      strength: 3
                    },
                    width: 100,
                    height: 30
                  }
                },
                circles: {
                  enabled: true,
                  major: [
                    { enabled: true, distance: 445, thickness: 0.75, alpha: 45, color: 0xFFCC66 },
                    { enabled: false, distance: 50, thickness: 1, alpha: 100, color: 0xFFFFFF }
                  ],
                  special: [
                    // level 2
                      { su_18:                {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 500 } },
                      { gw_mk_vie:            {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 850 } },
                      { t57:                  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 553 } },
                      { renaultbs:            {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 483 } },
                      { gb25_loyd_carrier:    {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 509 } },
                    // level 3
                      { su_26:                {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1218} },
                      { bison_i:              {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 602 } },
                      { wespe:                {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 989 } },
                      { m7_priest:            {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 989 } },
                      { lorraine39_l_am:      {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 983 } },
                      { gb27_sexton:          {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1051} },
                      { gb78_sexton_i:        {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1051} },
                    // level 4
                      { su_5:                 {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 613 } },
                      { sturmpanzer_ii:       {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 602 } },
                      { pz_sfl_ivb:           {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 989 } },
                      { m37:                  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 989 } },
                      { amx_ob_am105:         {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1288} },
                      { gb26_birch_gun:       {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1051} },
                    // level 5
                      { su122a:               {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1201} },
                      { grille:               {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 836 } },
                      { m41:                  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1294} },
                      { amx_105am:            {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1288} },
                      { _105_lefh18b2:        {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1000} },
                      { gb28_bishop:          {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 500 } },
                    // level 6
                      { su_8:                 {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1345} },
                      { hummel:               {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1260} },
                      { m44:                  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1294} },
                      { amx_13f3am:           {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1381} },
                      { gb77_fv304:           {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 500 } },
                    // level 7
                      { s_51:                 {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1264} },
                      { su14_1:               {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1264} },
                      { g_panther:            {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1300} },
                      { m12:                  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1413} },
                      { lorraine155_50:       {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1350} },
                      { gb29_crusader_5inch:  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1327} },
                    // level 8
                      { su_14:                {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1264} },
                      { gw_tiger_p:           {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1333} },
                      { m40m43:               {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1336} },
                      { lorraine155_51:       {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1368} },
                      { gb79_fv206:           {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1405} },
                    // level 9
                      { object_212:           {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1264} },
                      { g_tiger:              {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1333} },
                      { m53_55:               {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1291} },
                      { bat_chatillon155_55:  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1413} },
                      { gb30_fv3805:          {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1354} },
                    // level 10
                      { object_261:           {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1470} },
                      { g_e:                  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1333} },
                      { t92:                  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1411} },
                      { bat_chatillon155_58:  {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1413} },
                      { gb31_conqueror_gun:   {enabled: true, thickness: 1, alpha: 60, color: "0xEE4444", distance: 1007} }
                  ]
                },
                square: {
                  enabled: false,
                  artilleryEnabled: false,
                  thickness: 0.7,
                  alpha: 40,
                  color: "0xFFFFFF"
                },
                lines: {
                  enabled: true,
                  vehicle: [
                    { enabled: false, from: 20,  to: 300, inmeters: false, thickness: 0.4, alpha: 35, color: 0xFFCC66 }
                  ],
                  camera: [
                    { enabled: false, from: 50,  to: 100, inmeters: true, thickness: 2,   alpha: 60, color: 0xEE0044},
                    { enabled: false, from: 200, to: 300, inmeters: true, thickness: 1.5, alpha: 45, color: 0xEE0044},
                    { enabled: false, from: 350, to: 445, inmeters: true, thickness: 1,   alpha: 30, color: 0xEE0044}
                  ],
                  traverseAngle: [
                    { enabled: true, from: 20,  to: 300, inmeters: false, thickness: 0.4, alpha: 35, color: 0xFFCC66}
                  ]
                }
            },
            captureBar: {
                enabled: true,
                primaryTitleOffset: 7,
                appendPlus: true,
                enemy: {
                    primaryTitleFormat:   "<font size='15' color='#FFFFFF'>Enemy base capture! {{extra}}</font>",
                    secondaryTitleFormat: "<font size='15' color='#FFFFFF'>{{points}}</font>",
                    captureDoneFormat:    "<font size='17' color='#FFCC66'>Enemy base captured!</font>",
                    extra: "Capturers: <b><font color='#FFCC66'>{{tanks}}</font></b> Timeleft: <b><font color='#FFCC66'>{{time}}</font><b>",
                    shadow: {
                        color: "0x000000",
                        alpha: 50,
                        blur: 6,
                        strength: 3
                    }
                },
                ally: {
                    primaryTitleFormat:   "<font size='15' color='#FFFFFF'>Ally base capture! {{extra}}</font>",
                    secondaryTitleFormat: "<font size='15' color='#FFFFFF'>{{points}}</font>",
                    captureDoneFormat:    "<font size='17' color='#FFCC66'>Ally base captured!</font>",
                    extra: "Capturers: <b><font color='#FFCC66'>{{tanks}}</font></b> Timeleft: <b><font color='#FFCC66'>{{time}}</font><b>",
                    shadow: {
                        color: "0x000000",
                        alpha: 50,
                        blur: 6,
                        strength: 3
                    }
                }
            },
            hitLog: {
                visible: true,
                hpLeft: {
                    enabled: true,
                    header: "",
                    format: "<font color='#FFFFFF'>{{vehicle}} </font>   <font color='#FF9999'>{{hp}}</font>    <font color='#BBBBBB'>{{nick}}</font>"
                },
                x: 270,
                y: 5,
                w: 500,
                h: 1000,
                lines: 0,
                direction: "down",
                insertOrder: "end",
                groupHitsByPlayer: true,
                // Substitution for {{dead}} macro when player is dead
                deadMarker:   "<font face='Wingdings'>N</font>",
                blowupMarker: "<font face='Wingdings'>M</font>",
                defaultHeader: "<font color='#FFFFFF'>Hits:</font> <font size='13'>#0</font>",
                formatHeader:  "<font color='#FFFFFF'>Hits:</font> <font size='13'>#{{n}}</font> <b>{{dmg-total}}</b>  <font color='#FFFFFF'>Last:</font> <font color='{{c:dmg-kind}}'><b>{{dmg}}</b> {{dead}}</font>",
                formatHistory: "<textformat leading='-4' tabstops='[20,50,90,150]'><font size='12'>\u00D7{{n-player}}:</font><tab>{{dmg-player}}<tab>| <font color='{{c:dmg-kind}}'>{{dmg}}</font><tab>| <font color='{{c:dmg-kind}}'>{{dmg-kind}}</font><tab>| <font color='{{c:vtype}}'>{{vehicle}} {{dead}}</font></textformat>",
			    shadow: {
                  alpha: 100,
                  color: "0x000000",
                  angle: 45,
                  distance: 0,
                  size: 5,
                  strength: 150
                }
            },
            markers: {
                ally: {
                    alive: {
                        normal: {
                            vehicleIcon: vi,
                            healthBar: hb_alive,
                            damageText: dmg,
                            damageTextPlayer: dmg,
                            damageTextSquadman: dmg,
                            contourIcon: ci,
                            clanIcon: clanIcon,
                            levelIcon: li,
                            actionMarker: am,
                            textFields: [ vehicleName_alive, currentHealth ]
                        },
                        extended: {
                            vehicleIcon: vi,
                            healthBar: hb_alive,
                            damageText: dmg,
                            damageTextPlayer: dmg,
                            damageTextSquadman: dmg,
                            contourIcon: ci,
                            clanIcon: clanIcon,
                            levelIcon: li,
                            actionMarker: am,
                            textFields: [ playerName_alive, healthRatio, ratingText ]
                        }
                    },
                    dead: {
                        normal: {
                            vehicleIcon: vi,
                            healthBar: hb_dead,
                            damageText: dmg,
                            damageTextPlayer: dmg,
                            damageTextSquadman: dmg,
                            contourIcon: ci,
                            clanIcon: clanIcon,
                            levelIcon: li,
                            actionMarker: am,
                            textFields: [  ]
                        },
                        extended: {
                            vehicleIcon: vi,
                            healthBar: hb_dead,
                            damageText: dmg,
                            damageTextPlayer: dmg,
                            damageTextSquadman: dmg,
                            contourIcon: ci,
                            clanIcon: clanIcon,
                            levelIcon: li,
                            actionMarker: am,
                            textFields: [ playerName_dead, vehicleName_dead ]
                        }
                    }
                },
                enemy: {
                    alive: {
                        normal: {
                            vehicleIcon: vi,
                            healthBar: hb_alive,
                            damageText: dmg,
                            damageTextPlayer: dmg,
                            damageTextSquadman: dmg,
                            contourIcon: ci,
                            clanIcon: clanIcon,
                            levelIcon: li,
                            actionMarker: am,
                            textFields: [ vehicleName_alive, currentHealth ]
                        },
                        extended: {
                            vehicleIcon: vi,
                            healthBar: hb_alive,
                            damageText: dmg,
                            damageTextPlayer: dmg,
                            damageTextSquadman: dmg,
                            contourIcon: ci,
                            clanIcon: clanIcon,
                            levelIcon: li,
                            actionMarker: am,
                            textFields: [ playerName_alive, healthRatio, ratingText ]
                        }
                    },
                    dead: {
                        normal: {
                            vehicleIcon: vi,
                            healthBar: hb_dead,
                            damageText: dmg,
                            damageTextPlayer: dmg,
                            damageTextSquadman: dmg,
                            contourIcon: ci,
                            clanIcon: clanIcon,
                            levelIcon: li,
                            actionMarker: am,
                            textFields: [  ]
                        },
                        extended: {
                            vehicleIcon: vi,
                            healthBar: hb_dead,
                            damageText: dmg,
                            damageTextPlayer: dmg,
                            damageTextSquadman: dmg,
                            contourIcon: ci,
                            clanIcon: clanIcon,
                            levelIcon: li,
                            actionMarker: am,
                            textFields: [ playerName_dead, vehicleName_dead ]
                        }
                    }
                }
            },
            colors: {
                system: {
                    ally_alive:          "0x96FF00",
                    ally_dead:           "0x009900",
                    ally_blowedup:       "0x007700",
                    squadman_alive:      "0xFFB964",
                    squadman_dead:       "0xCA7000",
                    squadman_blowedup:   "0xA45A00",
                    teamKiller_alive:    "0x00EAFF",
                    teamKiller_dead:     "0x097783",
                    teamKiller_blowedup: "0x096A75",
                    enemy_alive:         "0xF50800",
                    enemy_dead:          "0x840500",
                    enemy_blowedup:      "0x5A0401"
                },
                // src: ally, squadman, enemy, unknown, player
                // dst: ally, squadman, allytk, enemytk, enemy
                damage: {
                    ally_ally_hit:            "0x00EAFF",
                    ally_ally_kill:           "0x00EAFF",
                    ally_ally_blowup:         "0x00EAFF",
                    ally_squadman_hit:        "0x00EAFF",
                    ally_squadman_kill:       "0x00EAFF",
                    ally_squadman_blowup:     "0x00EAFF",
                    ally_enemy_hit:           "0xF50800",
                    ally_enemy_kill:          "0xF50800",
                    ally_enemy_blowup:        "0xF50800",
                    ally_allytk_hit:          "0x00EAFF",
                    ally_allytk_kill:         "0x00EAFF",
                    ally_allytk_blowup:       "0x00EAFF",
                    ally_enemytk_hit:         "0xF50800",
                    ally_enemytk_kill:        "0xF50800",
                    ally_enemytk_blowup:      "0xF50800",
                    squadman_ally_hit:        "0x00EAFF",
                    squadman_ally_kill:       "0x00EAFF",
                    squadman_ally_blowup:     "0x00EAFF",
                    squadman_squadman_hit:    "0x00EAFF",
                    squadman_squadman_kill:   "0x00EAFF",
                    squadman_squadman_blowup: "0x00EAFF",
                    squadman_enemy_hit:       "0xF50800",
                    squadman_enemy_kill:      "0xF50800",
                    squadman_enemy_blowup:    "0xF50800",
                    squadman_allytk_hit:      "0x00EAFF",
                    squadman_allytk_kill:     "0x00EAFF",
                    squadman_allytk_blowup:   "0x00EAFF",
                    squadman_enemytk_hit:     "0xF50800",
                    squadman_enemytk_kill:    "0xF50800",
                    squadman_enemytk_blowup:  "0xF50800",
                    enemy_ally_hit:           "0x96FF00",
                    enemy_ally_kill:          "0x96FF00",
                    enemy_ally_blowup:        "0x96FF00",
                    enemy_squadman_hit:       "0xFFB964",
                    enemy_squadman_kill:      "0xFFB964",
                    enemy_squadman_blowup:    "0xFFB964",
                    enemy_enemy_hit:          "0xF50800",
                    enemy_enemy_kill:         "0xF50800",
                    enemy_enemy_blowup:       "0xF50800",
                    enemy_allytk_hit:         "0x96FF00",
                    enemy_allytk_kill:        "0x96FF00",
                    enemy_allytk_blowup:      "0x96FF00",
                    enemy_enemytk_hit:        "0xF50800",
                    enemy_enemytk_kill:       "0xF50800",
                    enemy_enemytk_blowup:     "0xF50800",
                    unknown_ally_hit:         "0x96FF00",
                    unknown_ally_kill:        "0x96FF00",
                    unknown_ally_blowup:      "0x96FF00",
                    unknown_squadman_hit:     "0xFFB964",
                    unknown_squadman_kill:    "0xFFB964",
                    unknown_squadman_blowup:  "0xFFB964",
                    unknown_enemy_hit:        "0xF50800",
                    unknown_enemy_kill:       "0xF50800",
                    unknown_enemy_blowup:     "0xF50800",
                    unknown_allytk_hit:       "0x96FF00",
                    unknown_allytk_kill:      "0x96FF00",
                    unknown_allytk_blowup:    "0x96FF00",
                    unknown_enemytk_hit:      "0xF50800",
                    unknown_enemytk_kill:     "0xF50800",
                    unknown_enemytk_blowup:   "0xF50800",
                    player_ally_hit:          "0xFFDD33",
                    player_ally_kill:         "0xFFDD33",
                    player_ally_blowup:       "0xFFDD33",
                    player_squadman_hit:      "0xFFDD33",
                    player_squadman_kill:     "0xFFDD33",
                    player_squadman_blowup:   "0xFFDD33",
                    player_enemy_hit:         "0xFFDD33",
                    player_enemy_kill:        "0xFFDD33",
                    player_enemy_blowup:      "0xFFDD33",
                    player_allytk_hit:        "0xFFDD33",
                    player_allytk_kill:       "0xFFDD33",
                    player_allytk_blowup:     "0xFFDD33",
                    player_enemytk_hit:       "0xFFDD33",
                    player_enemytk_kill:      "0xFFDD33",
                    player_enemytk_blowup:    "0xFFDD33"
                },
                dmg_kind: {
                    attack:          "0xFFAA55",
                    fire:            "0xFF6655",
                    ramming:         "0x998855",
                    world_collision: "0x998855",
                    other:           "0xCCCCCC"
                },
                vtype: {
                    LT:  "0xA2FF9A",        // Color for light tanks
                    MT:  "0xFFF198",        // Color for medium tanks
                    HT:  "0xFFACAC",        // Color for heavy tanks
                    SPG: "0xEFAEFF",        // Color for arty
                    TD:  "0xA0CFFF",        // Color for tank destroyers
                    premium: "0xFFCC66",    // Color for premium tanks
                    usePremiumColor: false  // Enable/disable premium color usage
                },
                // values - from min to max, colors are for values 'lesser then ...'
                hp: [
                    { value: 201,  color: ColorPalette.redBright },
                    { value: 401,  color: ColorPalette.redSmooth },
                    { value: 1001, color: ColorPalette.orange },
                    { value: 9999, color: ColorPalette.white }
                ],
                hp_ratio: [
                    { value: 10,  color: ColorPalette.redBright },
                    { value: 25,  color: ColorPalette.redSmooth },
                    { value: 50,  color: ColorPalette.orange },
                    { value: 101, color: ColorPalette.white }
                ],
                // XVM Scale: http://www.koreanrandom.com/forum/topic/2625-xvm-scale
                x: [
                    { value: 17,  color: ColorPalette.red },      // 00   - 16.5 - very bad   (20% of players)
                    { value: 34,  color: ColorPalette.orange },   // 16.5 - 33.5 - bad        (better then 20% of players)
                    { value: 53,  color: ColorPalette.yellow },   // 33.5 - 52.5 - normal     (better then 60% of players)
                    { value: 76,  color: ColorPalette.green },    // 52.5 - 75.5 - good       (better then 90% of players)
                    { value: 93,  color: ColorPalette.blue },     // 75.5 - 92.5 - very good  (better then 99% of players)
                    { value: 999, color: ColorPalette.purple }    // 92.5 - XX   - unique     (better then 99.9% of players)
                ],
                eff: [
                    { value: 630,  color: ColorPalette.red },     // very bad
                    { value: 860,  color: ColorPalette.orange },  // bad
                    { value: 1140, color: ColorPalette.yellow },  // normal
                    { value: 1460, color: ColorPalette.green },   // good
                    { value: 1735, color: ColorPalette.blue },    // very good
                    { value: 9999, color: ColorPalette.purple }   // unique
                ],
                wn: [
                    { value: 425,  color: ColorPalette.red },     // very bad
                    { value: 795,  color: ColorPalette.orange },  // bad
                    { value: 1175, color: ColorPalette.yellow },  // normal
                    { value: 1570, color: ColorPalette.green },   // good
                    { value: 1885, color: ColorPalette.blue },    // very good
                    { value: 9999, color: ColorPalette.purple }   // unique
                ],
                rating: [
                    { value: 47,  color: ColorPalette.red },      // very bad
                    { value: 49,  color: ColorPalette.orange },   // bad
                    { value: 52,  color: ColorPalette.yellow },   // normal
                    { value: 57,  color: ColorPalette.green },    // good
                    { value: 64,  color: ColorPalette.blue },     // very good
                    { value: 101, color: ColorPalette.purple }    // unique
                ],
                twr: [
                    { value: 47,  color: ColorPalette.red },      // very bad
                    { value: 49,  color: ColorPalette.orange },   // bad
                    { value: 52,  color: ColorPalette.yellow },   // normal
                    { value: 57,  color: ColorPalette.green },    // good
                    { value: 62,  color: ColorPalette.blue },     // very good
                    { value: 101, color: ColorPalette.purple }    // unique
                ],
                e: [
                    { value: 2,    color: ColorPalette.red },     // very bad
                    { value: 4,    color: ColorPalette.orange },  // bad
                    { value: 5,    color: ColorPalette.yellow },  // normal
                    { value: 7,    color: ColorPalette.green },   // good
                    { value: 9,    color: ColorPalette.blue },    // very good
                    { value: 20,   color: ColorPalette.purple }   // unique
                ],
                kb: [
                    { value: 2,   color: ColorPalette.red },
                    { value: 5,   color: ColorPalette.orange },
                    { value: 9,   color: ColorPalette.yellow },
                    { value: 14,  color: ColorPalette.green },
                    { value: 20,  color: ColorPalette.blue },
                    { value: 999, color: ColorPalette.purple }
                ],
                t_battles: [
                    { value: 100,   color: ColorPalette.red },
                    { value: 250,   color: ColorPalette.orange },
                    { value: 500,   color: ColorPalette.yellow },
                    { value: 1000,  color: ColorPalette.green },
                    { value: 1800,  color: ColorPalette.blue },
                    { value: 99999, color: ColorPalette.purple }
                ],
                tdb: [
                    { value: 500,  color: ColorPalette.red },
                    { value: 1000, color: ColorPalette.yellow },
                    { value: 2000, color: ColorPalette.green }
                ],
                tdv: [
                    { value: 0.6,  color: ColorPalette.red },
                    { value: 0.8,  color: ColorPalette.orange },
                    { value: 1.0,  color: ColorPalette.yellow },
                    { value: 1.3,  color: ColorPalette.green },
                    { value: 2.0,  color: ColorPalette.blue },
                    { value: 15,   color: ColorPalette.purple }
                ],
                tfb: [
                    { value: 0.6,  color: ColorPalette.red },
                    { value: 0.8,  color: ColorPalette.orange },
                    { value: 1.0,  color: ColorPalette.yellow },
                    { value: 1.3,  color: ColorPalette.green },
                    { value: 2.0,  color: ColorPalette.blue },
                    { value: 15,   color: ColorPalette.purple }
                ],
                tsb: [
                    { value: 0.6,  color: ColorPalette.red },
                    { value: 0.8,  color: ColorPalette.orange },
                    { value: 1.0,  color: ColorPalette.yellow },
                    { value: 1.3,  color: ColorPalette.green },
                    { value: 2.0,  color: ColorPalette.blue },
                    { value: 15,   color: ColorPalette.purple }
                ]
            },
            alpha: {
                // values - from min to max, transparency are for values 'lesser then ...'
                hp: [
                    { value: 200,  alpha: 100 },
                    { value: 400,  alpha: 80 },
                    { value: 1000, alpha: 60 },
                    { value: 9999, alpha: 40 }
                ],
                hp_ratio: [
                    { value: 10,  alpha: 100 },
                    { value: 25,  alpha: 80 },
                    { value: 50,  alpha: 60 },
                    { value: 101, alpha: 40 }
                ],
                x: [
                    { value: 30,  alpha: 100 },
                    { value: 50, alpha: 80 },
                    { value: 70, alpha: 60 },
                    { value: 9999, alpha: 40 }
                ],
                eff: [
                    { value: 860,  alpha: 100 },
                    { value: 1140, alpha: 80 },
                    { value: 1460, alpha: 60 },
                    { value: 9999, alpha: 40 }
                ],
                wn: [
                    { value: 795,  alpha: 100 },
                    { value: 1175, alpha: 80 },
                    { value: 1570, alpha: 60 },
                    { value: 9999, alpha: 40 }
                ],
                rating: [
                    { value: 49,  alpha: 100 },
                    { value: 53,  alpha: 80 },
                    { value: 60,  alpha: 60 },
                    { value: 101, alpha: 40 }
                ],
                twr: [
                    { value: 49,  alpha: 100 },
                    { value: 53,  alpha: 80 },
                    { value: 60,  alpha: 60 },
                    { value: 101, alpha: 40 }
                ],
                e: [
                    { value: 5,  alpha: 100 },
                    { value: 7,  alpha: 80 },
                    { value: 9,  alpha: 60 },
                    { value: 20, alpha: 40 }
                ],
                kb: [
                    { value: 2,   alpha: 100 },
                    { value: 10,  alpha: 80 },
                    { value: 20,  alpha: 60 },
                    { value: 999, alpha: 40 }
                ],
                t_battles: [
                    { value: 250,  alpha: 100 },
                    { value: 500, alpha: 80 },
                    { value: 1000, alpha: 60 },
                    { value: 99999, alpha: 40 }
                ],
                tdb: [
                    { value: 1,   alpha: 100 },
                    { value: 500,  alpha: 80 },
                    { value: 1000,  alpha: 60 },
                    { value: 9999, alpha: 40 }
                ],
                tdv: [
                    { value: 0.6,   alpha: 100 },
                    { value: 1.0,  alpha: 80 },
                    { value: 1.3,  alpha: 60 },
                    { value: 15, alpha: 40 }
                ],
                tfb: [
                    { value: 0.6,   alpha: 100 },
                    { value: 1.0,  alpha: 80 },
                    { value: 1.3,  alpha: 60 },
                    { value: 15, alpha: 40 }
                ],
                tsb: [
                    { value: 0.6,   alpha: 100 },
                    { value: 1.0,  alpha: 80 },
                    { value: 1.3,  alpha: 60 },
                    { value: 15, alpha: 40 }
                ]
            },
            // Text substitutions
            texts: {
                // Text for {{vtype}} macro
                vtype: {
                    LT:  "LT",        // Text for light tanks
                    MT:  "MT",        // Text for medium tanks
                    HT:  "HT",        // Text for heavy tanks
                    SPG: "SPG",       // Text for arty
                    TD:  "TD"         // Text for tank destroyers
                }
            },
      /*      images: {
              dmg_kind: {
                  attack: "",
                  fire: "../../../icons/xvm/dmg_fire.png",
                  ramming: "../../../icons/xvm/dmg_ramming.png",
                  world_collision: "../../../icons/xvm/dmg_world_collision.png",
                  other: "../../../icons/xvm/dmg_other.png"
              }
            },*/
            iconset: {
                battleLoading: "contour/",
                statisticForm: "contour/",
                playersPanel:  "contour/",
                vehicleMarker: "contour/"
            },
            consts: consts,
            vehicleNames: VehicleInfo.getVehicleNamesData()
        };

        return a;
    }

    public static function get shadow_150(): Object
    {
        return {
            alpha: 100,
            color: "0x000000",
            angle: 90,
            distance: 0,
            size: 4,
            strength: 150
        }
    }

    public static function get shadow_200(): Object
    {
        return {
            alpha: 100,
            color: "0x000000",
            angle: 90,
            distance: 0,
            size: 6,
            strength: 200
        }
    }

    public static function get font_11b(): Object
    {
        return {
            name: "$FieldFont",
            size: 11,
            align: "center",
            bold: true,
            italic: false
        }
    }

    public static function get font_13(): Object
    {
        return {
            name: "$FieldFont",
            size: 13,
            align: "center",
            bold: false,
            italic: false
        }
    }

    public static function get font_18(): Object
    {
        return {
            name: "$FieldFont",
            size: 18,
            align: "center",
            bold: false,
            italic: false
        }
    }

    // vehicleIcon
    public static function get vi(): Object
    {
        return {
            visible: true,
            showSpeaker: false,
            x: 0,
            y: -16,
            alpha: 100,
            color: null,
            maxScale: 100,
            scaleX: 0,
            scaleY: 16,
            shadow: shadow_200
        }
    }

    // healthBar
    public static function get hb_alive(): Object
    {
        return {
          visible: true,
          x: -41,
          y: -33,
          alpha: 100,
          color: null,
          lcolor: null,
          width: 80,
          height: 12,
          border: {
              alpha: 30,
              color: "0x000000",
              size: 1
          },
          fill: {
              alpha: 30
          },
          damage: {
              alpha: 80,
              color: null,
              fade: 1
          }
        }
    }

    public static function get hb_dead(): Object
    {
        var hb:Object = hb_alive;
        hb.visible = false;
        return hb;
    }

    // damageText
    public static function get dmg(): Object
    {
        return {
            visible: true,
            x: 0,
            y: -67,
            alpha: 100,
            color: null,
            font: font_18,
            shadow: shadow_200,
            speed: 2,
            maxRange: 40,
            damageMessage: "{{dmg}}",
            blowupMessage: "Blown-up!"
        }
    }

    // contourIcon
    public static function get ci(): Object
    {
        return {
            visible: false,
            x: 6,
            y: -65,
            alpha: 100,
            color: null,
            amount: 0
        }
    }

    // clanIcon
    public static function get clanIcon(): Object
    {
        return {
            visible: false,
            x: 0,
            y: -67,
            w: 16,
            h: 16,
            alpha: 100
        }
    }

    // levelIcon
    public static function get li(): Object
    {
        return {
            visible: false,
            x: 0,
            y: -21,
            alpha: 100
        }
    }

    // actionMarker
    public static function get am(): Object
    {
        return {
            visible: true,
            x: 0,
            y: -67,
            alpha: 100
        }
    }

    /**
     * TEXT FIELDS
     */

    // playerName
    public static function get playerName_alive(): Object
    {
        return {
            name: "Player Name",
            visible: true,
            x: 0,
            y: -36,
            alpha: 100,
            color: null,
            font: font_13,
            shadow: shadow_200,
            format: "{{nick}}"
        }
    }

    public static function get playerName_dead(): Object
    {
        return {
            name: "Player Name",
            visible: true,
            x: 0,
            y: -34,
            alpha: 80,
            color: null,
            font: font_13,
            shadow: shadow_200,
            format: "{{nick}}"
        }
    }

    // vehicleName
    public static function get vehicleName_alive(): Object
    {
        return {
            name: "Vehicle Name",
            visible: true,
            x: 0,
            y: -36,
            alpha: 100,
            color: null,
            font: font_13,
            shadow: shadow_200,
            format: "{{vehicle}}{{turret}}"
        }
    }

    public static function get vehicleName_dead(): Object
    {
        return {
            name: "Vehicle Name",
            visible: true,
            x: 0,
            y: -20,
            alpha: 80,
            color: null,
            font: font_13,
            shadow: shadow_200,
            format: "{{vehicle}}"
        }
    }

    // currentHealth
    public static function get currentHealth(): Object
    {
        return {
            name: "Current Health",
            visible: true,
            x: 0,
            y: -20,
            alpha: 100,
            color: ColorPalette.white,
            font: font_11b,
            shadow: shadow_150,
            format: "{{hp}} / {{hp-max}}"
        }
    }

    // healthRatio
    public static function get healthRatio(): Object
    {
        return {
            name: "Health Ratio",
            visible: true,
            x: 0,
            y: -20,
            alpha: 100,
            color: ColorPalette.white,
            font: font_11b,
            shadow: shadow_150,
            format: "{{hp-ratio}}%"
        }
    }

    // ratingText
    public static function get ratingText(): Object
    {
        return {
            name: "Rating",
            visible: true,
            x: 0,
            y: -46,
            alpha: 100,
            color: "{{c:rating}}",
            font: font_11b,
            shadow: shadow_150,
            format: "{{rating}}"
        }
    }

    public static function get consts(): Object
    {
        return {
            AVG_GWR: 48,  // Average GWR. Source: http://wot-news.com/stat/server/ru/norm/en
            AVG_XVMSCALE: 30, // Average XVM Scale. Source: http://www.koreanrandom.com/forum/topic/2625-/
            AVG_BATTLES: 2000, // Averate number of battles. Source: http://wot-news.com/stat/server/ru/norm/en
            MAX_EBN: 200, // Maximum Ebn value for win-chance formula
            VM_COEFF_VMM: 0.88, // vehicle markers manager (alive)
            VM_COEFF_VMM_DEAD: 0.50, // vehicle markers manager (dead)
            VM_COEFF_MM_PLAYER: 0.93, // minimap (player)
            VM_COEFF_MM_BASE: 0.8, // minimap (base)
            VM_COEFF_FC: 0.93 // frag correlation
        };
    }
}
