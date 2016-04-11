/**
 * Battle inteface text fields.
 * Текстовые поля боевого интерфейса.
 */
{
  "def": {
    // Accepted field settings
    // Доступные настройки поля
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // THIS FIELD ("demoItem") IS NOT CONNECTED IN battleLabels.xc; THIS FIELD ONLY SHOWS AVAILABLE SETTINGS FOR TEXT FIELD AND DO NOT AFFECT OTHER TEXT FIELDS
    // MACROS ALLOWED, CAN BE SET TO UPDATE ON EVENT
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Name of text field (User defined). Do not forget to attach this in battleLabels.xc
    //"demoItem": {
      /////////////////////
      // Enable field switch: true or false
      /////////////////////
      //
      //"enabled": true,
      //
      /////////////////////
      // Event on which field updates, use with dynamic macros
      // To disable define null value
      // Allowed events: "ON_VECHICLE_DESTROYED"
      /////////////////////
      //
      //"updateEvent": "", 
      //
      /////////////////////
      // positon on x, y axes relative to "align" and "valign"; width, height, alpha, rotation, 
      // scaleX and scaleY of text field / (all MACROS ALLOWED)
      /////////////////////
      //
      //"x": 0,
      //"y": 0,
      //"width": 100,
      //"height": 40,
      //"alpha": 50, 
      //"rotation": "", 
      //"scaleX": "", 
      //"scaleY": "", 
      // "none" (default), "left", "right", "center"
      //"autoSize": "none",
      //
      /////////////////////
      // horizontal ("align") and vertical ("valign") align by screen resolution.
      // allows only "left", "right", "center" values for horizontal alignment and "top", "bottom", "middle", "center" for vertical.
      // горизонтальное ("align") и вертикальное ("valign") выравнивание по разрешению экрана.
      // допускаются только значения "left", "right", "center" для горизонтального выравнивания и "top", "bottom", "middle", "center" для вертикального. 
      ///////////////////////
      //
      //"align": "left", 
      //"valign": "top",
      //
      ///////////////////////
      // Antialias type: "normal", "advanced"
      ///////////////////////
      //
      //"antiAliasType": "advanced",
      //
      ///////////////////////
      // Background switch: true or false
      ///////////////////////
      //
      //"background": false,
      //
      ///////////////////// 
      // Background color (MACROS ALLOWED)
      ///////////////////////
      //
      //"bgColor": null,
      //
      ///////////////////////
      // Border switch: true or false 
      ///////////////////////
      //
      //"border": false,
      //
      ///////////////////////
      // Border color (MACROS ALLOWED)
      ///////////////////////
      //
      //"borderColor": null, 
      //
      ///////////////////////
      // Shadow settings (defaults: 0, 0, 0x000000, 0.75, 2, 1) (MACROS ALLOWED)
      /////////////////////
      //
      //"shadow": { "distance": 0, "angle": 0, "color": "0x000000", "alpha": 0.75, "blur": 2, "strength": 1}, 
      //
      /////////////////////
      // Field default styles. It applies global style to html in "formats". Note, that defined font attributes in "formats" override those in "currentFieldDefaultStyle"
      // defaults: "0xFFFFFF", $FieldFont, 12, "left", false, false, "block" (required for align to work), 0, 0, 0 / (MACROS ALLOWED))
      // if blank values, defaults above used; if attribute also defined in "formats", attribute in "formats" used 
      /////////////////////
      //
      //"currentFieldDefaultStyle": { "color": "0xFFFFFF", "name": "$FieldFont", "size": 15, "align": "left", "bold": true, "italic": true, "display": "block", "leading": -5, "marginLeft": 2, "marginRight": 2},
      //
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      // Displayed text field data (HTML ALLOWED, MACROS ALLOWED)
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //
      //"formats": ""
      //
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //},
    // User defined text fields
    // ...
    //
    "test": {
      "enabled": true,
      "updateEvent": "ON_VECHICLE_DESTROYED", 
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
      "currentFieldDefaultStyle": { "color": "{{battleType=1?0x00FFFF|0xFFFF00}}", "name": "$FieldFont", "size": 25, "align": "center", "bold": true, "italic": false, "display": "block", "leading": -1, "marginLeft": 2, "marginRight": 2},
      "formats": "This is a demo of XVM text fields on battle inteface. You may disable it in battle.xc <br/> Chances to Win (Static/Live):&nbsp;{{chancesStatic}}&nbsp;/&nbsp;{{chancesLive}}"
    },
    "test2": {
      "enabled": true, 
      "updateEvent": null, 
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
      "currentFieldDefaultStyle": { "color": "0x60FF00", "name": "$FieldFont", "size": 15, "align": "left", "bold": false, "italic": false, "display": "block", "leading": -20, "marginLeft": 2, "marginRight": 2},
      "formats": "<font color='#FFFFFF'><p align='center'><b>Info text field (WN8:&nbsp;<font color='{{c:wn8}}'>{{wn8}}</font>)</b></p></font><br/>Battle tier:<font color='#ff1aff'>&nbsp;{{battletier}}</font><p align='right'>My vehicle:&nbsp;<font color='#ff1aff'>{{my-vehicle}}</font>&nbsp;(<font color='{{c:t-winrate}}'>{{t-winrate%2d}}%</font>)</p>"
    }
  }
}