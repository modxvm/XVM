{
  "minimap": {
    "enabled": true,
    //"iconScale": 2,
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
          "ally":           "<span class='mm_a'><font color='{{c:xwn8}}'>*</font> {{vehicle-short}}</span>",
          "teamkiller":     "<span class='mm_t'><font color='{{c:xwn8}}'>*</font> {{vehicle-short}}</span>",
          "enemy":          "<span class='mm_e'><font color='{{c:xwn8}}'>*</font> {{vehicle-short}}</span>"
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
    "enabled": false,
    "mapBackgroundImageAlpha": 50,
    "selfIconAlpha": 50,
    "cameraAlpha": 50,
    "iconScale": 2,
    "circles": {
      //"enabled": false,
      "view": [
          { "enabled": true, "state": 1, "distance": 250, "scale": 1, "thickness": 0.5, "alpha": 70, "color": "0xFFFFFF" }
      ]
    },
    "lines": {
      //"enabled": false,
      "vehicle": [
         { "enabled": true, "from": 0, "to": 450, "inmeters": true, "thickness": 2,  "alpha": 30, "color": "0xFFFFFF"}
       ]
    },
    "labels": {
      "units": {
        "format": {
          "ally":           "<span class='mm_a'><font color='{{c:xwn8}}'>*</font></span>",
          "squad":          "<span class='mm_s'><font color='{{c:xwn8}}'>*</font></span>",
          "teamkiller":     "<span class='mm_t'><font color='{{c:xwn8}}'>*</font></span>",
          "enemy":          "<span class='mm_e'><font color='{{c:xwn8}}'>*</font></span>"
        }
      },
      "mapSize": { "enabled": false }
    },
    //"square" : { "enabled": false },
    "__stub__": null
  }
}
