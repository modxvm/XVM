// TODO: description and comments
/**
 * Camera settings
 * Настройки камеры
 */
{
  "camera": {
    "enabled": false,
    "arcade": {
      "distRange": [2, 25],
      "startDist": null, // null for default behavior
      "scrollSensitivity": 5
    },
    "postmortem": {
      "distRange": [2, 25],
      "startDist": null, // null for default behavior
      "scrollSensitivity": 5
    },
    "strategic": {
      "distRange": [40, 100]
    },
    "sniper": {
      "zooms": [2, 4, 8], // you can set more ranges: [ 2, 4, 8, 12, 16 ]
      "zoomExposure": [0.6, 0.5, 0.4] // length must be equal to the "zooms" value length
    }
  }
}
