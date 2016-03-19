/**
 * GUI elements settings (experts only)
 * Настройки графических элементов (только для экспертов!)
 * http://www.koreanrandom.com/forum/topic/1761-
 */
{
    // Minimap coordinates font
    // Шрифт координат миникарты
    "minimapFont": {
        "color": "0x8A855C",    // цвет / color
        "alpha": 100            // прозрачность / transparency
    },
    // Interface elements
    // Элементы интерфейса
    "elements": [
        // "_x"     - положение по горизонтали  / horizontal position
        // "_y"     - положение по вертикали    / vertical position
        // "_alpha" - прозрачность              / transparency

        // You can use constants, relative paths and mathematical expressions:
        // Можно использовать константы, относительные пути и математические выражения:
        // "_x": 100,
        // "_y": "HEIGHT / 2 + sin(minimap._alpha)",

        // Players panels
        // Панели игроков (уши)
        {
            "$delay": 100,
            // Left panel
            // Левая панель игроков (ухо)
            "leftPanel": {
                "_y": null
            },
            // Right panel
            // Правая панель игроков (ухо)
            "rightPanel": {
                "_y": null
            },
            // Players panels switcher
            // Переключатель режимов панелей игроков
            "switcher_mc": {
                "_y": "leftPanel._y - 28"
            }
        },
        // Sixth sense lamp
        // Лампа шестого чувства
        {
            "$delay": 100,
            // Sixth sense lamp duration (in milliseconds). Example: "sixthSenseDuration": 7000,
            // Время горения лампочки шестого чувства (в миллисекундах). Например: "sixthSenseDuration": 7000,
            "sixthSenseDuration": "sixthSenseDuration",
            // Sixth sense lamp
            // Лампа шестого чувства
            "sixthSenseIndicator": {
                // To use some settings in this section, you may need to remove "//" before "$interval". Reduces the performance!
                // Чтобы использовать некоторые настройки этой секции, может понадобиться удалить "//" перед "$interval". Снижает производительность!
                // "$interval": 0,
                "_alpha": 100,
                "_x": "sixthSenseIndicator._x",
                "_y": "sixthSenseIndicator._y"
            }
        },
        // Battle timer
        // Таймер боя
        {
            "$delay": 100,
            // Battle timer
            // Таймер боя
            "battleTimer": {
                "_x": "battleTimer._x - 0",
                "_y": "battleTimer._y - 0"
            }
        },
        // Minimap
        // Миникарта
        {
            "$delay": 100,
            // Minimap
            // Миникарта
            "minimap": {
                "_alpha": "minimap._alpha",
                // Vertical coordinates
                // Координаты по вертикали
                "rowA": { "textColor": ${"minimapFont.color"}, "_alpha": ${"minimapFont.alpha"} },
                "rowB": { "textColor": ${"minimapFont.color"}, "_alpha": ${"minimapFont.alpha"} },
                "rowC": { "textColor": ${"minimapFont.color"}, "_alpha": ${"minimapFont.alpha"} },
                "rowD": { "textColor": ${"minimapFont.color"}, "_alpha": ${"minimapFont.alpha"} },
                "rowE": { "textColor": ${"minimapFont.color"}, "_alpha": ${"minimapFont.alpha"} },
                "rowF": { "textColor": ${"minimapFont.color"}, "_alpha": ${"minimapFont.alpha"} },
                "rowG": { "textColor": ${"minimapFont.color"}, "_alpha": ${"minimapFont.alpha"} },
                "rowH": { "textColor": ${"minimapFont.color"}, "_alpha": ${"minimapFont.alpha"} },
                "rowJ": { "textColor": ${"minimapFont.color"}, "_alpha": ${"minimapFont.alpha"} },
                "rowK": { "textColor": ${"minimapFont.color"}, "_alpha": ${"minimapFont.alpha"} },
                // Horizontal coordinates
                // Координаты по горизонтали
                "colsNames": { "textColor": ${"minimapFont.color"}, "_alpha": ${"minimapFont.alpha"} }
            }
        },
        // Debug panel (ping/lag/fps)
        // Панель пинга/лага/фпс
        {
            "$delay": 100,
            // Debug panel (ping/lag/fps)
            // Панель пинга/лага/фпс
            "debugPanel": {
                // To use some settings in this section, you may need to remove "//" before "$interval". Reduces the performance!
                // Чтобы использовать некоторые настройки этой секции, может понадобиться удалить "//" перед "$interval". Снижает производительность!
                // "$interval": 0,
                "_alpha": 100,
                "_x": "debugPanel._x",
                "_y": "debugPanel._y"
            }
        },
        // Battle score
        // Счёт боя
        {
            "$delay": 100,
            // Battle score
            // Счёт боя
            "fragCorrelationBar": {
                // To use some settings in this section, you may need to remove "//" before "$interval". Reduces the performance!
                // Чтобы использовать некоторые настройки этой секции, может понадобиться удалить "//" перед "$interval". Снижает производительность!
                // "$interval": 0,
                "_alpha": 100,
                "_x": "fragCorrelationBar._x",
                "_y": "fragCorrelationBar._y"
            }
        },
        // Capture bar
        // Полоса захвата баз
        {
            "$delay": 100,
            // Capture bar
            // Полоса захвата баз
            "teamBasesPanel": {
                "_alpha": 100,
                "_x": "teamBasesPanel._x + 0",
                "_y": 60
            }
        },
        // Chat
        // Чат
        {
            "$delay": 100,
            // Chat
            // Чат
            "messenger": {
                "_alpha": 100,
                "_x": "messenger._x + 0",
                "_y": "messenger._y + 0"
            }
        },
        // Kill-log
        // Килл-лог (лог убитых)
        {
            "$delay": 100,
            // Kill-log
            // Килл-лог (лог убитых)
            "playerMessangersPanel": {
                "_alpha": 100
            }
        },
        // Ammo bar
        // Панель снарядов и расходников
        {
            "$delay": 100,
            // Ammo bar
            // Панель снарядов и расходников
            "consumablesPanel": {
                "_alpha": 100,
                "_x": "consumablesPanel._x + 0",
                "_y": "consumablesPanel._y - 0"
            }
        }
    ]
}
