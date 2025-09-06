/**
 * Extra sounds settings.
 * Настройки дополнительных звуков.
 *
 * https://kr.cm/f/t/18955/
 */
{
  "sounds": {
    "enabled": true,
    // true - to enable remote communication between WoT client and WWISE Authoring Tools.
    // true - для включения коммуникации между клиентом WoT и WWISE Authoring Tools.
    "remote_communication": false,
    // List of extra banks to load.
    // Use comma for multiple values: ["bank1.bnk", "bank2.bnk"]. Path is relative to ./res_mods/x.x.x/audioww/
    // You can use xvm:// (path relative to /res_mods/mods/shared_resources/xvm/ ) and cfg:// (path relative to /res_mods/configs/xvm/ )
    // Список дополнительных банков для загрузки.
    // Несколько банков необходимо указывать через запятую: ["bank1.bnk", "bank2.bnk"]. Путь относителен к ./res_mods/x.x.x/audioww/
    // Разрешено использование xvm:// (путь относительно /res_mods/mods/shared_resources/xvm/ ) и cfg:// (относительно /res_mods/configs/xvm/ )
    "soundBanks": {
      "battle": ["xvm://audioww/xvm.bnk"],
      "hangar": ["xvm://audioww/xvm.bnk"]
    },
    // Enable sound events logging in the xvm.log
    // Включить логирование звуковых событий в xvm.log
    "logSoundEvents": false,
    // Sound events remapping.
    // Переопределение звуковых событий.
    "soundMapping": {
      // Event mapping.
      // Переопределение события.
      //"originalEventName": "newEventName"
      // To disable sound event use empty string for value.
      // Для отключения звукового события используйте пустую строку для значения.
      //"originalEventName": ""
      //
      // Disable original sixth sense light bulb sound event (Variant 1, Variant 2, User sound).
      // Отключить оригинальный звук лампы шестого чувства (Вариант 1, Вариант 2, Пользовательский).
      "lightbulb": "",
      "lightbulb_02": "",
      "sixthSense": "",
      // 
      // Disable original sixth sense light bulb unspotted sound event on Lesta (Variant 1, Variant 2, User sound).
      // Отключить оригинальный звук выхода из засвета лампы шестого чувства на Lesta (Вариант 1, Вариант 2, Пользовательский).
      // "lightbulb_off": "",
      // "lightbulb_02_off": "",
      // "sixthSense_off": "",
      //
      // Disable original enemy detection event.
      // Отключить оригинальный звук обнаружения противника.
      //"enemy_sighted_for_team": "",
      //
      // Disable original fire sound event.
      // Отключить оригинальный звук пожара.
      //"vo_fire_started": "",
      //
      // Disable original ammo bay damaged event.
      // Отключить оригинальный звук повреждения боеукладки.
      //"vo_ammo_bay_damaged": "",
      //
      // Disable original notifications informing about the imminent end of the battle event.
      // Отключить оригинальный звук оповещения сообщающий о скором завершении боя.
      //"time_buzzer_01": "",
      //"time_buzzer_02": "",
      //
      // Sound events added by XVM.
      // Звуковые события, добавленные в XVM.
      //
      // Sixth sense perk.
      // Перк Шестое чувство.
      "xvm_sixthSense": "xvm_sixthSense",
      // Sixth sense perk for Т-34-85 Rudy.
      // Перк Шестое чувство для Т-34-85 Rudy.
      "xvm_sixthSenseRudy": "xvm_sixthSenseRudy",
      // Enemy detection (Use in together with disable original enemy detection event).
      // Обнаружение противника (Используйте вместе с отключением оригинального звука обнаружения противника).
      "xvm_enemySighted": "",
      //"xvm_enemySighted": "xvm_enemySighted",
      // Fire alert (Use in together with disable original event).
      // Пожар (Используйте вместе с отключением оригинального звука).
      //"xvm_fireAlert": "",
      "xvm_fireAlert": "xvm_fireAlert",
      // Damage ammoBay (Use in together with disable original event).
      // Повреждение боеукладки (Используйте вместе с отключением оригинального звука).
      //"xvm_ammoBay": "",
      "xvm_ammoBay": "xvm_ammoBay",
      // The sound of the end of recharging the gun.
      // Озвучка окончания перезарядки орудия.
      "xvm_gunReloaded": "",
      //"xvm_gunReloaded": "xvm_gunReloaded",
      // Notifications informing about the imminent end of the battle (Use in together with disable original event).
      // Оповещения сообщающие о скором завершении боя (Используйте вместе с отключением оригинального звука).
      "xvm_battleEnd_5_min": "",
      //"xvm_battleEnd_5_min": "xvm_battleEnd_5_min",
      "xvm_battleEnd_3_min": "",
      //"xvm_battleEnd_3_min": "xvm_battleEnd_3_min",
      "xvm_battleEnd_2_min": "",
      //"xvm_battleEnd_2_min": "xvm_battleEnd_2_min",
      "xvm_battleEnd_1_min": "",
      //"xvm_battleEnd_1_min": "xvm_battleEnd_1_min",
      "xvm_battleEnd_30_sec": "",
      //"xvm_battleEnd_30_sec": "xvm_battleEnd_30_sec",
      "xvm_battleEnd_5_sec": ""
      //"xvm_battleEnd_5_sec": "xvm_battleEnd_5_sec"
    }
  }
}
