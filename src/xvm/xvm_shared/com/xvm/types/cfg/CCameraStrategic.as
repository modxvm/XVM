/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCameraStrategic implements ICloneable
    {
        public var distRange:Array;
        public var dynamicCameraEnabled:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
