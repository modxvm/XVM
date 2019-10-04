/**
 * XFW
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xfw.events
{
    import flash.events.*;

    public class BooleanEvent extends Event
    {
        public var value:Boolean;

        public function BooleanEvent(type:String, value:Boolean, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
            this.value = value;
        }

        public override function clone():Event
        {
            return new BooleanEvent(type, value, bubbles, cancelable);
        }
    }

}
