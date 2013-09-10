/**
 * Options for player statistics (only with xvm-stat).
 * Блок управлением статистикой (только с xvm-stat).
 */
{
  "rating": {
    // true - Toggle player statistics on/off. Global setting - without the statistics module, this is always disabled.
    // true - включить отображение статистики. Глобальный переключатель - без него модуль статистики будет везде отключен.
    "showPlayersStatistics": false,
    // true - Enable statistics in the user info window.
    // true - включить отображение статистики в достижениях пользователя.
    "enableUserInfoStatistics": true,
    // true - Enable statistics in the company window.
    // true - включить отображение статистики при наборе роты.
    "enableCompanyStatistics": true,
    // true - Enable downloading of data on opponents in the "fog of war".
    // true - включить загрузку данных по противникам в "тумане войны".
    "loadEnemyStatsInFogOfWar": true,
    // true - Enable saving statistics to "xvm-stat.log" file.
    // true - включить сохранение статистики в файл "xvm-stat.log".
    "enableStatisticsLog": false
  }
}
