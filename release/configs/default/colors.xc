/**
 * Color settings.
 * Настройки цветов.
 */
{
  // Color values for substitutions.
  // Значения цветов для подстановок.
  "def": {
    "al": "0x96FF00", // ally       / союзник
    "sq": "0xFFB964", // squadman   / взводный
    "tk": "0x00EAFF", // teamKiller / тимкиллер
    "en": "0xF50800", // enemy      / противник
    "pl": "0xFFDD33", // player     / игрок
    // Dynamic color by various statistical parameters.
    // Динамический цвет по различным статистическим показателям.
    "colorRating": {
      "very_bad":     "0xFE0E00",   // very bad   / очень плохо
      "bad":          "0xFE7903",   // bad        / плохо
      "normal":       "0xF8F400",   // normal     / средне
      "good":         "0x60FF00",   // good       / хорошо
      "very_good":    "0x02C9B3",   // very good  / очень хорошо
      "unique":       "0xD042F3"    // unique     / уникально
    },
    // Dynamic color by remaining health points.
    // Динамический цвет по оставшемуся запасу прочности.
    "colorHP": {
      "very_low":         "0xFF0000",   // very low       / очень низкий
      "low":              "0xDD4444",   // low            / низкий
      "average":          "0xFFCC22",   // average        / средний
      "above_average":    "0xFCFCFC"    // above-average  / выше среднего
    }
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
      "ally_alive":          ${"def.al"},
      "ally_dead":           "0x009900",
      "ally_blowedup":       "0x007700",
      "squadman_alive":      ${"def.sq"},
      "squadman_dead":       "0xCA7000",
      "squadman_blowedup":   "0xA45A00",
      "teamKiller_alive":    ${"def.tk"},
      "teamKiller_dead":     "0x097783",
      "teamKiller_blowedup": "0x096A75",
      "enemy_alive":         ${"def.en"},
      "enemy_dead":          "0x840500",
      "enemy_blowedup":      "0x5A0401",
      "ally_base":           ${"def.al"},
      "enemy_base":          ${"def.en"}
    },
    // Dynamic color by damage kind.
    // Динамический цвет по типу урона.
    "dmg_kind": {
      "shot": "0xFFAA55",            // shot / попадание
      "fire": "0xFF6655",            // fire / пожар
      "ramming": "0x998855",         // ramming / таран
      "world_collision": "0x228855", // world collision / столкновение с объектами, падение
      "death_zone": "0xCCCCCC",      // death_zone / опасная зона
      "drowning": "0xCCCCCC",        // drowning / затопление
      "other": "0xCCCCCC"            // other / другое
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
    // Dynamic color by spotted status
    // Динамический цвет по статусу засвета
    "spotted": {
      "neverSeen":      "0x000000",
      "lost":           "0xD9D9D9",
      "spotted":        "0xFFBB00",
      "dead":           "0xFFFFFF",
      "neverSeen_arty": "0x000000",
      "lost_arty":      "0xD9D9D9",
      "spotted_arty":   "0xFFBB00",
      "dead_arty":      "0xFFFFFF"
    },
    // HP color depending on the ratio of ally and enemy teams hp.
    // Цвет ХП в зависимости от отношения хп союзной и вражеской команд.
    "totalHP": {
      "bad":     "0xFF0000",
      "neutral": "0xFFFFFF",
      "good":    "0x00FF00"
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
      "ally_ally_hit":              ${"def.tk"},
      "ally_ally_kill":             ${"def.tk"},
      "ally_ally_blowup":           ${"def.tk"},
      "ally_squadman_hit":          ${"def.tk"},
      "ally_squadman_kill":         ${"def.tk"},
      "ally_squadman_blowup":       ${"def.tk"},
      "ally_enemy_hit":             ${"def.en"},
      "ally_enemy_kill":            ${"def.en"},
      "ally_enemy_blowup":          ${"def.en"},
      "ally_allytk_hit":            ${"def.tk"},
      "ally_allytk_kill":           ${"def.tk"},
      "ally_allytk_blowup":         ${"def.tk"},
      "ally_enemytk_hit":           ${"def.en"},
      "ally_enemytk_kill":          ${"def.en"},
      "ally_enemytk_blowup":        ${"def.en"},
      "enemy_ally_hit":             ${"def.al"},
      "enemy_ally_kill":            ${"def.al"},
      "enemy_ally_blowup":          ${"def.al"},
      "enemy_squadman_hit":         ${"def.al"},
      "enemy_squadman_kill":        ${"def.al"},
      "enemy_squadman_blowup":      ${"def.al"},
      "enemy_enemy_hit":            ${"def.en"},
      "enemy_enemy_kill":           ${"def.en"},
      "enemy_enemy_blowup":         ${"def.en"},
      "enemy_allytk_hit":           ${"def.al"},
      "enemy_allytk_kill":          ${"def.al"},
      "enemy_allytk_blowup":        ${"def.al"},
      "enemy_enemytk_hit":          ${"def.en"},
      "enemy_enemytk_kill":         ${"def.en"},
      "enemy_enemytk_blowup":       ${"def.en"},
      "unknown_ally_hit":           ${"def.al"},
      "unknown_ally_kill":          ${"def.al"},
      "unknown_ally_blowup":        ${"def.al"},
      "unknown_squadman_hit":       ${"def.al"},
      "unknown_squadman_kill":      ${"def.al"},
      "unknown_squadman_blowup":    ${"def.al"},
      "unknown_enemy_hit":          ${"def.en"},
      "unknown_enemy_kill":         ${"def.en"},
      "unknown_enemy_blowup":       ${"def.en"},
      "unknown_allytk_hit":         ${"def.al"},
      "unknown_allytk_kill":        ${"def.al"},
      "unknown_allytk_blowup":      ${"def.al"},
      "unknown_enemytk_hit":        ${"def.en"},
      "unknown_enemytk_kill":       ${"def.en"},
      "unknown_enemytk_blowup":     ${"def.en"},
      "squadman_ally_hit":          ${"def.sq"},
      "squadman_ally_kill":         ${"def.sq"},
      "squadman_ally_blowup":       ${"def.sq"},
      "squadman_squadman_hit":      ${"def.sq"},
      "squadman_squadman_kill":     ${"def.sq"},
      "squadman_squadman_blowup":   ${"def.sq"},
      "squadman_enemy_hit":         ${"def.sq"},
      "squadman_enemy_kill":        ${"def.sq"},
      "squadman_enemy_blowup":      ${"def.sq"},
      "squadman_allytk_hit":        ${"def.sq"},
      "squadman_allytk_kill":       ${"def.sq"},
      "squadman_allytk_blowup":     ${"def.sq"},
      "squadman_enemytk_hit":       ${"def.sq"},
      "squadman_enemytk_kill":      ${"def.sq"},
      "squadman_enemytk_blowup":    ${"def.sq"},
      "player_ally_hit":            ${"def.pl"},
      "player_ally_kill":           ${"def.pl"},
      "player_ally_blowup":         ${"def.pl"},
      "player_squadman_hit":        ${"def.pl"},
      "player_squadman_kill":       ${"def.pl"},
      "player_squadman_blowup":     ${"def.pl"},
      "player_enemy_hit":           ${"def.pl"},
      "player_enemy_kill":          ${"def.pl"},
      "player_enemy_blowup":        ${"def.pl"},
      "player_allytk_hit":          ${"def.pl"},
      "player_allytk_kill":         ${"def.pl"},
      "player_allytk_blowup":       ${"def.pl"},
      "player_enemytk_hit":         ${"def.pl"},
      "player_enemytk_kill":        ${"def.pl"},
      "player_enemytk_blowup":      ${"def.pl"}
    },
    // Values below should be from smaller to larger.
    // Значения ниже должны быть от меньшего к большему.
    // ----
    // Dynamic color by remaining absolute health.
    // Динамический цвет по оставшемуся здоровью.
    "hp": [
      { "value": 200,  "color": ${"def.colorHP.very_low"     } }, // color for HP <= 200
      { "value": 400,  "color": ${"def.colorHP.low"          } }, // color for HP <= 400
      { "value": 1000, "color": ${"def.colorHP.average"      } }, // color for HP <= 1000
      { "value": 9999, "color": ${"def.colorHP.above_average"} }  // color for HP > 1000
    ],
    // Dynamic color by remaining health percent.
    // Динамический цвет по проценту оставшегося здоровья.
    "hp_ratio": [
      { "value": 10.4, "color": ${"def.colorHP.very_low"     } }, // color for HP <= 10%
      { "value": 25.4, "color": ${"def.colorHP.low"          } }, // color for HP <= 25%
      { "value": 50.4, "color": ${"def.colorHP.average"      } }, // color for HP <= 50%
      { "value": 100,  "color": ${"def.colorHP.above_average"} }  // color for HP > 50%
    ],
    // Dynamic color for XVM Scale
    // Динамический цвет по шкале XVM
    // http://www.koreanrandom.com/forum/topic/2625-/
    "x": [
      { "value": 16.4, "color": ${"def.colorRating.very_bad" } }, // 00 - 16 - very bad  (20% of players)
      { "value": 33.4, "color": ${"def.colorRating.bad"      } }, // 17 - 33 - bad       (better than 20% of players)
      { "value": 52.4, "color": ${"def.colorRating.normal"   } }, // 34 - 52 - normal    (better than 60% of players)
      { "value": 75.4, "color": ${"def.colorRating.good"     } }, // 53 - 75 - good      (better than 90% of players)
      { "value": 92.4, "color": ${"def.colorRating.very_good"} }, // 76 - 92 - very good (better than 99% of players)
      { "value": 999,  "color": ${"def.colorRating.unique"   } }  // 93 - XX - unique    (better than 99.9% of players)
    ],
    // Dynamic color by efficiency (remove /* and */ to use this block)
    // Динамический цвет по эффективности (чтобы использовать этот блок удалите /* и */)
    /*
    "eff": [
      { "value": 597,  "color": ${"def.colorRating.very_bad" } }, //    0 - 597  - very bad  (20% of players)
      { "value": 874,  "color": ${"def.colorRating.bad"      } }, //  598 - 874  - bad       (better than 20% of players)
      { "value": 1179, "color": ${"def.colorRating.normal"   } }, //  875 - 1179 - normal    (better than 60% of players)
      { "value": 1540, "color": ${"def.colorRating.good"     } }, // 1180 - 1540 - good      (better than 90% of players)
      { "value": 1867, "color": ${"def.colorRating.very_good"} }, // 1541 - 1867 - very good (better than 99% of players)
      { "value": 9999, "color": ${"def.colorRating.unique"   } }  // 1868 - *    - unique    (better than 99.9% of players)
    ],
    */
    // Dynamic color by WTR rating (remove /* and */ to use this block)
    // Динамический цвет по рейтингу WTR (чтобы использовать этот блок удалите /* и */)
    /*
    "wtr": [
      { "value": 2671,  "color": ${"def.colorRating.very_bad" } }, //    0 - 2671 - very bad  (20% of players)
      { "value": 4276,  "color": ${"def.colorRating.bad"      } }, // 2672 - 4276 - bad       (better than 20% of players)
      { "value": 6123,  "color": ${"def.colorRating.normal"   } }, // 4277 - 6123 - normal    (better than 60% of players)
      { "value": 8116,  "color": ${"def.colorRating.good"     } }, // 6124 - 8116 - good      (better than 90% of players)
      { "value": 9496,  "color": ${"def.colorRating.very_good"} }, // 8117 - 9496 - very good (better than 99% of players)
      { "value": 99999, "color": ${"def.colorRating.unique"   } }  // 9497 - *    - unique    (better than 99.9% of players)
    ],
    */
    // Dynamic color by WN8 rating (remove /* and */ to use this block)
    // Динамический цвет по рейтингу WN8 (чтобы использовать этот блок удалите /* и */)
    /*
    "wn8": [
      { "value": 411,  "color": ${"def.colorRating.very_bad" } }, //    0 - 411  - very bad  (20% of players)
      { "value": 941,  "color": ${"def.colorRating.bad"      } }, //  412 - 941  - bad       (better than 20% of players)
      { "value": 1536, "color": ${"def.colorRating.normal"   } }, //  942 - 1536 - normal    (better than 60% of players)
      { "value": 2311, "color": ${"def.colorRating.good"     } }, // 1537 - 2311 - good      (better than 90% of players)
      { "value": 3095, "color": ${"def.colorRating.very_good"} }, // 2312 - 3095 - very good (better than 99% of players)
      { "value": 9999, "color": ${"def.colorRating.unique"   } }  // 3096 - *    - unique    (better than 99.9% of players)
    ],
    */
    // Dynamic color by WG rating (remove /* and */ to use this block)
    // Динамический цвет по рейтингу WG (чтобы использовать этот блок удалите /* и */)
    /*
    "wgr": [
      { "value": 2579,  "color": ${"def.colorRating.very_bad" } }, //     0 - 2579  - very bad  (20% of players)
      { "value": 4525,  "color": ${"def.colorRating.bad"      } }, //  2580 - 4525  - bad       (better than 20% of players)
      { "value": 6637,  "color": ${"def.colorRating.normal"   } }, //  4526 - 6637  - normal    (better than 60% of players)
      { "value": 8899,  "color": ${"def.colorRating.good"     } }, //  6638 - 8899  - good      (better than 90% of players)
      { "value": 10358, "color": ${"def.colorRating.very_good"} }, //  8900 - 10358 - very good (better than 99% of players)
      { "value": 99999, "color": ${"def.colorRating.unique"   } }  // 10359 - *     - unique    (better than 99.9% of players)
    ],
    */
    // Dynamic color by win percent
    // Динамический цвет по проценту побед
    "winrate": [
      { "value": 46.49, "color": ${"def.colorRating.very_bad" } }, //  0   - 46.5  - very bad  (20% of players)
      { "value": 48.49, "color": ${"def.colorRating.bad"      } }, // 46.5 - 48.5  - bad       (better than 20% of players)
      { "value": 52.49, "color": ${"def.colorRating.normal"   } }, // 48.5 - 52.5  - normal    (better than 60% of players)
      { "value": 57.49, "color": ${"def.colorRating.good"     } }, // 52.5 - 57.5  - good      (better than 90% of players)
      { "value": 64.49, "color": ${"def.colorRating.very_good"} }, // 57.5 - 64.5  - very good (better than 99% of players)
      { "value": 100,  "color": ${"def.colorRating.unique"   } }  // 64.5 - 100   - unique    (better than 99.9% of players)
    ],
    // Dynamic color by kilo-battles
    // Динамический цвет по количеству кило-боев
    "kb": [
      { "value": 2,   "color": ${"def.colorRating.very_bad" } },  //  0 - 2
      { "value": 6,   "color": ${"def.colorRating.bad"      } },  //  3 - 6
      { "value": 16,  "color": ${"def.colorRating.normal"   } },  //  7 - 16
      { "value": 30,  "color": ${"def.colorRating.good"     } },  // 17 - 30
      { "value": 43,  "color": ${"def.colorRating.very_good"} },  // 31 - 43
      { "value": 999, "color": ${"def.colorRating.unique"   } }   // 44 - *
    ],
    // Dynamic color by average level of player tanks
    // Динамический цвет по среднему уровню танков игрока
    "avglvl": [
      { "value": 1,  "color": ${"def.colorRating.very_bad" } },
      { "value": 2,  "color": ${"def.colorRating.bad"      } },
      { "value": 4,  "color": ${"def.colorRating.normal"   } },
      { "value": 6,  "color": ${"def.colorRating.good"     } },
      { "value": 8,  "color": ${"def.colorRating.very_good"} },
      { "value": 10, "color": ${"def.colorRating.unique"   } }
    ],
    // Dynamic color by battles on current tank
    // Динамический цвет по количеству боев на текущем танке
    "t_battles": [
      { "value": 99,    "color": ${"def.colorRating.very_bad" } }, //    0 - 99
      { "value": 249,   "color": ${"def.colorRating.bad"      } }, //  100 - 249
      { "value": 499,   "color": ${"def.colorRating.normal"   } }, //  250 - 499
      { "value": 999,   "color": ${"def.colorRating.good"     } }, //  500 - 999
      { "value": 1799,  "color": ${"def.colorRating.very_good"} }, // 1000 - 1799
      { "value": 99999, "color": ${"def.colorRating.unique"   } }  // 1800 - *
    ],
    // Dynamic color by average damage on current tank
    // Динамический цвет по среднему урону за бой на текущем танке
    "tdb": [
      { "value": 499,  "color": ${"def.colorRating.very_bad" } },
      { "value": 749,  "color": ${"def.colorRating.bad"      } },
      { "value": 999,  "color": ${"def.colorRating.normal"   } },
      { "value": 1799, "color": ${"def.colorRating.good"     } },
      { "value": 2499, "color": ${"def.colorRating.very_good"} },
      { "value": 9999, "color": ${"def.colorRating.unique"   } }
    ],
    // Dynamic color by average damage efficiency on current tank
    // Динамический цвет по эффективности урона за бой на текущем танке
    "tdv": [
      { "value": 0.5, "color": ${"def.colorRating.very_bad" } },
      { "value": 0.7, "color": ${"def.colorRating.bad"      } },
      { "value": 0.9, "color": ${"def.colorRating.normal"   } },
      { "value": 1.2, "color": ${"def.colorRating.good"     } },
      { "value": 1.9, "color": ${"def.colorRating.very_good"} },
      { "value": 15,  "color": ${"def.colorRating.unique"   } }
    ],
    // Dynamic color by average frags per battle on current tank
    // Динамический цвет по среднему количеству фрагов за бой на текущем танке
    "tfb": [
      { "value": 0.5, "color": ${"def.colorRating.very_bad" } },
      { "value": 0.7, "color": ${"def.colorRating.bad"      } },
      { "value": 0.9, "color": ${"def.colorRating.normal"   } },
      { "value": 1.2, "color": ${"def.colorRating.good"     } },
      { "value": 1.9, "color": ${"def.colorRating.very_good"} },
      { "value": 15,  "color": ${"def.colorRating.unique"   } }
    ],
    // Dynamic color by average number of spotted enemies per battle on current tank
    // Динамический цвет по среднему количеству засвеченных врагов за бой на текущем танке
    "tsb": [
      { "value": 0.5, "color": ${"def.colorRating.very_bad" } },
      { "value": 0.7, "color": ${"def.colorRating.bad"      } },
      { "value": 0.9, "color": ${"def.colorRating.normal"   } },
      { "value": 1.2, "color": ${"def.colorRating.good"     } },
      { "value": 1.9, "color": ${"def.colorRating.very_good"} },
      { "value": 15,  "color": ${"def.colorRating.unique"   } }
    ],
    // Dynamic color by WN8 effective damage
    // Динамический цвет по эффективному урону по WN8
    "wn8effd": [
      { "value": 0.5, "color": ${"def.colorRating.very_bad" } },
      { "value": 0.7, "color": ${"def.colorRating.bad"      } },
      { "value": 0.9, "color": ${"def.colorRating.normal"   } },
      { "value": 1.2, "color": ${"def.colorRating.good"     } },
      { "value": 1.9, "color": ${"def.colorRating.very_good"} },
      { "value": 15,  "color": ${"def.colorRating.unique"   } }
    ],
    // Dynamic color by damage rating (percents for marks on gun)
    // Динамический цвет по рейтингу урона (процент для отметок на стволе)
    "damageRating": [
      { "value": 64.99, "color": ${"def.colorRating.very_bad"} }, // 0-64.99
      { "value": 84.99, "color": ${"def.colorRating.normal"  } }, // 65-84.99
      { "value": 94.99, "color": ${"def.colorRating.good"    } }, // 85-94.99
      { "value": 100,   "color": ${"def.colorRating.unique"  } }  // 95-*
    ],
    // Dynamic color by hit ratio (percents of hits)
    // Динамический цвет по проценту попаданий
    "hitsRatio": [
      { "value": 47.4, "color": ${"def.colorRating.very_bad" } },
      { "value": 60.4, "color": ${"def.colorRating.bad"      } },
      { "value": 68.4, "color": ${"def.colorRating.normal"   } },
      { "value": 74.4, "color": ${"def.colorRating.good"     } },
      { "value": 78.4, "color": ${"def.colorRating.very_good"} },
      { "value": 100,  "color": ${"def.colorRating.unique"   } }
    ]
  }
}
