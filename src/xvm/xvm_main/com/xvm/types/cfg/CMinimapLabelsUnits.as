/**
 * XVM Config - "minimap" section
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CMinimapLabelsUnits extends Object
    {
        public var revealedEnabled:Boolean;
        public var lostEnemyEnabled:Boolean;
        public var antiAliasType:String;

        public var format:Object;
            //"ally":           "<span class='mm_a'>{{vehicle}}</span>",
            //"teamkiller":     "<span class='mm_t'>{{vehicle}}</span>",
            //"enemy":          "<span class='mm_e'>{{vehicle}}</span>",
            //"squad":          "<textformat leading='-2'><span class='mm_s'><i>{{nick%.5s}}</i>\n{{vehicle}}</span><textformat>",
            //"oneself":        "",
            //"lostally":       "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_la'><i>{{vehicle}}</i></span>",
            //"lostteamkiller": "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_lt'><i>{{vehicle}}</i></span>",
            //"lost":           "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_l'><i>{{vehicle}}</i></span>",
            //"lostsquad":      "<textformat leading='-4'><span class='mm_dot'>{{vehicle-class}}</span><span class='mm_ls'><i>{{nick%.5s}}</i>\n   {{vehicle}}</span><textformat>",
            //"deadally":       "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_da'></span>",
            //"deadteamkiller": "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_dt'></span>",
            //"deadenemy":      "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_de'></span>",
            //"deadsquad":      "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_ds'><i>{{nick%.5s}}</i></span>"
        public var css:Object;
            //"ally":            ".mm_a{font-family:$FieldFont; font-size:8px; color:#C8FFA6;}",
            //"teamkiller":      ".mm_t{font-family:$FieldFont; font-size:8px; color:#A6F8FF;}",
            //"enemy":           ".mm_e{font-family:$FieldFont; font-size:8px; color:#FCA9A4;}",
            //"squad":           ".mm_s{font-family:$FieldFont; font-size:8px; color:#FFD099;}",
            //"oneself":         ".mm_o{font-family:$FieldFont; font-size:8px; color:#FFFFFF;}",
            //"lostally":       ".mm_la{font-family:$FieldFont; font-size:8px; color:#C8FFA6;} .mm_dot{font-family:Arial; font-size:17px; color:#B4E595;}",
            //"lostteamkiller": ".mm_lt{font-family:$FieldFont; font-size:8px; color:#A6F8FF;} .mm_dot{font-family:Arial; font-size:17px; color:#00D2E5;}",
            //"lost":            ".mm_l{font-family:$FieldFont; font-size:8px; color:#FCA9A4;} .mm_dot{font-family:Arial; font-size:17px; color:#E59995;}",
            //"lostsquad":      ".mm_ls{font-family:$FieldFont; font-size:8px; color:#FFD099;} .mm_dot{font-family:Arial; font-size:17px; color:#E5BB8A;}",
            //"deadally":       ".mm_da{font-family:$FieldFont; font-size:8px; color:#6E8C5B;} .mm_dot{font-family:Arial; font-size:17px; color:#004D00;}",
            //"deadteamkiller": ".mm_dt{font-family:$FieldFont; font-size:8px; color:#5B898C;} .mm_dot{font-family:Arial; font-size:17px; color:#043A40;}",
            //"deadenemy":      ".mm_de{font-family:$FieldFont; font-size:8px; color:#996763;} .mm_dot{font-family:Arial; font-size:17px; color:#4D0300;}",
            //"deadsquad":      ".mm_ds{font-family:$FieldFont; font-size:8px; color:#997C5C;} .mm_dot{font-family:Arial; font-size:17px; color:#663800;}"
        public var shadow:Object;
            //"ally":           { "enabled": true, "color": "0x000000", "distance": 0, "angle": 45, "alpha": 80, "blur": 3, "strength": 4 },
            //"teamkiller":     { "enabled": true, "color": "0x000000", "distance": 0, "angle": 45, "alpha": 80, "blur": 3, "strength": 4 },
            //"enemy":          { "enabled": true, "color": "0x000000", "distance": 0, "angle": 45, "alpha": 80, "blur": 3, "strength": 4 },
            //"squad":          { "enabled": true, "color": "0x000000", "distance": 0, "angle": 45, "alpha": 80, "blur": 3, "strength": 4 },
            //"oneself":        { "enabled": true, "color": "0x000000", "distance": 0, "angle": 45, "alpha": 80, "blur": 3, "strength": 4 },
            //"lostally":       { "enabled": true, "color": "0x000000", "distance": 0, "angle": 45, "alpha": 80, "blur": 6, "strength": 4 },
            //"lostteamkiller": { "enabled": true, "color": "0x000000", "distance": 0, "angle": 45, "alpha": 80, "blur": 6, "strength": 4 },
            //"lost":           { "enabled": true, "color": "0x000000", "distance": 0, "angle": 45, "alpha": 80, "blur": 6, "strength": 4 },
            //"lostsquad":      { "enabled": true, "color": "0x000000", "distance": 0, "angle": 45, "alpha": 80, "blur": 6, "strength": 4 },
            //"deadally":       { "enabled": true, "color": "0x000000", "distance": 0, "angle": 45, "alpha": 80, "blur": 3, "strength": 3 },
            //"deadteamkiller": { "enabled": true, "color": "0x000000", "distance": 0, "angle": 45, "alpha": 80, "blur": 3, "strength": 3 },
            //"deadenemy":      { "enabled": true, "color": "0x000000", "distance": 0, "angle": 45, "alpha": 80, "blur": 3, "strength": 3 },
            //"deadsquad":      { "enabled": true, "color": "0x000000", "distance": 0, "angle": 45, "alpha": 80, "blur": 3, "strength": 3 }
            //},
        public var offset:Object;
            //"ally":           {"x": 3, "y": -1},
            //"teamkiller":     {"x": 3, "y": -1},
            //"enemy":          {"x": 3, "y": -1},
            //"squad":          {"x": 3, "y": -2},
            //"oneself":        {"x": 0, "y": 0},
            //"lostally":       {"x": -5, "y": -11},
            //"lostteamkiller": {"x": -5, "y": -11},
            //"lost":           {"x": -5, "y": -11},
            //"lostsquad":      {"x": -5, "y": -11},
            //"deadally":       {"x": -5, "y": -11},
            //"deadteamkiller": {"x": -5, "y": -11},
            //"deadenemy":      {"x": -5, "y": -11},
            //"deadsquad":      {"x": -5, "y": -11}
        public var alpha:Object;
            //"ally": 100,
            //"teamkiller": 100,
            //"enemy": 100,
            //"squad": 100,
            //"oneself": 100,
            //"lostally": 70,
            //"lostteamkiller": 70,
            //"lost": 70,
            //"lostsquad": 70,
            //"deadally": 50,
            //"deadteamkiller": 50,
            //"deadenemy": 0,
            //"deadsquad": 50
    }
}
