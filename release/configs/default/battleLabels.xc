/**
 * Battle inteface text fields.
 * Текстовые поля боевого интерфейса.
 */
{
     "def": {
     // Accepted field settings
     // Доступные настройки поля
     ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     //
     // THIS FIELD ("demoItem") IS NOT CONNECTED IN battleLabelsList.xc; THIS FIELD ONLY SHOWS AVAILABLE SETTINGS FOR TEXT FIELD AND DO NOT AFFECT OTHER TEXT FIELDS
     // AT THIS TIME ONLY GLOBAL MACROS ALLOWED
     ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          // Name of text field (User defined). Do not forget to attach this in battleLabelsList.xc
          //"demoItem": {
                // Enable field switch: true or false. Do not forget to enable "battleLabels" in battle.xc // todo
                //"enabled": true, // todo
                //"updateable": true, //todo
                // Allowed: work in progress...
                //"updateEvent": "", // todo
                // positon on x, y axes relative to "align" and "valign"; width, height, alpha, rotation, 
                // scaleX and scaleY of text field / (all MACROS ALLOWED)
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
                // horizontal ("align") and vertical ("valign") align by screen resolution.
                // allows only "left", "right", "center" values for horizontal alignment and "top", "bottom", "middle", "center" for vertical.
                // горизонтальное ("align") и вертикальное ("valign") выравнивание по разрешению экрана.
                // допускаются только значения "left", "right", "center" для горизонтального выравнивания и "top", "bottom", "middle", "center" для вертикального. 
                //"align": "left", 
                //"valign": "top",
                // Antialias type: "normal", "advanced"
                //"antiAliasType": "advanced",
                // Background switch: true or false
                //"background": false, 
                // Background color (GLOBAL MACROS ALLOWED)
                //"bgColor": null,
                // Border switch: true or false 
                //"border": false,
                // Border color (GLOBAL MACROS ALLOWED)
                //"borderColor": null, 
                // Shadow settings (defaults: 0, 0, 0x000000, 0.75, 2, 1)
                //"shadow": { "distance": 0, "angle": 0, "color": "0x000000", "alpha": 0.75, "blur": 2, "strength": 1}, 
                // Font stylesheet. It defines global style to html in "formats". Note, that defined font attributes in "formats" override those in "fontCSS"
                // defaults: "0xFFFFFF" / (MACROS ALLOWED), $FieldFont / (GLOBAL MACROS ALLOWED), 12 / (GLOBAL MACROS ALLOWED), "left", false, false, block (required for align to work), 0, 0, 0)
                // if blank values, defaults above used; if attribute also defined in "formats", attribute in "formats" used 
                //"currentFieldDefaultStyle": { "color": "0xFFFFFF", "name": "$PartnerCondensed", "size": 15, "align": "left", "bold": true, "italic": true, "display": "block", "leading": -5, "marginLeft": 2, "marginRight": 2},
                ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                // Displayed text field data (HTML ALLOWED, GLOBAL MACROS ALLOWED)
                ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //"formats": ""
                ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //},
     // User defined text fields
     // ...
     //
    "test": {
                "enabled": true, // todo
                //"updateable": true, //todo
                //"updateEvent": "", // todo
                "x": 0,
                "y": -155,
                "width": 200,
                "height": 20,
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
                "currentFieldDefaultStyle": { "color": "0x00ff00", "name": "$FieldFont", "size": 15, "align": "justify", "bold": true, "italic": false, "marginLeft": 2, "marginRight": 2},
                "formats": "This is a demo of XVM text fields on battle inteface. You may disable it in battle.xc "
    },
    "test2": {
                "enabled": true, // todo
                //"updateable": true, //todo
                //"updateEvent": "", // todo
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
                "formats": "<font color='#FFFFFF'><p align='center'><b>Info text field</b></p></font><br/>Battle tier:<font color='#ff1aff'>&nbsp;{{battletier}}</font><p align='right'>My vehicle:&nbsp;<font color='#ff1aff'>{{my-vehicle}}</p></font>"
    }
  }
}