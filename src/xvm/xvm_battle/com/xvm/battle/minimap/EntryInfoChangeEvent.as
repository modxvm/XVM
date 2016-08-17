/**
 * XVM
 * @author s_sorochich
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.minimap
{
    import com.xvm.battle.vo.*;
    import flash.events.*;

    public class EntryInfoChangeEvent extends Event
    {
        public static const INFO_CHANGED:String = "info_changed";

        public var vehicleID:Number;
        public var playerState:VOPlayerState;

        public function EntryInfoChangeEvent(type:String, vehicleID:Number, playerState:VOPlayerState)
        {
            super(type, false, false);
            this.vehicleID = vehicleID;
            this.playerState = playerState;
        }

        public override function clone():Event
        {
            return new EntryInfoChangeEvent(type, vehicleID, playerState);
        }

        public override function toString():String
        {
            return formatToString("EntryInfoChangeEvent", "type", "vehicleId", "playerState");
        }
    }
}
