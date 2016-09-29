/**
 * Normal carousel cells settings
 * Настройки ячеек карусели обычного размера
 */
{
  // Definitions
  // Шаблоны
  "def": {
    // Text fields shadow.
    // Тень текстовых полей.
    "textFieldShadow": { "enabled": true, "color": "0x000000", "alpha": 80, "blur": 2, "strength": 2, "distance": 0, "angle": 0 }
  },
  "normal": {
    // Cell width
    // Ширина ячейки
    "width": 160,
    // Cell height
    // Высота ячейки
    "height": 100,
    // Spacing between carousel cells.
    // Отступ между ячейками карусели.
    "padding": {
      "horizontal": 10,   // по горизонтали
      "vertical": 2       // по вертикали
    },
    // Standard cell elements.
    // Стандартные элементы ячеек.
    "fields": {
      // "enabled"  - the visibility of the element / видимость элемента
      // "dx"       - horizontal shift              / смещение по горизонтали
      // "dy"       - vertical shift                / смещение по вертикали
      // "alpha"    - transparency                  / прозрачность
      // "scale"    - scale                         / масштаб
      //
      // Vehicle class icon.
      // Иконка типа техники.
      "tankType": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Vehicle level.
      // Уровень техники
      "level":    { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // todo: english description
      // Иконка не сбитого опыта за первую победу в день.
      "xp":       { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Vehicle name.
      // Название танка.
      "tankName": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Status text (Crew incomplete, Repairs required)
      // Статусный текст (Неполный экипаж, Требуется ремонт).
      "statusText": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Status text for "Buy vehicle" and "Buy slot" slots.
      // Статусный текст для слотов "Купить машину" и "Купить слот".
      "statusTextBuy": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Clan lock timer
      // Таймер блокировки танка
      "clanLock":   { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Activate / deactivate button.
      // Кнопка активации / деактивации.
      "activateButton": { "dx": 0, "dy": 0, "alpha": 100, "scale": 1 }
    },
    // Extra cell fields (see playersPanel.xc).
    // Дополнительные поля ячеек (см. playersPanel.xc).
    "extraFields": [
      // Средний урон
      // Average damage
      {
        "enabled": true,
        "x": 1, "y": 28, "width": 18, "height": 18, "alpha": "{{v.tdb?|0}}",
        "src": "xvm://res/icons/carousel/damage.png"
      },
      {
        "enabled": true,
        "x": 17, "y": 28,
        "format": "<b><font face='$FieldFont' size='12' color='{{v.c_xtdb|#CFCFCF}}'>{{v.tdb%d}}</font></b>",
        "shadow": ${ "def.textFieldShadow" }
      },
      // Sign of mastery.
      // Знак мастерства.
      {
        "enabled": true,
        "x": -1, "y": 10, "width": 23, "height": 23,
        "src": "img://gui/maps/icons/library/proficiency/class_icons_{{v.mastery}}.png"
      },
      // Количество боёв
      // Battles count
      {
        "enabled": true,
        "x": 158, "y": 17, "align": "right", "width": 13, "height": 13, "alpha": "{{v.battles?|0}}",
        "src": "xvm://res/icons/carousel/battles.png"
      },
      {
        "enabled": true,
        "x": 145, "y": 14, "align": "right",
        "format": "<b><font face='$FieldFont' size='12' color='#CFCFCF' alpha='#F0'>{{v.battles}}</font></b>",
        "shadow": ${ "def.textFieldShadow" }
      },
      // Процент побед
      // Winrate
      {
        "enabled": true,
        "x": 158, "y": 32, "align": "right", "width": 13, "height": 13, "alpha": "{{v.winrate?|0}}",
        "src": "xvm://res/icons/carousel/wins.png"
      },
      {
        "enabled": true,
        "x": 145, "y": 28, "align": "right",
        "format": "<b><font face='$FieldFont' size='12' color='{{v.c_winrate|#CFCFCF}}'>{{v.winrate%2d~%}}</font></b>",
        "shadow": ${ "def.textFieldShadow" }
      }
    ]
  }
}
