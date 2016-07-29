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
    "debugPanel"         - Панель пинга/лага/фпс          / Debug panel (ping/lag/fps)
    "consumablesPanel"   - Панель снарядов и расходников  / Ammo bar
    "destroyTimersPanel" - ?                              / ?
    "radialMenu"         - Радиальное меню                / Radial menu
    "battleTimer"        - Таймер боя                     / Battle timer
    "battleTicker"       - ?                              / ?
    "prebattleTimer"     - Таймер до начала боя           / Timer before a battle start
    "playersPanel"       - Панели игроков (уши)           / Players panels
    "teamBasesPanelUI"   - Полоса захвата баз             / Capture bar   
    "sixthSense"         - Лампа шестого чувства          / Sixth sense lamp
    "endWarningPanel"    - Панель оповещяющая о конце боя / Panel informing about the imminent end of the battle
    "fullStats"          - ?                              / ?
    "damagePanel"        - Панель повреждений             / Damage panel
    "damageInfoPanel"    - ?                              / ?
    "minimap"            - Миникарта                      / Minimap
    "ribbonsPanel"       - Ленты боевой эффективности     / Battle performance badges
    "battleMessenger"    - Чат                            / Chat    
    "fragCorrelationBar" - Счёт боя                       / Battle score
    */
  ]
}
