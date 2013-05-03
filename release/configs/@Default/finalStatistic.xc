/**
 * Parameters of the After Battle Screen.
 * Параметры окна послебоевой статистики.
 */
{
  "finalStatistic": {
    // Initial page (1, 2, 3).
    // Номер начальной страницы (1, 2, 3).
    "startPage": 1,
    // Number of column for sorting (1 - 7).
    // Номер колонки для сортировки (1 - 7).
    // 1 - squad        / взвод;
    // 2 - player name  / имя игрока;
    // 3 - vehicle name / модель танка;
    // 4 - damage       / урон нанесенный за бой;
    // 5 - frags        / фраги за бой;
    // 6 - experience   / опыт за бой;
    // 7 - medals       / медали за бой.
    "sortColumn": 6,
    // true - Enable display of "chance to win" (only with xvm-stat).
    // true - включить отображение шансов на победу (только с xvm-stat).
    "showChances": false,
    // true - Enable display of experimental "chance to win" formula
    // true - включить отображение экспериментальной формулы расчета шансов.
    "showChancesExp": false
  }
}
