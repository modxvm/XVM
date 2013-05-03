/**
 * Options for dynamic transparency. Values ​​from smallest to largest.
 * Настройки динамической прозрачности. Значения от меньшего к большему.
 */
{
  "alpha": {
    // Dynamic transparency by remaining health.
    // Динамическая прозрачность по оставшемуся здоровью. 
    "hp": [
      { "value": 200,  "alpha": 100 },
      { "value": 400,  "alpha": 80 },
      { "value": 1000, "alpha": 60 },
      { "value": 9999, "alpha": 40 }
    ],
    // Dynamic transparency by percentage of remaining health.
    // Динамическая прозрачность по проценту оставшегося здоровья.
    "hp_ratio": [
      { "value": 10,  "alpha": 100 },
      { "value": 25,  "alpha": 80 },
      { "value": 50,  "alpha": 60 },
      { "value": 101, "alpha": 40 }
    ],
    // Dynamic transparency by effectiveness (only with xvm-stat).
    // Динамическая прозрачность по эффективности (только с xvm-stat).
    "eff": [
      { "value": 900,  "alpha": 100 },
      { "value": 1200, "alpha": 100 },
      { "value": 9999, "alpha": 100 }
    ],
    // Dynamic transparency by victory percentage (only with xvm-stat).
    // Динамическая прозрачность по проценту побед (только с xvm-stat).
    "rating": [
      { "value": 49,  "alpha": 100 },
      { "value": 53,  "alpha": 100 },
      { "value": 101, "alpha": 100 }
    ],
    // Dynamic transparency by the number of thousands of battles ("kilo-battles") (only with xvm-stat).
    // Динамическая прозрачность по количеству кило-боев (только с xvm-stat).
    "kb": [
      { "value": 2,   "alpha": 100 },
      { "value": 10,  "alpha": 100 },
      { "value": 999, "alpha": 100 }
    ]
  }
}
