/**
 * Color settings.
 * Настройки цветов.
 */
{
  "def": {
    "al": "0xAADDFF",
    "sq": "0xAAAAFF",
    "tk": "0x00DDFF",
    "en": "0xFFDDAA",
    "pl": "0xAAFFAA"
  },
  "colorRating": {
    "undefined":    "0xFCFCFC",   // undefined  / неопределенно
    "very_bad":     "0xFE0E00",   // very bad   / очень плохо
    "bad":          "0xFE7903",   // bad        / плохо
    "normal":       "0xF8F400",   // normal     / средне
    "good":         "0x60FF00",   // good       / хорошо
    "very_good":    "0x02C9B3",   // very good  / очень хорошо
    "unique":       "0xD042F3"    // unique     / уникально
  },
  "colorHP": {
    "very_low":         "0xFF0000",   // very low       / очень низкий
    "low":              "0xDD4444",   // low            / низкий
    "average":          "0xFFCC22",   // average        / средний
    "above_average":    "0xFCFCFC"    // above-average  / выше среднего
  },

  "colors": {
    "system": {
      "ally_alive":          ${"def.al"},
      "ally_dead":           "0x556E7F",
      "ally_blowedup":       "0x668499",
      "squadman_alive":      ${"def.sq"},
      "squadman_dead":       "0x55557F",
      "squadman_blowedup":   "0x666699",
      "teamKiller_alive":    ${"def.tk"},
      "teamKiller_dead":     "0x006E7F",
      "teamKiller_blowedup": "0x008499",
      "enemy_alive":         ${"def.en"},
      "enemy_dead":          "0x9F6E55",
      "enemy_blowedup":      "0x998466"
    },
    // Color settings for damage. Link.
    // Настройки цвета для урона. Ссылка.
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
      "ally_ally_hit":		${"def.tk"},
      "ally_ally_kill":		${"def.tk"},
      "ally_ally_blowup":	${"def.tk"},
      "ally_squadman_hit":	${"def.tk"},
      "ally_squadman_kill":	${"def.tk"},
      "ally_squadman_blowup":	${"def.tk"},
      "ally_enemy_hit":		${"def.en"},
      "ally_enemy_kill":	${"def.en"},
      "ally_enemy_blowup":	${"def.en"},
      "ally_allytk_hit":	${"def.tk"},
      "ally_allytk_kill":	${"def.tk"},
      "ally_allytk_blowup":	${"def.tk"},
      "ally_enemytk_hit":	${"def.en"},
      "ally_enemytk_kill":	${"def.en"},
      "ally_enemytk_blowup":	${"def.en"},
      "squadman_ally_hit":	${"def.tk"},
      "squadman_ally_kill":	${"def.tk"},
      "squadman_ally_blowup":	${"def.tk"},
      "squadman_squadman_hit":	${"def.tk"},
      "squadman_squadman_kill":	${"def.tk"},
      "squadman_squadman_blowup":${"def.tk"},
      "squadman_enemy_hit":	${"def.en"},
      "squadman_enemy_kill":	${"def.en"},
      "squadman_enemy_blowup":	${"def.en"},
      "squadman_allytk_hit":	${"def.tk"},
      "squadman_allytk_kill":	${"def.tk"},
      "squadman_allytk_blowup":	${"def.tk"},
      "squadman_enemytk_hit":	${"def.en"},
      "squadman_enemytk_kill":	${"def.en"},
      "squadman_enemytk_blowup":${"def.en"},
      "enemy_ally_hit":		${"def.al"},
      "enemy_ally_kill":	${"def.al"},
      "enemy_ally_blowup":	${"def.al"},
      "enemy_squadman_hit":	${"def.sq"},
      "enemy_squadman_kill":	${"def.sq"},
      "enemy_squadman_blowup":	${"def.sq"},
      "enemy_enemy_hit":	${"def.en"},
      "enemy_enemy_kill":	${"def.en"},
      "enemy_enemy_blowup":	${"def.en"},
      "enemy_allytk_hit":	${"def.al"},
      "enemy_allytk_kill":	${"def.al"},
      "enemy_allytk_blowup":	${"def.al"},
      "enemy_enemytk_hit":	${"def.en"},
      "enemy_enemytk_kill":	${"def.en"},
      "enemy_enemytk_blowup":	${"def.en"},
      "unknown_ally_hit":	${"def.al"},
      "unknown_ally_kill":	${"def.al"},
      "unknown_ally_blowup":	${"def.al"},
      "unknown_squadman_hit":	${"def.sq"},
      "unknown_squadman_kill":	${"def.sq"},
      "unknown_squadman_blowup":${"def.sq"},
      "unknown_enemy_hit":	${"def.en"},
      "unknown_enemy_kill":	${"def.en"},
      "unknown_enemy_blowup":	${"def.en"},
      "unknown_allytk_hit":	${"def.al"},
      "unknown_allytk_kill":	${"def.al"},
      "unknown_allytk_blowup":	${"def.al"},
      "unknown_enemytk_hit":	${"def.en"},
      "unknown_enemytk_kill":	${"def.en"},
      "unknown_enemytk_blowup":	${"def.en"},
      "player_ally_hit":	${"def.pl"},
      "player_ally_kill":	${"def.pl"},
      "player_ally_blowup":	${"def.pl"},
      "player_squadman_hit":	${"def.pl"},
      "player_squadman_kill":	${"def.pl"},
      "player_squadman_blowup":	${"def.pl"},
      "player_enemy_hit":	${"def.pl"},
      "player_enemy_kill":	${"def.pl"},
      "player_enemy_blowup":	${"def.pl"},
      "player_allytk_hit":	${"def.pl"},
      "player_allytk_kill":	${"def.pl"},
      "player_allytk_blowup":	${"def.pl"},
      "player_enemytk_hit":	${"def.pl"},
      "player_enemytk_kill":	${"def.pl"},
      "player_enemytk_blowup":	${"def.pl"}
    },
    // Dynamic color by damage kind.
    // Динамический цвет по типу урона.
    "dmg_kind": {
      // Атака.
      "attack": "0xFFAA55",
      // Пожар.
      "fire": "0xFF6655",
      // Таран.
      "ramming": "0x998855",
      // Cтолкновение с объектами, падение.
      "world_collision": "0x228855",
      // Другое.
      "other": "0xCCCCCC"
    },
    // Dynamic color by vehicle type.
    // Динамический цвет по типу техники.
    "vtype": {
      // Цвет для легких танков.
      "LT":  "0xA2FF9A",
      // Цвет для средних танков.
      "MT":  "0xFFF198",
      // Цвет для тяжелых танков.
      "HT":  "0xFFACAC",
      // Цвет для арты.
      "SPG": "0xEFAEFF",
      // Цвет для ПТ.
      "TD":  "0xA0CFFF",
      // Цвет для премиумной техники.
      "premium": "0xFFCC66",
      // Включить/выключить использование премиумного цвета.
      "usePremiumColor": false
    },
    // Values ​​below should be from smaller to larger.
    // Значения ниже должны быть от меньшего к большему.
    // ----
    // Dynamic color by remaining absolute health.
    // Динамический цвет по оставшемуся здоровью.
    "hp": [
      { "value": 201,  "color": ${"colorHP.very_low"     } },      // Цвет для значений менее 201
      { "value": 401,  "color": ${"colorHP.low"          } },      // Цвет для значений менее 401
      { "value": 1001, "color": ${"colorHP.average"      } },      // Цвет для значений менее 1001
      { "value": 9999, "color": ${"colorHP.above_average"} }       // Цвет для остальных значений
    ],
    // Dynamic color by remaining health percent.
    // Динамический цвет по проценту оставшегося здоровья.
    "hp_ratio": [
      { "value": 10,  "color": ${"colorHP.very_low"     } },       // Цвет для значений менее 10 проц
      { "value": 25,  "color": ${"colorHP.low"          } },       // Цвет для значений менее 25 проц
      { "value": 50,  "color": ${"colorHP.average"      } },       // Цвет для значений менее 50 проц
      { "value": 101, "color": ${"colorHP.above_average"} }        // Цвет для остальных значений
    ],
    // Dynamic color for XVM Scale (only with xvm-stat).
    // Динамический цвет по шкале XVM (только с xvm-stat).
    // http://www.koreanrandom.com/forum/topic/2625-/
    "x": [
      { "value": 17,  "color": ${"colorRating.very_bad" } },   // 00   - 16.5 - very bad   (20% of players)
      { "value": 34,  "color": ${"colorRating.bad"      } },   // 16.5 - 33.5 - bad        (better then 20% of players)
      { "value": 53,  "color": ${"colorRating.normal"   } },   // 33.5 - 52.5 - normal     (better then 60% of players)
      { "value": 76,  "color": ${"colorRating.good"     } },   // 52.5 - 75.5 - good       (better then 90% of players)
      { "value": 93,  "color": ${"colorRating.very_good"} },   // 75.5 - 92.5 - very good  (better then 99% of players)
      { "value": 999, "color": ${"colorRating.unique"   } }    // 92.5 - XX   - unique     (better then 99.9% of players)
    ],
    // Dynamic color by efficiency (only with xvm-stat).
    // Динамический цвет по эффективности (только с xvm-stat).
    "eff": [
      { "value": 645,  "color": ${"colorRating.very_bad" } },  //    0 - 644  - very bad
      { "value": 875,  "color": ${"colorRating.bad"      } },  //  645 - 874  - bad
      { "value": 1155, "color": ${"colorRating.normal"   } },  //  875 - 1154 - normal
      { "value": 1470, "color": ${"colorRating.good"     } },  // 1155 - 1469 - good
      { "value": 1740, "color": ${"colorRating.very_good"} },  // 1470 - 1739 - very good
      { "value": 9999, "color": ${"colorRating.unique"   } }   // 1740 - *    - unique
    ],
    // Dynamic color by WN6 rating (only with xvm-stat).
    // Динамический цвет по рейтингу WN6 (только с xvm-stat).
    "wn": [
      { "value": 435,  "color": ${"colorRating.very_bad" } },  //    0 - 434  - very bad
      { "value": 805,  "color": ${"colorRating.bad"      } },  //  435 - 804  - bad
      { "value": 1200, "color": ${"colorRating.normal"   } },  //  805 - 1199 - normal
      { "value": 1595, "color": ${"colorRating.good"     } },  // 1200 - 1594 - good
      { "value": 1900, "color": ${"colorRating.very_good"} },  // 1595 - 1899 - very good
      { "value": 9999, "color": ${"colorRating.unique"   } }   // 1900 - *    - unique
    ],
    // Dynamic color by TEFF (E) rating (only with xvm-stat).
    // Динамический цвет по рейтингу TEFF (E) (только с xvm-stat).
    "e": [
      { "value": 0.01, "color": ${"colorRating.undefined"} },
      { "value": 2,    "color": ${"colorRating.very_bad" } },
      { "value": 4,    "color": ${"colorRating.bad"      } },
      { "value": 5,    "color": ${"colorRating.normal"   } },
      { "value": 7,    "color": ${"colorRating.good"     } },
      { "value": 9,    "color": ${"colorRating.very_good"} },
      { "value": 20,   "color": ${"colorRating.unique"   } }
    ],
    // Dynamic color by win percent (only with xvm-stat).
    // Динамический цвет по проценту побед (только с xvm-stat).
    "rating": [
      { "value": 47,  "color": ${"colorRating.very_bad" } },   //  0   - 46.5  - very bad
      { "value": 49,  "color": ${"colorRating.bad"      } },   // 46.5 - 48.5  - bad
      { "value": 52,  "color": ${"colorRating.normal"   } },   // 48.5 - 51.5  - normal
      { "value": 57,  "color": ${"colorRating.good"     } },   // 51.5 - 56.5  - good
      { "value": 64,  "color": ${"colorRating.very_good"} },   // 56.5 - 63.5  - very good
      { "value": 101, "color": ${"colorRating.unique"   } }    // 63.5 - 100   - unique
    ],
    // Dynamic color by kilo-battles (only with xvm-stat).
    // Динамический цвет по количеству кило-боев (только с xvm-stat).
    "kb": [
      { "value": 2,   "color": ${"colorRating.very_bad" } },   //  0 - 1
      { "value": 5,   "color": ${"colorRating.bad"      } },   //  2 - 4
      { "value": 9,   "color": ${"colorRating.normal"   } },   //  5 - 8
      { "value": 14,  "color": ${"colorRating.good"     } },   //  9 - 13
      { "value": 20,  "color": ${"colorRating.very_good"} },   // 14 - 19
      { "value": 999, "color": ${"colorRating.unique"   } }    // 20 - *
    ],
    // Dynamic color by battles on current tank (only with xvm-stat).
    // Динамический цвет по количеству боев на текущем танке (только с xvm-stat).
    "t_battles": [
      { "value": 100,   "color": ${"colorRating.very_bad" } }, //    0 - 99
      { "value": 250,   "color": ${"colorRating.bad"      } }, //  100 - 249
      { "value": 500,   "color": ${"colorRating.normal"   } }, //  250 - 499
      { "value": 1000,  "color": ${"colorRating.good"     } }, //  500 - 999
      { "value": 1800,  "color": ${"colorRating.very_good"} }, // 1000 - 1799
      { "value": 99999, "color": ${"colorRating.unique"   } }  // 1800 - *
    ],
    // Dynamic color by average damage on current tank (only with xvm-stat).
    // Динамический цвет по среднему урону за бой на текущем танке (только с xvm-stat).
    "tdb": [
      { "value": 1,    "color": ${"colorRating.undefined"} },
      { "value": 500,  "color": ${"colorRating.very_bad" } },
      { "value": 1000, "color": ${"colorRating.normal"   } },
      { "value": 2000, "color": ${"colorRating.good"     } }
    ],
    // Dynamic color by average damage efficiency on current tank (only with xvm-stat).
    // Динамический цвет по эффективности урона за бой на текущем танке (только с xvm-stat).
    "tdv": [
      { "value": 0.01, "color": ${"colorRating.undefined"} },
      { "value": 0.6,  "color": ${"colorRating.very_bad" } },
      { "value": 0.8,  "color": ${"colorRating.bad"      } },
      { "value": 1.0,  "color": ${"colorRating.normal"   } },
      { "value": 1.3,  "color": ${"colorRating.good"     } },
      { "value": 2.0,  "color": ${"colorRating.very_good"} },
      { "value": 15,   "color": ${"colorRating.unique"   } }
    ],
    // Dynamic color by average frags per battle on current tank (only with xvm-stat).
    // Динамический цвет по среднему количеству фрагов за бой на текущем танке (только с xvm-stat).
    "tfb": [
      { "value": 0.01, "color": ${"colorRating.undefined"} },
      { "value": 0.6,  "color": ${"colorRating.very_bad" } },
      { "value": 0.8,  "color": ${"colorRating.bad"      } },
      { "value": 1.0,  "color": ${"colorRating.normal"   } },
      { "value": 1.3,  "color": ${"colorRating.good"     } },
      { "value": 2.0,  "color": ${"colorRating.very_good"} },
      { "value": 15,   "color": ${"colorRating.unique"   } }
    ],
    // Dynamic color by number of spotted enemies per battle on current tank (only with xvm-stat).
    // Динамический цвет по среднему количеству засвеченных врагов за бой на текущем танке (только с xvm-stat).
    "tsb": [
      { "value": 0.01, "color": ${"colorRating.undefined"} },
      { "value": 0.6,  "color": ${"colorRating.very_bad" } },
      { "value": 0.8,  "color": ${"colorRating.bad"      } },
      { "value": 1.0,  "color": ${"colorRating.normal"   } },
      { "value": 1.3,  "color": ${"colorRating.good"     } },
      { "value": 2.0,  "color": ${"colorRating.very_good"} },
      { "value": 15,   "color": ${"colorRating.unique"   } }
    ]
  }
}
