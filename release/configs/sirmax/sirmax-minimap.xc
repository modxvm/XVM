{
  "minimap": {
    //"enabled": false,
    "iconScale": 1.2,
    "hideCameraTriangle": true,
    "cameraAlpha": 90,
    "selfIconAlpha": 75,
    //"showCameraLineAfterDeath": false,
    "minimapAimIcon": "cfg://sirmax/img/MinimapAim.png",
    "minimapAimIconScale": 200,
    "zoom": { "centered": false },
    "circles": {
        "view": [
            { "enabled": true, "state": 1, "distance": 50, "scale": 1, "thickness": 0.5, "alpha": 70, "color": "0xFFFFFF" },
            { "enabled": true, "state": 2, "distance": 50, "scale": 1, "thickness": 0.5, "alpha": 45, "color": "0xFFFFFF" },
            { "enabled": true, "distance": 445, "scale": 1, "thickness": 0.5, "alpha": 45, "color": "0xFFFFFF" },
            //{ "enabled": true, "distance": "blindarea", "scale": 0.9, "thickness": 1.5, "alpha": 80, "color": "0xFFFF00" },
            { "enabled": true, "state": 1, "distance": "dynamic", "scale": 1, "thickness": 1, "alpha": 80, "color": "0x3EB5F1" },
            { "enabled": true, "state": 2, "distance": "dynamic", "scale": 1, "thickness": 0.75, "alpha": 80, "color": "0x3EB5F1" },
            { "enabled": true, "distance": "motion", "scale": 1, "thickness": 0.5, "alpha": 50, "color": "0x3EB5F1" },
            { "enabled": true, "distance": "standing", "scale": 1, "thickness": 0.5, "alpha": 50, "color": "0x3EB5F1" },
            {}
        ],
        "special": [
//            { "uk-GB01_Medium_Mark_I": { "alpha": 60, "color": "0xEE4444", "distance": 100, "enabled": true, "thickness": 0.5 } }
        ]
    },
    "lines": {
      "vehicle": [
        { "enabled": true, "from": -50, "to": 150,  "inmeters": true, "thickness": 1.2,  "alpha": 65, "color": "0xFFFFFF"}
      ],
      "camera": [
        { "enabled": true, "from": 50,  "to": 707,   "inmeters": true, "thickness": 0.7,  "alpha": 65, "color": "0x00BBFF"},
        { "enabled": true, "from": 707, "to": 1463,  "inmeters": true, "thickness": 0.2,  "alpha": 35, "color": "0x00BBFF"},
        { "enabled": true, "from": 445, "to": 446,   "inmeters": true, "thickness": 3,    "alpha": 65, "color": "0x00BBFF"},
        { "enabled": true, "from": 500, "to": 501,   "inmeters": true, "thickness": 3,    "alpha": 65, "color": "0x00BBFF"},
        { "enabled": true, "from": 706, "to": 707,   "inmeters": true, "thickness": 3,    "alpha": 65, "color": "0x00BBFF"}
      ],
      "traverseAngle": [
        { "enabled": true, "from": 50,  "to": 1463,  "inmeters": true, "thickness": 0.5,   "alpha": 65, "color": "0xFFFFFF"}
      ]
    },
    "labels": {
      "units": {
        "format": {
          "ally":       "<textformat leading='-15'><span class='mm_a'>{{vehicle-short}}\n<font color='{{t-battles>9?{{c:r|#666666}}|#666666}}' alpha='{{alive?#FF|#80}}'>{{marksOnGun|*}}</font></span></textformat>",
          "teamkiller": "<textformat leading='-15'><span class='mm_t'>{{vehicle-short}}\n<font color='{{t-battles>9?{{c:r|#666666}}|#666666}}' alpha='{{alive?#FF|#80}}'>{{marksOnGun|*}}</font></span></textformat>",
          "enemy":      "<textformat leading='-15'><span class='mm_e'>{{vehicle-short}}\n<font color='{{t-battles>9?{{c:r|#666666}}|#666666}}' alpha='{{alive?#FF|#80}}'>{{marksOnGun|*}}</font></span></textformat>"
        },
        "alpha" : {
          //"deadenemy": 50
        }
      }
    },
    "square" : { "enabled": true }
  },
  "minimapAlt": {
    "$ref": { "path": "minimap" },
    "enabled": true,
    "mapBackgroundImageAlpha": 50,
    "selfIconAlpha": 50,
    "hideCameraTriangle": false,
    "cameraAlpha": 100,
    "iconScale": 2,
    "circles": {
      //"enabled": false,
      "view": [
          { "enabled": true, "state": 3, "distance": 50, "scale": 1, "thickness": 0.5, "alpha": 70, "color": "0xFFFFFF" },
          { "enabled": true, "state": 1, "distance": 250, "scale": 1, "thickness": 0.5, "alpha": 70, "color": "0xFFFFFF" }
      ]
    },
    "lines": {
      //"enabled": false,
      "camera": [
        { "enabled": true, "from": 50,  "to": 1463,   "inmeters": true, "thickness": 0.7,  "alpha": 65, "color": "0x00BBFF"}
      ],
      "traverseAngle": [
       { "enabled": true, "from": 50,  "to": 1463,  "inmeters": true, "thickness": 0.5,   "alpha": 65, "color": "0xFFFFFF"}
      ]
    },
    "labels": {
      "units": {
        "format": {
          "ally":           "<span class='mm_a'><font color='{{t-battles>9?{{c:r|#666666}}|#666666}}' alpha='{{alive?#FF|#80}}'>{{marksOnGun|*}}</font></span>",
          "squad":          "<span class='mm_s'><font color='{{t-battles>9?{{c:r|#666666}}|#666666}}' alpha='{{alive?#FF|#80}}'>{{marksOnGun|*}}</font></span>",
          "teamkiller":     "<span class='mm_t'><font color='{{t-battles>9?{{c:r|#666666}}|#666666}}' alpha='{{alive?#FF|#80}}'>{{marksOnGun|*}}</font></span>",
          "enemy":          "<span class='mm_e'><font color='{{t-battles>9?{{c:r|#666666}}|#666666}}' alpha='{{alive?#FF|#80}}'>{{marksOnGun|*}}</font></span>",
          "lostally":       "<span class='mm_la'>{{vehicle-class}}</span>",
          "lost":           "<span class='mm_l'>{{vehicle-class}}</span>",
          "deadally":       "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_da'><i>{{nick%.5s}}</i></span>",
          "deadteamkiller": "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_dt'><i>{{nick%.5s}}</i></span>",
          "deadenemy":      "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_de'><i>{{nick%.5s}}</i></span>",
          "deadsquad":      "<span class='mm_dot'>{{vehicle-class}}</span><span class='mm_ds'><i>{{nick%.5s}}</i></span>"
        }
      },
      "mapSize": { "enabled": false }
    },
    //"square" : { "enabled": false },
    "__stub__": null
  }
}
