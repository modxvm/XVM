/**
 * Options for dynamic transparency. Values ​​from smallest to largest.
 * Настройки динамической прозрачности. Значения от меньшего к большему.
 */
{
  // Transparency values for substitutions.
  // Значения прозрачности для подстановок.
  "def": {
    // Dynamic transparency by various statistical parameters.
    // Динамическая прозрачность по различным статистическим показателям.
    "alphaRating": {
      "very_bad":      "100",  // very bad   / очень плохо
      "bad":           "70",   // bad        / плохо
      "normal":        "40",   // normal     / средне
      "good":          "10",   // good       / хорошо
      "very_good":     "0",    // very good  / очень хорошо
      "unique":        "0"     // unique     / уникально
    },
    // Dynamic transparency by remaining health points.
    // Динамическая прозрачность по оставшемуся запасу прочности.
    "alphaHP": {
      "very_low":      "100",  // very low       / очень низкий
      "low":           "75",   // low            / низкий
      "average":       "50",   // average        / средний
      "above_average": "0"     // above-average  / выше среднего
    }
  },
  "alpha": {
    // Dynamic transparency by spotted status
    // Динамическая прозрачность по статусу засвета
    "spotted": {
      "neverSeen":      100,
      "lost":           100,
      "spotted":        100,
      "dead":           100,
      "neverSeen_arty": 100,
      "lost_arty":      100,
      "spotted_arty":   100,
      "dead_arty":      100
    },
    // Dynamic transparency by remaining health.
    // Динамическая прозрачность по оставшемуся здоровью.
    "hp": [
      { "value": 200,  "alpha": ${"def.alphaHP.very_low"     } }, // alpha for HP <= 200     
      { "value": 400,  "alpha": ${"def.alphaHP.low"          } }, // alpha for HP <= 400     
      { "value": 1000, "alpha": ${"def.alphaHP.average"      } }, // alpha for HP <= 1000    
      { "value": 9999, "alpha": ${"def.alphaHP.above_average"} }  // alpha for HP > 1000     
    ],                                                                                          
    // Dynamic transparency by percentage of remaining health.                                  
    // Динамическая прозрачность по проценту оставшегося здоровья.                              
    "hp_ratio": [                                                                               
      { "value": 10.4, "alpha": ${"def.alphaHP.very_low"     } }, // alpha for HP <= 10%     
      { "value": 25.4, "alpha": ${"def.alphaHP.low"          } }, // alpha for HP <= 25%     
      { "value": 50.4, "alpha": ${"def.alphaHP.average"      } }, // alpha for HP <= 50%     
      { "value": 100,  "alpha": ${"def.alphaHP.above_average"} }  // alpha for HP > 50%      
    ],
    // Dynamic transparency for XVM Scale
    // Динамическая прозрачность по шкале XVM
    "x": [
      { "value": 16.4, "alpha": ${"def.alphaRating.very_bad" } }, // 00 - 16 - very bad  (20% of players)              
      { "value": 33.4, "alpha": ${"def.alphaRating.bad"      } }, // 17 - 33 - bad       (better than 20% of players)  
      { "value": 52.4, "alpha": ${"def.alphaRating.normal"   } }, // 34 - 52 - normal    (better than 60% of players)  
      { "value": 75.4, "alpha": ${"def.alphaRating.good"     } }, // 53 - 75 - good      (better than 90% of players)  
      { "value": 92.4, "alpha": ${"def.alphaRating.very_good"} }, // 76 - 92 - very good (better than 99% of players)  
      { "value": 999,  "alpha": ${"def.alphaRating.unique"   } }  // 93 - XX - unique    (better than 99.9% of players)
    ],
    // Dynamic transparency by efficiency (remove /* and */ to use this block)
    // Динамическая прозрачность по эффективности (чтобы использовать этот блок удалите /* и */)
    /*
    "eff": [
      { "value": 597,  "alpha": ${"def.alphaRating.very_bad" } }, //    0 - 597  - very bad  (20% of players)
      { "value": 874,  "alpha": ${"def.alphaRating.bad"      } }, //  598 - 874  - bad       (better than 20% of players)
      { "value": 1179, "alpha": ${"def.alphaRating.normal"   } }, //  875 - 1179 - normal    (better than 60% of players)
      { "value": 1540, "alpha": ${"def.alphaRating.good"     } }, // 1180 - 1540 - good      (better than 90% of players)
      { "value": 1867, "alpha": ${"def.alphaRating.very_good"} }, // 1541 - 1867 - very good (better than 99% of players)
      { "value": 9999, "alpha": ${"def.alphaRating.unique"   } }  // 1868 - *    - unique    (better than 99.9% of players)
    ],
    */
    // Dynamic transparency by WTR rating (remove /* and */ to use this block)
    // Динамическая прозрачность по рейтингу WTR (чтобы использовать этот блок удалите /* и */)
    /*
    "wtr": [
      { "value": 2671,  "alpha": ${"def.alphaRating.very_bad" } }, //    0 - 2671 - very bad  (20% of players)
      { "value": 4276,  "alpha": ${"def.alphaRating.bad"      } }, // 2672 - 4276 - bad       (better than 20% of players)
      { "value": 6123,  "alpha": ${"def.alphaRating.normal"   } }, // 4277 - 6123 - normal    (better than 60% of players)
      { "value": 8116,  "alpha": ${"def.alphaRating.good"     } }, // 6124 - 8116 - good      (better than 90% of players)
      { "value": 9496,  "alpha": ${"def.alphaRating.very_good"} }, // 8117 - 9496 - very good (better than 99% of players)
      { "value": 99999, "alpha": ${"def.alphaRating.unique"   } }  // 9497 - *    - unique    (better than 99.9% of players)
    ],
    */
    // Dynamic transparency by WN8 rating (remove /* and */ to use this block)
    // Динамическая прозрачность по рейтингу WN8 (чтобы использовать этот блок удалите /* и */)
    /*
    "wn8": [
      { "value": 411,  "alpha": ${"def.alphaRating.very_bad" } }, //    0 - 411  - very bad  (20% of players)
      { "value": 941,  "alpha": ${"def.alphaRating.bad"      } }, //  412 - 941  - bad       (better than 20% of players)
      { "value": 1536, "alpha": ${"def.alphaRating.normal"   } }, //  942 - 1536 - normal    (better than 60% of players)
      { "value": 2311, "alpha": ${"def.alphaRating.good"     } }, // 1537 - 2311 - good      (better than 90% of players)
      { "value": 3095, "alpha": ${"def.alphaRating.very_good"} }, // 2312 - 3095 - very good (better than 99% of players)
      { "value": 9999, "alpha": ${"def.alphaRating.unique"   } }  // 3096 - *    - unique    (better than 99.9% of players)
    ],
    */
    // Dynamic transparency by WG rating (remove /* and */ to use this block)
    // Динамическая прозрачность по рейтингу WG (чтобы использовать этот блок удалите /* и */)
    /*
    "wgr": [
      { "value": 2579,  "alpha": ${"def.alphaRating.very_bad" } }, //     0 - 2579  - very bad  (20% of players)
      { "value": 4525,  "alpha": ${"def.alphaRating.bad"      } }, //  2580 - 4525  - bad       (better than 20% of players)
      { "value": 6637,  "alpha": ${"def.alphaRating.normal"   } }, //  4526 - 6637  - normal    (better than 60% of players)
      { "value": 8899,  "alpha": ${"def.alphaRating.good"     } }, //  6638 - 8899  - good      (better than 90% of players)
      { "value": 10358, "alpha": ${"def.alphaRating.very_good"} }, //  8900 - 10358 - very good (better than 99% of players)
      { "value": 99999, "alpha": ${"def.alphaRating.unique"   } }  // 10359 - *     - unique    (better than 99.9% of players)
    ],
    */
    // Dynamic transparency by win percent
    // Динамическая прозрачность по проценту побед
    "winrate": [
      { "value": 46.49, "alpha": ${"def.alphaRating.very_bad" } },
      { "value": 48.49, "alpha": ${"def.alphaRating.bad"      } },
      { "value": 52.49, "alpha": ${"def.alphaRating.normal"   } },
      { "value": 57.49, "alpha": ${"def.alphaRating.good"     } },
      { "value": 64.49, "alpha": ${"def.alphaRating.very_good"} },
      { "value": 100,   "alpha": ${"def.alphaRating.unique"   } }
    ],
    // Dynamic transparency by kilo-battles
    // Динамическая прозрачность по количеству кило-боев
    "kb": [
      { "value": 2,   "alpha": ${"def.alphaRating.very_bad" } },
      { "value": 6,   "alpha": ${"def.alphaRating.bad"      } },
      { "value": 16,  "alpha": ${"def.alphaRating.normal"   } },
      { "value": 30,  "alpha": ${"def.alphaRating.good"     } },
      { "value": 43,  "alpha": ${"def.alphaRating.very_good"} },
      { "value": 999, "alpha": ${"def.alphaRating.unique"   } }
    ],
    // Dynamic transparency by average level of player tanks
    // Динамическая прозрачность по среднему уровню танков игрока
    "avglvl": [
      { "value": 1,   "alpha": ${"def.alphaRating.very_bad" } },
      { "value": 2,   "alpha": ${"def.alphaRating.bad"      } },
      { "value": 4,   "alpha": ${"def.alphaRating.normal"   } },
      { "value": 6,   "alpha": ${"def.alphaRating.good"     } },
      { "value": 8,   "alpha": ${"def.alphaRating.very_good"} },
      { "value": 10,  "alpha": ${"def.alphaRating.unique"   } }
    ],
    // Dynamic transparency by battles on current tank
    // Динамическая прозрачность по количеству боев на текущем танке
    "t_battles": [
      { "value": 99,    "alpha": ${"def.alphaRating.very_bad" } },
      { "value": 249,   "alpha": ${"def.alphaRating.bad"      } },
      { "value": 499,   "alpha": ${"def.alphaRating.normal"   } },
      { "value": 999,   "alpha": ${"def.alphaRating.good"     } },
      { "value": 1799,  "alpha": ${"def.alphaRating.very_good"} },
      { "value": 99999, "alpha": ${"def.alphaRating.unique"   } }
    ],
    // Dynamic transparency by average damage on current tank
    // Динамическая прозрачность по среднему урону за бой на текущем танке
    "tdb": [
      { "value": 499,  "alpha": ${"def.alphaRating.very_bad" } },
      { "value": 749,  "alpha": ${"def.alphaRating.bad"      } },
      { "value": 999,  "alpha": ${"def.alphaRating.normal"   } },
      { "value": 1799, "alpha": ${"def.alphaRating.good"     } },
      { "value": 2499, "alpha": ${"def.alphaRating.very_good"} },
      { "value": 9999, "alpha": ${"def.alphaRating.unique"   } }
    ],
    // Dynamic transparency by average damage efficiency on current tank
    // Динамическая прозрачность по эффективности урона за бой на текущем танке
    "tdv": [
      { "value": 0.5, "alpha": ${"def.alphaRating.very_bad" } },
      { "value": 0.7, "alpha": ${"def.alphaRating.bad"      } },
      { "value": 0.9, "alpha": ${"def.alphaRating.normal"   } },
      { "value": 1.2, "alpha": ${"def.alphaRating.good"     } },
      { "value": 1.9, "alpha": ${"def.alphaRating.very_good"} },
      { "value": 15,  "alpha": ${"def.alphaRating.unique"   } }
    ],
    // Dynamic transparency by average frags per battle on current tank
    // Динамическая прозрачность по среднему количеству фрагов за бой на текущем танке
    "tfb": [
      { "value": 0.5, "alpha": ${"def.alphaRating.very_bad" } },
      { "value": 0.7, "alpha": ${"def.alphaRating.bad"      } },
      { "value": 0.9, "alpha": ${"def.alphaRating.normal"   } },
      { "value": 1.2, "alpha": ${"def.alphaRating.good"     } },
      { "value": 1.9, "alpha": ${"def.alphaRating.very_good"} },
      { "value": 15,  "alpha": ${"def.alphaRating.unique"   } }
    ],
    // Dynamic transparency by average number of spotted enemies per battle on current tank
    // Динамическая прозрачность по среднему количеству засвеченных врагов за бой на текущем танке
    "tsb": [
      { "value": 0.5, "alpha": ${"def.alphaRating.very_bad" } },
      { "value": 0.7, "alpha": ${"def.alphaRating.bad"      } },
      { "value": 0.9, "alpha": ${"def.alphaRating.normal"   } },
      { "value": 1.2, "alpha": ${"def.alphaRating.good"     } },
      { "value": 1.9, "alpha": ${"def.alphaRating.very_good"} },
      { "value": 15,  "alpha": ${"def.alphaRating.unique"   } }
    ]
  }
}
