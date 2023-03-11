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

    public final class XvmVehicleMarkerState
    {
        public static const PLAYER_STATES:Vector.<String> = new <String>[
            "enemy/dead/normal", "enemy/dead/extended", "enemy/alive/normal", "enemy/alive/extended",
            "ally/dead/normal", "ally/dead/extended", "ally/alive/normal", "ally/alive/extended"];
        public static const ALLY_STATES:Vector.<String> = new <String>[
            "ally/alive/normal", "ally/alive/extended", "ally/dead/normal", "ally/dead/extended"];
        public static const ENEMY_STATES:Vector.<String> = new <String>[
            "enemy/alive/normal", "enemy/alive/extended", "enemy/dead/normal", "enemy/dead/extended"];

        [Inline]
        public static function getCurrentState(playerState:VOPlayerState, exInfo:Boolean):String
        {
            return PLAYER_STATES[(int(playerState.isAlly) << 2) | (int(playerState.isAlive) << 1) | int(exInfo)];
        }

        [Inline]
        public static function getCurrentConfig(playerState:VOPlayerState, exInfo:Boolean):CMarkers4
        {
            return Config.config.markers[playerState.isAlly ? "ally" : "enemy"][playerState.isAlive ? "alive" : "dead"][exInfo ? "extended" : "normal"];
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

        [Inline]
        public static function getAllStates(isAlly:Boolean):Vector.<String>
        {
            return isAlly ? ALLY_STATES : ENEMY_STATES;
        }
    }
}
