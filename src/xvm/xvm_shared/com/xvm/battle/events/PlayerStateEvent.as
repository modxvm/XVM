/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.events
{
    import flash.events.*;

    public class PlayerStateEvent extends Event
    {
        public static const CHANGED:String = "PS_CHANGED";
        public static const HP_CHANGED:String = "PS_HP_CHANGED";
        public static const DEAD:String = "PS_DEAD";
        public static const SELF_DEAD:String = "PS_SELF_DEAD";
        public static const MODULE_CRITICAL:String = "PS_MODULE_CRITICAL";
        public static const MODULE_DESTROYED:String = "PS_MODULE_DESTROYED";
        public static const MODULE_REPAIRED:String = "PS_MODULE_REPAIRED";
        public static const DAMAGE_CAUSED:String = "PS_DAMAGE_CAUSED";

        public var vehicleID:Number;
        public var accountDBID:Number;
        public var playerName:String;

        public function PlayerStateEvent(type:String, vehicleID:Number, accountDBID:Number, playerName:String)
        {
            super(type, false, false);
            this.vehicleID = vehicleID;
            this.accountDBID = accountDBID;
            this.playerName = playerName;
        }

        public override function clone():Event
        {
            return new PlayerStateEvent(type, vehicleID, accountDBID, playerName);
        }
    }

}
