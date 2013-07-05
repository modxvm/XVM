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
      "ally_ally_hit":		"0x100001",			// союзник союзника удар
      "ally_ally_kill":		"0x100001", 		// союзник союзника убил
      "ally_ally_blowup":	"0x100001", 		// союзник союзника боеуклад
      "ally_squadman_hit":	"0x100002", 		// союзник взводного удар
      "ally_squadman_kill":	"0x100002", 		// союзник взводного убил
      "ally_squadman_blowup":	"0x100002", 	// союзник взводного боеуклад
      "ally_enemy_hit":		"0x100003", 		// союзник врага удар
      "ally_enemy_kill":	"0x100003", 		// союзник врага убил
      "ally_enemy_blowup":	"0x100003", 		// союзник врага боеуклад
      "ally_allytk_hit":	"0x100004", 		// союзник союзника(тимкиллер) удар
      "ally_allytk_kill":	"0x100004", 		// союзник союзника(тимкиллер) убил
      "ally_allytk_blowup":	"0x100004", 		// союзник союзника(тимкиллер) боеуклад
      "ally_enemytk_hit":	"0x100005", 		// союзник врага(тимкиллер) удар
      "ally_enemytk_kill":	"0x100005", 		// союзник врага(тимкиллер) убил
      "ally_enemytk_blowup":	"0x100005", 	// союзник врага(тимкиллер) боеуклад
      "squadman_ally_hit":	"0x200001", 		// взводный союзника удар
      "squadman_ally_kill":	"0x200001", 		// взводный союзника убил
      "squadman_ally_blowup":	"0x200001", 	// взводный союзника боеуклад
      "squadman_squadman_hit":	"0x200002", 	// взводный взводного удар
      "squadman_squadman_kill":	"0x200002", 	// взводный взводного убил
      "squadman_squadman_blowup": "0x200002", 	// взводный взводного боеуклад
      "squadman_enemy_hit":	"0x200003", 		// взводный врага удар
      "squadman_enemy_kill":	"0x200003", 	// взводный врага убил
      "squadman_enemy_blowup":	"0x200003", 	// взводный врага боеуклад
      "squadman_allytk_hit":	"0x200004", 	// взводный союзника(тимкиллер) удар
      "squadman_allytk_kill":	"0x200004", 	// взводный союзника(тимкиллер) убил
      "squadman_allytk_blowup":	"0x200004", 	// взводный союзника(тимкиллер) боеуклад
      "squadman_enemytk_hit":	"0x200005", 	// взводный врага(тимкиллер) удар
      "squadman_enemytk_kill":	"0x200005", 	// взводный врага(тимкиллер) убил
      "squadman_enemytk_blowup":"0x200005", 	// взводный врага(тимкиллер) боеуклад
      "enemy_ally_hit":		"0x300001", 		// враг союзника удар
      "enemy_ally_kill":	"0x300001", 		// враг союзника убил
      "enemy_ally_blowup":	"0x300001", 		// враг союзника боеуклад
      "enemy_squadman_hit":	"0x300002", 		// враг взводного удар
      "enemy_squadman_kill":	"0x300002", 	// враг взводного убил
      "enemy_squadman_blowup":	"0x300002", 	// враг взводного боеуклад
      "enemy_enemy_hit":	"0x300003", 		// враг врага удар
      "enemy_enemy_kill":	"0x300003", 		// враг врага убил
      "enemy_enemy_blowup":	"0x300003", 		// враг врага боеуклад
      "enemy_allytk_hit":	"0x300004", 		// враг союзника(тимкиллер) удар
      "enemy_allytk_kill":	"0x300004", 		// враг союзника(тимкиллер) убил
      "enemy_allytk_blowup":	"0x300004", 	// враг союзника(тимкиллер) боеуклад
      "enemy_enemytk_hit":	"0x300005", 		// враг врага(тимкиллер) удар
      "enemy_enemytk_kill":	"0x300005", 		// враг врага(тимкиллер) убил
      "enemy_enemytk_blowup":	"0x300005", 	// враг врага(тимкиллер) боеуклад
      "unknown_ally_hit":	"0x400001", 		// неизвестный союзника удар
      "unknown_ally_kill":	"0x400001", 		// неизвестный союзника убил
      "unknown_ally_blowup":	"0x400001", 	// неизвестный союзника боеуклад
      "unknown_squadman_hit":	"0x400002", 	// неизвестный взводного удар
      "unknown_squadman_kill":	"0x400002", 	// неизвестный взводного убил
      "unknown_squadman_blowup":"0x400002", 	// неизвестный взводного боеуклад
      "unknown_enemy_hit":	"0x400003", 		// неизвестный врага удар
      "unknown_enemy_kill":	"0x400003", 		// неизвестный врага убил
      "unknown_enemy_blowup":	"0x400003",		// неизвестный врага боеуклад
      "unknown_allytk_hit":	"0x400004", 		// неизвестный союзника(тимкиллер) удар
      "unknown_allytk_kill":	"0x400004", 	// неизвестный союзника(тимкиллер) убил
      "unknown_allytk_blowup":	"0x400004", 	// неизвестный союзника(тимкиллер) боеуклад
      "unknown_enemytk_hit":	"0x400005", 	// неизвестный врага(тимкиллер) удар
      "unknown_enemytk_kill":	"0x400005", 	// неизвестный врага(тимкиллер) убил
      "unknown_enemytk_blowup":	"0x400005", 	// неизвестный врага(тимкиллер) боеуклад
      "player_ally_hit":	"0x500001", 		// игрок союзника удар
      "player_ally_kill":	"0x500001", 		// игрок союзника убил
      "player_ally_blowup":	"0x500001", 		// игрок союзника боеуклад
      "player_squadman_hit":	"0x500002", 	// игрок взводного удар
      "player_squadman_kill":	"0x500002", 	// игрок взводного убил
      "player_squadman_blowup":	"0x500002", 	// игрок взводного боеуклад
      "player_enemy_hit":	"0x500003", 		// игрок врага удар
      "player_enemy_kill":	"0x500003", 		// игрок врага убил
      "player_enemy_blowup":	"0x500003", 	// игрок врага боеуклад
      "player_allytk_hit":	"0x500004", 		// игрок союзника(тимкиллер) удар
      "player_allytk_kill":	"0x500004", 		// игрок союзника(тимкиллер) убил
      "player_allytk_blowup":	"0x500004", 	// игрок союзника(тимкиллер) боеуклад
      "player_enemytk_hit":	"0x500005", 		// игрок врага(тимкиллер) удар
      "player_enemytk_kill":	"0x500005", 	// игрок врага(тимкиллер) убил
      "player_enemytk_blowup":	"0x500005"  	// игрок врага(тимкиллер) боеуклад
    }
}