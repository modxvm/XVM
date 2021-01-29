{
  "def": {
    "pingServers": {
      "enabled": true,
      //"y": 70,
      "ignoredServers": ["RU4", "RU8", "RU9", "RU10"],
      //"currentServerFormat": "<b><font size='16'>{server}</font></b>",
      "showTitle": false,
      "updateInterval": 5000
    },
    "onlineServers": {
      "enabled": true,
      "x": 5,
      "y": 86,
      "hAlign": "left",
      "ignoredServers": ["RU4", "RU8", "RU9"],
      //"currentServerFormat": "<b><font size='16'>{server}</font></b>",
      "layer": "top",
      "showTitle": false
    }
  },
  "login": {
    "autologin": true,
    "confirmOldReplays": true,
    //"disabledServers": ["RU10"],
    "pingServers": ${"def.pingServers"},
    "onlineServers": ${"def.onlineServers"},
    "widgets": ${"sirmax-widgets.xc":"widgets.login"}
  },
  "hangar": {
    "enableGoldLocker": true,
    "enableFreeXpLocker": true,
    "enableCrystalLocker": true,
    "hidePricesInTechTree": true,
    "masteryMarkInTechTree": true,
    "allowExchangeXPInTechTree": false,
    "blockVehicleIfNoAmmo": true,
    //"enableCrewAutoReturn": false,
    //"crewReturnByDefault": true,
    "crewMaxPerksCount": 10,
    "enableEquipAutoReturn": true,
    "notificationsButtonType": "blink",
    "blockVehicleIfLowAmmo": true,
    "restoreBattleType": true,
    "pingServers": {
      "$ref": { "path":"def.pingServers" },
      "x": 5
    },
    "carousel": ${"sirmax-carousel.xc":"carousel"},
    //"showBuyPremiumButton": false,
    //"showPremiumShopButton": false,
    "showCreateSquadButtonText": false,
    //"showBattleTypeSelectorText": false,
    "showPromoPremVehicle": false,
    "serverInfo": {
      "enabled": false
      //"alpha": 75,
      //"rotation": 0,
      //"offsetX": 0,
      //"offsetY": 50
    },
    "commonQuests": {
      //"enabled": false,
      //"alpha": 100,
      //"rotation": 0,
      //"offsetX": 0,
      //"offsetY": 0
    },
    "personalQuests": {
      //"enabled": false,
      //"alpha": 100,
      //"rotation": 0,
      //"offsetX": 0,
      //"offsetY": 0
    },
    "vehicleName": {
      //"enabled": false,
      //"alpha": 100,
      //"rotation": 0,
      //"offsetX": 0,
      //"offsetY": 0
    },
    "widgets": ${"sirmax-widgets.xc":"widgets.lobby"}
  }
}
