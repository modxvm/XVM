/**
 * XVM Default Config
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.misc
{
    import com.xvm.Defines;

    public class DefaultConfig
    {
        public static function get config():Object
        {
            var c:Object = new Object();
            c.configVersion = Defines.CONFIG_VERSION;
            c.editorVersion = Defines.EDITOR_VERSION;
            c.language = Defines.LOCALE_AUTO_DETECTION;
            c.region =  Defines.REGION_AUTO_DETECTION;
            c.definition = getDefinitionSection();
            c.login = getLoginSection();
            c.hangar = getHangarSection();
            c.battle = getBattleSection();
            c.rating = getRatingSection();
            c.squad = getSquadSection();
            c.userInfo = getUserInfoSection();
            c.fragCorrelation = getFragCorrelationSection();
            c.hotkeys = getHotkeysSection();
            c.battleLoading = getBattleLoadingSection();
            c.statisticForm = getStatisticFormSection();
            c.playersPanel = getPlayersPanelSection();
            c.battleResults = getBattleResultsSection();
            c.turretMarkers = getTurretMarkersSection();
            c.expertPanel = getExpertPanelSection();
            c.minimap = getMinimapSection();
            c.captureBar = getCaptureBarSection();
            c.hitLog = getHitlogSection();
            c.markers = getMarkersSection();
            c.colors = getColorsSection();
            c.alpha = getAlphaSection();
            c.texts = getTextsSection();
            c.iconset = getIconsetSection();
            c.vehicleNames = VehicleNames.data;
            c.consts = getConstsSection();
            return c;
        }

        private static function getDefinitionSection():Object
        {
            var c:Object = new Object();
            c.author = "XVM";
            c.description = "Default settings for XVM";
            c.url = "http://www.modxvm.com/";
            var d:Date = new Date();
            c.date = (d.getDate() < 10 ? "0" : "") + d.getDate() + "." +
                (d.getMonth() < 9 ? "0" : "") + (d.getMonth() + 1) + "." + d.getFullYear();
            c.gameVersion = Defines.WOT_VERSION;
            c.modMinVersion = Defines.XVM_VERSION;
            return c;
        }

        private static function getLoginSection():Object
        {
            var c:Object = new Object();
            c.skipIntro = true;
            c.saveLastServer = false;
            c.autologin = false;
            c.confirmOldReplays = false;
            // Show ping to the servers
            c.pingServers = new Object();
            c.pingServers.enabled = false;
            c.pingServers.updateInterval = 10000; // msec
            c.pingServers.x = 15;
            c.pingServers.y = 35;
            c.pingServers.alpha = 80;
            c.pingServers.delimiter = ": ";
            c.pingServers.maxRows = 4;
            c.pingServers.columnGap = 10;
            c.pingServers.fontStyle = {
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
                };
            c.pingServers.threshold = {
                    great: 35,
                    good: 60,
                    poor: 100
                };
            c.pingServers.shadow = {
                    enabled: true,
                    color: "0x000000",
                    distance: 0,
                    angle: 0,
                    alpha: 70,
                    blur: 4,
                    strength: 2
                };
            return c;
        }

        private static function getHangarSection():Object
        {
            var c:Object = new Object();
            c.hideTutorial = false;
            c.xwnInCompany = true;
            c.masteryMarkInTankCarousel = true;
            c.masteryMarkInTechTree = true;
            c.hidePricesInTechTree = false;
            c.widgetsEnabled = false;
            // Show ping to the servers
            c.pingServers = new Object();
            c.pingServers.enabled = false;
            c.pingServers.updateInterval = 10000; // msec
            c.pingServers.x = 170;
            c.pingServers.y = 35;
            c.pingServers.alpha = 80;
            c.pingServers.delimiter = ": ";
            c.pingServers.maxRows = 4;
            c.pingServers.columnGap = 10;
            c.pingServers.fontStyle = {
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
                };
            c.pingServers.threshold = {
                    great: 35,
                    good: 60,
                    poor: 100
                };
            c.pingServers.shadow = {
                    enabled: true,
                    color: "0x000000",
                    distance: 0,
                    angle: 0,
                    alpha: 70,
                    blur: 4,
                    strength: 2
                };
            return c;
        }

        private static function getBattleSection():Object
        {
            var c:Object = new Object();
            c.mirroredVehicleIcons = true;      // Set false for alternative tank icon mirroring.
            c.showPostmortemTips = true;        // Popup tooltip panel after death.
            c.highlightVehicleIcon = true;      // False - disable highlighting of selected vehicle icon and squad.
            c.allowHpInPanelsAndMinimap = false;
            // Show the clock on the Debug Panel (near FPS).
            c.clockFormat = "H:N"; // TODO "H:i:s";   // Format: http://php.net/date
            c.clanIconsFolder = "clanicons/";   // Folder with clan icons
            // Visual elements
            c.elements = [];
            return c;
        }

        private static function getRatingSection():Object
        {
            var c:Object = new Object();
            c.showPlayersStatistics = false;   // Global switch. Handles whole statisctics module.
            c.loadEnemyStatsInFogOfWar = true; // Load players data in "fog of war".
            c.enableStatisticsLog = false;     // Enable saving statistics to "xvm-stat.log" file
            c.enableUserInfoStatistics = true; // Enable statistics in the user info window
            c.enableCompanyStatistics = true;  // Enable statistics in the company window
            return c;
        }

        private static function getSquadSection():Object
        {
            var c:Object = new Object();
            c.enabled = true;       // Global switch
            c.romanNumbers = true;  // Roman level numbers
            c.showClan = true;      // Show player clan
            c.leftLvlBorder = "";   // Grille [4
            c.rightLvlBorder = "";  // Grille 4]
            return c;
        }

        private static function getUserInfoSection():Object
        {
            var c:Object = new Object();
            c.startPage = 1;
            c.sortColumn = -5;                  // Number of column for sorting
            c.showExtraDataInProfile = false;
            c.inHangarFilterEnabled = false;   // Enable In hangar radio button by default
            c.showFilters = true;              // Show tank filters
            c.filterFocused = true;            // Set the default focus to the filter text input
            c.defaultFilterValue = "";         // Default filter value
            return c;
        }

        private static function getFragCorrelationSection():Object
        {
            var c:Object = new Object();
            c.hideTeamTextFields = true;
            return c;
        }

        private static function getHotkeysSection():Object
        {
            var c:Object = new Object();
            c.minimapZoom = { enabled: false, onHold: true, keyCode: 17 }; // 17 - Ctrl
            /*
            c.minimapExtended: { enabled: true, onHold: true, keycode: 16 } // 16 - Alt?
            c.messages: [
              {  enabled: true, keycode: 113, text: "ШАНСЫ 5% АЙДА ТАПИЦА" }, // F2
              {  enabled: true, keycode: 114, text: "☆\nhey!\n☆" } // .split("\n")
            ]
            */
            return c;
        }

        private static function getBattleLoadingSection():Object
        {
            var c:Object = new Object();
            // Show clock at Battle Loading Screen.
            // ### Is there a clock:on\off switch variable supposed to be? ###
            // A: No, it is possible to set clockFormat: "" to disable clock.

            c.clockFormat = "H:i:s";   // Format: http://php.net/date
            c.showChances = false;     // Show game round win chances percentage.
            c.showBattleTier = false;
            c.removeSquadIcon = false; // Hide squad icon.
            // Playes/clan icon parameters.
            c.clanIcon = new Object();
            c.clanIcon.show = true;
            c.clanIcon.x = 0;
            c.clanIcon.y = 6;
            c.clanIcon.xr = 0;
            c.clanIcon.yr = 6;
            c.clanIcon.h = 16;
            c.clanIcon.w = 16;
            c.clanIcon.alpha = 90;
            // Dispay format. Macro-substitutiones allowed.
            c.formatLeftNick = "{{name}}{{clan}}";
            c.formatLeftVehicle = "{{vehicle}}<font face='Lucida Console' size='12'> <font color='{{c:kb}}'>{{kb:3}}</font> <font color='{{c:xwn8}}'>{{xwn8}}</font> <font color='{{c:rating}}'>{{rating:3}}</font></font>";
            c.formatRightNick = "{{name}}{{clan}}";
            c.formatRightVehicle = "<font face='Lucida Console' size='12'><font color='{{c:rating}}'>{{rating:3}}</font> <font color='{{c:xwn8}}'>{{xwn8}}</font> <font color='{{c:kb}}'>{{kb:3}}</font> </font>{{vehicle}}";
            return c;
        }

        private static function getStatisticFormSection():Object
        {
            var c:Object = new Object();
            c.showChances = false;     // Show game round win chances percentage.
            c.showChancesLive = false;
            c.showBattleTier = false;
            c.removeSquadIcon = false; // Hide squad icon.
            // Playes/clan icon parameters.
            c.clanIcon = new Object();
            c.clanIcon.show = true;
            c.clanIcon.x = 0;
            c.clanIcon.y = 6;
            c.clanIcon.xr = 0;
            c.clanIcon.yr = 6;
            c.clanIcon.h = 16;
            c.clanIcon.w = 16;
            c.clanIcon.alpha = 90;
            // Dispay format.
            c.formatLeftNick = "{{nick}}";
            c.formatLeftVehicle = "{{vehicle}}<font face='Lucida Console' size='12'> <font color='{{c:kb}}'>{{kb:3}}</font> <font color='{{c:xwn8}}'>{{xwn8}}</font> <font color='{{c:rating}}'>{{rating:3}}</font></font>";
            c.formatRightNick = "{{nick}}";
            c.formatRightVehicle = "<font face='Lucida Console' size='12'><font color='{{c:rating}}'>{{rating:3}}</font> <font color='{{c:xwn8}}'>{{xwn8}}</font> <font color='{{c:kb}}'>{{kb:3}}</font> </font>{{vehicle}}";
            return c;
        }

        private static function getPlayersPanelSection():Object
        {
            var c:Object = new Object();
            c.alpha = 60;              // Side panel transparency. 0 - transparent, 100 - opaque.
            c.iconAlpha = 100;         // Side panel icons transparency. 0 - transparent, 100 - opaque.
            c.removeSquadIcon = false; // Hide squad icon.
            c.removePanelsModeSwitcher = false; // Set true to hide mouse modes switcher.
            // Playes/clan icon parameters.
            c.clanIcon = { show: true, x: 0, y: 6, xr: 0, yr: 6, h: 16, w: 16, alpha: 90 };
            // Display options for icons of never seen enemies
            c.enemySpottedMarker = {
              enabled: false,
              Xoffset: 15,
              Yoffset: 0,
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
            };
            c.allySpottedMarker = {
              enabled: false,
              Xoffset: -15,
              Yoffset: 0,
              format: {
                lost: "",
                revealed: "",
                dead: ""
              }
            };
            // Medium1 mode.
            c.medium = {
                // 0..250 - player name field width.
                width: 46,
                // Dispay format.
                formatLeft: "<font color='{{c:xwn8}}'>{{nick}}</font>",
                formatRight: "<font color='{{c:xwn8}}'>{{nick}}</font>"
            };
            // Medium2 mode.
            c.medium2 = {
                // 0..250 - player name field width.
                width: 65,
                // Dispay format.
                formatLeft: "<font color='{{c:xwn8}}'>{{vehicle}}</font>",
                formatRight: "<font color='{{c:xwn8}}'>{{vehicle}}</font>"
            };
            // Large mode.
            c.large = {
                // 0..250 - player name field width.
                width: 170,
                // Dispay format.
                nickFormatLeft: "<font color='{{c:rating}}'>{{rating}}</font> {{nick}}",
                nickFormatRight: "{{nick}} <font color='{{c:rating}}'>{{rating}}</font>",
                vehicleFormatLeft: "<font color='{{c:xwn8}}'>{{vehicle}}</font>",
                vehicleFormatRight: "<font color='{{c:xwn8}}'>{{vehicle}}</font>"
            };
            return c;
        }

        private static function getBattleResultsSection():Object
        {
            var c:Object = new Object();
            c.startPage = 1;
            c.showNetIncome = true;
            c.showExtendedInfo = true;
            c.showTotals = true;
            c.showChances = false;
            c.showBattleTier = false;
            return c;
        }

        private static function getTurretMarkersSection():Object
        {
            var c:Object = new Object();
            c.highVulnerability = "*";
            c.lowVulnerability = "'";
            return c;
        }

        private static function getExpertPanelSection():Object
        {
            var c:Object = new Object();
            c.delay = 15;
            c.scale = 150;
            return c;
        }

        private static function getMinimapSection():Object
        {
            var c:Object = new Object();
            c.enabled = true;
            c.mapBackgroundImageAlpha = 100;
            c.selfIconAlpha = 100;
            c.cameraAlpha = 100;
            c.iconScale = 1;
            c.zoom = {
              pixelsBack: 160,
              centered: true
            };
            c.labels = {
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
                  squad:          "<textformat leading='-2'><span class='mm_s'><i>{{nick%.5s}}</i>\n{{vehicle}}</span><textformat>",
                  oneself:        "",
                  lostally:       "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_la'><i>{{vehicle}}</i></span>",
                  lostteamkiller: "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_lt'><i>{{vehicle}}</i></span>",
                  lost:           "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_l'><i>{{vehicle}}</i></span>",
                  lostsquad:      "<textformat leading='-4'><span class='mm_dot'>{{vehicle-class}}</span><span class='mm_ls'><i>{{nick%.5s}}</i>\n   {{vehicle}}</span><textformat>",
                  deadally:       "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_da'></span>",
                  deadteamkiller: "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_dt'></span>",
                  deadenemy:      "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_de'></span>",
                  deadsquad:      "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_ds'><i>{{nick%.5s}}</i></span>"
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
            };
            c.circles = {
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
            };
            c.square = {
              enabled: false,
              artilleryEnabled: false,
              thickness: 0.7,
              alpha: 40,
              color: "0xFFFFFF"
            };
            c.lines = {
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
            };
            return c;
        }

        private static function getCaptureBarSection():Object
        {
            var c:Object = new Object();
            c.enabled = true;
            c.primaryTitleOffset = 7;
            c.appendPlus = true;
            c.enemy = {
                primaryTitleFormat:   "<font size='15' color='#FFFFFF'>{{l10n:enemyBaseCapture}} {{extra}}</font>",
                secondaryTitleFormat: "<font size='15' color='#FFFFFF'>{{points}}</font>",
                captureDoneFormat:    "<font size='17' color='#FFCC66'>{{l10n:enemyBaseCaptured}}</font>",
                extra: "{{l10n:Capturers}}: <b><font color='#FFCC66'>{{tanks}}</font></b> {{l10n:Timeleft}}: <b><font color='#FFCC66'>{{time}}</font><b>",
                shadow: {
                    color: "0x000000",
                    alpha: 50,
                    blur: 6,
                    strength: 3
                }
            };
            c.ally = {
                primaryTitleFormat:   "<font size='15' color='#FFFFFF'>{{l10n:allyBaseCapture}} {{extra}}</font>",
                secondaryTitleFormat: "<font size='15' color='#FFFFFF'>{{points}}</font>",
                captureDoneFormat:    "<font size='17' color='#FFCC66'>{{l10n:allyBaseCaptured}}</font>",
                extra: "{{l10n:Capturers}}: <b><font color='#FFCC66'>{{tanks}}</font></b> {{l10n:Timeleft}}: <b><font color='#FFCC66'>{{time}}</font><b>",
                shadow: {
                    color: "0x000000",
                    alpha: 50,
                    blur: 6,
                    strength: 3
                }
            };
            return c;
        }

        private static function getHitlogSection():Object
        {
            var c:Object = new Object();
            c.visible = true;
            c.hpLeft = {
                enabled: true,
                header: "<font color='#FFFFFF'>{{l10n:hpLeftTitle}}</font>",
                format: "<textformat leading='-4' tabstops='[50,90,180]'><font color='{{c:hp-ratio}}'>     {{hp}}</font><tab><font color='#FFFFFF'>/ </font>{{hp-max}}<tab><font color='#FFFFFF'>|</font><font color='{{c:vtype}}'>{{vehicle}}</font><tab><font color='#FFFFFF'>|{{nick}}</font></textformat>"
            };
            c.x = 270;
            c.y = 5;
            c.w = 500;
            c.h = 1000;
            c.lines = 0;
            c.direction = "down";
            c.insertOrder = "end";
            c.groupHitsByPlayer = true;
            // Substitution for {{dead}} macro when player is dead
            c.deadMarker =   "<font face='Wingdings'>N</font>";
            c.blowupMarker = "<font face='Wingdings'>M</font>";
            c.defaultHeader = "<font color='#FFFFFF'>{{l10n:Hits}}:</font> <font size='13'>#0</font>";
            c.formatHeader =  "<font color='#FFFFFF'>{{l10n:Hits}}:</font> <font size='13'>#{{n}}</font> <font color='#FFFFFF'>{{l10n:Total}}: </font><b>{{dmg-total}}</b>  <font color='#FFFFFF'>{{l10n:Last}}:</font> <font color='{{c:dmg-kind}}'><b>{{dmg}}</b> {{dead}}</font>";
            c.formatHistory = "<textformat leading='-4' tabstops='[20,50,90,180]'><font size='12'>\u00D7{{n-player}}:</font><tab><font color='{{c:dmg-kind}}'>{{dmg}}</font><tab>| {{dmg-player}}<tab>|<font color='{{c:vtype}}'>{{vehicle}} {{dead}}</font><tab><font color='#FFFFFF'>|{{nick}}</font></textformat>";
            c.shadow = {
              alpha: 100,
              color: "0x000000",
              angle: 45,
              distance: 0,
              size: 5,
              strength: 150
            };
            return c;
        }

        private static function getMarkersSection():Object
        {
            var c:Object = new Object();
            c.useStandardMarkers = false;       // Use original WoT markers.
            c.ally = {
                alive: {
                    normal: {
                        vehicleIcon: vi,
                        healthBar: hb_alive,
                        damageText: dmg,
                        damageTextPlayer: dmg,
                        damageTextSquadman: dmg,
                        contourIcon: ci,
                        clanIcon: getClanIcon(),
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
                        clanIcon: getClanIcon(),
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
                        clanIcon: getClanIcon(),
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
                        clanIcon: getClanIcon(),
                        levelIcon: li,
                        actionMarker: am,
                        textFields: [ playerName_dead, vehicleName_dead ]
                    }
                }
            };
            c.enemy = {
                alive: {
                    normal: {
                        vehicleIcon: vi,
                        healthBar: hb_alive,
                        damageText: dmg,
                        damageTextPlayer: dmg,
                        damageTextSquadman: dmg,
                        contourIcon: ci,
                        clanIcon: getClanIcon(),
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
                        clanIcon: getClanIcon(),
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
                        clanIcon: getClanIcon(),
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
                        clanIcon: getClanIcon(),
                        levelIcon: li,
                        actionMarker: am,
                        textFields: [ playerName_dead, vehicleName_dead ]
                    }
                }
            };
            return c;
        }

        private static function getColorsSection():Object
        {
            var c:Object = new Object();
            c.system = {
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
            };
            // src: ally, squadman, enemy, unknown, player
            // dst: ally, squadman, allytk, enemytk, enemy
            c.damage = {
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
            };
            c.dmg_kind = {
                attack:          "0xFFAA55",
                fire:            "0xFF6655",
                ramming:         "0x998855",
                world_collision: "0x998855",
                other:           "0xCCCCCC"
            };
            c.vtype = {
                LT:  "0xA2FF9A",        // Color for light tanks
                MT:  "0xFFF198",        // Color for medium tanks
                HT:  "0xFFACAC",        // Color for heavy tanks
                SPG: "0xEFAEFF",        // Color for arty
                TD:  "0xA0CFFF",        // Color for tank destroyers
                premium: "0xFFCC66",    // Color for premium tanks
                usePremiumColor: false  // Enable/disable premium color usage
            };
            // values - from min to max, colors are for values 'lesser then ...'
            c.hp = [
                { value: 201,  color: Defines.C_REDBRIGHT },
                { value: 401,  color: Defines.C_REDSMOOTH },
                { value: 1001, color: Defines.C_ORANGE },
                { value: 9999, color: Defines.C_WHITE }
            ];
            c.hp_ratio = [
                { value: 10,  color: Defines.C_REDBRIGHT },
                { value: 25,  color: Defines.C_REDSMOOTH },
                { value: 50,  color: Defines.C_ORANGE },
                { value: 101, color: Defines.C_WHITE }
            ];
            // XVM Scale: http://www.koreanrandom.com/forum/topic/2625-xvm-scale
            c.x = [
                { value: 17,  color: Defines.C_RED },      // 00   - 16.5 - very bad   (20% of players)
                { value: 34,  color: Defines.C_ORANGE },   // 16.5 - 33.5 - bad        (better then 20% of players)
                { value: 53,  color: Defines.C_YELLOW },   // 33.5 - 52.5 - normal     (better then 60% of players)
                { value: 76,  color: Defines.C_GREEN },    // 52.5 - 75.5 - good       (better then 90% of players)
                { value: 93,  color: Defines.C_BLUE },     // 75.5 - 92.5 - very good  (better then 99% of players)
                { value: 999, color: Defines.C_PURPLE }    // 92.5 - XX   - unique     (better then 99.9% of players)
            ];
            c.eff = [
                { value: 610,  color: Defines.C_RED },     // very bad
                { value: 850,  color: Defines.C_ORANGE },  // bad
                { value: 1145, color: Defines.C_YELLOW },  // normal
                { value: 1475, color: Defines.C_GREEN },   // good
                { value: 1775, color: Defines.C_BLUE },    // very good
                { value: 9999, color: Defines.C_PURPLE }   // unique
            ];
            c.wn6 = [
                { value: 410,  color: Defines.C_RED },     // very bad
                { value: 795,  color: Defines.C_ORANGE },  // bad
                { value: 1185, color: Defines.C_YELLOW },  // normal
                { value: 1585, color: Defines.C_GREEN },   // good
                { value: 1925, color: Defines.C_BLUE },    // very good
                { value: 9999, color: Defines.C_PURPLE }   // unique
            ];
            c.wn8 = [
                { value: 310,  color: Defines.C_RED },     // very bad
                { value: 750,  color: Defines.C_ORANGE },  // bad
                { value: 1310, color: Defines.C_YELLOW },  // normal
                { value: 1965, color: Defines.C_GREEN },   // good
                { value: 2540, color: Defines.C_BLUE },    // very good
                { value: 9999, color: Defines.C_PURPLE }   // unique
            ];
            c.rating = [
                { value: 47,  color: Defines.C_RED },      // very bad
                { value: 49,  color: Defines.C_ORANGE },   // bad
                { value: 52,  color: Defines.C_YELLOW },   // normal
                { value: 57,  color: Defines.C_GREEN },    // good
                { value: 65,  color: Defines.C_BLUE },     // very good
                { value: 101, color: Defines.C_PURPLE }    // unique
            ];
            c.e = [
                { value: 3,    color: Defines.C_RED },     // very bad
                { value: 6,    color: Defines.C_ORANGE },  // bad
                { value: 7,    color: Defines.C_YELLOW },  // normal
                { value: 8,    color: Defines.C_GREEN },   // good
                { value: 9,    color: Defines.C_BLUE },    // very good
                { value: 20,   color: Defines.C_PURPLE }   // unique
            ];
            c.kb = [
                { value: 2,   color: Defines.C_RED },
                { value: 5,   color: Defines.C_ORANGE },
                { value: 9,   color: Defines.C_YELLOW },
                { value: 14,  color: Defines.C_GREEN },
                { value: 20,  color: Defines.C_BLUE },
                { value: 999, color: Defines.C_PURPLE }
            ];
            c.avglvl = [
                { value: 2,  color: Defines.C_RED },
                { value: 3,  color: Defines.C_ORANGE },
                { value: 5,  color: Defines.C_YELLOW },
                { value: 7,  color: Defines.C_GREEN },
                { value: 9,  color: Defines.C_BLUE },
                { value: 11, color: Defines.C_PURPLE }
            ];
            c.t_battles = [
                { value: 100,   color: Defines.C_RED },
                { value: 250,   color: Defines.C_ORANGE },
                { value: 500,   color: Defines.C_YELLOW },
                { value: 1000,  color: Defines.C_GREEN },
                { value: 1800,  color: Defines.C_BLUE },
                { value: 99999, color: Defines.C_PURPLE }
            ];
            c.tdb = [
                { value: 500,  color: Defines.C_RED },
                { value: 1000, color: Defines.C_YELLOW },
                { value: 2000, color: Defines.C_GREEN }
            ];
            c.tdv = [
                { value: 0.6,  color: Defines.C_RED },
                { value: 0.8,  color: Defines.C_ORANGE },
                { value: 1.0,  color: Defines.C_YELLOW },
                { value: 1.3,  color: Defines.C_GREEN },
                { value: 2.0,  color: Defines.C_BLUE },
                { value: 15,   color: Defines.C_PURPLE }
            ];
            c.tfb = [
                { value: 0.6,  color: Defines.C_RED },
                { value: 0.8,  color: Defines.C_ORANGE },
                { value: 1.0,  color: Defines.C_YELLOW },
                { value: 1.3,  color: Defines.C_GREEN },
                { value: 2.0,  color: Defines.C_BLUE },
                { value: 15,   color: Defines.C_PURPLE }
            ];
            c.tsb = [
                { value: 0.6,  color: Defines.C_RED },
                { value: 0.8,  color: Defines.C_ORANGE },
                { value: 1.0,  color: Defines.C_YELLOW },
                { value: 1.3,  color: Defines.C_GREEN },
                { value: 2.0,  color: Defines.C_BLUE },
                { value: 15,   color: Defines.C_PURPLE }
            ];
            return c;
        }

        private static function getAlphaSection():Object
        {
            var c:Object = new Object();
            // values - from min to max, transparency are for values 'lesser then ...'
            c.hp = [
                { value: 200,  alpha: 100 },
                { value: 400,  alpha: 80 },
                { value: 1000, alpha: 60 },
                { value: 9999, alpha: 40 }
            ];
            c.hp_ratio = [
                { value: 10,  alpha: 100 },
                { value: 25,  alpha: 80 },
                { value: 50,  alpha: 60 },
                { value: 101, alpha: 40 }
            ];
            c.x = [
                { value: 30,  alpha: 100 },
                { value: 50, alpha: 80 },
                { value: 70, alpha: 60 },
                { value: 9999, alpha: 40 }
            ];
            c.eff = [
                { value: 850,  alpha: 100 },
                { value: 1145, alpha: 80 },
                { value: 1475, alpha: 60 },
                { value: 9999, alpha: 40 }
            ];
            c.wn6 = [
                { value: 795,  alpha: 100 },
                { value: 1185, alpha: 80 },
                { value: 1585, alpha: 60 },
                { value: 9999, alpha: 40 }
            ];
            c.wn8 = [
                { value: 750,  alpha: 100 },
                { value: 1310, alpha: 80 },
                { value: 1965, alpha: 60 },
                { value: 9999, alpha: 40 }
            ];
            c.rating = [
                { value: 49,  alpha: 100 },
                { value: 53,  alpha: 80 },
                { value: 60,  alpha: 60 },
                { value: 101, alpha: 40 }
            ];
            c.e = [
                { value: 5,  alpha: 100 },
                { value: 7,  alpha: 80 },
                { value: 9,  alpha: 60 },
                { value: 20, alpha: 40 }
            ];
            c.kb = [
                { value: 2,   alpha: 100 },
                { value: 10,  alpha: 80 },
                { value: 20,  alpha: 60 },
                { value: 999, alpha: 40 }
            ];
            c.avglvl = [
                { value: 11,  alpha: 100 }
            ];
            c.t_battles = [
                { value: 250,  alpha: 100 },
                { value: 500, alpha: 80 },
                { value: 1000, alpha: 60 },
                { value: 99999, alpha: 40 }
            ];
            c.tdb = [
                { value: 1,   alpha: 100 },
                { value: 500,  alpha: 80 },
                { value: 1000,  alpha: 60 },
                { value: 9999, alpha: 40 }
            ];
            c.tdv = [
                { value: 0.6,   alpha: 100 },
                { value: 1.0,  alpha: 80 },
                { value: 1.3,  alpha: 60 },
                { value: 15, alpha: 40 }
            ];
            c.tfb = [
                { value: 0.6,   alpha: 100 },
                { value: 1.0,  alpha: 80 },
                { value: 1.3,  alpha: 60 },
                { value: 15, alpha: 40 }
            ];
            c.tsb = [
                { value: 0.6,   alpha: 100 },
                { value: 1.0,  alpha: 80 },
                { value: 1.3,  alpha: 60 },
                { value: 15, alpha: 40 }
            ];
            return c;
        }

        private static function getTextsSection():Object
        {
            var c:Object = new Object();
            // Text for {{vtype}} macro
            c.vtype = new Object();
            c.vtype.LT =  "LT",        // Text for light tanks
            c.vtype.MT =  "MT",        // Text for medium tanks
            c.vtype.HT =  "HT",        // Text for heavy tanks
            c.vtype.SPG = "SPG",       // Text for arty
            c.vtype.TD =  "TD"         // Text for tank destroyers
            return c;
        }

        private static function getIconsetSection():Object
        {
            var c:Object = new Object();
            c.battleLoadingAlly = "contour/";
            c.battleLoadingEnemy = "contour/";
            c.statisticFormAlly = "contour/";
            c.statisticFormEnemy = "contour/";
            c.playersPanelAlly =  "contour/";
            c.playersPanelEnemy =  "contour/";
            c.vehicleMarkerAlly = "contour/";
            c.vehicleMarkerEnemy = "contour/";
            return c;
        }

        private static function getConstsSection():Object
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

        /////////////////////

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
                blowupMessage: "{{l10n:blownUp}}"
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
        public static function getClanIcon(): Object
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
                color: Defines.C_WHITE,
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
                color: Defines.C_WHITE,
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
    }
}
