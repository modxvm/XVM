/**
 * Color settings for damage.
 * Настройки цвета для урона.
 */
{
  "damage": {
      // Format: src_dst_type.
      // Src:  ally, squadman, enemy, unknown, player.
      // Dst:  ally, squadman, allytk, enemytk, enemy.
      // Type: hit, kill, blowup.
      // ----
      // Формат: источник_получатель_тип.
      // Источник:   ally - союзник, squadman - взводный, enemy - противник, unknown - неизвестный (не виден игроку), player - игрок.
      // Получатель: ally, squadman, enemy, allytk - союзник тимкиллер, enemytk - противник тимкиллер.
      // Тип:        hit - попадание, kill - убийство, blowup - боеукладка.
      "ally_ally_hit": "0x00CCFF",                         // "teamKiller"
      "ally_ally_kill": "0x00EAFF",                         // "teamKiller"
      "ally_ally_blowup": "0x00EAFF",                   // "teamKiller"
      "ally_squadman_hit": "0x00CCFF",               // "teamKiller"
      "ally_squadman_kill": "0x00EAFF",               // "teamKiller"
      "ally_squadman_blowup": "0x00EAFF",        // "teamKiller"
      "ally_enemy_hit": "0xFE0E00",                      // "enemy"
      "ally_enemy_kill": "0xFE0E00",                     // "enemy"
      "ally_enemy_blowup": "0xFE0E00",               // "enemy"
      "ally_allytk_hit": "0x00CCFF",                       // "teamKiller"
      "ally_allytk_kill": "0x00EAFF",                      // "teamKiller"
      "ally_allytk_blowup": "0x00EAFF",                // "teamKiller"
      "ally_enemytk_hit": "0xFE0E00",                   // "enemy"
      "ally_enemytk_kill": "0xFE0E00",                  // "enemy"
      "ally_enemytk_blowup": "0xFE0E00",            // "enemy"
      "squadman_ally_hit": "0x00EAFF",               // "teamKiller"
      "squadman_ally_kill": "0x00EAFF",               // "teamKiller"
      "squadman_ally_blowup": "0x00EAFF",        // "teamKiller"
      "squadman_squadman_hit": "0x00EAFF",           // "teamKiller"
      "squadman_squadman_kill": "0x00EAFF",           // "teamKiller"
      "squadman_squadman_blowup": "0x00EAFF",    // "teamKiller"
      "squadman_enemy_hit": "0xFF914C",           // "enemy" *
      "squadman_enemy_kill": "0xFF914C",           // "enemy" *
      "squadman_enemy_blowup": "0xFF914C",    // "enemy" *
      "squadman_allytk_hit": "0x00EAFF",            // "teamKiller"
      "squadman_allytk_kill": "0x00EAFF",            // "teamKiller"
      "squadman_allytk_blowup": "0x00EAFF",     // "teamKiller"
      "squadman_enemytk_hit": "0xFF914C",        // "enemy" *
      "squadman_enemytk_kill": "0xFF914C",       // "enemy" *
      "squadman_enemytk_blowup": "0xFF914C", // "enemy" *
      "enemy_ally_hit": "0x36AD00",                     // "ally"
      "enemy_ally_kill": "0x60FF00",                     // "ally"
      "enemy_ally_blowup": "0x60FF00",               // "ally"
      "enemy_squadman_hit": "0xFF7D2E",           // "squadman"
      "enemy_squadman_kill": "0xFF914C",          // "squadman"
      "enemy_squadman_blowup": "0xFF914C",    // "squadman"
      "enemy_enemy_hit": "0xFE0E00",                  // "enemy"
      "enemy_enemy_kill": "0xFE0E00",                 // "enemy"
      "enemy_enemy_blowup": "0xFE0E00",           // "enemy"
      "enemy_allytk_hit": "0x36AD00",                  // "ally"
      "enemy_allytk_kill": "0x60FF00",                   // "ally"
      "enemy_allytk_blowup": "0x60FF00",            // "ally"
      "enemy_enemytk_hit": "0xFE0E00",               // "enemy"
      "enemy_enemytk_kill": "0xFE0E00",              // "enemy"
      "enemy_enemytk_blowup": "0xFE0E00",        // "enemy"
      "unknown_ally_hit": "0x36AD00",                  // "ally"
      "unknown_ally_kill": "0x60FF00",                  // "ally"
      "unknown_ally_blowup": "0x60FF00",            // "ally"
      "unknown_squadman_hit": "0xFF7D2E",        // "squadman"
      "unknown_squadman_kill": "0xFF914C",       // "squadman"
      "unknown_squadman_blowup": "0xFF914C", // "squadman"
      "unknown_enemy_hit": "0xFE0E00",               // "enemy"
      "unknown_enemy_kill": "0xFE0E00",               // "enemy"
      "unknown_enemy_blowup": "0xFE0E00",        // "enemy"
      "unknown_allytk_hit": "0x36AD00",               // "ally"
      "unknown_allytk_kill": "0x60FF00",                // "ally"
      "unknown_allytk_blowup": "0x60FF00",         // "ally"
      "unknown_enemytk_hit": "0xFE0E00",            // "enemy"
      "unknown_enemytk_kill": "0xFE0E00",           // "enemy"
      "unknown_enemytk_blowup": "0xFE0E00",     // "enemy"
      "player_ally_hit": "0xFFCC66",                        // "me"
      "player_ally_kill": "0xFFCC66",                         // "me"
      "player_ally_blowup": "0xFFCC66",                  // "me"
      "player_squadman_hit": "0xFFCC66",             // "me"
      "player_squadman_kill": "0xFFCC66",              // "me"
      "player_squadman_blowup": "0xFFCC66",        // "me"
      "player_enemy_hit": "0xFFCC66",                   // "me"
      "player_enemy_kill": "0xFFCC66",                    // "me"
      "player_enemy_blowup": "0xFFCC66",              // "me"
      "player_allytk_hit": "0xFFCC66",                     // "me"
      "player_allytk_kill": "0xFFCC66",                      // "me"
      "player_allytk_blowup": "0xFFCC66",               // "me"
      "player_enemytk_hit": "0xFFCC66",                // "me"
      "player_enemytk_kill": "0xFFCC66",                 // "me"
      "player_enemytk_blowup": "0xFFCC66"           // "me"
    }
}