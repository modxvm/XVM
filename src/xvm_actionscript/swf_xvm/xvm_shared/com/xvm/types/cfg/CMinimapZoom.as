/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMinimapZoom implements ICloneable
    {
        public var centered:*;
        public var index:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            centered = Macros.FormatBooleanGlobal(centered, false);
            index = Macros.FormatNumberGlobal(index);
        }
    }
}
