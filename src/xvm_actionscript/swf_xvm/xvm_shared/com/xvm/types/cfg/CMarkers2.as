/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkers2 implements ICloneable
    {
        public var alive:CMarkers3;
        public var dead:CMarkers3;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            if (alive)
            {
                alive.applyGlobalMacros();
            }
            if (dead)
            {
                dead.applyGlobalMacros();
            }
        }
    }
}
