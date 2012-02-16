Параметры конфига XVM.xvmconf:

battle
  disableMirroredVehicleIcons: true  - отключить зеркалирование иконок танков (полезно
                                       для альтернативных иконок)
  showPostmortemTips:          false - отключить всплывающую внизу панель после смерти
  drawGrid:                    true  - включить отображение сетки координат (может быть
                                       полезным для настройки)

rating
  showPlayersStatistics:       true  - включить отображение статистики. Глобальный
                                       переключатель - без него модуль статистики будет
                                       везде отключен.
  showAtBattleLoading:         false - отключить отображение статистики в окне загрузки боя
  showAtLargePlayersPanel:     false - отключить отображение статистики в широких ушах
  colorizeMiddlePlayersPanel:  false - отключить подсветку ников в зависимости от рейтинга
                                       в средних ушах
  showAtStatisticForm:         false - отключить отображение статистики в окне статистики
                                       боя (по клавише Tab)


Возможности, недоступные из редактора (OTMData.xml):

- если атрибут color у какого-то тэга отсутствует, мод использует цвет клиента
  по умолчанию для этого типа маркера (в т.ч. отдельные цвета для взводных / ТК);

- атрибут lcolor тега fill задаёт цветовой переход для полоски здоровья;

- тэг battle/showPostMortemTips позволяет отключить панель, всплывающую при уничтожении танка.
  <battle>
    <showPostmortemTips>false</showPostmortemTips>
  </battle>

- тэг rating/showPlayersStatistics позволяет включить отображение статистики в infoText (см. ниже).
  <rating>
    <showPlayersStatistics>true</showPlayersStatistics>
  </rating>

- тэг combatScrollText/hitKind позволяет переключить отображение всплывающих повреждений
  в режим показа процентов
  <combatScrollText>
    <hitKind>Relative</hitKind>

- тэг combatScrollText/font позволяет задать свой шрифт для вылетающего дамага

- атрибуты healthRatio/format/@font, playerName/format/@font, vehicleName/format/@font,
  currentHealth/format/@font позволяют задать свой шрифт для соответствующих строк

- тег components/*/infoText задаёт формат текстовых строк по умолчанию (аналогично
  components/*/currentHealth), тэг behavior/*/*/*/infoText задаёт положение и содержимое
  текстовых строк.
  Используемые макросы:
    {{hp}}         - текущее здоровье
    {{hp-ratio}}   - процент текущего здоровья
    {{hp-max}}     - максимальное здоровье
    {{nick}}       - ник игрока
    {{vehicle}}    - название танка
  Статистика (необходимо включить rating/showPlayersStatistics):
    {{rating}}     - процент побед
    {{eff}}        - эффективность игрока
    {{kb}}         - количество кило-боев (округление количества боев до 1000).
    {{battles}}    - количество боев
    {{wins}}       - количество побед
