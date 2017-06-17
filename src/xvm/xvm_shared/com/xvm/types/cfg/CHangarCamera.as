/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CHangarCamera implements ICloneable
    {
        public var minDistance:*;
        public var maxDistance:*;
        public var startDistance:*;
        public var zoomSensitivity:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
