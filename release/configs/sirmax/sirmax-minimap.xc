{
  "minimap": {
    //"enabled": false,
    //"mapBackgroundImageAlpha": 50,
    //"selfIconAlpha": 70,
    //"selfIconScale": 0.5,
    //"iconAlpha": 10,
    //"iconScale": 0.5,
    "hideCameraTriangle": true,
    //"showCameraLineAfterDeath": false,
    "cameraAlpha": 90,
    "minimapAimIcon": "cfg://sirmax/img/MinimapAim.png",
    "minimapAimIconScale": 100,
    "zoom": { "pixelsBack": 150, "centered": true },
    "mapSize": ${"../default/minimapMapSize.xc":"mapSize"},
    //"useStandardCircles": true,
    //"useStandardLabels": true,
    //"useStandardLines": true,
    "labels": ${"sirmax-minimapLabels.xc":"labels"},
    "circles": ${"sirmax-minimapCircles.xc":"circles"},
    "lines": ${"sirmax-minimapLines.xc":"lines"}
  },
  "minimapAlt": {
    "$ref": { "path": "minimap" },
    "enabled": true,
    "mapBackgroundImageAlpha": 50,
    "selfIconAlpha": 50,
    "selfIconScale": 1.2,
    "iconAlpha": 50,
    "iconScale": 1.2,
    "hideCameraTriangle": false,
    "showCameraLineAfterDeath": false,
    "cameraAlpha": 50,
    "minimapAimIcon": "cfg://sirmax/img/MinimapAim2.png",
    "minimapAimIconScale": 200,
    "zoom": { "pixelsBack": 300, "centered": false },
    "mapSize": ${"../default/minimapMapSize.xc":"mapSize"},
    "labels": ${"sirmax-minimapLabels.xc":"labels"},
    "circles": ${"sirmax-minimapCircles.xc":"circles"},
    "lines": ${"sirmax-minimapLines.xc":"lines"}
  }
}
