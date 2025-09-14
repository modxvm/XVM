/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.events
{
    import flash.events.*;

    public class HangarStateEvent extends Event
    {
        public static const ON_CHANGED:String = "ON_CHANGED";

        public var isHangar:Boolean;
        public var isEvent:Boolean;

        public function HangarStateEvent(type:String, isHangar:Boolean, isEvent:Boolean = false)
        {
            super(type);
            this.isHangar = isHangar;
            this.isEvent = isEvent;
        }

        override public function clone():Event
        {
            return new HangarStateEvent(type, isHangar, isEvent);
        }
    }
}

