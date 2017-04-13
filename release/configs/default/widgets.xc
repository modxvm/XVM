/**
 * List of widgets.
 * Список виджетов.
 */
{
  "widgets": {
    // Referenced templates:
    // * every widget can be enabled or disabled separately by "enabled" switch in their settings.
    // * extended format supported, see extra-field.txt
    // Подключенные шаблоны:
    // * виджеты можно отдельно отключать и включать с помощью "enabled" в их настройках.
    // * поддерживается расширенный формат, см. extra-field.txt
    "login": [
      ${ "widgetsTemplates.xc":"test" },
      ${ "widgetsTemplates.xc":"test2" }
    ],
    "lobby": [
      ${ "widgetsTemplates.xc":"clock" },
      ${ "widgetsTemplates.xc":"test" },
      ${ "widgetsTemplates.xc":"test2" }
    ]
  }
}
