/**
 * ...
 * @author sirmax2
 */
class wot.utils.Defines
{
  // Global versions
  public static var XVM_VERSION = "2.0.test2";
  public static var WOT_VERSION = "0.7.2";
  public static var CONFIG_VERSION = "1.1.0";
  public static var EDITOR_VERSION = "0.0.0";

  public static var DEFAULT_CONFIG_NAME = "XVM.xvmconf";

  // file name limit is ~ 220 chars
  public static var MAX_PATH = 180;

  // Path to Dokan MountPoint
  public static var DOKAN_MP = "../../../.stat/";

  // WebDav commands
  public static var COMMAND_LOG = DOKAN_MP + "@LOG";
  public static var COMMAND_SET = DOKAN_MP + "@SET";
  public static var COMMAND_ADD = DOKAN_MP + "@ADD";
  public static var COMMAND_GET = DOKAN_MP + "@GET";
  public static var COMMAND_RUN = DOKAN_MP + "@RUN";
  public static var COMMAND_RUNINGAME = DOKAN_MP + "@RUNINGAME";
  public static var COMMAND_RETRIEVE = DOKAN_MP + "@RETRIEVE";
  public static var COMMAND_READY = DOKAN_MP + "@READY";
  public static var COMMAND_GET_LAST_STAT = DOKAN_MP + "@GET_LAST_STAT";

  // Position
  public static var POSITION_LEFT = 0;
  public static var POSITION_RIGHT = 1;

  // Team
  public static var TEAM_ALLY = 0;
  public static var TEAM_ENEMY = 1;

  // Dynamic color types
  public static var DYNAMIC_COLOR_EFF = 1;
  public static var DYNAMIC_COLOR_RATING = 2;
  public static var DYNAMIC_COLOR_KB = 3;
  public static var DYNAMIC_COLOR_HP = 4;
  public static var DYNAMIC_COLOR_HP_RATIO = 5;

  // Dynamic alpha types
  public static var DYNAMIC_ALPHA_EFF = 1;
  public static var DYNAMIC_ALPHA_RATING = 2;
  public static var DYNAMIC_ALPHA_KB = 3;
  public static var DYNAMIC_ALPHA_HP = 4;
  public static var DYNAMIC_ALPHA_HP_RATIO = 5;

  // System colors
  public static var SYSTEM_COLORS = {
    ally_alive_normal: 0x96FF00,
    ally_alive_blind: 0x96FF00,
    ally_dead_normal: 0x009900,
    ally_dead_blind: 0x009900,
    ally_blowedup_normal: 0x007700,
    ally_blowedup_blind: 0x007700,
    squadman_alive_normal: 0xFFB964,
    squadman_alive_blind: 0xFFFF00,
    squadman_dead_normal: 0xCA7000,
    squadman_dead_blind: 0xAAAA00,
    squadman_blowedup_normal: 0xA45A00,
    squadman_blowedup_blind: 0x888800,
    teamKiller_alive_normal: 0x00EAFF,
    teamKiller_alive_blind: 0x00EAFF,
    teamKiller_dead_normal: 0x097783,
    teamKiller_dead_blind: 0x097783,
    teamKiller_blowedup_normal: 0x096A75,
    teamKiller_blowedup_blind: 0x096A75,
    enemy_alive_normal: 0xF50800,
    enemy_alive_blind: 0x8379FE,
    enemy_dead_normal: 0x840500,
    enemy_dead_blind: 0x47407A,
    enemy_blowedup_normal: 0x5A0401,
    enemy_blowedup_blind: 0x3B365F
  }
}
