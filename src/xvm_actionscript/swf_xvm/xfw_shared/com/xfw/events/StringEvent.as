/**
 * XFW
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xfw.events
{
    import flash.events.*;

    public class StringEvent extends Event
    {
        public var value:String;

        public function StringEvent(type:String, value:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
            this.value = value;
        }

        public override function clone():Event
        {
            return new StringEvent(type, value, bubbles, cancelable);
        }
    }

}
