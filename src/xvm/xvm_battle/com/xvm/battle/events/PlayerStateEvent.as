/**
 * XFW
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.events
{
    import flash.events.*;

    public class PlayerStateEvent extends Event
    {
        public static const PLAYER_STATE_CHANGED:String = "PLAYER_STATE_CHANGED";
        public static const PLAYER_DEAD:String = "PLAYER_DEAD";

        public var vehicleID:Number;
        public var accountDBID:Number;
        public var playerName:String;

        public function PlayerStateEvent(type:String, vehicleID:Number, accountDBID:Number, playerName:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
            this.vehicleID = vehicleID;
            this.accountDBID = accountDBID;
            this.playerName = playerName;
        }

        public override function clone():Event
        {
            return new PlayerStateEvent(type, vehicleID, accountDBID, playerName, bubbles, cancelable);
        }
    }

}
