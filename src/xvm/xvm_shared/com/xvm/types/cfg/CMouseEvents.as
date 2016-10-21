/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMouseEvents extends Object implements ICloneable
    {
        public var click:String;
        public var mouseDown:String;
        public var mouseUp:String;
        public var mouseOver:String;
        public var mouseOut:String;
        public var mouseMove:String;
        public var mouseWheel:String;

        public function clone():*
        {
            var cloned:CMouseEvents = new CMouseEvents();
            cloned.click = click;
            cloned.mouseDown = mouseDown;
            cloned.mouseUp = mouseUp;
            cloned.mouseOver = mouseOver;
            cloned.mouseOut = mouseOut;
            cloned.mouseMove = mouseMove;
            cloned.mouseWheel = mouseWheel;
            return cloned;
        }
    }
}
