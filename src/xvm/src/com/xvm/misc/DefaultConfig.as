/**
 * XVM Default Config
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.misc
{
    import com.xvm.*;
    import com.xvm.utils.*;
    import com.xvm.types.cfg.*;

    public class DefaultConfig
    {
        public static function get config():CConfig
        {
            var c:CConfig = new CConfig();
            c.xvmVersion = Defines.XVM_VERSION;
            c.configVersion = Defines.CONFIG_VERSION;
            c.autoReloadConfig = false;
            c.language = Defines.LOCALE_AUTO_DETECTION;
            c.region =  Defines.REGION_AUTO_DETECTION;
            c.definition = getDefinitionSection();
            c.login = getLoginSection();
            c.hangar = getHangarSection();
            c.battle = getBattleSection();
            c.squad = getSquadSection();
            c.userInfo = getUserInfoSection();
            c.fragCorrelation = getFragCorrelationSection();
            c.hotkeys = getHotkeysSection();
            c.battleLoading = getBattleLoadingSection();
            c.statisticForm = getStatisticFormSection();
            c.playersPanel = getPlayersPanelSection();
            c.battleResults = getBattleResultsSection();
            c.expertPanel = getExpertPanelSection();
            c.minimap = getMinimapSection();
            c.minimapAlt = getMinimapSection();
            c.minimapAlt.enabled = false;
            c.captureBar = getCaptureBarSection();
            c.hitLog = getHitlogSection();
            c.markers = getMarkersSection();
            c.colors = getColorsSection();
            c.alpha = getAlphaSection();
            c.texts = getTextsSection();
            c.iconset = getIconsetSection();
            c.vehicleNames = new Object();
            c.consts = getConstsSection();
            return c;
        }

        private static function getDefinitionSection():CDefinition
        {
            var c:CDefinition = new CDefinition();
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

        private static function getLoginSection():CLogin
        {
            var c:CLogin = new CLogin();
            c.skipIntro = true;
            c.saveLastServer = false;
            c.autologin = false;
            c.confirmOldReplays = false;

            // Show ping to the servers
            c.pingServers = new CPingServers;
            c.pingServers.enabled = false;
            c.pingServers.updateInterval = 10000; // msec
            c.pingServers.x = 5;
            c.pingServers.y = 30;
            c.pingServers.alpha = 80;
            c.pingServers.delimiter = ": ";
            c.pingServers.maxRows = 4;
            c.pingServers.columnGap = 10;
            c.pingServers.leading = 0;
            c.pingServers.topmost = true;
            c.pingServers.fontStyle = {
                name: "$TextFont",
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
            c.pingServers.shadow = new CShadow();
            c.pingServers.shadow.enabled = true;
            c.pingServers.shadow.color = "0x000000";
            c.pingServers.shadow.distance = 0;
            c.pingServers.shadow.angle = 0;
            c.pingServers.shadow.alpha = 70;
            c.pingServers.shadow.blur = 4;
            c.pingServers.shadow.strength = 2;

            return c;
        }

        private static function getHangarSection():CHangar
        {
            var c:CHangar = new CHangar();
            c.xwnInCompany = true;
            c.masteryMarkInTechTree = true;
            c.hidePricesInTechTree = false;
            c.widgetsEnabled = false;

            // Show ping to the servers
            c.pingServers = new CPingServers();
            c.pingServers.enabled = false;
            c.pingServers.updateInterval = 10000; // msec
            c.pingServers.x = 3;
            c.pingServers.y = 51;
            c.pingServers.alpha = 80;
            c.pingServers.delimiter = ": ";
            c.pingServers.maxRows = 2;
            c.pingServers.columnGap = 3;
            c.pingServers.leading = 0;
            c.pingServers.topmost = true;
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
            c.pingServers.shadow = new CShadow();
            c.pingServers.shadow.enabled = true;
            c.pingServers.shadow.color = "0x000000";
            c.pingServers.shadow.distance = 0;
            c.pingServers.shadow.angle = 0;
            c.pingServers.shadow.alpha = 70;
            c.pingServers.shadow.blur = 4;
            c.pingServers.shadow.strength = 2;

            // Tank carousel
            c.carousel = new CCarousel();
            c.carousel.enabled = true;
            c.carousel.zoom = 1;
            c.carousel.rows = 1;
            c.carousel.padding = { horizontal:10, vertical:2 },
            c.carousel.alwaysShowFilters = false;
            c.carousel.hideBuyTank = false;
            c.carousel.hideBuySlot = false;
            c.carousel.filters = {
              nation:   { enabled: true },
              type:     { enabled: true },
              level:    { enabled: true },
              prefs:    { enabled: true },
              favorite: { enabled: true }
            },
            c.carousel.fields = {
                tankType: { visible: true, dx: 0, dy: 0, alpha: 100, scale: 1 },
                level:    { visible: true, dx: 0, dy: 0, alpha: 100, scale: 1 },
                xp:       { visible: true, dx: 0, dy: 0, alpha: 100, scale: 1 },
                multiXp:  { visible: true, dx: 0, dy: 0, alpha: 100, scale: 1 },
                tankName: { visible: true, dx: 0, dy: 0, alpha: 100, scale: 1 }
            };
            c.carousel.extraFields = [
                { x: -1, y: 10, format: "<img src='img://gui/maps/icons/library/proficiency/class_icons_{{v.mastery}}.png' width='23' height='23'>" }
            ];

            // Clock
            c.clock = new CClock();
            c.clock.enabled = true;
            c.clock.x = -10;
            c.clock.y = 28;
            c.clock.width = 300;
            c.clock.height = 60;
            c.clock.topmost = true;
            c.clock.align = "right";
            c.clock.valign = "top";
            c.clock.textAlign = "right";
            c.clock.textVAlign = "center";
            c.clock.alpha = 100;
            c.clock.rotation = 0;
            c.clock.borderColor = null;
            c.clock.bgColor = null;
            c.clock.bgImage = null;
            c.clock.antiAliasType = "advanced";
            c.clock.format = "<textformat tabstops='[80]' leading='-39'><font face='$FieldFont'><font size='15'>{{D%02d}} {{MM}} {{Y}}<tab><font size='36'>{{h%02d}}:{{m%02d}}</font>\n<textformat rightMargin='87'>{{WW}}</font></textformat></textformat>";
            c.clock.shadow = new CShadow();
            c.clock.shadow.enabled = true;
            c.clock.shadow.distance = 0;
            c.clock.shadow.angle = 0;
            c.clock.shadow.color = "0x000000";
            c.clock.shadow.alpha = 70;
            c.clock.shadow.blur = 4;
            c.clock.shadow.strength = 2;

            return c;
        }

        private static function getBattleSection():CBattle
        {
            var c:CBattle = new CBattle();
            c.mirroredVehicleIcons = true;      // Set false for alternative tank icon mirroring.
            c.showPostmortemTips = true;        // Popup tooltip panel after death.
            c.highlightVehicleIcon = true;      // False - disable highlighting of selected vehicle icon and squad.
            c.allowHpInPanelsAndMinimap = false;
            c.allowMarksOnGunInPanelsAndMinimap = false;
            // Show the clock on the Debug Panel (near FPS).
            c.clockFormat = "H:N"; // TODO "H:i:s";   // Format: http://php.net/date
            c.clanIconsFolder = "clanicons/";   // Folder with clan icons
            // Visual elements
            c.elements = [
                {
                    minimap: {
                        rowA: { textColor: "0x8A855C" },
                        rowB: { textColor: "0x8A855C" },
                        rowC: { textColor: "0x8A855C" },
                        rowD: { textColor: "0x8A855C" },
                        rowE: { textColor: "0x8A855C" },
                        rowF: { textColor: "0x8A855C" },
                        rowG: { textColor: "0x8A855C" },
                        rowH: { textColor: "0x8A855C" },
                        rowJ: { textColor: "0x8A855C" },
                        rowK: { textColor: "0x8A855C" },
                        colsNames: { textColor: "0x8A855C" }
                    }
                }
            ];
            return c;
        }

        private static function getSquadSection():CSquad
        {
            var c:CSquad = new CSquad();
            c.enabled = true;                  // Global switch
            c.showClan = true;                 // Show player clan
            c.formatInfoField = "{{rlevel}}";  // Format of vehicle info field
            return c;
        }

        private static function getUserInfoSection():CUserInfo
        {
            var c:CUserInfo = new CUserInfo();
            c.startPage = 1;
            c.sortColumn = -5;                 // Number of column for sorting
            c.showExtraDataInProfile = false;
            c.inHangarFilterEnabled = false;   // Enable In hangar radio button by default
            c.showFilters = true;              // Show tank filters
            c.filterFocused = true;            // Set the default focus to the filter text input
            c.defaultFilterValue = "";         // Default filter value
            return c;
        }

        private static function getFragCorrelationSection():CFragCorrelation
        {
            var c:CFragCorrelation = new CFragCorrelation();
            c.hideTeamTextFields = true;
            return c;
        }

        private static function getHotkeysSection():CHotkeys
        {
            var c:CHotkeys = new CHotkeys();
            c.minimapZoom = { enabled: false, keyCode: 29, onHold: true }; // 29 - Left Ctrl
            c.minimapAltMode = { enabled: false, keyCode: 29, onHold: true };
            c.playersPanelAltMode = { enabled: false, keyCode: 29, onHold: true };
            /*
            c.messages: [
              {  enabled: true, keycode: 113, text: "ШАНСЫ 5% АЙДА ТАПИЦА" }, // F2
              {  enabled: true, keycode: 114, text: "☆\nhey!\n☆" } // .split("\n")
            ]
            */
            return c;
        }

        private static function getBattleLoadingSection():CBattleLoading
        {
            var c:CBattleLoading = new CBattleLoading();
            // Show clock at Battle Loading Screen.
            // ### Is there a clock:on\off switch variable supposed to be? ###
            // A: No, it is possible to set clockFormat: "" to disable clock.

            c.clockFormat = "H:i:s";   // Format: http://php.net/date
            c.showBattleTier = false;  // Show battle tier.
            c.removeSquadIcon = false; // Hide squad icon.
            // Playes/clan icon parameters.
            c.clanIcon = new CClanIcon();
            c.clanIcon.show = true;
            c.clanIcon.x = 0;
            c.clanIcon.y = 6;
            c.clanIcon.xr = 0;
            c.clanIcon.yr = 6;
            c.clanIcon.h = 16;
            c.clanIcon.w = 16;
            c.clanIcon.alpha = 90;
            // Dispay format. Macro-substitutiones allowed.
            c.darkenNotReadyIcon = true;
            c.formatLeftNick = "{{name%.20s~..}} <font alpha='#A0'>{{clan}}</font>";
            c.formatRightNick = "{{name%.20s~..}} <font alpha='#A0'>{{clan}}</font>";
            c.formatLeftVehicle = "{{vehicle}}<font face='Lucida Console' size='12'> <font color='{{c:kb}}'>{{kb%2d~k}}</font> <font color='{{c:xwn8}}'>{{xwn8}}</font> <font color='{{c:rating}}'>{{rating%2d~%}}</font></font>";
            c.formatRightVehicle = "<font face='Lucida Console' size='12'><<font color='{{c:rating}}'>{{rating%2d~%}}</font> <font color='{{c:xwn8}}'>{{xwn8}}</font> <font color='{{c:kb}}'>{{kb%2d~k}}</font> </font>{{vehicle}}";
            return c;
        }

        private static function getStatisticFormSection():CStatisticForm
        {
            var c:CStatisticForm = new CStatisticForm();
            c.showBattleTier = false;  // Show battle tier.
            c.removeSquadIcon = false; // Hide squad icon.
            // Playes/clan icon parameters.
            c.clanIcon = new CClanIcon();
            c.clanIcon.show = true;
            c.clanIcon.x = 0;
            c.clanIcon.y = 6;
            c.clanIcon.xr = 0;
            c.clanIcon.yr = 6;
            c.clanIcon.h = 16;
            c.clanIcon.w = 16;
            c.clanIcon.alpha = 90;
            // Dispay format.
            c.formatLeftNick = "{{name%.20s~..}} <font alpha='#A0'>{{clan}}</font>";
            c.formatRightNick = "{{name%.20s~..}} <font alpha='#A0'>{{clan}}</font>";
            c.formatLeftVehicle = "{{vehicle}}<font face='Lucida Console' size='12'> <font color='{{c:kb}}'>{{kb%2d~k}}</font> <font color='{{c:xwn8}}'>{{xwn8}}</font> <font color='{{c:rating}}'>{{rating%2d~%}}</font></font>";
            c.formatRightVehicle = "<font face='Lucida Console' size='12'><<font color='{{c:rating}}'>{{rating%2d~%}}</font> <font color='{{c:xwn8}}'>{{xwn8}}</font> <font color='{{c:kb}}'>{{kb%2d~k}}</font> </font>{{vehicle}}";
            return c;
        }

        private static function getPlayersPanelSection():CPlayersPanel
        {
            var c:CPlayersPanel = new CPlayersPanel();
            c.alpha = 60;
            c.iconAlpha = 100;
            c.removeSquadIcon = false;
            c.removeSelectedBackground = false;
            c.removePanelsModeSwitcher = false;
            c.startMode = "large";
            c.altMode = null;
            // Playes/clan icon parameters.
            c.clanIcon = { show: true, x: 0, y: 6, xr: 0, yr: 6, h: 16, w: 16, alpha: 90 };
            // Display options for icons of never seen enemies
            c.none = {
                enabled: true,
                layout: "vertical",
                extraFields: {
                    leftPanel: {
                        x: 0,
                        y: 65,
                        width: 250,
                        height: 25,
                        formats: []
                    },
                    rightPanel: {
                        x: 0,
                        y: 65,
                        width: 250,
                        height: 25,
                        formats: []
                    }
                }
            };
            c.short = {
                enabled: true,
                width: 0,
                fragsFormatLeft: "{{frags}}",
                fragsFormatRight: "{{frags}}",
                extraFieldsLeft: [],
                extraFieldsRight: [
                    { x: 0, y: 5, valign: "top", bindToIcon: true, format: "{{spotted}}", shadow: {} }
                ]
            };
            // Medium1 mode.
            c.medium = {
                enabled: true,
                // 0..250 - player name field width.
                width: 46,
                // Dispay format.
                formatLeft: "        <font color='{{c:xwn8}}' alpha='{{alive?#FF|#80}}'>{{name%.20s~..}}</font> <font alpha='#A0'>{{clan}}</font>",
                formatRight: "<font alpha='#A0'>{{clan}}</font> <font color='{{c:xwn8}}' alpha='{{alive?#FF|#80}}'>{{name%.20s~..}}</font>        <font size='0'>.</font>",
                fragsFormatLeft: "{{frags}}",
                fragsFormatRight: "{{frags}}",
                extraFieldsLeft: [
                    { "x": 5, "y": 5, "src": "xvm://res/icons/lang/16x16/{{lang}}.png" }
                ],
                extraFieldsRight: [
                    { x: 0, y: 5, valign: "top", bindToIcon: true, format: "{{spotted}}", shadow: {} },
					{ "x": 5, "y": 5, "src": "xvm://res/icons/lang/16x16/{{lang}}.png" }
                ]
            };
            // Medium2 mode.
            c.medium2 = {
                enabled: true,
                // 0..250 - player name field width.
                width: 65,
                // Dispay format.
                formatLeft: "<font color='{{c:xwn8}}'>{{vehicle}}</font>",
                formatRight: "<font color='{{c:xwn8}}'>{{vehicle}}</font>",
                fragsFormatLeft: "{{frags}}",
                fragsFormatRight: "{{frags}}",
                extraFieldsLeft: [],
                extraFieldsRight: [
                    { x: 0, y: 5, valign: "top", bindToIcon: true, format: "{{spotted}}", shadow: {} }
                ]
            };
            // Large mode.
            c.large = {
                enabled: true,
                // 0..250 - player name field width.
                width: 170,
                // Dispay format.
                nickFormatLeft: "<font face='Lucida Console' size='12' color='{{c:xwn8}}' alpha='{{alive?#FF|#80}}'>{{xwn8}}</font>        {{name%.20s~..}} <font alpha='#A0'>{{clan}}</font>",
                nickFormatRight: "<font alpha='#A0'>{{clan}}</font> {{name%.20s~..}}        <font face='Lucida Console' size='12' color='{{c:xwn8}}' alpha='{{alive?#FF|#80}}'>{{xwn8}}</font>",
                vehicleFormatLeft: "{{vehicle}}",
                vehicleFormatRight: "{{vehicle}}",
                fragsFormatLeft: "{{frags}}",
                fragsFormatRight: "{{frags}}",
                extraFieldsLeft: [
                    { "x": 46, "y": 5, "src": "xvm://res/icons/lang/16x16/{{lang}}.png" }
                ],
                extraFieldsRight: [
                    { x: 0, y: 5, valign: "top", bindToIcon: true, format: "{{spotted}}", shadow: {} },
					{ "x": 46, "y": 5, "src": "xvm://res/icons/lang/16x16/{{lang}}.png" }
                ]
            };

            return c;
        }

        private static function getBattleResultsSection():CBattleResults
        {
            var c:CBattleResults = new CBattleResults();
            c.startPage = 1;
            c.showTotalExperience = true;
            c.showCrewExperience = false;
            c.showNetIncome = true;
            c.showExtendedInfo = true;
            c.showTotals = true;
            c.showBattleTier = false;
            return c;
        }

        private static function getExpertPanelSection():CExpertPanel
        {
            var c:CExpertPanel = new CExpertPanel();
            c.delay = 15;
            c.scale = 150;
            return c;
        }

        private static function getMinimapSection():CMinimap
        {
            var c:CMinimap = new CMinimap();
            c.enabled = true;
            c.mapBackgroundImageAlpha = 100;
            c.selfIconAlpha = 75;
            c.hideCameraTriangle = false;
            c.cameraAlpha = 100;
            c.iconScale = 1;

            c.zoom = new CMinimapZoom();
            c.zoom.pixelsBack = 160;
            c.zoom.centered = true;

            c.square = new CMinimapSquare();
            c.square.enabled = false;
            c.square.artilleryEnabled = false;
            c.square.thickness = 0.7;
            c.square.alpha = 40;
            c.square.color = "0xFFFFFF";

            c.circles = new CMinimapCircles();
            c.circles.enabled = true;

            c.circles.view = [ ];

            var range_blind:CMinimapCirclesViewRange = new CMinimapCirclesViewRange();
            range_blind.enabled = true;
            range_blind.distance = "blindarea";
            range_blind.scale = 1;
            range_blind.alpha = 80;
            range_blind.color = "0x3EB5F1";
            range_blind.thickness = 0.75;
            c.circles.view.push(range_blind);

            var range_445:CMinimapCirclesViewRange = new CMinimapCirclesViewRange();
            range_445.enabled = true;
            range_445.distance = 445;
            range_445.scale = 1;
            range_445.alpha = 45;
            range_445.color = "0xFFCC66";
            range_445.thickness = 1.1;
            c.circles.view.push(range_445);

            c.circles.artillery = new CMinimapCirclesRange();
            c.circles.artillery.enabled = true;
            c.circles.artillery.alpha = 55;
            c.circles.artillery.color = "0xFF6666";
            c.circles.artillery.thickness = 0.5;

            c.circles.shell =  new CMinimapCirclesRange();
            c.circles.shell.enabled = true;
            c.circles.shell.alpha = 55;
            c.circles.shell.color = "0xFF6666";
            c.circles.shell.thickness = 0.5;

            c.circles.special = [ ];

            c.circles._internal = new CMinimapCirclesInternal();
            c.circles._internal.view_distance_vehicle = 0;
            c.circles._internal.shell_range = 0;
            c.circles._internal.artillery_range = 0;

            c.lines = new CMinimapLines();
            c.lines.enabled = true;
            c.lines.vehicle = [
                { enabled: true, inmeters: true, color: 0x60FF00, from: 50,  to: 97,   thickness: 1.5,  alpha: 45 },
                { enabled: true, inmeters: true, color: 0x60FF00, from: 100, to: 147,  thickness: 1.4,  alpha: 40 },
                { enabled: true, inmeters: true, color: 0x60FF00, from: 150, to: 197,  thickness: 1.3,  alpha: 35 },
                { enabled: true, inmeters: true, color: 0x60FF00, from: 200, to: 248,  thickness: 1.2,  alpha: 33 },
                { enabled: true, inmeters: true, color: 0x60FF00, from: 250, to: 298,  thickness: 1.1,  alpha: 30 },
                { enabled: true, inmeters: true, color: 0x60FF00, from: 300, to: 398,  thickness: 1,    alpha: 30 },
                { enabled: true, inmeters: true, color: 0x60FF00, from: 400, to: 498,  thickness: 0.9,  alpha: 30 },
                { enabled: true, inmeters: true, color: 0x60FF00, from: 500, to: 2000, thickness: 0.75, alpha: 30 }
            ];
            c.lines.camera = [
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 50,   to: 80,   thickness: 1.3,  alpha: 50 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 120,  to: 180,  thickness: 1.2,  alpha: 45 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 220,  to: 280,  thickness: 1.1,  alpha: 40 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 320,  to: 380,  thickness: 1,    alpha: 35 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 420,  to: 480,  thickness: 0.9,  alpha: 35 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 520,  to: 580,  thickness: 0.8,  alpha: 35 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 620,  to: 680,  thickness: 0.75, alpha: 35 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 720,  to: 780,  thickness: 0.75, alpha: 35 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 820,  to: 880,  thickness: 0.75, alpha: 35 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 920,  to: 980,  thickness: 0.75, alpha: 35 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1020, to: 1080, thickness: 0.75, alpha: 35 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1120, to: 1180, thickness: 0.75, alpha: 35 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1220, to: 1280, thickness: 0.75, alpha: 35 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1320, to: 1380, thickness: 0.75, alpha: 35 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1420, to: 1480, thickness: 0.75, alpha: 35 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1520, to: 1580, thickness: 0.75, alpha: 35 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1620, to: 1680, thickness: 0.75, alpha: 35 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1720, to: 1780, thickness: 0.75, alpha: 35 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1820, to: 1880, thickness: 0.75, alpha: 35 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1920, to: 2000, thickness: 0.75, alpha: 35 },
                //Dots
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 99,   to: 100,  thickness: 2.2, alpha: 70 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 199,  to: 200,  thickness: 2.1, alpha: 65 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 299,  to: 300,  thickness: 2,   alpha: 60 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 399,  to: 400,  thickness: 1.9, alpha: 55 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 499,  to: 500,  thickness: 1.8, alpha: 55 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 599,  to: 600,  thickness: 1.7, alpha: 55 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 699,  to: 700,  thickness: 1.6, alpha: 55 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 799,  to: 800,  thickness: 1.5, alpha: 55 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 899,  to: 900,  thickness: 1.5, alpha: 55 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 999,  to: 1000, thickness: 1.5, alpha: 55 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1099, to: 1100, thickness: 1.5, alpha: 55 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1199, to: 1200, thickness: 1.5, alpha: 55 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1299, to: 1300, thickness: 1.5, alpha: 55 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1399, to: 1400, thickness: 1.5, alpha: 55 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1499, to: 1500, thickness: 1.5, alpha: 55 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1599, to: 1600, thickness: 1.5, alpha: 55 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1699, to: 1700, thickness: 1.5, alpha: 55 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1799, to: 1800, thickness: 1.5, alpha: 55 },
                { enabled: true, inmeters: true, color: 0xFFCC66, from: 1899, to: 1900, thickness: 1.5, alpha: 55 }
            ];
            c.lines.traverseAngle = [
                { enabled: true, inmeters: true, color: 0xCCCCCC, from: 50,  to: 97,   thickness: 1.5,  alpha: 50 },
                { enabled: true, inmeters: true, color: 0xCCCCCC, from: 100, to: 147,  thickness: 1.4,  alpha: 48 },
                { enabled: true, inmeters: true, color: 0xCCCCCC, from: 150, to: 197,  thickness: 1.3,  alpha: 46 },
                { enabled: true, inmeters: true, color: 0xCCCCCC, from: 200, to: 248,  thickness: 1.2,  alpha: 44 },
                { enabled: true, inmeters: true, color: 0xCCCCCC, from: 250, to: 298,  thickness: 1.1,  alpha: 42 },
                { enabled: true, inmeters: true, color: 0xCCCCCC, from: 300, to: 398,  thickness: 1,    alpha: 40 },
                { enabled: true, inmeters: true, color: 0xCCCCCC, from: 400, to: 498,  thickness: 0.9,  alpha: 40 },
                { enabled: true, inmeters: true, color: 0xCCCCCC, from: 500, to: 2000, thickness: 0.75, alpha: 40 }
            ];

            c.labels = new CMinimapLabels();
            c.labels.vehicleclassmacro = new CMinimapLabelsVehicleClassMacro();
            c.labels.vehicleclassmacro.light = "\u2022";
            c.labels.vehicleclassmacro.medium =  "\u2022";
            c.labels.vehicleclassmacro.heavy = "\u2022";
            c.labels.vehicleclassmacro.td = "\u2022";
            c.labels.vehicleclassmacro.spg = "\u25AA";
            c.labels.vehicleclassmacro.superh = "\u2022";
            c.labels.units = new CMinimapLabelsUnits();
            c.labels.units.revealedEnabled = true;
            c.labels.units.lostEnemyEnabled = true;
            c.labels.units.format = {
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
            };
            c.labels.units.css = {
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
            };
            c.labels.units.shadow = {
                ally:           { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 4 },
                teamkiller:     { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 4 },
                enemy:          { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 4 },
                squad:          { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 4 },
                oneself:        { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 4 },
                lostally:       { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 6, strength: 4 },
                lostteamkiller: { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 6, strength: 4 },
                lost:           { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 6, strength: 4 },
                lostsquad:      { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 6, strength: 4 },
                deadally:       { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 3 },
                deadteamkiller: { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 3 },
                deadenemy:      { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 3 },
                deadsquad:      { enabled: true, color: "0x000000", distance: 0, angle: 45, alpha: 80, blur: 3, strength: 3 }
            };
            c.labels.units.offset = {
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
            };
            c.labels.units.alpha = {
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
            };
            c.labels.mapSize = new CMinimapLabelsMapSize();
            c.labels.mapSize.enabled = true;
            c.labels.mapSize.format = "<b>{{cellsize}}0 m</b>";
            c.labels.mapSize.css = "font-size:10px; color:#FFCC66;";
            c.labels.mapSize.alpha = 80;
            c.labels.mapSize.offsetX = 0;
            c.labels.mapSize.offsetY = 0;
            c.labels.mapSize.shadow = {
                enabled: true,
                color: "0x000000",
                distance: 0,
                angle: 0,
                alpha: 80,
                blur: 2,
                strength: 3
            };
            c.labels.mapSize.width = 100;
            c.labels.mapSize.height = 30;
            return c;
        }

        private static function getCaptureBarSection():CCaptureBar
        {
            var c:CCaptureBar = new CCaptureBar();
            c.enabled = true;
            c.allyColor = null;
            c.enemyColor = null;
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

        private static function getHitlogSection():CHitlog
        {
            var c:CHitlog = new CHitlog();
            c.visible = true;
            c.hpLeft = {
                enabled: true,
                header: "<font color='#FFFFFF'>{{l10n:hpLeftTitle}}</font>",
                format: "<textformat leading='-4' tabstops='[50,90,190]'><font color='{{c:hp-ratio}}'>     {{hp}}</font><tab><font color='#FFFFFF'>/ </font>{{hp-max}}<tab><font color='#FFFFFF'>|</font><font color='{{c:vtype}}'>{{vehicle}}</font><tab><font color='#FFFFFF'>|{{nick}}</font></textformat>"
            };
            c.x = 270;
            c.y = 40;
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
            c.formatHistory = "<textformat leading='-4' tabstops='[20,50,90,190]'><font size='12'>\u00D7{{n-player}}:</font><tab><font color='{{c:dmg-kind}}'>{{dmg}}</font><tab>| {{dmg-player}}<tab>|<font color='{{c:vtype}}'>{{vehicle}} {{dead}}</font><tab><font color='#FFFFFF'>|{{nick}}</font></textformat>";
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

        private static function getMarkersSection():CMarkers
        {
            var c:CMarkers = new CMarkers();

            c.useStandardMarkers = false;       // Use original WoT markers.
            c.turretMarkers = {
                highVulnerability: "*",
                lowVulnerability: "'"
            };
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

        private static function getColorsSection():CColors
        {
            var c:CColors = new CColors();
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
                enemy_blowedup:      "0x5A0401",
                ally_base:           "0x96FF00",
                enemy_base:          "0xF50800"
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
                enemy_ally_hit:           "0x96FF00",
                enemy_ally_kill:          "0x96FF00",
                enemy_ally_blowup:        "0x96FF00",
                enemy_squadman_hit:       "0x96FF00",
                enemy_squadman_kill:      "0x96FF00",
                enemy_squadman_blowup:    "0x96FF00",
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
                unknown_squadman_hit:     "0x96FF00",
                unknown_squadman_kill:    "0x96FF00",
                unknown_squadman_blowup:  "0x96FF00",
                unknown_enemy_hit:        "0xF50800",
                unknown_enemy_kill:       "0xF50800",
                unknown_enemy_blowup:     "0xF50800",
                unknown_allytk_hit:       "0x96FF00",
                unknown_allytk_kill:      "0x96FF00",
                unknown_allytk_blowup:    "0x96FF00",
                unknown_enemytk_hit:      "0xF50800",
                unknown_enemytk_kill:     "0xF50800",
                unknown_enemytk_blowup:   "0xF50800",
                squadman_ally_hit:        "0xFFB964",
                squadman_ally_kill:       "0xFFB964",
                squadman_ally_blowup:     "0xFFB964",
                squadman_squadman_hit:    "0xFFB964",
                squadman_squadman_kill:   "0xFFB964",
                squadman_squadman_blowup: "0xFFB964",
                squadman_enemy_hit:       "0xFFB964",
                squadman_enemy_kill:      "0xFFB964",
                squadman_enemy_blowup:    "0xFFB964",
                squadman_allytk_hit:      "0xFFB964",
                squadman_allytk_kill:     "0xFFB964",
                squadman_allytk_blowup:   "0xFFB964",
                squadman_enemytk_hit:     "0xFFB964",
                squadman_enemytk_kill:    "0xFFB964",
                squadman_enemytk_blowup:  "0xFFB964",
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
                shot:            "0xFFAA55",
                fire:            "0xFF6655",
                ramming:         "0x998855",
                world_collision: "0x998855",
                death_zone:      "0xCCCCCC",
                drowning:        "0xCCCCCC",
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
                { value: 355,  color: Defines.C_RED },     // very bad
                { value: 820,  color: Defines.C_ORANGE },  // bad
                { value: 1370, color: Defines.C_YELLOW },  // normal
                { value: 2020, color: Defines.C_GREEN },   // good
                { value: 2620, color: Defines.C_BLUE },    // very good
                { value: 9999, color: Defines.C_PURPLE }   // unique
            ];
            c.wgr = [
                { value: 2020,  color: Defines.C_RED },     // very bad
                { value: 4185,  color: Defines.C_ORANGE },  // bad
                { value: 6340,  color: Defines.C_YELLOW },  // normal
                { value: 8525,  color: Defines.C_GREEN },   // good
                { value: 9930,  color: Defines.C_BLUE },    // very good
                { value: 99999, color: Defines.C_PURPLE }   // unique
            ];
            c.rating = [
                { value: 46.5,  color: Defines.C_RED },      // very bad
                { value: 48.5,  color: Defines.C_ORANGE },   // bad
                { value: 51.5,  color: Defines.C_YELLOW },   // normal
                { value: 56.5,  color: Defines.C_GREEN },    // good
                { value: 64.5,  color: Defines.C_BLUE },     // very good
                { value: 101,   color: Defines.C_PURPLE }    // unique
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
                { value: 6,   color: Defines.C_ORANGE },
                { value: 16,  color: Defines.C_YELLOW },
                { value: 30,  color: Defines.C_GREEN },
                { value: 43,  color: Defines.C_BLUE },
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
                { value: 750,  color: Defines.C_ORANGE },
                { value: 1000, color: Defines.C_YELLOW },
                { value: 1800, color: Defines.C_GREEN },
                { value: 2500, color: Defines.C_BLUE },
                { value: 9999, color: Defines.C_PURPLE }
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
            c.wn8effd = [
                { value: 0.6,  color: Defines.C_RED },
                { value: 0.8,  color: Defines.C_ORANGE },
                { value: 1.0,  color: Defines.C_YELLOW },
                { value: 1.3,  color: Defines.C_GREEN },
                { value: 2.0,  color: Defines.C_BLUE },
                { value: 15,   color: Defines.C_PURPLE }
            ];
            c.damageRating = [
                { value: 20,    color: Defines.C_RED },
                { value: 60,    color: Defines.C_ORANGE },
                { value: 90,    color: Defines.C_YELLOW },
                { value: 99,    color: Defines.C_GREEN },
                { value: 99.9,  color: Defines.C_BLUE },
                { value: 101,   color: Defines.C_PURPLE }
            ];
            c.hitsRatio = [
                { value: 47.5,  color: Defines.C_RED },
                { value: 60.5,  color: Defines.C_ORANGE },
                { value: 68.5,  color: Defines.C_YELLOW },
                { value: 74.5,  color: Defines.C_GREEN },
                { value: 78.5,  color: Defines.C_BLUE },
                { value: 101,   color: Defines.C_PURPLE }
            ];
            return c;
        }

        private static function getAlphaSection():CAlpha
        {
            var c:CAlpha = new CAlpha();
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
                { value: 820,  alpha: 100 },
                { value: 1370, alpha: 80 },
                { value: 2020, alpha: 60 },
                { value: 9999, alpha: 40 }
            ];
            c.wgr = [
                { value: 4185,  alpha: 100 },
                { value: 6340,  alpha: 80 },
                { value: 8525,  alpha: 60 },
                { value: 99999, alpha: 40 }
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
                { value: 16,  alpha: 80 },
                { value: 30,  alpha: 60 },
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
                { value: 1,    alpha: 100 },
                { value: 1000, alpha: 80 },
                { value: 1800, alpha: 60 },
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

        private static function getTextsSection():CTexts
        {
            var c:CTexts = new CTexts();

            c.vtype = new CTextsVType();
            c.vtype.LT =  "{{l10n:LT}}",   // Text for light tanks
            c.vtype.MT =  "{{l10n:MT}}",   // Text for medium tanks
            c.vtype.HT =  "{{l10n:HT}}",   // Text for heavy tanks
            c.vtype.SPG = "{{l10n:SPG}}",  // Text for arty
            c.vtype.TD =  "{{l10n:TD}}"    // Text for tank destroyers

            c.marksOnGun = new CTextsMarksOnGun();
            c.marksOnGun._0 = "0";
            c.marksOnGun._1 = "1";
            c.marksOnGun._2 = "2";
            c.marksOnGun._3 = "3";

            c.spotted = new CTextsSpotted();
            c.spotted.neverSeen = "";
            c.spotted.lost = "<font face='$FieldFont' size='24' color='#999999'>*</font>";
            c.spotted.revealed = "<font face='$FieldFont' size='24' color='#FFFFFF'>*</font>";
            c.spotted.dead = "";

            return c;
        }

        private static function getIconsetSection():CIconset
        {
            var c:CIconset = new CIconset();
            c.battleLoadingAlly =  "contour/";
            c.battleLoadingEnemy = "contour/";
            c.statisticFormAlly =  "contour/";
            c.statisticFormEnemy = "contour/";
            c.playersPanelAlly =   "contour/";
            c.playersPanelEnemy =  "contour/";
            c.vehicleMarkerAlly =  "contour/";
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
                  alpha: 100,
                  color: "{{c:dmg}}",
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
                blowupMessage: "{{l10n:blownUp}}\n{{dmg}}"
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
                format: "{{rating%2d~%}}"
            }
        }
    }
}
