/**
 * Small carousel cells settings.
 * Настройки ячеек карусели малелького размера.
 */
{
  // Definitions.
  // Шаблоны.
  "def": {
    // Text fields shadow.
    // Тень текстовых полей.
    "textFieldShadow": { "enabled": true, "color": "0x000000", "alpha": 80, "blur": 2, "strength": 2, "distance": 0, "angle": 0 }
  },
  "small": {
    // Cell width.
    // Ширина ячейки.
    "width": 160,
    // Cell height.
    // Высота ячейки.
    "height": 35,
    // Spacing between carousel cells.
    // Отступ между ячейками карусели.
    "gap": 10,
    // Standard cell elements.
    // Стандартные элементы ячеек.
    "fields": {
      // "enabled"  - the visibility of the element / видимость элемента
      // "dx"       - horizontal shift              / смещение по горизонтали
      // "dy"       - vertical shift                / смещение по вертикали
      // "alpha"    - transparency                  / прозрачность
      // "scale"    - scale                         / масштаб
      //
      // Nation flag.
      // Флаг нации.
      "flag": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Vehicle icon.
      // Иконка танка.
      "tankIcon": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Vehicle class icon.
      // Иконка типа техники.
      "tankType": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Vehicle level.
      // Уровень техники.
      "level": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Double XP icon.
      // Иконка не сбитого опыта за первую победу в день.
      "xp": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Vehicle name.
      // Название танка.
      "tankName": { "enabled": false, "dx": 0, "dy": 0, "alpha": 100, "scale": 1, "textFormat": {}, "shadow": {} },
      // Info text (Crew incomplete, Repairs required).
      // Инфо текст (Неполный экипаж, Требуется ремонт).
      "info": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1, "textFormat": {}, "shadow": {} },
      // Info image.
      // Инфо иконка.
      "infoImg": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Info text for "Buy vehicle" and "Buy slot" slots.
      // Инфо текст для слотов "Купить машину" и "Купить слот".
      "infoBuy": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1, "textFormat": {}, "shadow": {} },
      // Clan lock timer.
      // Таймер блокировки танка.
      "clanLock": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Price.
      // Цена.
      "price": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Action price.
      // Акционная цена.
      "actionPrice": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Favorite vehicle mark.
      // Маркер основной техники.
      "favorite": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Vehicle mark with the ability to earn bonds.
      // Маркер техники с возможностью заработка бон.
      "crystalsBorder": { "enabled": true, "alpha": 100 },
      // Image in in the stats field "stats" for vehicle with the ability to earn bonds.
      // Иконка в поле статистики "stats" для техники с возможностью заработка бон.
      "crystalsIcon": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100 },
      // Stats field that appears on the mouse hover.
      // Поле статистики, отображаемое при наведении мыши.
      "stats": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1, "textFormat": {}, "shadow": {} }
    },
    // Extra cell fields (extended format supported, see extra-field.txt).
    // Дополнительные поля ячеек (поддерживается расширенный формат, см. extra-field_ru.txt).
    "extraFields": [
      // Slot background.
      // Подложка слота.
      { "x": 1, "y": 1, "layer": "substrate", "width": 160, "height": 35, "bgColor": "0x0A0A0A" },
      // Sign of mastery.
      // Знак мастерства.
      {
        "enabled": true,
        "x": 4, "y": 14, "width": 23, "height": 23,
        "src": "{{v.mastery!=0?img://gui/maps/icons/library/proficiency/class_icons_{{v.mastery}}.png}}"
      },
      // Vehicle name.
      // Название танка.
      {
        "enabled": true,
        "x": 159, "y": 14, "align": "right",
        "format": "<font face='$FieldFont' size='15' color='{{v.premium?#FFA759|#C8C8B5}}'>{{v.name}}</font>",
        "shadow": { "$ref": { "path": "def.textFieldShadow" }, "color": "{{v.premium?0xFC3700|0xC8C8B5}}", "alpha": "{{v.premium?85|35}}", "blur": "{{v.premium?10|8}}" }
      },
      // Winrate.
      // Процент побед.
      {
        "enabled": true,
        "x": 24, "y": 16,
        "format": "<b><font face='$FieldFont' size='12' color='{{v.c_winrate|#C8C8B5}}'>{{v.winrate%2d~%}}</font></b>",
        "shadow": ${ "def.textFieldShadow" }
      }
    ]
  }
}
