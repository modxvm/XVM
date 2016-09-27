/**
 * GUI elements settings (experts only)
 * Настройки графических элементов (только для экспертов!)
 * http://www.koreanrandom.com/forum/topic/1761-
 *
 * TODO: doc
 *
 * commands:
 *   "$log": 1,  // команда $log используется для вывода значений в лог, число - уровень вложенности
 *   "$delay": 1,
 *   "$interval": 1,
 *   "$textFormat": {   // подстановка для формата текста
 *     //"$log": 1,             // тоже можно логгировать
 *     "size": 30,              // размер шрифта
 *     "font": "$TitleFont",    // шрифт пожирнее
 *     "align": "center"        // выравнивание
 *   }
 *
 */
{
  // TODO: elements
  //
  // Interface elements
  // Элементы интерфейса
  "elements": [
    // "x"     - положение по горизонтали / horizontal position
    // "y"     - положение по вертикали   / vertical position
    // "alpha" - прозрачность             / transparency
    //
    // Example: Players panels
    // Пример: Панели игроков (уши)
    /*
    {
      "$delay": 100,
      "playersPanel": {
        // Left panel
        // Левая панель игроков (ухо)
        "listLeft": {
          "y": 65
        },
        // Right panel
        // Правая панель игроков (ухо)
        "listRight": {
          "y": 65
        },
        // Players panels switcher
        // Переключатель режимов панелей игроков
        "panelSwitch": {
          "y": 37
        }
      }
    },
    */
    /*
    "battleDamageLogPanel" - Панель: Обратная связь - Урон  / Panel: Feedback - Damage
    "battleMessenger"      - Чат                            / Chat
    "battleTicker"         - ?                              / ?
    "battleTimer"          - Таймер боя                     / Battle timer
    "consumablesPanel"     - Панель снарядов и расходников  / Ammo bar
    "damageInfoPanel"      - ?                              / ?
    "damagePanel"          - Панель повреждений             / Damage panel
    "debugPanel"           - Панель пинга/лага/фпс          / Debug panel (ping/lag/fps)
    "destroyTimersPanel"   - ?                              / ?
    "endWarningPanel"      - Панель оповещяющая о конце боя / Panel informing about the imminent end of the battle
    "fragCorrelationBar"   - Счёт боя                       / Battle score
    "fullStats"            - ?                              / ?
    "minimap"              - Миникарта                      / Minimap
    "playersPanel"         - Панели игроков (уши)           / Players panels
    "prebattleTimer"       - Таймер до начала боя           / Timer before a battle start
    "radialMenu"           - Радиальное меню                / Radial menu
    "ribbonsPanel"         - Ленты боевой эффективности     / Battle performance badges
    "sixthSense"           - Лампа шестого чувства          / Sixth sense lamp
    "teamBasesPanelUI"     - Полоса захвата баз             / Capture bar
    */
  ]
}
