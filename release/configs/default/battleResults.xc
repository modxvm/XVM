/**
 * Parameters of the After Battle Screen.
 * Параметры окна послебоевой статистики.
 */
{
  "battleResults": {
    // Initial page (1, 2, 3).
    // Номер начальной страницы (1, 2, 3).
    "startPage": 1,
    // true - display total experience in first page.
    // true - отображать общий полученный опыт на первой странице.
    "showTotalExperience": true,
    // true - display crew experience in first page.
    // true - отображать опыт экипажа на первой странице.
    "showCrewExperience": false,
    // true - display net income of credits in first page.
    // true - отображать чистый доход на первой странице.
    "showNetIncome": true,
    // true - display shots precision and damage in first page under credits and XP.
    // true - отображать процент попаданий и урон на первой странице, под кредитами и опытом.
    "showExtendedInfo": true,
    // true - display standard interface for the "FrontLine" mode.
    // true - отображать стандартный интерфейс для режима "Линия фронта".
    "showStandardFrontLineInterface": true,
    // Customize "Manageable bonus to experience" panel.
    // Настройка панели "Управляемый бонус к опыту".
    "bonusState": {
      // false - disable.
      // false - отключить.
      "enabled": true,
      // Offset panel of X axis.
      // Смещение панели по оси X.
      "offsetX": 25,
      // Offset panel of Y axis.
      // Смещение панели по оси Y.
      "offsetY": 60,
      // Panel background transparency, in percents.
      // 0 - transparent, 100 - opaque.
      // Прозрачность подложки панели, в процентах.
      // 0 - прозрачная, 100 - не прозрачная.
      "backgroundAlpha": 70
    }
  }
}
