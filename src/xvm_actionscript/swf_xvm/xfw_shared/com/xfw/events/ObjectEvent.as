/**
 * XFW
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xfw.events
{
    import flash.events.*;

    public class ObjectEvent extends Event
    {
        public var result:Object;

        public function ObjectEvent(type:String, result:Object, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
            this.result = result;
        }

        public override function clone():Event
        {
            return new ObjectEvent(type, result, bubbles, cancelable);
        }
    }

}
