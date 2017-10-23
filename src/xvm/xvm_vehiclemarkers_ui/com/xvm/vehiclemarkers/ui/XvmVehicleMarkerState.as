/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vehiclemarkers.ui
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.vo.*;
    import com.xvm.types.cfg.*;

    public class XvmVehicleMarkerState
    {
        public static const ALLY_STATES:Array = ["ally/alive/normal", "ally/alive/extended", "ally/dead/normal", "ally/dead/extended"];
        public static const ENEMY_STATES:Array = ["enemy/alive/normal", "enemy/alive/extended", "enemy/dead/normal", "enemy/dead/extended"];

        public static function getCurrentState(playerState:VOPlayerState, exInfo:Boolean):String
        {
            var result:String = playerState.isAlly ? "ally/" : "enemy/";
            result += playerState.isAlive ? "alive/" : "dead/";
            result += exInfo ? "extended" : "normal";
            return result;
        }

        public static function getCurrentConfig(playerState:VOPlayerState, exInfo:Boolean):CMarkers4
        {
            var result1:CMarkers = Config.config.markers;
            var result2:CMarkers2 = playerState.isAlly ? result1.ally : result1.enemy;
            var result3:CMarkers3 = playerState.isAlive ? result2.alive : result2.dead;
            var result4:CMarkers4 = exInfo ? result3.extended : result3.normal;
            return result4;
        }

        public static function getConfig(stateString:String):CMarkers4
        {
            switch (stateString)
            {
                case "ally/alive/normal":
                    return Config.config.markers.ally.alive.normal;
                case "ally/alive/extended":
                    return Config.config.markers.ally.alive.extended;
                case "ally/dead/normal":
                    return Config.config.markers.ally.dead.normal;
                case "ally/dead/extended":
                    return Config.config.markers.ally.dead.extended;
                case "enemy/alive/normal":
                    return Config.config.markers.enemy.alive.normal;
                case "enemy/alive/extended":
                    return Config.config.markers.enemy.alive.extended;
                case "enemy/dead/normal":
                    return Config.config.markers.enemy.dead.normal;
                case "enemy/dead/extended":
                    return Config.config.markers.enemy.dead.extended;
            }
            return null;
        }

        public static function getAllStates(isAlly:Boolean):Array
        {
            return isAlly ? ALLY_STATES : ENEMY_STATES;
        }
    }
}
