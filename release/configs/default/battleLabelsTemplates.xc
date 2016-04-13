/**
 * Battle inteface text fields.
 * Текстовые поля боевого интерфейса.
 */
{
  "def": {
    /**
      Set of formats fields available for configuring:
      Набор форматов полей доступных для настройки:
     ┌────────────────────────────┬──────────────────────────────────────────────────────────────────────────
     │ Parametrs                  │ Description
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "enabled"                  │ enable/disable field creation: true or false
     │                            │ включить/отключить создание полей: true or false
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "updateEvent"              │ event on which field updates, use with dynamic macros
     │                            │ to disable define null value; allowed events: "ON_VECHICLE_DESTROYED"
     │                            │ событие по которому обновляется поле, используйте динамические макросы
     │                            │ для отключения используйте значение null; доступные события: "ON_VECHICLE_DESTROYED"
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "hotKey"                   │ keyboard key code (see list in hotkeys.xc), when pressed - switches text field to show and apply configured html in "formats", or hide;
     │                            │ when defined, text field will not be shown until key is pressed, to disable define null value // IN DEVELOPMENT
     │                            │ горячие клавиши клавиатуры (список в hotkeys.xc), при нажатии - выводится текстовое поле и применяются параметры html в "formats", или скрывается поле;
     │                            │ текстовое поле не будет отображаться, пока не будет нажата клавиша, для отключения используйте значение null // В РАЗРАБОТКЕ
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "x"                        │ x position (macros allowed)
     │                            │ положение по оси x (доступно использование макросов)
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "y"                        │ y position (macros allowed)
     │                            │ положение по оси y (доступно использование макросов)
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "width"                    │ width (macros allowed)
     │                            │ ширина элемента (доступно использование макросов)
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "height"                   │ height (macros allowed)
     │                            │ высота элемента (доступно использование макросов)
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "alpha"                    │ transparency in percents (0..100) (macros allowed)
     │                            │ прозрачность элемента, в процентах (0..100) (доступно использование макросов)
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "rotation"                 │ rotation in degrees (0..360) (macros allowed)
     │                            │ поворот элемента, в градусах (доступно использование макросов)
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "scaleX"                   │ scaling axis X (use negative values for mirroring)
     │                            │ масштабирование по оси x (используйте отрицательные значения для зеркального отображения )
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "scaleY"                   │ scaling axis Y (use negative values for mirroring)
     │                            │ масштабирование по оси y (используйте отрицательные значения для зеркального отображения )
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "autoSize"                 │ controls automatic sizing and alignment of text fields ("none" [default], "left", "right", "center")
     │                            │ управление автоматической настройкой размеров и выравниванием текстовых полей ("none" [default], "left", "right", "center")
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "align"                    │ horizontal alignment ("left", "center", "right")
     │                            │ горизонтальное выравнивание ("left", "center", "right")
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "valign"                   │ vertical alignment ("top", "center", "bottom")
     │                            │ вертикальное выравнивание ("top", "center", "bottom")
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "antiAliasType"            │ sets anti-aliasing to advanced anti-aliasing ("advanced" or "normal")
     │                            │ задает использование расширенных возможностей сглаживания ("advanced" or "normal")
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "background"               │ enable/disable background creation: true or false
     │                            │ включить/отключить создание фона: true or false
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "bgColor"                  │ if set, draw background with specified color (macros allowed)
     │                            │ окрашивает фон в заданный цвет, если установлен (доступно использование макросов)
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "border"                   │ enable/disable border creation: true or false
     │                            │ включить/отключить создание границы вокруг элемента: true or false
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "borderColor"              │ if set, draw border with specified color (macros allowed)
     │                            │ окрашивает границу в заданный цвет, если установлен (доступно использование макросов)
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "shadow"                   │ shadow settings, defaults:
     │                            │ настройки тени, значение по умолчанию: 
     │                            │
     │                            │ "shadow": { "distance": 0, "angle": 0, "color": "0x000000", "alpha": 0.75, "blur": 2, "strength": 1 }
     │----------------------------│--------------------------------------------------------------------------
     │ "distance"                 │ distance shadow, in pixels
     │                            │ дистанция тени, в пикселях
     │----------------------------│--------------------------------------------------------------------------
     │ "angle"                    │ angle shadow (0.0 .. 360.0)
     │                            │ угол смещения тени, в градусах
     │----------------------------│--------------------------------------------------------------------------
     │ "color"                    │ color shadow ("0xXXXXXX")
     │                            │ цвет тени ("0xXXXXXX")
     │----------------------------│--------------------------------------------------------------------------
     │ "alpha"                    │ alpha shadow (0.0 .. 1.0)
     │                            │ прозрачность тени (0.0 .. 1.0)
     │----------------------------│--------------------------------------------------------------------------
     │ "blur"                     │ blur shadow (0.0 .. 255.0)
     │                            │ эффект размывки тени (0.0 .. 255.0)
     │----------------------------│--------------------------------------------------------------------------
     │ "strength"                 │ strength shadow (0.0 .. 255.0)
     │                            │ интенсивность тени (0.0 .. 255.0)
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "currentFieldDefaultStyle" │ Field default styles. It applies global style to html in "formats".
     │                            │ Note, that defined font attributes in "formats" override those in "currentFieldDefaultStyle"
     │                            │ Стандартный стиль поля. Применяет глобальный стиль HTML в "formats".
     │                            │ Обратите внимание, что определенные атрибуты шрифта в "formats" переопределяют "currentFieldDefaultStyle"
     │                            │
     │                            │ "currentFieldDefaultStyle": { "name": "$FieldFont", "color": "0xFFFFFF", "size": 12, "align": "left", "bold": false, "italic": false, "display": "block", "leading": 0, "marginLeft": 0, "marginRight": 0 },
     │----------------------------│--------------------------------------------------------------------------
     │ "name"                     │ font name
     │                            │ наименование шрифта
     │----------------------------│--------------------------------------------------------------------------
     │ "color"                    │ font color ("0xXXXXXX")
     │                            │ цвет шрифта ("0xXXXXXX")
     │----------------------------│--------------------------------------------------------------------------
     │ "size"                     │ font size
     │                            │ размер шрифта
     │----------------------------│--------------------------------------------------------------------------
     │ "align"                    │ text alignment (left, center, right)
     │                            │ выравнивание текста (left, center, right)
     │----------------------------│--------------------------------------------------------------------------
     │ "bold"                     │ true - bold
     │                            │ true - жирный
     │----------------------------│--------------------------------------------------------------------------
     │ "italic"                   │ true - italic
     │                            │ true - курсив
     │----------------------------│--------------------------------------------------------------------------
     │ "display"                  │ required for align to work
     │                            │ требуется для работы выравнивания
     │----------------------------│--------------------------------------------------------------------------
     │ "leading"                  │ space between lines, similarly (<textformat leading='-5'>...</textformat>)
     │                            │ пространство между строками, аналогично (<textformat leading='-5'>...</textformat>)
     │----------------------------│--------------------------------------------------------------------------
     │ "marginLeft"               │ indent left, similarly (<textformat lefMargin='2'>...</textformat>)
     │                            │ отступ слева, аналогично (<textformat lefMargin='2'>...</textformat>)
     │----------------------------│--------------------------------------------------------------------------
     │ "marginRight"              │ indent left, similarly (<textformat rightMargin='2'>...</textformat>)
     │                            │ отступ справа, аналогично (<textformat rightMargin='2'>...</textformat>)
     ├────────────────────────────┼──────────────────────────────────────────────────────────────────────────
     │ "formats"                  │ displayed text field data (HTML allowed, macros allowed)
     │                            │ отображаемые данные в текстовых полях (доступно использование HTML и макросов)
     └────────────────────────────┴──────────────────────────────────────────────────────────────────────────
    */
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
