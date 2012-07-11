/**
 * ...
 * @author sirmax2
 */

/*
  s_data members:
    playerId: Number,
    fullPlayerName: fullPlayerName,
    label: String,
    clanAbbrev: String,
    vehicle: String,
    vehicleId: String,
    icon: String,
    team: Defines.TEAM_ALLY | Defines.TEAM_ENEMY,
    selected: Boolean,
    loaded: Boolean
    stat:
      b - battles
      w - wins
      r - global win ratio
      e - eff
      tb - tank battles
      tw - tank wins
      tr - tank win ratio
      tl - tank level
      ts - tank spotted
      td - tank damage
      tf - tank frags
*/

class wot.utils.StatData
{
  public static var s_loaded = false;
  public static var s_data = {};
}
