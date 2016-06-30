/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.vo.*;
    import com.xvm.types.cfg.*;

    public class XvmVehicleMarkerState
    {
        public static var allAlly:Array = ["ally/alive/normal", "ally/alive/extended", "ally/dead/normal", "ally/dead/extended"];
        public static var allEnemy:Array = ["enemy/alive/normal", "enemy/alive/extended", "enemy/dead/normal", "enemy/dead/extended"];

        public static function getCurrentState(playerState:VOPlayerState, exInfo:Boolean):String
        {
            var result:String = playerState.isAlly ? "ally/" : "enemy/";
            result += playerState.isAlive ? "alive/" : "dead/";
            result += exInfo ? "extended" : "normal";
            return result;
        }

        public static function getCurrentConfig(playerState:VOPlayerState, exInfo:Boolean):CMarkers4
        {
            var result:CMarkers = Config.config.markers;
            var result2:CMarkers2 = playerState.isAlly ? result.ally : result.enemy;
            var result3:CMarkers3 = playerState.isAlive ? result.alive : result.dead;
            var result4:CMarkers4 = exInfo ? result.extended : result.normal;
            return result4;
        }

        public static function getConfig(stateString:String):CMarkers4
        {
            var path:Array = stateString.split("/");
            if (path.length != 3)
                return null;
            var result:CMarkers = Config.config.markers;
            var result2:CMarkers2 = path[0] == "ally" ? result.ally : result.enemy;
            var result3:CMarkers3 = path[1] == "alive" ? result.alive : result.dead;
            var result4:CMarkers4 = path[2] == "normal" ? result.normal : result.extended;
            return result4;
        }

        public static function getAllStates(isAlly:Boolean):Array
        {
            return isAlly ? allAlly : allEnemy;
        }
    }
}
