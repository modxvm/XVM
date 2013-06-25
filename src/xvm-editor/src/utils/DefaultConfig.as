package utils {

public class DefaultConfig
{
    import utils.Defines;

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
                clanIconsFolder: "clanicons/", // Folder with clan icons
                // Visual elements
                elements: {
                    // x - X position
                    // y - Y position
                    // w - width
                    // h - height
                    // a - alpha
                    // ha - horizontal align
                    // va - vertical align
                    // debug - draw border, element name and geometry
                    // x, y values can be:
                    //   null - use default client value
                    //   -xxxx..xxxx
                    //   xx.xx%
                    // ha values can be:
                    //   1 - left
                    //   2 - right (x = [width .. 0])
                    // va values can be:
                    //   1 - top
                    //   2 - bottom (y = [height .. 0])
                    minimap:               { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    playerMessangersPanel: { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    leftPanel:             { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    rightPanel:            { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    switcher_mc:           { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    fragCorrelationBar:    { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    debugPanel:            { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    battleTimer:           { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    damagePanel:           { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    sixthSenseIndicator:   { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    vehicleErrorsPanel:    { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    messenger:             { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    damageInfoPanel:       { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    timerBig:              { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    deathZoneTimer:        { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    overturnedTimer:       { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    drownTimer:            { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    langBarPanel:          { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    consumablesPanel:      { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    vehicleMessagesPanel:  { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
                    teamBasesPanel:        { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false }
                }
            },
            rating: {
                showPlayersStatistics: true,	// Global switch. Handles whole statisctics module.
                loadEnemyStatsInFogOfWar: true,	// Load players data in "fog of war".
                enableStatisticsLog: false, 	// Enable saving statistics to "xvm-stat.log" file
                enableUserInfoStatistics: true,	// Enable statistics in the user info window
                enableCompanyStatistics: true	// Enable statistics in the company window
            },
            squad: {
                enabled: false,			// Global switch
                romanNumbers: true,		// Roman level numbers
                showClan: true,			// Show player clan
                leftLvlBorder: "",		// Grille [4
                rightLvlBorder: ""		// Grille 4]
            },
            userInfo: {
                showFilters: true,              // Show tank filters
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
                    light: "",
                    medium: "",
                    heavy: "",
                    td: "▼",
                    spg: "■",
                    superh: ""
                  },
                  units: {
                    revealedEnabled: true,
                    lostEnemyEnabled: true,
                    format: {
                      ally:  "<span class='mm_a'>{{vehicle-type}}</span>",
                      enemy: "<span class='mm_e'>{{vehicle-type}}</span>",
                      squad: "<textformat leading='-1'><span class='mm_s'><i>{{short-nick}}</i>\n{{vehicle-type}}</span><textformat>",
                      lost:  "<span class='mm_dot'>\u2022</span><span class='mm_l'><i>{{vehicle-type}}</i></span>",
                      oneself: ""
                    },
                    css: {
                      ally:  ".mm_a{font-family:$FieldFont; font-size:8px; color:#C8FFA6;}",
                      enemy: ".mm_e{font-family:$FieldFont; font-size:8px; color:#FCA9A4;}",
                      squad: ".mm_s{font-family:$FieldFont; font-size:8px; color:#FFC099;}",
                      lost:  ".mm_l{font-family:$FieldFont; font-size:8px; color:#FCA9A4;} .mm_dot{font-family:Arial; font-size:17px; color:#FCA9A4;}",
                      oneself: ".mm_o{font-family:$FieldFont; font-size:8px; color:#FFFFFF;}"
                    },
                    shadow: {
                      ally: {
                        enabled: true,
                        color: "0x000000",
                        distance: 0,
                        angle: 0,
                        alpha: 80,
                        blur: 3,
                        strength: 3
                      },
                      enemy: {
                        enabled: true,
                        color: "0x000000",
                        distance: 0,
                        angle: 0,
                        alpha: 80,
                        blur: 3,
                        strength: 3
                      },
                      squad: {
                        enabled: true,
                        color: "0x000000",
                        distance: 0,
                        angle: 0,
                        alpha: 80,
                        blur: 3,
                        strength: 3
                      },
                      lost: {
                        enabled: true,
                        color: "0x000000",
                        distance: 0,
                        angle: 0,
                        alpha: 80,
                        blur: 3,
                        strength: 3
                      },
                      oneself: {
                        enabled: true,
                        color: "0x000000",
                        distance: 0,
                        angle: 0,
                        alpha: 80,
                        blur: 3,
                        strength: 3
                      }
                    },
                    offset: {
                      ally:  {x: 3, y: -1},
                      enemy: {x: 3, y: -1},
                      squad: {x: 3, y: -2},
                      lost:  {x: -6, y: -10},
                      oneself: {x: 0, y: 0}
                    },
                    alpha : {
                      ally:  100,
                      enemy: 100,
                      squad: 100,
                      lost:  70,
                      oneself: 100
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
                    { enabled: false, distance: 50, thickness: 2.5, alpha: 100, color: 0xFFFFFF }
                  ],
                  special: [
                    { g_e:              { enabled: true, distance: 1172, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { object_261:       { enabled: true, distance: 1463, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { bat_chatillon155: { enabled: true, distance: 1296, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { t92:              { enabled: true, distance: 1248, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { g_tiger:          { enabled: true, distance: 1172, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { m40m43:           { enabled: true, distance: 1179, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { object_212:       { enabled: true, distance: 1229, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { lorraine155_51:   { enabled: true, distance: 1296, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { su_14:            { enabled: true, distance: 1229, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { s_51:             { enabled: true, distance: 1229, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { lorraine155_50:   { enabled: true, distance: 1202, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { m12:              { enabled: true, distance: 1316, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { g_panther:        { enabled: true, distance: 1407, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { amx_13f3am:       { enabled: true, distance: 1250, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { su_8:             { enabled: true, distance: 920,  thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { m41:              { enabled: true, distance: 1210, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { hummel:           { enabled: true, distance: 1264, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { amx_105am:        { enabled: true, distance: 1000, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { _105_lefh18b2:    { enabled: true, distance: 1000, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { su_5:             { enabled: true, distance: 605,  thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { m7_priest:        { enabled: true, distance: 1047, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { grille:           { enabled: true, distance: 1210, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { lorraine39_l_am:  { enabled: true, distance: 844,  thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { su_26:            { enabled: true, distance: 578,  thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { wespe:            { enabled: true, distance: 1000, thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { sturmpanzer_ii:   { enabled: true, distance: 605,  thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { m37:              { enabled: true, distance: 969,  thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { renaultbs:        { enabled: true, distance: 450,  thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { su_18:            { enabled: true, distance: 552,  thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { t57:              { enabled: true, distance: 552,  thickness: 1, alpha: 60, color: 0xEE4444 } },
                    { bison_i:          { enabled: true, distance: 605,  thickness: 1, alpha: 60, color: 0xEE4444 } }
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
                hpLeft: true,
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
                    ally_alive:			"0x96FF00",
                    ally_dead:			"0x009900",
                    ally_blowedup:		"0x007700",
                    squadman_alive:		"0xFFB964",
                    squadman_dead:		"0xCA7000",
                    squadman_blowedup:		"0xA45A00",
                    teamKiller_alive:		"0x00EAFF",
                    teamKiller_dead:		"0x097783",
                    teamKiller_blowedup:	"0x096A75",
                    enemy_alive:		"0xF50800",
                    enemy_dead:			"0x840500",
                    enemy_blowedup:		"0x5A0401"
                },
                // src: ally, squadman, enemy, unknown, player
                // dst: ally, squadman, allytk, enemytk, enemy
                damage: {
                    ally_ally_hit:		"0x00EAFF",
                    ally_ally_kill:		"0x00EAFF",
                    ally_ally_blowup:		"0x00EAFF",
                    ally_squadman_hit:		"0x00EAFF",
                    ally_squadman_kill:		"0x00EAFF",
                    ally_squadman_blowup:	"0x00EAFF",
                    ally_enemy_hit:		"0xF50800",
                    ally_enemy_kill:		"0xF50800",
                    ally_enemy_blowup:		"0xF50800",
                    ally_allytk_hit:		"0x00EAFF",
                    ally_allytk_kill:		"0x00EAFF",
                    ally_allytk_blowup:		"0x00EAFF",
                    ally_enemytk_hit:		"0xF50800",
                    ally_enemytk_kill:		"0xF50800",
                    ally_enemytk_blowup:	"0xF50800",
                    squadman_ally_hit:		"0x00EAFF",
                    squadman_ally_kill:		"0x00EAFF",
                    squadman_ally_blowup:	"0x00EAFF",
                    squadman_squadman_hit:	"0x00EAFF",
                    squadman_squadman_kill:	"0x00EAFF",
                    squadman_squadman_blowup:	"0x00EAFF",
                    squadman_enemy_hit:		"0xF50800",
                    squadman_enemy_kill:	"0xF50800",
                    squadman_enemy_blowup:	"0xF50800",
                    squadman_allytk_hit:	"0x00EAFF",
                    squadman_allytk_kill:	"0x00EAFF",
                    squadman_allytk_blowup:	"0x00EAFF",
                    squadman_enemytk_hit:	"0xF50800",
                    squadman_enemytk_kill:	"0xF50800",
                    squadman_enemytk_blowup:	"0xF50800",
                    enemy_ally_hit:		"0x96FF00",
                    enemy_ally_kill:		"0x96FF00",
                    enemy_ally_blowup:		"0x96FF00",
                    enemy_squadman_hit:		"0xFFB964",
                    enemy_squadman_kill:	"0xFFB964",
                    enemy_squadman_blowup:	"0xFFB964",
                    enemy_enemy_hit:		"0xF50800",
                    enemy_enemy_kill:		"0xF50800",
                    enemy_enemy_blowup:		"0xF50800",
                    enemy_allytk_hit:		"0x96FF00",
                    enemy_allytk_kill:		"0x96FF00",
                    enemy_allytk_blowup:	"0x96FF00",
                    enemy_enemytk_hit:		"0xF50800",
                    enemy_enemytk_kill:		"0xF50800",
                    enemy_enemytk_blowup:	"0xF50800",
                    unknown_ally_hit:		"0x96FF00",
                    unknown_ally_kill:		"0x96FF00",
                    unknown_ally_blowup:	"0x96FF00",
                    unknown_squadman_hit:	"0xFFB964",
                    unknown_squadman_kill:	"0xFFB964",
                    unknown_squadman_blowup:	"0xFFB964",
                    unknown_enemy_hit:		"0xF50800",
                    unknown_enemy_kill:		"0xF50800",
                    unknown_enemy_blowup:	"0xF50800",
                    unknown_allytk_hit:		"0x96FF00",
                    unknown_allytk_kill:	"0x96FF00",
                    unknown_allytk_blowup:	"0x96FF00",
                    unknown_enemytk_hit:	"0xF50800",
                    unknown_enemytk_kill:	"0xF50800",
                    unknown_enemytk_blowup:	"0xF50800",
                    player_ally_hit:		"0xFFDD33",
                    player_ally_kill:		"0xFFDD33",
                    player_ally_blowup:		"0xFFDD33",
                    player_squadman_hit:	"0xFFDD33",
                    player_squadman_kill:	"0xFFDD33",
                    player_squadman_blowup:	"0xFFDD33",
                    player_enemy_hit:		"0xFFDD33",
                    player_enemy_kill:		"0xFFDD33",
                    player_enemy_blowup:	"0xFFDD33",
                    player_allytk_hit:		"0xFFDD33",
                    player_allytk_kill:		"0xFFDD33",
                    player_allytk_blowup:	"0xFFDD33",
                    player_enemytk_hit:		"0xFFDD33",
                    player_enemytk_kill:	"0xFFDD33",
                    player_enemytk_blowup:	"0xFFDD33"
                },
                dmg_kind: {
                    attack: "0xFFAA55",
                    fire: "0xFF6655",
                    ramming: "0x998855",
                    world_collision: "0x998855",
                    other: "0xCCCCCC"
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
                    { value: 645,  color: ColorPalette.red },     // very bad
                    { value: 875,  color: ColorPalette.orange },  // bad
                    { value: 1155, color: ColorPalette.yellow },  // normal
                    { value: 1470, color: ColorPalette.green },   // good
                    { value: 1740, color: ColorPalette.blue },    // very good
                    { value: 9999, color: ColorPalette.purple }   // unique
                ],
                wn: [
                    { value: 435,  color: ColorPalette.red },     // very bad
                    { value: 805,  color: ColorPalette.orange },  // bad
                    { value: 1200, color: ColorPalette.yellow },  // normal
                    { value: 1595, color: ColorPalette.green },   // good
                    { value: 1900, color: ColorPalette.blue },    // very good
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
                    { value: 0.1,  color: ColorPalette.white },
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
                    { value: 1,    color: ColorPalette.white },
                    { value: 500,  color: ColorPalette.red },
                    { value: 1000, color: ColorPalette.yellow },
                    { value: 2000, color: ColorPalette.green }
                ],
                tdv: [
                    { value: 0.1,  color: ColorPalette.white },
                    { value: 0.6,  color: ColorPalette.red },
                    { value: 0.8,  color: ColorPalette.orange },
                    { value: 1.0,  color: ColorPalette.yellow },
                    { value: 1.3,  color: ColorPalette.green },
                    { value: 2.0,  color: ColorPalette.blue },
                    { value: 15,   color: ColorPalette.purple }
                ],
                tfb: [
                    { value: 0.1,  color: ColorPalette.white },
                    { value: 0.6,  color: ColorPalette.red },
                    { value: 0.8,  color: ColorPalette.orange },
                    { value: 1.0,  color: ColorPalette.yellow },
                    { value: 1.3,  color: ColorPalette.green },
                    { value: 2.0,  color: ColorPalette.blue },
                    { value: 15,   color: ColorPalette.purple }
                ],
                tsb: [
                    { value: 0.1,  color: ColorPalette.white },
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
                    { value: 900,  alpha: 100 },
                    { value: 1200, alpha: 80 },
                    { value: 1500, alpha: 60 },
                    { value: 9999, alpha: 40 }
                ],
                wn: [
                    { value: 900,  alpha: 100 },
                    { value: 1200, alpha: 80 },
                    { value: 1500, alpha: 60 },
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

}
