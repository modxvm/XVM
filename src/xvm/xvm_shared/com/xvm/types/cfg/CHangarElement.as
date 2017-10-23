/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CHangarElement implements ICloneable
    {
        public var enabled:*;
        public var alpha:*;
        public var rotation:*;
        public var shiftX:*;
        public var shiftY:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
