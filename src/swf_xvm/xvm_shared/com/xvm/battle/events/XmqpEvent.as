/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.events
{
    import flash.events.*;

    public class XmqpEvent extends Event
    {
        public static const XMQP_HOLA:String = "xmqp_hola";
        public static const XMQP_FIRE:String = "xmqp_fire";
        public static const XMQP_VEHICLE_TIMER:String = "xmqp_vehicle_timer";
        public static const XMQP_DEATH_ZONE_TIMER:String = "xmqp_death_zone_timer";
        public static const XMQP_SPOTTED:String = "xmqp_spotted";
        public static const XMQP_MINIMAP_CLICK:String = "xmqp_minimap_click";

        public var accountDBID:Number;
        public var data:Object;

        public function XmqpEvent(type:String, accountDBID:Number, data:Object = null)
        {
            super(type, false, false);
            this.accountDBID = accountDBID;
            this.data = data;
        }

        public override function clone():Event
        {
            return new XmqpEvent(type, accountDBID, data);
        }
    }

}
