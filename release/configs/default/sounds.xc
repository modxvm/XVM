/**
 * Extra sounds settings.
 * Настройки дополнительных звуков.
 * http://www.koreanrandom.com/forum/topic/18955-
 */
{
  "sounds": {
    // List of extra banks to load from folder res_mods/X.Y.Z/audioww.
    // Use semicolon for multiple values: "bank1.bnk; bank2.bnk;..."
    // Список дополнительных банков для загрузки из папки res_mods/X.Y.Z/audioww.
    // Несколько банков необходимо указывать через точку с запятой: "bank1.bnk; bank2.bnk;..."
    "soundBanks": {
      "hangar": "xvm.bnk;",
      "battle": "xvm.bnk;"
    },
    // Sound events added by XVM
    // Звуковые события, добавленные в XVM
    "events": {
      // Perk SixthSense
      // Перк Шестое чувство
      "sixthSense": "sixthsense",
      // Perk SixthSense (On vehicle Т-34-85 Rudy)
      // Перк Шестое чувство (На технике Т-34-85 Rudy)
      "sixthSenseRudy": "sixthSenseRudy",
      // Fire alert
      // Пожар
      "fireAlert": "fireAlert",
      // Damage ammoBay
      // Повреждение боеукладки
      "ammoBay": "ammoBay"
    },
    // Enable sound events logging in the xvm.log
    // Включить логгирование звуковых событий в xvm.log
    "logSoundEvents": false,
    // Sound events remapping
    // Переопределение звуковых событий
    "soundMapping": {
      // Event mapping
      // Переопределение события
      //"originalEventName": "newEventName"
      // To disable sound event use empty string for value
      // Для отключения звукового события используйте пустую строку для значения
      //"originalEventName": ""
      //
      // Disable original sixth sense light bulb sound event
      // Отключить оригинальный звук лампы шестого чувства
      "lightbulb": "",
      // Disable original fire sound event
      // Отключить оригинальный звук пожара
      "vo_fire_started": "",
      // Disable original ammo bay damaged event
      // Отключить оригинальный звук повреждения боеукладки
      "vo_ammo_bay_damaged": ""
    }
  }
}
