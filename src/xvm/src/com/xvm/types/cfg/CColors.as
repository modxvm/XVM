/**
 * XVM Config - "colors" section
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.types.cfg
{
    public dynamic class CColors extends Object
    {
        //system: {
            //ally_alive:          "0x96FF00",
            //ally_dead:           "0x009900",
            //ally_blowedup:       "0x007700",
            //squadman_alive:      "0xFFB964",
            //squadman_dead:       "0xCA7000",
            //squadman_blowedup:   "0xA45A00",
            //teamKiller_alive:    "0x00EAFF",
            //teamKiller_dead:     "0x097783",
            //teamKiller_blowedup: "0x096A75",
            //enemy_alive:         "0xF50800",
            //enemy_dead:          "0x840500",
            //enemy_blowedup:      "0x5A0401"
        //},
        // src: ally, squadman, enemy, unknown, player
        // dst: ally, squadman, allytk, enemytk, enemy
        //damage: {
            //ally_ally_hit:            "0x00EAFF",
            //ally_ally_kill:           "0x00EAFF",
            //ally_ally_blowup:         "0x00EAFF",
            //ally_squadman_hit:        "0x00EAFF",
            //ally_squadman_kill:       "0x00EAFF",
            //ally_squadman_blowup:     "0x00EAFF",
            //ally_enemy_hit:           "0xF50800",
            //ally_enemy_kill:          "0xF50800",
            //ally_enemy_blowup:        "0xF50800",
            //ally_allytk_hit:          "0x00EAFF",
            //ally_allytk_kill:         "0x00EAFF",
            //ally_allytk_blowup:       "0x00EAFF",
            //ally_enemytk_hit:         "0xF50800",
            //ally_enemytk_kill:        "0xF50800",
            //ally_enemytk_blowup:      "0xF50800",
            //squadman_ally_hit:        "0x00EAFF",
            //squadman_ally_kill:       "0x00EAFF",
            //squadman_ally_blowup:     "0x00EAFF",
            //squadman_squadman_hit:    "0x00EAFF",
            //squadman_squadman_kill:   "0x00EAFF",
            //squadman_squadman_blowup: "0x00EAFF",
            //squadman_enemy_hit:       "0xF50800",
            //squadman_enemy_kill:      "0xF50800",
            //squadman_enemy_blowup:    "0xF50800",
            //squadman_allytk_hit:      "0x00EAFF",
            //squadman_allytk_kill:     "0x00EAFF",
            //squadman_allytk_blowup:   "0x00EAFF",
            //squadman_enemytk_hit:     "0xF50800",
            //squadman_enemytk_kill:    "0xF50800",
            //squadman_enemytk_blowup:  "0xF50800",
            //enemy_ally_hit:           "0x96FF00",
            //enemy_ally_kill:          "0x96FF00",
            //enemy_ally_blowup:        "0x96FF00",
            //enemy_squadman_hit:       "0xFFB964",
            //enemy_squadman_kill:      "0xFFB964",
            //enemy_squadman_blowup:    "0xFFB964",
            //enemy_enemy_hit:          "0xF50800",
            //enemy_enemy_kill:         "0xF50800",
            //enemy_enemy_blowup:       "0xF50800",
            //enemy_allytk_hit:         "0x96FF00",
            //enemy_allytk_kill:        "0x96FF00",
            //enemy_allytk_blowup:      "0x96FF00",
            //enemy_enemytk_hit:        "0xF50800",
            //enemy_enemytk_kill:       "0xF50800",
            //enemy_enemytk_blowup:     "0xF50800",
            //unknown_ally_hit:         "0x96FF00",
            //unknown_ally_kill:        "0x96FF00",
            //unknown_ally_blowup:      "0x96FF00",
            //unknown_squadman_hit:     "0xFFB964",
            //unknown_squadman_kill:    "0xFFB964",
            //unknown_squadman_blowup:  "0xFFB964",
            //unknown_enemy_hit:        "0xF50800",
            //unknown_enemy_kill:       "0xF50800",
            //unknown_enemy_blowup:     "0xF50800",
            //unknown_allytk_hit:       "0x96FF00",
            //unknown_allytk_kill:      "0x96FF00",
            //unknown_allytk_blowup:    "0x96FF00",
            //unknown_enemytk_hit:      "0xF50800",
            //unknown_enemytk_kill:     "0xF50800",
            //unknown_enemytk_blowup:   "0xF50800",
            //player_ally_hit:          "0xFFDD33",
            //player_ally_kill:         "0xFFDD33",
            //player_ally_blowup:       "0xFFDD33",
            //player_squadman_hit:      "0xFFDD33",
            //player_squadman_kill:     "0xFFDD33",
            //player_squadman_blowup:   "0xFFDD33",
            //player_enemy_hit:         "0xFFDD33",
            //player_enemy_kill:        "0xFFDD33",
            //player_enemy_blowup:      "0xFFDD33",
            //player_allytk_hit:        "0xFFDD33",
            //player_allytk_kill:       "0xFFDD33",
            //player_allytk_blowup:     "0xFFDD33",
            //player_enemytk_hit:       "0xFFDD33",
            //player_enemytk_kill:      "0xFFDD33",
            //player_enemytk_blowup:    "0xFFDD33"
        //},
        //dmg_kind: {
            //attack:          "0xFFAA55",
            //fire:            "0xFF6655",
            //ramming:         "0x998855",
            //world_collision: "0x998855",
            //other:           "0xCCCCCC"
        //},
        //vtype: {
            //LT:  "0xA2FF9A",        // Color for light tanks
            //MT:  "0xFFF198",        // Color for medium tanks
            //HT:  "0xFFACAC",        // Color for heavy tanks
            //SPG: "0xEFAEFF",        // Color for arty
            //TD:  "0xA0CFFF",        // Color for tank destroyers
            //premium: "0xFFCC66",    // Color for premium tanks
            //usePremiumColor: false  // Enable/disable premium color usage
        //},
        // values - from min to max, colors are for values 'lesser then ...'
        //hp: [
            //{ value: 201,  color: ColorPalette.redBright },
            //{ value: 401,  color: ColorPalette.redSmooth },
            //{ value: 1001, color: ColorPalette.orange },
            //{ value: 9999, color: ColorPalette.white }
        //],
        //hp_ratio: [
            //{ value: 10,  color: ColorPalette.redBright },
            //{ value: 25,  color: ColorPalette.redSmooth },
            //{ value: 50,  color: ColorPalette.orange },
            //{ value: 101, color: ColorPalette.white }
        //],
        // XVM Scale: http://www.koreanrandom.com/forum/topic/2625-xvm-scale
        //x: [
            //{ value: 17,  color: ColorPalette.red },      // 00   - 16.5 - very bad   (20% of players)
            //{ value: 34,  color: ColorPalette.orange },   // 16.5 - 33.5 - bad        (better then 20% of players)
            //{ value: 53,  color: ColorPalette.yellow },   // 33.5 - 52.5 - normal     (better then 60% of players)
            //{ value: 76,  color: ColorPalette.green },    // 52.5 - 75.5 - good       (better then 90% of players)
            //{ value: 93,  color: ColorPalette.blue },     // 75.5 - 92.5 - very good  (better then 99% of players)
            //{ value: 999, color: ColorPalette.purple }    // 92.5 - XX   - unique     (better then 99.9% of players)
        //],
        //eff: [
            //{ value: 630,  color: ColorPalette.red },     // very bad
            //{ value: 860,  color: ColorPalette.orange },  // bad
            //{ value: 1140, color: ColorPalette.yellow },  // normal
            //{ value: 1460, color: ColorPalette.green },   // good
            //{ value: 1735, color: ColorPalette.blue },    // very good
            //{ value: 9999, color: ColorPalette.purple }   // unique
        //],
        //wn6: [..],
        //wn8: [..],
        //wgr: [..],
        //rating: [
            //{ value: 47,  color: ColorPalette.red },      // very bad
            //{ value: 49,  color: ColorPalette.orange },   // bad
            //{ value: 52,  color: ColorPalette.yellow },   // normal
            //{ value: 57,  color: ColorPalette.green },    // good
            //{ value: 64,  color: ColorPalette.blue },     // very good
            //{ value: 101, color: ColorPalette.purple }    // unique
        //],
        //e: [
            //{ value: 3,    color: ColorPalette.red },     // very bad
            //{ value: 6,    color: ColorPalette.orange },  // bad
            //{ value: 7,    color: ColorPalette.yellow },  // normal
            //{ value: 8,    color: ColorPalette.green },   // good
            //{ value: 9,    color: ColorPalette.blue },    // very good
            //{ value: 20,   color: ColorPalette.purple }   // unique
        //],
        //avglvl
        //kb: [
            //{ value: 2,   color: ColorPalette.red },
            //{ value: 5,   color: ColorPalette.orange },
            //{ value: 9,   color: ColorPalette.yellow },
            //{ value: 14,  color: ColorPalette.green },
            //{ value: 20,  color: ColorPalette.blue },
            //{ value: 999, color: ColorPalette.purple }
        //],
        //t_battles: [
            //{ value: 100,   color: ColorPalette.red },
            //{ value: 250,   color: ColorPalette.orange },
            //{ value: 500,   color: ColorPalette.yellow },
            //{ value: 1000,  color: ColorPalette.green },
            //{ value: 1800,  color: ColorPalette.blue },
            //{ value: 99999, color: ColorPalette.purple }
        //],
        //tdb: [
            //{ value: 500,  color: ColorPalette.red },
            //{ value: 1000, color: ColorPalette.yellow },
            //{ value: 2000, color: ColorPalette.green }
        //],
        //tdv: [
            //{ value: 0.6,  color: ColorPalette.red },
            //{ value: 0.8,  color: ColorPalette.orange },
            //{ value: 1.0,  color: ColorPalette.yellow },
            //{ value: 1.3,  color: ColorPalette.green },
            //{ value: 2.0,  color: ColorPalette.blue },
            //{ value: 15,   color: ColorPalette.purple }
        //],
        //tfb: [
            //{ value: 0.6,  color: ColorPalette.red },
            //{ value: 0.8,  color: ColorPalette.orange },
            //{ value: 1.0,  color: ColorPalette.yellow },
            //{ value: 1.3,  color: ColorPalette.green },
            //{ value: 2.0,  color: ColorPalette.blue },
            //{ value: 15,   color: ColorPalette.purple }
        //],
        //tsb: [
            //{ value: 0.6,  color: ColorPalette.red },
            //{ value: 0.8,  color: ColorPalette.orange },
            //{ value: 1.0,  color: ColorPalette.yellow },
            //{ value: 1.3,  color: ColorPalette.green },
            //{ value: 2.0,  color: ColorPalette.blue },
            //{ value: 15,   color: ColorPalette.purple }
        //]
    }
}
