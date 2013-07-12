{
  "def": {
    "tf": {
      //"@log": 1,
      "size": 30,
      "font": "$TitleFont",
      "align": "center"
    }
  },
  "battleTimer": {
    //"@log": 2,
    //"_x": "@log",
    "_x": "WIDTH / 2",
    "_y": 50,
    "dotsMC": {
      "_x": "-80/2",
      "_y": "-3",
      "_height": 100,
      "_width": 80,
      "text": ":",
      "@textFormat": ${"def.tf"}
    },
    "secondsMC": {
      "_x": 5,
      "_height": 100,
      "_width": 80,
      "@textFormat": { "$ref": { "path": "def.tf" }, "align": "left" }
    },
    "minutesMC": {
      "_x": -85,
      "_height": 100,
      "_width": 80,
      "@textFormat": { "$ref": { "path": "def.tf" }, "align": "right" }
    }
  }
}
