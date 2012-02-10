/**
 * ...
 * @author sirmax2
 */
class wot.utils.Defines
{
  public static var DEFAULT_CONFIG_NAME = "XVM.xvmconf";
        
  // file name limit is ~ 220 chars
  public static var MAX_PATH = 170;

  // WebDav commands
  public static var COMMAND_LOG = "stat/@LOG";
  public static var COMMAND_SET_USERS = "stat/@SET_USERS";
  public static var COMMAND_ADD_USERS = "stat/@ADD_USERS";
  public static var COMMAND_RUN = "stat/@RUN";
  public static var COMMAND_GET_USERS = "stat/@GET_USERS";
  public static var COMMAND_GET_LAST_STAT = "stat/@GET_LAST_STAT";

  // Position
  public static var POSITION_LEFT = 0;
  public static var POSITION_RIGHT = 1;

  // Team
  public static var TEAM_ALLY = 0;
  public static var TEAM_ENEMY = 1;
}
