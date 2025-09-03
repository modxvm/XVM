/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMouseEvents implements ICloneable
    {
        public var click:String;
        public var mouseDown:String;
        public var mouseMove:String;
        public var mouseOver:String;
        public var mouseOut:String;
        public var mouseUp:String;
        public var mouseWheel:String;

        public function clone():*
        {
            var cloned:CMouseEvents = new CMouseEvents();
            cloned.click = click;
            cloned.mouseDown = mouseDown;
            cloned.mouseMove = mouseMove;
            cloned.mouseOver = mouseOver;
            cloned.mouseOut = mouseOut;
            cloned.mouseUp = mouseUp;
            cloned.mouseWheel = mouseWheel;
            return cloned;
        }
    }
}
