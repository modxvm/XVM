/**
 * Options for dynamic transparency. Values ​​from smallest to largest.
 * Настройки динамической прозрачности. Значения от меньшего к большему.
 */
{
  // Dynamic transparency by various statistical parameters.
  // Динамическая прозрачность по различным статистическим показателям.
  "alphaRating": {
    "undefined":    "100",  // undefined  / неопределенно
    "very_bad":     "100",  // very bad   / очень плохо
    "bad":          "70",   // bad        / плохо
    "normal":       "40",   // normal     / средне
    "good":         "10",   // good       / хорошо
    "very_good":    "0",    // very good  / очень хорошо
    "unique":       "0"     // unique     / уникально
  },
  // Dynamic transparency by remaining health points.
  // Динамическая прозрачность по оставшемуся запасу прочности.
  "alphaHP": {
    "very_low":         "100",  // very low       / очень низкий
    "low":              "75",   // low            / низкий
    "average":          "50",   // average        / средний
    "above_average":    "0"     // above-average  / выше среднего
  },
  "alpha": {
    // Dynamic transparency by remaining health.
    // Динамическая прозрачность по оставшемуся здоровью. 
    "hp": [
      { "value": 200,  "alpha": ${"alphaHP.very_low"     } },
      { "value": 400,  "alpha": ${"alphaHP.low"          } },
      { "value": 1000, "alpha": ${"alphaHP.average"      } },
      { "value": 9999, "alpha": ${"alphaHP.above_average"} }
    ],
    // Dynamic transparency by percentage of remaining health.
    // Динамическая прозрачность по проценту оставшегося здоровья.
    "hp_ratio": [
      { "value": 10,  "alpha": ${"alphaHP.very_low"     } },
      { "value": 25,  "alpha": ${"alphaHP.low"          } },
      { "value": 50,  "alpha": ${"alphaHP.average"      } },
      { "value": 101, "alpha": ${"alphaHP.above_average"} }
    ],
    // Dynamic transparency for XVM Scale (only with xvm-stat).
    // Динамическая прозрачность по шкале XVM (только с xvm-stat).
    "x": [
      { "value": 17,  "color": ${"alphaRating.very_bad" } },
      { "value": 34,  "color": ${"alphaRating.bad"      } },
      { "value": 53,  "color": ${"alphaRating.normal"   } },
      { "value": 76,  "color": ${"alphaRating.good"     } },
      { "value": 93,  "color": ${"alphaRating.very_good"} },
      { "value": 999, "color": ${"alphaRating.unique"   } }
    ],
    // Dynamic transparency by efficiency (only with xvm-stat).
    // Динамическая прозрачность по эффективности (только с xvm-stat).
    "eff": [
      { "value": 645,  "color": ${"alphaRating.very_bad" } },
      { "value": 875,  "color": ${"alphaRating.bad"      } },
      { "value": 1155, "color": ${"alphaRating.normal"   } },
      { "value": 1470, "color": ${"alphaRating.good"     } },
      { "value": 1740, "color": ${"alphaRating.very_good"} },
      { "value": 9999, "color": ${"alphaRating.unique"   } }
    ],
    // Dynamic transparency by WN6 rating (only with xvm-stat).
    // Динамическая прозрачность по рейтингу WN6 (только с xvm-stat).
    "wn": [
      { "value": 435,  "color": ${"alphaRating.very_bad" } },
      { "value": 805,  "color": ${"alphaRating.bad"      } },
      { "value": 1200, "color": ${"alphaRating.normal"   } },
      { "value": 1595, "color": ${"alphaRating.good"     } },
      { "value": 1900, "color": ${"alphaRating.very_good"} },
      { "value": 9999, "color": ${"alphaRating.unique"   } }
    ],
    // Dynamic transparency by TEFF (E) rating (only with xvm-stat).
    // Динамическая прозрачность по рейтингу TEFF (E) (только с xvm-stat).
    "e": [
      { "value": 0.01, "color": ${"alphaRating.undefined"} },
      { "value": 2,    "color": ${"alphaRating.very_bad" } },
      { "value": 4,    "color": ${"alphaRating.bad"      } },
      { "value": 5,    "color": ${"alphaRating.normal"   } },
      { "value": 7,    "color": ${"alphaRating.good"     } },
      { "value": 9,    "color": ${"alphaRating.very_good"} },
      { "value": 20,   "color": ${"alphaRating.unique"   } }
    ],
    // Dynamic transparency by win percent (only with xvm-stat).
    // Динамическая прозрачность по проценту побед (только с xvm-stat).
    "rating": [
      { "value": 47,  "color": ${"alphaRating.very_bad" } },
      { "value": 49,  "color": ${"alphaRating.bad"      } },
      { "value": 52,  "color": ${"alphaRating.normal"   } },
      { "value": 57,  "color": ${"alphaRating.good"     } },
      { "value": 64,  "color": ${"alphaRating.very_good"} },
      { "value": 101, "color": ${"alphaRating.unique"   } }
    ],
    // Dynamic transparency by TWR (T-Calc) (only with xvm-stat).
    // Динамическая прозрачность по TWR (T-Calc) (только с xvm-stat).
    "twr": [
      { "value": 47,  "color": ${"alphaRating.very_bad" } },
      { "value": 49,  "color": ${"alphaRating.bad"      } },
      { "value": 52,  "color": ${"alphaRating.normal"   } },
      { "value": 57,  "color": ${"alphaRating.good"     } },
      { "value": 62,  "color": ${"alphaRating.very_good"} },
      { "value": 101, "color": ${"alphaRating.unique"   } }
    ],
    // Dynamic transparency by kilo-battles (only with xvm-stat).
    // Динамическая прозрачность по количеству кило-боев (только с xvm-stat).
    "kb": [
      { "value": 2,   "color": ${"alphaRating.very_bad" } },
      { "value": 5,   "color": ${"alphaRating.bad"      } },
      { "value": 9,   "color": ${"alphaRating.normal"   } },
      { "value": 14,  "color": ${"alphaRating.good"     } },
      { "value": 20,  "color": ${"alphaRating.very_good"} },
      { "value": 999, "color": ${"alphaRating.unique"   } }
    ],
    // Dynamic transparency by battles on current tank (only with xvm-stat).
    // Динамическая прозрачность по количеству боев на текущем танке (только с xvm-stat).
    "t_battles": [
      { "value": 100,   "color": ${"alphaRating.very_bad" } },
      { "value": 250,   "color": ${"alphaRating.bad"      } },
      { "value": 500,   "color": ${"alphaRating.normal"   } },
      { "value": 1000,  "color": ${"alphaRating.good"     } },
      { "value": 1800,  "color": ${"alphaRating.very_good"} },
      { "value": 99999, "color": ${"alphaRating.unique"   } }
    ],
    // Dynamic transparency by average damage on current tank (only with xvm-stat).
    // Динамическая прозрачность по среднему урону за бой на текущем танке (только с xvm-stat).
    "tdb": [
      { "value": 1,    "color": ${"alphaRating.undefined"} },
      { "value": 500,  "color": ${"alphaRating.very_bad" } },
      { "value": 1000, "color": ${"alphaRating.normal"   } },
      { "value": 2000, "color": ${"alphaRating.good"     } }
    ],
    // Dynamic transparency by average damage efficiency on current tank (only with xvm-stat).
    // Динамическая прозрачность по эффективности урона за бой на текущем танке (только с xvm-stat).
    "tdv": [
      { "value": 0.01, "color": ${"alphaRating.undefined"} },
      { "value": 0.6,  "color": ${"alphaRating.very_bad" } },
      { "value": 0.8,  "color": ${"alphaRating.bad"      } },
      { "value": 1.0,  "color": ${"alphaRating.normal"   } },
      { "value": 1.3,  "color": ${"alphaRating.good"     } },
      { "value": 2.0,  "color": ${"alphaRating.very_good"} },
      { "value": 15,   "color": ${"alphaRating.unique"   } }
    ],
    // Dynamic transparency by average frags per battle on current tank (only with xvm-stat).
    // Динамическая прозрачность по среднему количеству фрагов за бой на текущем танке (только с xvm-stat).
    "tfb": [
      { "value": 0.01, "color": ${"alphaRating.undefined"} },
      { "value": 0.6,  "color": ${"alphaRating.very_bad" } },
      { "value": 0.8,  "color": ${"alphaRating.bad"      } },
      { "value": 1.0,  "color": ${"alphaRating.normal"   } },
      { "value": 1.3,  "color": ${"alphaRating.good"     } },
      { "value": 2.0,  "color": ${"alphaRating.very_good"} },
      { "value": 15,   "color": ${"alphaRating.unique"   } }
    ],
    // Dynamic transparency by number of spotted enemies per battle on current tank (only with xvm-stat).
    // Динамическая прозрачность по среднему количеству засвеченных врагов за бой на текущем танке (только с xvm-stat).
    "tsb": [
      { "value": 0.01, "color": ${"alphaRating.undefined"} },
      { "value": 0.6,  "color": ${"alphaRating.very_bad" } },
      { "value": 0.8,  "color": ${"alphaRating.bad"      } },
      { "value": 1.0,  "color": ${"alphaRating.normal"   } },
      { "value": 1.3,  "color": ${"alphaRating.good"     } },
      { "value": 2.0,  "color": ${"alphaRating.very_good"} },
      { "value": 15,   "color": ${"alphaRating.unique"   } }
    ]
  }
}
