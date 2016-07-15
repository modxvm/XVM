package com.xvm.battle.events {
import flash.events.Event;

public class HitLogEvent extends Event {

    public static const DAMAGE_CAUSED : String = "damageCaused";

    public var hitVehicleID : Number;

    public function HitLogEvent(type:String, hitVehicleID : Number, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);
        this.hitVehicleID = hitVehicleID;
    }


    override public function clone():Event {
        return new HitLogEvent(type, hitVehicleID, bubbles, cancelable);
    }
}
}
