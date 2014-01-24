/**
 * XVM Sandbox Detector
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.utils
{
  //import net.wargaming.utils.DebugUtils;

  public class Sandbox
  {
      public static const SANDBOX_UNKNOWN:String = "X";
      /*public static const SANDBOX_VMM:String = "V";
      public static const SANDBOX_BATTLE:String = "B";
      public static const SANDBOX_HANGAR:String = "H";
      public static const SANDBOX_LOGIN:String = "L";*/



      public static function GetCurrentSandboxPrefix() : String
      {
          /*// VehicleMarkersManager.swf
          if (root["vehicleMarkersCanvas"] != undefined)
              return SANDBOX_VMM;

          // battle.swf, PlayersPanel.swf, StatisticForm.swf, Minimap.swf, TeamBasesPanel.swf
          if (root["sixthSenseIndicator"] != undefined)
              return SANDBOX_BATTLE;

          // hangar SWFs + battleloading.swf
          if (root["invitesHandler"] != undefined)
              return SANDBOX_HANGAR;

          // login screen
          if (root.loadingName != "startgamevideo" || _root.loadingName == "login")
              return SANDBOX_LOGIN;

          // unknown sand box
          var s = "XVM\nunknown sand box\n\n";
          for (var i in _root)
          {
              if (typeof(_root[i]) != "function")
                  s += i + ": " + _root[i] + "\n";
          }
          DebugUtils.LOG_WARNING(s);*/
          return SANDBOX_UNKNOWN;
      }
  }
}
