/**
 *
 */
{
  // Настройки цветов
  "colors": {
    // Системные цвета
    "system": {
      "ally_alive_normal": "0x96FF00",             // Цвет для живого союзника
      "ally_alive_blind": "0x96FF00",              // Цвет для живого союзника в режиме цветовой слепоты
      "ally_dead_normal": "0x009900",              // Цвет для мертвого союзника
      "ally_dead_blind": "0x009900",               // Цвет для мертвого союзника в режиме цветовой слепоты
      "ally_blowedup_normal": "0x007700",          // Цвет для взрыва БК у союзника
      "ally_blowedup_blind": "0x007700",           // Цвет для взрыва БК у союзника в режиме цветовой слепоты
      "squadman_alive_normal": "0xFFB964",         // Цвет для живого взводного
      "squadman_alive_blind": "0xFFFF00",          // Цвет для живого взводного в режиме цветовой слепоты
      "squadman_dead_normal": "0xCA7000",          // Цвет для мертвого взводного
      "squadman_dead_blind": "0xAAAA00",           // Цвет для мертвого взводного в режиме цветовой слепоты
      "squadman_blowedup_normal": "0xA45A00",      // Цвет для взрыва БК у взводного
      "squadman_blowedup_blind": "0x888800",       // Цвет для взрыва БК у взводного в режиме цветовой слепоты
      "teamKiller_alive_normal": "0x00EAFF",       // Цвет для живого тимкиллера
      "teamKiller_alive_blind": "0x00EAFF",        // Цвет для живого тимкиллера в режиме цветовой слепоты
      "teamKiller_dead_normal": "0x097783",        // Цвет для мертвого тимкиллера
      "teamKiller_dead_blind": "0x097783",         // Цвет для мертвого тимкиллера в режиме цветовой слепоты
      "teamKiller_blowedup_normal": "0x096A75",    // Цвет для взрыва БК у тимкиллера
      "teamKiller_blowedup_blind": "0x096A75",     // Цвет для взрыва БК у тимкиллера в режиме цветовой слепоты
      "enemy_alive_normal": "0xF50800",            // Цвет для живого противника
      "enemy_alive_blind": "0x8379FE",             // Цвет для живого противника в режиме цветовой слепоты
      "enemy_dead_normal": "0x840500",             // Цвет для мертвого противника
      "enemy_dead_blind": "0x47407A",              // Цвет для мертвого противника в режиме цветовой слепоты
      "enemy_blowedup_normal": "0x5A0401",         // Цвет для взрыва БК у противника
      "enemy_blowedup_blind": "0x3B365F"           // Цвет для взрыва БК у противника в режиме цветовой слепоты
    },
    // Цвет для отлетающего урона
    //   источник_получатель_тип
    //   источник:   ally, squadman, enemy, unknown, player
    //   получатель: ally, squadman, allytk, enemytk, enemy
    //   тип:        hit, kill, blowup
    "damage": ${"colorsDamage.xc":"damage"},
    // Динамический цвет по типу урона
    "dmg_kind": {
      "attack": "0xFFAA55",                        // атака
      "fire": "0xFF6655",                          // пожар
      "ramming": "0x998855",                       // таран
      "world_collision": "0x228855",               // столкновение с объектами, падение
      "other": "0xCCCCCC"                          // другое
    },
    // Динамический цвет по типу техники
    "vtype": {
      "LT":  "0xA2FF9A",                           // Цвет для легких танков
      "MT":  "0xFFF198",                           // Цвет для средних танков
      "HT":  "0xFFACAC",                           // Цвет для тяжелых танков
      "SPG": "0xEFAEFF",                           // Цвет для арты
      "TD":  "0xA0CFFF",                           // Цвет для ПТ
      "premium": "0xFFCC66",                       // Цвет для премиумной техники
      "usePremiumColor": false                     // Включить/выключить использование премиумного цвета
    },
    // Динамический цвет по оставшемуся здоровью. Значения от меньшего к большему.
    "hp": [
      { "value": 201,  "color": "0xFF0000" },    // Цвет для значений менее 201
      { "value": 401,  "color": "0xDD4444" },    // Цвет для значений менее 401
      { "value": 1001, "color": "0xFFCC22" },    // Цвет для значений менее 1001
      { "value": 9999, "color": "0xFCFCFC" }     // Цвет для остальных значений
    ],
    // Динамический цвет по проценту оставшегося здоровья. Значения от меньшего к большему.
    "hp_ratio": [
      { "value": 10,  "color": "0xFF0000" },    // Цвет для значений менее 10 проц
      { "value": 25,  "color": "0xDD4444" },    // Цвет для значений менее 25 проц
      { "value": 50,  "color": "0xFFCC22" },    // Цвет для значений менее 50 проц
      { "value": 101, "color": "0xFCFCFC" }     // Цвет для остальных значений
    ],
    // Динамический цвет по шкале XVM (только с xvm-stat). Значения от меньшего к большему.
    // http://www.koreanrandom.com/forum/topic/2625-xvm-scale
    "x": [
      { "value": 17,  "color": "0xFE0E00" },   // 00   - 16.5 - very bad   (20% of players)
      { "value": 34,  "color": "0xFE7903" },   // 16.5 - 33.5 - bad        (better then 20% of players)
      { "value": 53,  "color": "0xF8F400" },   // 33.5 - 52.5 - normal     (better then 60% of players)
      { "value": 76,  "color": "0x60FF00" },   // 52.5 - 75.5 - good       (better then 90% of players)
      { "value": 93,  "color": "0x02C9B3" },   // 75.5 - 92.5 - very good  (better then 99% of players)
      { "value": 999, "color": "0xD042F3" }    // 92.5 - XX   - unique     (better then 99.9% of players)
    ],
    // Динамический цвет по эффективности (только с xvm-stat). Значения от меньшего к большему.
    "eff": [
      { "value": 645,  "color": "0xFE0E00" },   //    0 - 644  - very bad
      { "value": 875,  "color": "0xFE7903" },   //  645 - 869  - bad
      { "value": 1155, "color": "0xF8F400" },   //  870 - 1149 - normal
      { "value": 1470, "color": "0x60FF00" },   // 1150 - 1464 - good
      { "value": 1740, "color": "0x02C9B3" },   // 1465 - 1724 - very good
      { "value": 9999, "color": "0xD042F3" }    // 1725 - *    - unique
    ],
    // Динамический цвет по рейтингу WN6 (только с xvm-stat)
    "wn": [
      { "value": 435,  "color": "0xFE0E00" },   //    0 - 434  - very bad
      { "value": 805,  "color": "0xFE7903" },   //  435 - 799  - bad
      { "value": 1200, "color": "0xF8F400" },   //  800 - 1194 - normal
      { "value": 1595, "color": "0x60FF00" },   // 1195 - 1584 - good
      { "value": 1900, "color": "0x02C9B3" },   // 1585 - 1879 - very good
      { "value": 9999, "color": "0xD042F3" }    // 1880 - *    - unique
    ],
    "e": [
      { "value": 0.01, "color": "0xFCFCFC" },
      { "value": 2,    "color": "0xFE0E00" },
      { "value": 4,    "color": "0xFE7903" },
      { "value": 5,    "color": "0xF8F400" },
      { "value": 7,    "color": "0x60FF00" },
      { "value": 9,    "color": "0x02C9B3" },
      { "value": 20,   "color": "0xD042F3" }
    ],
    // Динамический цвет по проценту побед (только с xvm-stat). Значения от меньшего к большему.
    "rating": [
      { "value": 47,  "color": "0xFE0E00" },   //  0   - 46.5  - very bad
      { "value": 49,  "color": "0xFE7903" },   // 46.5 - 48.5  - bad
      { "value": 52,  "color": "0xF8F400" },   // 48.5 - 51.5  - normal
      { "value": 57,  "color": "0x60FF00" },   // 51.5 - 56.5  - good
      { "value": 64,  "color": "0x02C9B3" },   // 56.5 - 63.5  - very good
      { "value": 101, "color": "0xD042F3" }    // 63.5 - 100   - unique
    ],
    // Динамический цвет по TWR (T-Calc) (только с xvm-stat)
    "twr": [
      { "value": 47,  "color": "0xFE0E00" },   //  0   - 46.5  - very bad
      { "value": 49,  "color": "0xFE7903" },   // 46.5 - 48.5  - bad
      { "value": 52,  "color": "0xF8F400" },   // 48.5 - 51.5  - normal
      { "value": 57,  "color": "0x60FF00" },   // 51.5 - 56.5  - good
      { "value": 62,  "color": "0x02C9B3" },   // 56.5 - 61.5  - very good
      { "value": 101, "color": "0xD042F3" }    // 61.5 - 100   - unique
    ],
    // Динамический цвет по количеству кило-боев (только с xvm-stat). Значения от меньшего к большему.
    "kb": [
      { "value": 2,   "color": "0xFE0E00" },   //  0 - 1
      { "value": 5,   "color": "0xFE7903" },   //  2 - 4
      { "value": 9,   "color": "0xF8F400" },   //  5 - 8
      { "value": 14,  "color": "0x60FF00" },   //  9 - 13
      { "value": 20,  "color": "0x02C9B3" },   // 14 - 19
      { "value": 999, "color": "0xD042F3" }    // 20 - *
    ],
    // Динамический цвет по количеству боев по текущему танку (только с xvm-stat). Значения от меньшего к большему.
    "t_battles": [
      { "value": 100,   "color": "0xFE0E00" }, //    0 - 99
      { "value": 250,   "color": "0xFE7903" }, //  100 - 249
      { "value": 500,   "color": "0xF8F400" }, //  250 - 499
      { "value": 1000,  "color": "0x60FF00" }, //  500 - 999
      { "value": 1800,  "color": "0x02C9B3" }, // 1000 - 1799
      { "value": 99999, "color": "0xD042F3" }  // 1800 - *
    ],
    "tdb": [
      { "value": 1,    "color": "0xFCFCFC" },
      { "value": 500,  "color": "0xFE0E00" },
      { "value": 1000, "color": "0xF8F400" },
      { "value": 2000, "color": "0x60FF00" }
    ],
    "tdv": [
      { "value": 0.01, "color": "0xFCFCFC" },
      { "value": 0.6,  "color": "0xFE0E00" },
      { "value": 0.8,  "color": "0xFE7903" },
      { "value": 1.0,  "color": "0xF8F400" },
      { "value": 1.3,  "color": "0x60FF00" },
      { "value": 2.0,  "color": "0x02C9B3" },
      { "value": 15,   "color": "0xD042F3" }
    ],
    "tfb": [
      { "value": 0.01, "color": "0xFCFCFC" },
      { "value": 0.6,  "color": "0xFE0E00" },
      { "value": 0.8,  "color": "0xFE7903" },
      { "value": 1.0,  "color": "0xF8F400" },
      { "value": 1.3,  "color": "0x60FF00" },
      { "value": 2.0,  "color": "0x02C9B3" },
      { "value": 15,   "color": "0xD042F3" }
    ],
    "tsb": [
      { "value": 0.01, "color": "0xFCFCFC" },
      { "value": 0.6,  "color": "0xFE0E00" },
      { "value": 0.8,  "color": "0xFE7903" },
      { "value": 1.0,  "color": "0xF8F400" },
      { "value": 1.3,  "color": "0x60FF00" },
      { "value": 2.0,  "color": "0x02C9B3" },
      { "value": 15,   "color": "0xD042F3" }
    ]
  }
}
