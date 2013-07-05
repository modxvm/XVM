/**
 * Options for dynamic transparency. Values ​​from smallest to largest.
 * Настройки динамической прозрачности. Значения от меньшего к большему.
 */
{
  "alpha": {
    // Dynamic transparency by remaining health.
    // Динамическая прозрачность по оставшемуся здоровью. 
    "hp": [
      { "value": 200,  "alpha": 100 },    // Прозрачность для значений менее 200
      { "value": 400,  "alpha": 100 },    // Прозрачность для значений менее 400
      { "value": 1000, "alpha": 100 },   // Прозрачность для значений менее 1000
      { "value": 9999, "alpha": 100 }    // Прозрачность для остальных значений
    ],
    // Dynamic transparency by percentage of remaining health.
    // Динамическая прозрачность по проценту оставшегося здоровья.
    "hp_ratio": [
      { "value": 25,  "alpha": 100 },    // Прозрачность для значений менее 25 процентов
      { "value": 101, "alpha": 0 }        // Прозрачность для остальных значений
    ],
    // Dynamic transparency for XVM Scale (only with xvm-stat).
    // Динамическая прозрачность по шкале XVM (только с xvm-stat).
    "x": [
      { "value": 17,  "alpha": 100 },   // 00   - 16.5 - bad   (20% of players)
      { "value": 34,  "alpha": 100 },   // 16.5 - 33.5 - below average   (better then 20% of players)
      { "value": 53,  "alpha": 100 },   // 33.5 - 52.5 - normal     (better then 60% of players)
      { "value": 76,  "alpha": 100 },   // 52.5 - 75.5 - good       (better then 90% of players)
      { "value": 93,  "alpha": 100 },   // 75.5 - 92.5 - very good  (better then 99% of players)
      { "value": 999, "alpha": 100 }   // 92.5 - XX   - skillfully     (better then 99.9% of players)
    ],
    // Dynamic transparency by efficiency (only with xvm-stat).
    // Динамическая прозрачность по эффективности (только с xvm-stat).
    "eff": [
      { "value": 645,  "alpha": 100 },    //    0 - 644  - bad
      { "value": 875,  "alpha": 100 },    //  645 - 874  - below average
      { "value": 1155, "alpha": 100 },   //  875 - 1154 - normal
      { "value": 1470, "alpha": 100 },   // 1155 - 1469 - good
      { "value": 1740, "alpha": 100 },   // 1470 - 1739 - very good
      { "value": 9999, "alpha": 100 }    // 1740 - *    - skillfully
    ],
    // Dynamic transparency by WN6 rating (only with xvm-stat).
    // Динамическая прозрачность по рейтингу WN6 (только с xvm-stat).
    "wn": [
      { "value": 435,  "alpha": 100 },    //    0 - 434  - bad
      { "value": 805,  "alpha": 100 },    //  435 - 804  - below average
      { "value": 1200, "alpha": 100 },   //  805 - 1199 - normal
      { "value": 1595, "alpha": 100 },   // 1200 - 1594 - good
      { "value": 1900, "alpha": 100 },   // 1595 - 1899 - very good
      { "value": 9999, "alpha": 100 }    // 1900 - *    - skillfully
    ],
    // Dynamic transparency by TEFF (E) rating (only with xvm-stat).
    // Динамическая прозрачность по рейтингу TEFF (E) (только с xvm-stat).
    "e": [
      { "value": 0.01, "alpha": 100 },    // 0- undefined		/ статистика недоступна
      { "value": 3,    "alpha": 100 },      // 1-2- bad		/ владеет танком плохо
      { "value": 4,    "alpha": 100 },      // 3- below average	/ владеет танком ниже среднего
      { "value": 6,    "alpha": 100 },      // 4-5- normal		/ владеет танком средне
      { "value": 7,    "alpha": 100 },      // 6- good			/ владеет танком хорошо
      { "value": 9,    "alpha": 100 },      // 7-8- very good	/ владеет танком очень хорошо
      { "value": 20,   "alpha": 100 }      // 9-10- skillfully	/ владеет танком мастерски
    ],
    // Dynamic transparency by win percent (only with xvm-stat).
    // Динамическая прозрачность по проценту побед (только с xvm-stat).
    "rating": [
      { "value": 47,  "alpha": 100 },	//  0   - 46.5  - bad
      { "value": 49,  "alpha": 100 },	// 46.5 - 48.5  - below average
      { "value": 52,  "alpha": 100 },	// 48.5 - 51.5  - normal
      { "value": 57,  "alpha": 100 },	// 51.5 - 56.5  - good
      { "value": 64,  "alpha": 100 },	// 56.5 - 63.5  - very good
      { "value": 101, "alpha": 100 }	// 63.5 - 100   - skillfully
    ],
    // Dynamic transparency by TWR (T-Calc) (only with xvm-stat).
    // Динамическая прозрачность по TWR (T-Calc) (только с xvm-stat).
    "twr": [
      { "value": 47,  "alpha": 100 },	//  0   - 46.5  - bad
      { "value": 49,  "alpha": 100 },	// 46.5 - 48.5  - below average
      { "value": 52,  "alpha": 100 },	// 48.5 - 51.5  - normal
      { "value": 57,  "alpha": 100 },	// 51.5 - 56.5  - good
      { "value": 62,  "alpha": 100 },	// 56.5 - 61.5  - very good
      { "value": 101, "alpha": 100 }	// 61.5 - 100   - skillfully
    ],
    // Dynamic transparency by kilo-battles (only with xvm-stat).
    // Динамическая прозрачность по количеству кило-боев (только с xvm-stat).
    "kb": [
      { "value": 1.5,   "alpha": 100 },    //  0 - 1.5
      { "value": 4.5,   "alpha": 100 },    //  1.5 - 4.5
      { "value": 8.5,   "alpha": 100 },    //  4.5 - 8.5
      { "value": 13.5,  "alpha": 100 },   //  8.5 - 13.5
      { "value": 19.5,  "alpha": 100 },   // 13.5 - 19.5
      { "value": 999,   "alpha": 100 }    // 19.5 - *
    ],
    // Dynamic transparency by battles on current tank (only with xvm-stat).
    // Динамическая прозрачность по количеству боев на текущем танке (только с xvm-stat).
    "t_battles": [
      { "value": 150,   "alpha": 100 },    //  0h - 1.5h
      { "value": 350,   "alpha": 100 },    //  1.5h - 3.5h
      { "value": 650,   "alpha": 100 },    //  3.5h - 6.5h
      { "value": 1050,  "alpha": 100 },   //  6.5h - 10.5h
      { "value": 1750,  "alpha": 100 },   // 10.5h - 17.5h
      { "value": 99999, "alpha": 100 }   // 17.5h - *
    ],
    // Dynamic transparency by average damage on current tank (only with xvm-stat).
    // Динамическая прозрачность по среднему урону за бой на текущем танке (только с xvm-stat).
    "tdb": [
      { "value": 1,      "alpha": 100 },
      { "value": 500,   "alpha": 100 },
      { "value": 1000, "alpha": 100 },
      { "value": 2000, "alpha": 100 }
    ],
    // Dynamic transparency by average damage efficiency on current tank (only with xvm-stat).
    // Динамическая прозрачность по эффективности урона за бой на текущем танке (только с xvm-stat).
    "tdv": [
      { "value": 0.01, "alpha": 100 },
      { "value": 0.6,  "alpha": 100 },
      { "value": 0.8,  "alpha": 100 },
      { "value": 1.0,  "alpha": 100 },
      { "value": 1.3,  "alpha": 100 },
      { "value": 2.0,  "alpha": 100 },
      { "value": 15,   "alpha": 100 }
    ],
    // Dynamic transparency by average frags per battle on current tank (only with xvm-stat).
    // Динамическая прозрачность по среднему количеству фрагов за бой на текущем танке (только с xvm-stat).
    "tfb": [
      { "value": 0.01, "alpha": 100 },
      { "value": 0.6,  "alpha": 100 },
      { "value": 0.8,  "alpha": 100 },
      { "value": 1.0,  "alpha": 100 },
      { "value": 1.3,  "alpha": 100 },
      { "value": 2.0,  "alpha": 100 },
      { "value": 15,   "alpha": 100 }
    ],
    // Dynamic transparency by number of spotted enemies per battle on current tank (only with xvm-stat).
    // Динамическая прозрачность по среднему количеству засвеченных врагов за бой на текущем танке (только с xvm-stat).
    "tsb": [
      { "value": 0.01, "alpha": 100 },
      { "value": 0.6,  "alpha": 100 },
      { "value": 0.8,  "alpha": 100 },
      { "value": 1.0,  "alpha": 100 },
      { "value": 1.3,  "alpha": 100 },
      { "value": 2.0,  "alpha": 100 },
      { "value": 15,   "alpha": 100 }
    ]
  }
}