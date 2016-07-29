{
  "minimap": {
    //"enabled": false,
    "iconScale": 1.2,
    "hideCameraTriangle": true,
    "cameraAlpha": 90,
    //"selfIconAlpha": 70,
    //"iconAlpha": 0,
    //"showCameraLineAfterDeath": false,
    "minimapAimIcon": "cfg://sirmax/img/MinimapAim.png",
    "minimapAimIconScale": 200,
    "zoom": { "pixelsBack": 150, "centered": true },
    //"useStandardCircles": true,
    //"useStandardLabels": true,
    //"useStandardLines": true,
    "circles": {
        "view": [
            { "enabled": true, "state": 1, "distance": 50, "scale": 1, "thickness": 0.5, "alpha": 70, "color": "0xFFFFFF" },
            { "enabled": true, "state": 2, "distance": 50, "scale": 1, "thickness": 0.5, "alpha": 45, "color": "0xFFFFFF" },
            { "enabled": "{{my-vtype-key=SPG?false|true}}", "distance": 564, "scale": 1, "thickness": 0.5, "alpha": 40, "color": "0xFFFFFF" },
            { "enabled": true, "distance": 445, "scale": 1, "thickness": 0.5, "alpha": 40, "color": "0xFFFFFF" },
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
    "labels": ${"sirmax-minimapLabels.xc":"labels"}
  },
  "minimapAlt": {
    "$ref": { "path": "minimap" },
    "enabled": false,
    "mapBackgroundImageAlpha": 50,
    //"selfIconAlpha": 50,
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
    //"mapSize": { "enabled": false },
    "__stub__": null
  }
}
