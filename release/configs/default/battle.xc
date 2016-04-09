/**
 * General parameters for the battle interface.
 * Общие параметры боевого интерфейса.
 */
{
  "battle": {
    // false - Disable tank icon mirroring (good for alternative icons).
    // false - отключить зеркалирования иконок танков (полезно для альтернативных иконок).
    "mirroredVehicleIcons": true,
    // false - Disable pop-up panel at the bottom after death.
    // false - отключить всплывающую внизу панель после смерти.
    "showPostmortemTips": true,
    // false - disable highlighting of own vehicle icon and squad.
    // false - отключить подсветку иконки своего танка и взвода.
    "highlightVehicleIcon": true,
    // true - enable {{spotted}} macro in players panels and minimap. WARNING: performance expensive
    // true - включить макрос {{spotted}} в ушах и на миникарте. ВНИМАНИЕ: может понизить производительность
    "allowSpottedStatus": true,
    // true - enable {{hp*}} macros ability in players panels and minimap. WARNING: performance expensive
    // true - включить возможность {{hp*}} макросов в ушах и на миникарте. ВНИМАНИЕ: может понизить производительность
    "allowHpInPanelsAndMinimap": false,
    // true - enable {{marksOnGun}} macro in players panels and minimap. WARNING: performance expensive
    // true - включить макрос {{marksOnGun}} в ушах и на миникарте. ВНИМАНИЕ: может понизить производительность
    "allowMarksOnGunInPanelsAndMinimap": false,
    // true - enable custom labels on battle interface window
    // true - показывать пользовательские текстовые поля в окне боевого интерфейса
    "allowLabelsOnBattleInterface": true,
    // Format of clock on the Debug Panel (near FPS).
    // Формат часов на экране панели отладки (возле FPS).
    "clockFormat": "H:N", // TODO: "H:i"
    // Path to clan icons folder relative to res_mods/mods/shared_resources/xvm/res.
    // Путь к папке иконок кланов относительно res_mods/mods/shared_resources/xvm/res.
    "clanIconsFolder": "clanicons/",
    // Path to sixth sense icon ("" for original icon).
    // Путь к иконке 6-го чувства ("" для оригинальной иконки).
    "sixthSenseIcon": "xvm://res/SixthSense.png",
    // GUI elements settings (experts only)
    // Настройки графических элементов (только для экспертов!)
    "elements": ${"elements.xc":"elements"},
    // Camera settings
    // Настройки камеры
    "camera": ${"camera.xc":"camera"},
    // Switching between players on the minimap after death
    // Переключение между игроками по миникарте после смерти
    "minimapDeadSwitch": true,
    // Шансы на победу в окне боевого интерфейса
    // Win chances on battle interface window
    "winChancesOnBattleInterface": {
      // true - displaying chances to win on battle interface window (only while service is enabled (chances to win at battle/at battle (live))  on modxvm.com).
      // true - показывать шансы на победу в окне боевого интерфейса (только при включенном сервисе (шанс на победу в бою или шанс на победу в бою/в бою (динамический)) на modxvm.com).
      "enabled": true,
      // true - disable displaying of static chances to win in battle interface window (affects only while "enabled" == true and displaying of chances to win at battle is enabled on modxvm.com).
      // true - отключить отображение статического шанса на победу в окне боевого интерфейса (влияет только если "enabled" == true и включено отображение шанса на победу в бою на modxvm.com).
      "disableStatic": false,    
      // true - disable displaying of dynamic chances to win in battle interface window (affects only while "enabled" == true and displaying of chances to win at battle and chances to win at battle (live) is enabled on modxvm.com).
      // true - отключить отображение динамического шанса на победу в окне боевого интерфейса (влияет только если "enabled" == true и включено отображение шанса на победу в бою и шанса на победу в бою (динамического) на modxvm.com).
      "disableLive": false,
      // Axis field coordinates.
      // Положение поля по осям.
      "position": {
        // horizontal ("halign") and vertical ("valign") align by screen resolution.
        // allows only "left", "right", "center" values for horizontal alignment and "top", "bottom", "middle" for vertical.
        // горизонтальное ("halign") и вертикальное ("valign") выравнивание по разрешению экрана.
        // допускаются только значения "left", "right", "center" для горизонтального выравнивания и "top", "bottom", "middle" для вертикального. 
        "halign": "left",
        "valign": "top",
        // coordinate modifiers for x,y axes 
        // for halign = "left" use positive x-axis modifier
        // for halign = "right" use negative x-axis modifier
        // for valign = "top" use positive y-axis modifier
        // for valign = "bottom" use negative y-axis modifier
        // модификаторы координат для осей x,y
        // для halign = "left" используйте положительные значения модификатора по x-оси
        // для halign = "right" используйте отрицательные значения модификатора по x-оси
        // для valign = "top" используйте положительные значения модификатора по y-оси
        // для valign = "bottom" используйте отрицательные значения модификатора по y-оси
        "x": 222,   
        "y": 2,
        // field width (for static%/live% 75 is default)
        // ширина поля (для static%/live% 75 по умолчанию)
        "width": 75,
        // field height (for static%/live% 22 is default)
        // высота поля (для static%/live% 22 по умолчанию)
        "height": 22
      },
      // font settings
      // настройки шрифта
      "font": {
        "color": "0xF4EFE8", 
        "name": "$FieldFont", 
        "size": 15, 
        "align": "left", 
        "bold": false, 
        "italic": false
      },
      // shadow settings
      // настройки тени
      "shadow": {
        "distance": 1,
        "angle": 90,
        "color": "0x000000",
        "alpha": 100, 
        "blurX": 5,
        "blurY": 5,
        "strength": 1.5
      } 
    }
  },
  // Frag counter panel at top side of battle windows interface.
  // Панель счёта в бою.
  "fragCorrelation": {
    // true - show quantity of alive instead of dead
    // true - показывать количество живых танков вместо убитых
    "showAliveNotFrags": false
  },
  // Total HP of teams.
  // Общее ХП команд.
  "totalHP": {
    // true - show total HP of teams
    // true - показывать общее ХП команд
    "enabled": false,
    // Color of HP per ratio ally/enemy team, hex rgb
    // Цвет ХП в зависимости от отношения хп союзной и вражеской команд, hex rgb
    "colors": {
        "bad":     "FF0000",
        "neutral": "FFFFFF",
        "good":    "00FF00"
    },
    // Font of HP (used fonts from: res/packages/misk.pkg/system/fonts/)
    // Шрифт ХП (используются шрифты из: res/packages/misk.pkg/system/fonts/)
    // default_medium.font, default_smaller.font, default_small.font, hpmp_panel.font, system_large.font, system_medium.font, system_small.font, system_tiny.font, verdana_medium.font, verdana_small.font
    "font": "default_small.font",
    // Axis field coordinates
    // Положение поля по осям
    "x": 0,
    "y": 36,
    // Horizontal alignment of field at screen ("left", "center", "right").
    // Горизонтальное выравнивание поля на экране ("left", "center", "right").
    "hAlign": "center",
    // Vertical alignment of field at screen ("top", "center", "bottom").
    // Вертикальное выравнивание поля на экране ("top", "center", "bottom").
    "vAlign": "top"
  },
  // Ingame crits panel by "expert" skill.
  // Внутриигровая панель критов от навыка "эксперт".
  "expertPanel": {
    // Delay for panel disappear. Original value was 5.
    // Задержка исчезновения панели. Оригинальное значение было 5.
    "delay": 15,
    // Panel scaling. Original value was 100.
    // Увеличение панели. 100 в оригинале.
    "scale": 150
  }
}
