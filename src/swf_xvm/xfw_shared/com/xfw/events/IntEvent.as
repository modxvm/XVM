/**
 * XFW
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xfw.events
{
    import flash.events.*;

    public class IntEvent extends Event
    {
        public var value:int;

        public function IntEvent(type:String, value:int, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
            this.value = value;
        }

        public override function clone():Event
        {
            return new IntEvent(type, value, bubbles, cancelable);
        }
    }

}
