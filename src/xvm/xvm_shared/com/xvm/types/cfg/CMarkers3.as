/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
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

        internal function applyGlobalBattleMacros():void
        {
            if (normal)
            {
                normal.applyGlobalBattleMacros();
            }
            if (extended)
            {
                extended.applyGlobalBattleMacros();
            }
        }
    }
}
