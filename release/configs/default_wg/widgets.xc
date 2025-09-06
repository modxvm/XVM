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
    // * поддерживается расширенный формат, см. extra-field_ru.txt
    "login": [
    ],
    "lobby": [
      ${ "widgetsTemplates.xc":"statistics" },
      ${ "widgetsTemplates.xc":"clock" }
    ]
  }
}
