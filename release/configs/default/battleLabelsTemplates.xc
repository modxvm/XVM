/**
 * Battle inteface text fields.
 * Текстовые поля боевого интерфейса.
 */
{
  "def": {
    // --------------------------------------------------------------------- //
    // Set of formats fields available for configuring:
    // Набор форматов полей доступных для настройки:
    // --------------------------------------------------------------------- //
    // "enabled" - enable field switch: true or false
    // "updateEvent" - event on which field updates, use with dynamic macros (to disable define null value; allowed events: "ON_VECHICLE_DESTROYED") 
    // "hotKey" - keyboard key code (see list in hotkeys.xc), when pressed - switches text field to show and apply configured html in "formats", or hide; when defined, text field will not be shown until key is pressed, to disable define null value // IN DEVELOPMENT
    // "x" - x position (macros allowed)
    // "y" - y position (macros allowed)
    // "width" - width (macros allowed)
    // "height" - height (macros allowed)
    // "alpha" - transparency in percents (0..100) (macros allowed)
    // "rotation" - rotation in degrees (0..360) (macros allowed)
    // "scaleX", "scaleY" - scaling (use negative values for mirroring)
    // "autoSize" - controls automatic sizing and alignment of text fields, "none" (default), "left", "right", "center"
    // "align" - horizontal alignment ("left", "center", "right")
    // "valign" - vertical alignment ("top", "center", "bottom")
    // "antiAliasType" - anti aliasing mode ("advanced" or "normal")
    // "background" - background switch: true or false
    // "bgColor" - if set, draw background with specified color (macros allowed)
    // "border" - border switch: true or false
    // "borderColor" - if set, draw border with specified color (macros allowed)
    // "shadow": {
    //   "distance" (in pixels)
    //   "angle"    (0.0 .. 360.0)
    //   "color"    "0xXXXXXX"
    //   "alpha"    (0.0 .. 1.0)
    //   "blur"     (0.0 .. 255.0)
    //   "strength" (0.0 .. 255.0)
    //  }
    // --------------------------------------------------------------------- //
    // Field default styles. It applies global style to html in "formats".
    // Note, that defined font attributes in "formats" override those in "currentFieldDefaultStyle"
    // Стандартный стиль поля. Применяет глобальный стиль HTML в "formats".
    // Обратите внимание, что определенные атрибуты шрифта в "formats" переопределяют "currentFieldDefaultStyle"
    // --------------------------------------------------------------------- //
    // "currentFieldDefaultStyle": { "name": "$FieldFont", "color": "0xFFFFFF", "size": 15, "align": "left", "bold": false, "italic": false, "display": "block", "leading": -5, "marginLeft": 2, "marginRight": 2 },
    //
    // "name": "$FieldFont",  // font name
    // "color": "0xFFFFFF",   // font color
    // "size": 15,            // font size
    // "align": "left",       // text alignment (left, center, right)
    // "bold": false,         // true - bold
    // "italic": false,       // true - italic
    // "display": "block",    // required for align to work
    // "leading": -5,         // space between lines, similarly (<textformat leading='-5'>...</textformat>)
    // "marginLeft": 2,       // indent left, similarly (<textformat lefMargin='2'>...</textformat>)
    // "marginRight": 2       // indent left, similarly (<textformat rightMargin='2'>...</textformat>)
    // --------------------------------------------------------------------- //
    // "formats" - displayed text field data (HTML allowed, macros allowed)
    // --------------------------------------------------------------------- //
    "winChance": {
      "enabled": true,
      "updateEvent": "ON_VECHICLE_DESTROYED", 
      "hotKey": null, // IN DEVELOPMENT
      "x": 225,
      "y": 2,
      "width": 75,
      "height": 22,
      "alpha": 100, 
      "rotation": "", 
      "scaleX": "", 
      "scaleY": "", 
      "autoSize": "center",
      "align": "left", 
      "valign": "top",
      "antiAliasType": "advanced",
      "bgColor": null,
      "borderColor": null, 
      "shadow": { "distance": 1, "angle": 90, "color": "0x000000", "alpha": 0.8, "blur": 5, "strength": 1.5 }, 
      "currentFieldDefaultStyle": { "name": "$FieldFont", "color": "0xF4EFE8", "size": 15, "align": "left", "bold": false, "italic": false },
      "formats": "<font color='{{c:winChance}}'>{{chancesStatic}}</font> / <font color='{{c:winChance}}'>{{chancesLive}}</font>"
    },
    "test": {
      "enabled": true,
      "updateEvent": null, 
      "hotKey": null, // IN DEVELOPMENT
      "x": 0,
      "y": -170,
      "width": 200,
      "height": 50,
      "alpha": 70, 
      "rotation": "", 
      "scaleX": "", 
      "scaleY": "", 
      "autoSize": "center",
      "align": "center", 
      "valign": "bottom",
      "antiAliasType": "advanced",
      "bgColor": null,
      "borderColor": null, 
      "shadow": { "distance": 1, "angle": 90, "color": "0x000000", "alpha": 80, "blur": 2, "strength": 25}, 
      "currentFieldDefaultStyle": { "name": "$FieldFont", "color": "{{battleType=1?0x00FFFF|0xFFFF00}}", "size": 25, "align": "center", "bold": true, "italic": false, "display": "block", "leading": -1, "marginLeft": 2, "marginRight": 2},
      "formats": "This is a demo of XVM text fields on battle inteface. You may disable it in battle.xc"
    },
    "test2": {
      "enabled": true, 
      "updateEvent": null, 
      "hotKey": null, // IN DEVELOPMENT
      "x": 0,
      "y": -70,
      "width": 310,
      "height": 50,
      "alpha": 70, 
      "rotation": "", 
      "scaleX": "", 
      "scaleY": "", 
      "autoSize": "none",
      "align": "center", 
      "valign": "bottom",
      "antiAliasType": "advanced",
      "bgColor": "0x000000",
      "borderColor": "0x101009",
      "shadow": { "distance": 1, "angle": 90, "color": "0x000000", "alpha": 0.8, "blur": 2, "strength": 8}, 
      "currentFieldDefaultStyle": { "name": "$FieldFont", "color": "0x60FF00", "size": 15, "align": "left", "bold": false, "italic": false, "display": "block", "leading": -20, "marginLeft": 2, "marginRight": 2},
      "formats": "<font color='#FFFFFF'><p align='center'><b>Info text field (WN8:&nbsp;<font color='{{c:wn8}}'>{{wn8}}</font>)</b></p></font><br/>Battle tier:<font color='#ff1aff'>&nbsp;{{battletier}}</font><p align='right'>My vehicle:&nbsp;<font color='#ff1aff'>{{my-vehicle}}</font>&nbsp;(<font color='{{c:t-winrate}}'>{{t-winrate%2d}}%</font>)</p>"
    }
  }
}
