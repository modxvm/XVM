/**
 * UserInfo window.
 * Окно достижений.
 */
{
  "userInfo": {
    // Initial page (1, 2, 3, 4).
    // Номер начальной страницы (1, 2, 3, 4).
    "startPage": 1,
    // number of column for sorting by default. Sort order: >0 - ascending, <0 - descending
    // номер колонки для сортировки по умолчанию. Порядок сортировки: >0 - по возрастанию, <0 - по убыванию
    // 1 - Nation      / Нация
    // 2 - Type        / Тип
    // 3 - Level       / Уровень
    // 4 - Name        / Название
    // 5 - Fights      / Бои
    // 6 - Wins        / Победы
    // 7 - Average XP  / Средний опыт
    // 8 - Class mark  / Классность
    "sortColumn": -5,
    // true - Show extra data in profile (experimental)
    // true - Показывать расширенные данные в профиле (экспериментально)
    "showExtraDataInProfile": false,
    // true - Enable filter tanks in hangar by default.
    // true - включить фильтр отображения танков в ангаре по умолчанию.
    "inHangarFilterEnabled": false,
    // true - Show filters on tanks.
    // true - показывать фильтры отображения танков.
    "showFilters": true,
    // true - Set the default focus to the filter text input
    // true - Выбрать поле ввода фильтра по умолчанию
    "filterFocused": true,
    // TODO: description of the substitutions (+all, -premium, ...)
    // default value of the filter
    // значение фильтра по умолчанию
    "defaultFilterValue": ""
  }
}
