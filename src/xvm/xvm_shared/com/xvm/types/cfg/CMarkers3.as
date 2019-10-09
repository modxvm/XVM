/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkers3 implements ICloneable
    {
        public var normal:CMarkers4;
        public var extended:CMarkers4;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            if (normal)
            {
                normal.applyGlobalMacros();
            }
            if (extended)
            {
                extended.applyGlobalMacros();
            }
        }
    }
}
