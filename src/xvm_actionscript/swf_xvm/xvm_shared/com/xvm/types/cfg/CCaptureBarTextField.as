/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCaptureBarTextField implements ICloneable
    {
        public var done:*;
        public var format:*;
        public var shadow:CShadow;
        public var x:*;
        public var y:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
