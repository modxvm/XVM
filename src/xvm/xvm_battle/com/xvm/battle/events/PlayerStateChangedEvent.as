/**
 * XFW
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.events
{
    import flash.events.*;

    public class PlayerStateChangedEvent extends Event
    {
        public static const PLAYER_STATE_CHANGED:String = "PLAYER_STATE_CHANGED";

        public var vehicleID:Number;
        public var accountDBID:Number;
        public var playerName:String;

        public function PlayerStateChangedEvent(vehicleID:Number, accountDBID:Number, playerName:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(PLAYER_STATE_CHANGED, bubbles, cancelable);
            this.vehicleID = vehicleID;
            this.accountDBID = accountDBID;
            this.playerName = playerName;
        }

        public override function clone():Event
        {
            return new PlayerStateChangedEvent(vehicleID, accountDBID, playerName, bubbles, cancelable);
        }
    }

}
