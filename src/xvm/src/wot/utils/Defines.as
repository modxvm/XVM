/**
 * ...
 * @author sirmax2
 */
class wot.utils.Defines
{
  // Global versions
  public static var XVM_VERSION: String = "3.0.4.alpha9";
  public static var WOT_VERSION: String = "0.8.0";
  public static var CONFIG_VERSION: String = "1.6.0";
  public static var EDITOR_VERSION: String = "0.15";

  public static var DEFAULT_CONFIG_NAME: String = "XVM.xvmconf";

  // MAX_PATH is 259 on NTFS
  public static var MAX_PATH: Number = 100;

  // Path to Dokan MountPoint (WoT/xvm/.stat)
  public static var DOKAN_MP = "../../../../xvm/.stat/";

  // WebDav commands
  public static var COMMAND_LOG: String = DOKAN_MP + "@LOG";
  public static var COMMAND_SET: String = DOKAN_MP + "@SET";
  public static var COMMAND_ADD: String = DOKAN_MP + "@ADD";
  public static var COMMAND_RUN: String = DOKAN_MP + "@RUN";
  public static var COMMAND_RUN_ASYNC: String = DOKAN_MP + "@RUN_ASYNC";
  public static var COMMAND_GET_LAST_STAT: String = DOKAN_MP + "@GET_LAST_STAT";
  public static var COMMAND_GET_VERSION: String = DOKAN_MP + "@GET_VERSION";

  // Default path to vehicle icons (relative)
  public static var CONTOUR_ICON_PATH: String = "../maps/icons/vehicle/contour/";

  // Team
  public static var TEAM_ALLY: Number = 1;
  public static var TEAM_ENEMY: Number = 2;

  // Field Type
  public static var FIELDTYPE_NONE: Number = 0;
  public static var FIELDTYPE_NICK: Number = 1;
  public static var FIELDTYPE_VEHICLE: Number = 2;

  // Dead State
  public static var DEADSTATE_NONE: Number = 0;
  public static var DEADSTATE_ALIVE: Number = 1;
  public static var DEADSTATE_DEAD: Number = 2;

  // Dynamic color types
  public static var DYNAMIC_COLOR_EFF: Number = 1;
  public static var DYNAMIC_COLOR_RATING: Number = 2;
  public static var DYNAMIC_COLOR_KB: Number = 3;
  public static var DYNAMIC_COLOR_HP: Number = 4;
  public static var DYNAMIC_COLOR_HP_RATIO: Number = 5;
  public static var DYNAMIC_COLOR_TBATTLES: Number = 6;

  // Dynamic alpha types
  //public static var DYNAMIC_ALPHA_EFF: Number = 1;
  //public static var DYNAMIC_ALPHA_RATING: Number = 2;
  //public static var DYNAMIC_ALPHA_KB: Number = 3;
  public static var DYNAMIC_ALPHA_HP: Number = 4;
  public static var DYNAMIC_ALPHA_HP_RATIO: Number = 5;
  //public static var DYNAMIC_ALPHA_TBATTLES: Number = 6;

  // Damage flag at Xvm.as: updateHealth
  public static var FROM_UNKNOWN: Number = 0;
  public static var FROM_ALLY: Number = 1;
  public static var FROM_ENEMY: Number = 2;
  public static var FROM_SQUAD: Number = 3;
  public static var FROM_PLAYER: Number = 4;

  // Text direction
  public static var DIRECTION_UP = 1;
  public static var DIRECTION_DOWN = 2;

  // damage source to system color mapping
  // src_dst: sys
  //   src: ally, squadman, enemy, unknown, player (allytk, enemytk - how to detect?)
  //   dst: ally, squadman, allytk, enemytk, enemy
  //   sys: ally, squadman, teamKiller, enemy, me
  public static var damage_mapping:Object = {
    ally_ally:		"teamKiller",
    ally_squadman:	"teamKiller",
    ally_enemy:		"enemy",
    ally_allytk:	"teamKiller",
    ally_enemytk:	"enemy",
    squadman_ally:	"teamKiller",
    squadman_squad:	"teamKiller",
    squadman_enemy:	"enemy",
    squadman_allytk:	"teamKiller",
    squadman_enemytk:	"enemy",
//    allytk_ally:	"teamKiller",
//    allytk_squadman:	"teamKiller",
//    allytk_enemy:	"enemy",
//    allytk_allytk:	"teamKiller",
//    allytk_enemytk:	"enemy",
//    enemytk_ally:	"ally",
//    enemytk_squadman:	"squadman",
//    enemytk_enemy:	"enemy",
//    enemytk_allytk:	"ally",
//    enemytk_enemytk:	"enemy",
    enemy_ally:		"ally",
    enemy_squadman:	"squadman",
    enemy_enemy:	"enemy",
    enemy_allytk:	"ally",
    enemy_enemytk:	"enemy",
    unknown_ally:	"ally",
    unknown_squadman:	"squadman",
    unknown_enemy:	"enemy",
    unknown_allytk:	"ally",
    unknown_enemytk:	"enemy",
    player_ally:	"me",
    player_squadman:	"me",
    player_enemy:	"me",
    player_allytk:	"me",
    player_enemytk:	"me"
  }
}
