/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkersVehicleIcon extends Object implements ICloneable
    {
        public var enabled:*;
        public var showSpeaker:*;
        public var x:*;
        public var y:*;
        public var alpha:*;
        public var color:*;
        public var maxScale:*;
        public var scaleX:*;
        public var scaleY:*;
        public var shadow:CShadow;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
