/**
 * Color settings.
 * Настройки цветов.
 */
{
  "def": {
     // System and damage color definition.
     // Шаблон системного цвета и цвета для урона.
    "ally":		"0x60FF00",	// союзник
    "squadman":	"0xFF914C",	// взводный
    "teamKiller":	"0x00EAFF",	// тимкиллер
    "enemy":	"0xFE0E00",	// противник
    "player":	"0xFFCC66",	// игрок
     // Dynamic color definition.
     // Шаблон динамического цвета.
    "color0": "0xFCFCFC",	// undefined		/ статистика недоступна
    "color1": "0xFE0E00",	// bad			/ плохо
    "color2": "0xFE7903",	// below average	/ ниже среднего
    "color3": "0xF8F400",	// normal			/ средне
    "color4": "0x60FF00",	// good			/ хорошо
    "color5": "0x02C9B3",	// very good		/ очень хорошо
    "color6": "0xD042F3",	// skillfully			/ мастерски
     // HP dynamic color definition.
     // Шаблон динамического цвета для здоровья.
    "hpColor1": "0xFF0000",	// low			/ низкий
    "hpColor2": "0xDD4444",	// below average	/ ниже среднего
    "hpColor3": "0xFFCC22",	// average			/ средний
    "hpColor4": "0xFCFCFC"		// above-average	/ выше среднего
  },
  "colors": {
    // System colors.
    // Системные цвета.
    "system": {
      // Format: object_state
      // Object:      ally, squadman, teamKiller, enemy
      // State:       alive, dead, blowedup
      // ----
      // Формат: объект_состояние
      // Объект:      ally - союзник, squadman - взводный, teamKiller - тимкиллер, enemy - противник
      // Состояние:   alive - живой, dead - мертвый, blowedup - взорвана боеукладка
      //Союзник
      "ally_alive": ${ "def.ally" },				// живой
      "ally_dead": "0x009900",				// мертвый
      "ally_blowedup": "0x009900",			// взорван БК
      //Взводный
      "squadman_alive": ${ "def.squadman" },	// живой
      "squadman_dead": "0xCA7000",			// мертвый
      "squadman_blowedup": "0xCA7000",		// взорван БК
      //Тимкиллер
      "teamKiller_alive": ${ "def.teamKiller" },	// живой
      "teamKiller_dead": "0x097783",			// мертвый
      "teamKiller_blowedup": "0x097783",		// взорван БК
      //Противник
      "enemy_alive": ${ "def.enemy" },			// живой
      "enemy_dead": "0xB30B02",			// мертвый
      "enemy_blowedup": "0xB30B02"			// взорван БК
    },
    // Dynamic color by damage kind.
    // Динамический цвет по типу урона.
    "dmg_kind": {
      "attack": "0xFFBD00",			// attack			/ атака
      "fire": "0xFF0066",			// fire			/ пожар
      "ramming": "0x228855",		// ramming		/ таран
      "world_collision": "0x998855",	// world collision	/ столкновение с объектами, падение
      "other": "0xCCCCCC"			// other			/ другое
    },
    // Dynamic color by vehicle type.
    // Динамический цвет по типу техники.
    "vtype": {
      // Цвет для легких танков.
      "LT":  "0xA2FF9A",
      // Цвет для средних танков.
      "MT":  "0xFFF198",
      // Цвет для тяжелых танков.
      "HT":  "0xCCCCCC",
      // Цвет для арты.
      "SPG": "0xFFACAC",
      // Цвет для ПТ.
      "TD":  "0xA0CFFF",
      // Цвет для премиумной техники.
      "premium": "0xFFCC66",
      // Включить/выключить использование премиумного цвета.
      "usePremiumColor": false
    },
    // Color settings for damage.
    // Настройки цвета для урона.
  "damage": {
      // Format: src_dst_type.
      // Src:  ally, squadman, enemy, unknown, player.
      // Dst:  ally, squadman, allytk, enemytk, enemy.
      // Type: hit, kill, blowup.
      // ----
      // Формат: источник_получатель_тип.
      // Источник:   ally - союзник, squadman - взводный, enemy - противник, unknown - неизвестный (не виден игроку), player - игрок.
      // Получатель: ally, squadman, enemy, allytk - союзник тимкиллер, enemytk - противник тимкиллер.
      // Тип:        hit - попадание, kill - убийство, blowup - боеукладка.
      "ally_ally_hit": "0x00CCFF",						// "teamKiller"
      "ally_ally_kill": ${ "def.teamKiller" },				// "teamKiller"
      "ally_ally_blowup": ${ "def.teamKiller" },			// "teamKiller"
      "ally_squadman_hit": "0x00CCFF",				// "teamKiller"
      "ally_squadman_kill": ${ "def.teamKiller" },			// "teamKiller"
      "ally_squadman_blowup": ${ "def.teamKiller" },		// "teamKiller"
      "ally_enemy_hit": ${ "def.enemy" },				// "enemy"
      "ally_enemy_kill": ${ "def.enemy" },				// "enemy"
      "ally_enemy_blowup": ${ "def.enemy" },			// "enemy"
      "ally_allytk_hit": "0x00CCFF",					// "teamKiller"
      "ally_allytk_kill": ${ "def.teamKiller" },				// "teamKiller"
      "ally_allytk_blowup": ${ "def.teamKiller" },			// "teamKiller"
      "ally_enemytk_hit": ${ "def.enemy" },				// "enemy"
      "ally_enemytk_kill": ${ "def.enemy" },				// "enemy"
      "ally_enemytk_blowup": ${ "def.enemy" },			// "enemy"
      "squadman_ally_hit": ${ "def.teamKiller" },			// "teamKiller"
      "squadman_ally_kill": ${ "def.teamKiller" },			// "teamKiller"
      "squadman_ally_blowup": ${ "def.teamKiller" },		// "teamKiller"
      "squadman_squadman_hit": ${ "def.teamKiller" },	// "teamKiller"
      "squadman_squadman_kill": ${ "def.teamKiller" },	// "teamKiller"
      "squadman_squadman_blowup": ${ "def.teamKiller" },	// "teamKiller"
      "squadman_enemy_hit": ${ "def.squadman" },		// "enemy"
      "squadman_enemy_kill": ${ "def.squadman" },		// "enemy"
      "squadman_enemy_blowup": ${ "def.squadman" },	// "enemy"
      "squadman_allytk_hit": ${ "def.teamKiller" }, 		// "teamKiller"
      "squadman_allytk_kill": ${ "def.teamKiller" },		// "teamKiller"
      "squadman_allytk_blowup": ${ "def.teamKiller" },		// "teamKiller"
      "squadman_enemytk_hit": ${ "def.squadman" }, 		// "enemy"
      "squadman_enemytk_kill": ${ "def.squadman" },		// "enemy"
      "squadman_enemytk_blowup": ${ "def.squadman" },	// "enemy"
      "enemy_ally_hit": "0x36AD00", 					// "ally"
      "enemy_ally_kill": ${ "def.ally" },					// "ally"
      "enemy_ally_blowup": ${ "def.ally" },				// "ally"
      "enemy_squadman_hit": "0xFF7D2E",				// "squadman"
      "enemy_squadman_kill": ${ "def.squadman" },		// "squadman"
      "enemy_squadman_blowup": ${ "def.squadman" },	// "squadman"
      "enemy_enemy_hit": ${ "def.enemy" },			// "enemy"
      "enemy_enemy_kill": ${ "def.enemy" },			// "enemy"
      "enemy_enemy_blowup": ${ "def.enemy" },			// "enemy"
      "enemy_allytk_hit": "0x36AD00",					// "ally"
      "enemy_allytk_kill": ${ "def.ally" },				// "ally"
      "enemy_allytk_blowup": ${ "def.ally" },			// "ally"
      "enemy_enemytk_hit": ${ "def.enemy" },			// "enemy"
      "enemy_enemytk_kill": ${ "def.enemy" },			// "enemy"
      "enemy_enemytk_blowup": ${ "def.enemy" },		// "enemy"
      "unknown_ally_hit": "0x36AD00",					// "ally"
      "unknown_ally_kill": ${ "def.ally" },				// "ally"
      "unknown_ally_blowup": ${ "def.ally" },			// "ally"
      "unknown_squadman_hit": "0xFF7D2E",			// "squadman"
      "unknown_squadman_kill": ${ "def.squadman" },		// "squadman"
      "unknown_squadman_blowup": ${ "def.squadman" },	// "squadman"
      "unknown_enemy_hit": ${ "def.enemy" },			// "enemy"
      "unknown_enemy_kill": ${ "def.enemy" },			// "enemy"
      "unknown_enemy_blowup": ${ "def.enemy" },		// "enemy"
      "unknown_allytk_hit": "0x36AD00",				// "ally"
      "unknown_allytk_kill": ${ "def.ally" },				// "ally"
      "unknown_allytk_blowup": ${ "def.ally" },			// "ally"
      "unknown_enemytk_hit": ${ "def.enemy" },			// "enemy"
      "unknown_enemytk_kill": ${ "def.enemy" },			// "enemy"
      "unknown_enemytk_blowup": ${ "def.enemy" },		// "enemy"
      "player_ally_hit": ${ "def.player" },				// "me"
      "player_ally_kill": ${ "def.player" },				// "me"
      "player_ally_blowup": ${ "def.player" },			// "me"
      "player_squadman_hit": ${ "def.player" },			// "me"
      "player_squadman_kill": ${ "def.player" },			// "me"
      "player_squadman_blowup": ${ "def.player" },		// "me"
      "player_enemy_hit": ${ "def.player" },				// "me"
      "player_enemy_kill": ${ "def.player" },				// "me"
      "player_enemy_blowup": ${ "def.player" },			// "me"
      "player_allytk_hit": ${ "def.player" },				// "me"
      "player_allytk_kill": ${ "def.player" },				// "me"
      "player_allytk_blowup": ${ "def.player" },			// "me"
      "player_enemytk_hit": ${ "def.player" },			// "me"
      "player_enemytk_kill": ${ "def.player" },			// "me"
      "player_enemytk_blowup": ${ "def.player" }			// "me"
    },
    // Values ​​below should be from smaller to larger.
    // Значения ниже должны быть от меньшего к большему.
    // ----
    // Dynamic color by remaining absolute health.
    // Динамический цвет по оставшемуся здоровью.
    "hp": [
      { "value": 201,	"color": ${ "def.hpColor1" } },	// Цвет для значений менее 201
      { "value": 401,	"color": ${ "def.hpColor2" } },	// Цвет для значений менее 401
      { "value": 1001,	"color": ${ "def.hpColor3" } },	// Цвет для значений менее 1001
      { "value": 9999,	"color": ${ "def.hpColor4" } }	// Цвет для остальных значений
    ],
    // Dynamic color by remaining health percent.
    // Динамический цвет по проценту оставшегося здоровья.
    "hp_ratio": [
      { "value": 10,	"color": ${ "def.hpColor1" } },	// Цвет для значений менее 10 проц
      { "value": 25,	"color": ${ "def.hpColor2" } },	// Цвет для значений менее 25 проц
      { "value": 50,	"color": ${ "def.hpColor3" } },	// Цвет для значений менее 50 проц
      { "value": 101,	"color": ${ "def.hpColor4" } }	// Цвет для остальных значений
    ],
    // Dynamic color for XVM Scale (only with xvm-stat).
    // Динамический цвет по шкале XVM (только с xvm-stat).
    // http://www.koreanrandom.com/forum/topic/2625-/
    "x": [
      { "value": 17,   "color": ${ "def.color1" } },   // 00   - 16.5 - bad   (20% of players)
      { "value": 34,   "color": ${ "def.color2" } },   // 16.5 - 33.5 - below average   (better then 20% of players)
      { "value": 53,   "color": ${ "def.color3" } },   // 33.5 - 52.5 - normal     (better then 60% of players)
      { "value": 76,   "color": ${ "def.color4" } },   // 52.5 - 75.5 - good       (better then 90% of players)
      { "value": 93,   "color": ${ "def.color5" } },   // 75.5 - 92.5 - very good  (better then 99% of players)
      { "value": 999, "color": ${ "def.color6" } }    // 92.5 - XX   - skillfully     (better then 99.9% of players)
    ],
    // Dynamic color by efficiency (only with xvm-stat).
    // Динамический цвет по эффективности (только с xvm-stat).
    "eff": [
      { "value": 645,  "color": ${ "def.color1" } },   //    0 - 644  - bad
      { "value": 875,  "color": ${ "def.color2" } },   //  645 - 874  - below average
      { "value": 1155, "color": ${ "def.color3" } },   //  875 - 1154 - normal
      { "value": 1470, "color": ${ "def.color4" } },   // 1155 - 1469 - good
      { "value": 1740, "color": ${ "def.color5" } },   // 1470 - 1739 - very good
      { "value": 9999, "color": ${ "def.color6" } }    // 1740 - *    - skillfully
    ],
    // Dynamic color by WN6 rating (only with xvm-stat).
    // Динамический цвет по рейтингу WN6 (только с xvm-stat).
    "wn": [
      { "value": 435,  "color": ${ "def.color1" } },   //    0 - 434  - bad
      { "value": 805,  "color": ${ "def.color2" } },   //  435 - 804  - below average
      { "value": 1200, "color": ${ "def.color3" } },   //  805 - 1199 - normal
      { "value": 1595, "color": ${ "def.color4" } },   // 1200 - 1594 - good
      { "value": 1900, "color": ${ "def.color5" } },   // 1595 - 1899 - very good
      { "value": 9999, "color": ${ "def.color6" } }    // 1900 - *    - skillfully
    ],
    // Dynamic color by TEFF (E) rating (only with xvm-stat).
    // Динамический цвет по рейтингу TEFF (E) (только с xvm-stat).
    "e": [
      { "value": 0.01, "color": ${ "def.color0" } },    // 0- undefined		/ статистика недоступна
      { "value": 3,      "color": ${ "def.color1" } },    // 1-2- bad		/ владеет танком плохо
      { "value": 4,      "color": ${ "def.color2" } },    // 3- below average	/ владеет танком ниже среднего
      { "value": 6,      "color": ${ "def.color3" } },    // 4-5- normal		/ владеет танком средне
      { "value": 7,      "color": ${ "def.color4" } },    // 6- good		/ владеет танком хорошо
      { "value": 9,      "color": ${ "def.color5" } },    // 7-8- very good	/ владеет танком очень хорошо
      { "value": 20,    "color": ${ "def.color6" } }     // 9-10- skillfully	/ владеет танком мастерски
    ],
    // Dynamic color by win percent (only with xvm-stat).
    // Динамический цвет по проценту побед (только с xvm-stat).
    "rating": [
      { "value": 47,   "color": ${ "def.color1" } },   //  0   - 46.5  - bad
      { "value": 49,   "color": ${ "def.color2" } },   // 46.5 - 48.5  - below average
      { "value": 52,   "color": ${ "def.color3" } },   // 48.5 - 51.5  - normal
      { "value": 57,   "color": ${ "def.color4" } },   // 51.5 - 56.5  - good
      { "value": 64,   "color": ${ "def.color5" } },   // 56.5 - 63.5  - very good
      { "value": 101, "color": ${ "def.color6" } }    // 63.5 - 100   - skillfully
    ],
    // Dynamic color by TWR (T-Calc) (only with xvm-stat).
    // Динамический цвет по TWR (T-Calc) (только с xvm-stat).
    "twr": [
      { "value": 47,   "color": ${ "def.color1" } },   //  0   - 46.5  - bad
      { "value": 49,   "color": ${ "def.color2" } },   // 46.5 - 48.5  - below average
      { "value": 52,   "color": ${ "def.color3" } },   // 48.5 - 51.5  - normal
      { "value": 57,   "color": ${ "def.color4" } },   // 51.5 - 56.5  - good
      { "value": 62,   "color": ${ "def.color5" } },   // 56.5 - 61.5  - very good
      { "value": 101, "color": ${ "def.color6" } }    // 61.5 - 100   - skillfully
    ],
    // Dynamic color by kilo-battles (only with xvm-stat).
    // Динамический цвет по количеству кило-боев (только с xvm-stat).
    "kb": [
      { "value": 1.5,   "color": ${ "def.color1" } },   //  0 - 1.5
      { "value": 4.5,   "color": ${ "def.color2" } },   //  1.5 - 4.5
      { "value": 8.5,   "color": ${ "def.color3" } },   //  4.5 - 8.5
      { "value": 13.5,  "color": ${ "def.color4" } },   //  8.5 - 13.5
      { "value": 19.5,  "color": ${ "def.color5" } },   // 13.5 - 19.5
      { "value": 999,   "color": ${ "def.color6" } }    // 19.5 - *
    ],
    // Dynamic color by battles on current tank (only with xvm-stat).
    // Динамический цвет по количеству боев на текущем танке (только с xvm-stat).
    "t_battles": [
      { "value": 150,    "color": ${ "def.color1" } },   //  0h - 1.5h
      { "value": 350,    "color": ${ "def.color2" } },   //  1.5h - 3.5h
      { "value": 650,    "color": ${ "def.color3" } },   //  3.5h - 6.5h
      { "value": 1050 ,  "color": ${ "def.color4" } },   //  6.5h - 10.5h
      { "value": 1750,   "color": ${ "def.color5" } },   // 10.5h - 17.5h
      { "value": 99999, "color": ${ "def.color6" } }    // 17.5h - *
    ],
    // Dynamic color by average damage on current tank (only with xvm-stat).
    // Динамический цвет по среднему урону за бой на текущем танке (только с xvm-stat).
    "tdb": [
      { "value": 1,      "color": ${ "def.color0" } },
      { "value": 500,   "color": ${ "def.color1" } },
      { "value": 1000, "color": ${ "def.color3" } },
      { "value": 2000, "color": ${ "def.color4" } }
    ],
    // Dynamic color by average damage efficiency on current tank (only with xvm-stat).
    // Динамический цвет по эффективности урона за бой на текущем танке (только с xvm-stat).
    "tdv": [
      { "value": 0.01, "color": ${ "def.color0" } },
      { "value": 0.6,   "color": ${ "def.color1" } },
      { "value": 0.8,   "color": ${ "def.color2" } },
      { "value": 1.0,   "color": ${ "def.color3" } },
      { "value": 1.3,   "color": ${ "def.color4" } },
      { "value": 2.0,   "color": ${ "def.color5" } },
      { "value": 15,    "color": ${ "def.color6" } }
    ],
    // Dynamic color by average frags per battle on current tank (only with xvm-stat).
    // Динамический цвет по среднему количеству фрагов за бой на текущем танке (только с xvm-stat).
    "tfb": [
      { "value": 0.01, "color": ${ "def.color0" } },
      { "value": 0.6,   "color": ${ "def.color1" } },
      { "value": 0.8,   "color": ${ "def.color2" } },
      { "value": 1.0,   "color": ${ "def.color3" } },
      { "value": 1.3,   "color": ${ "def.color4" } },
      { "value": 2.0,   "color": ${ "def.color5" } },
      { "value": 15,    "color": ${ "def.color6" } }
    ],
    // Dynamic color by number of spotted enemies per battle on current tank (only with xvm-stat).
    // Динамический цвет по среднему количеству засвеченных врагов за бой на текущем танке (только с xvm-stat).
    "tsb": [
      { "value": 0.01, "color": ${ "def.color0" } },
      { "value": 0.6,   "color": ${ "def.color1" } },
      { "value": 0.8,   "color": ${ "def.color2" } },
      { "value": 1.0,   "color": ${ "def.color3" } },
      { "value": 1.3,   "color": ${ "def.color4" } },
      { "value": 2.0,   "color": ${ "def.color5" } },
      { "value": 15,    "color": ${ "def.color6" } }
    ]
  }
}
