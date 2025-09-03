/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.events
{
    import com.xvm.battle.*;
    import flash.events.*;

    public class PlayerStateEvent extends Event
    {
        public static const CHANGED:String = "PS_CHANGED";
        public static const PLAYERS_HP_CHANGED:String = "PS_PLAYERS_HP_CHANGED";
        public static const MY_HP_CHANGED:String = "PS_MY_HP_CHANGED";
        public static const VEHICLE_DESTROYED:String = "PS_VEHICLE_DESTROYED";
        public static const CURRENT_VEHICLE_DESTROYED:String = "PS_CURRENT_VEHICLE_DESTROYED";
        public static const MODULE_CRITICAL:String = "PS_MODULE_CRITICAL";
        public static const MODULE_DESTROYED:String = "PS_MODULE_DESTROYED";
        public static const MODULE_REPAIRED:String = "PS_MODULE_REPAIRED";
        public static const DAMAGE_CAUSED:String = "PS_DAMAGE_CAUSED";
        public static const DAMAGE_CAUSED_ALLY:String = "PS_DAMAGE_CAUSED_ALLY";
        public static const ON_HOTKEY_PRESSED:String = "PS_ON_HOTKEY_PRESSED";
        public static const ON_TARGET_IN:String = "PS_ON_TARGET_IN";
        public static const ON_TARGET_OUT:String = "PS_ON_TARGET_OUT";
        public static const ON_PANEL_MODE_CHANGED:String = "PS_ON_PANEL_MODE_CHANGED";
        public static const ON_MY_STAT_LOADED:String = "PS_ON_MY_STAT_LOADED";
        public static const ON_EVERY_FRAME:String = "PS_ON_EVERY_FRAME";
        public static const ON_EVERY_SECOND:String = "PS_ON_EVERY_SECOND";
        public static const ON_MINIMAP_ALT_MODE_CHANGED:String = "PS_ON_MINIMAP_ALT_MODE_CHANGED";
        public static const ON_MINIMAP_SIZE_CHANGED:String = "PS_ON_MINIMAP_SIZE_CHANGED";

        public var vehicleID:Number;
        public var playerName:String;
        public var userData:Object;

        public function PlayerStateEvent(type:String, vehicleID:Number = NaN, playerName:String = null, userData:Object = null)
        {
            super(type, false, false);
            this.vehicleID = isNaN(vehicleID) ? BattleGlobalData.playerVehicleID : vehicleID;
            this.playerName = playerName;
            this.userData = userData;
        }

        public override function clone():Event
        {
            return new PlayerStateEvent(type, vehicleID, playerName, userData);
        }
    }

}
