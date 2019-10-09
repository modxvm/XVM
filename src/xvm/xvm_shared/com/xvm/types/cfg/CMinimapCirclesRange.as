/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMinimapCirclesRange implements ICloneable
    {
        public var alpha:*;
        public var color:*;
        public var enabled:*;
        public var thickness:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            alpha = Macros.FormatNumberGlobal(alpha);
            color = Macros.FormatNumberGlobal(color);
            enabled = Macros.FormatBooleanGlobal(enabled, true);
            thickness = Macros.FormatNumberGlobal(thickness);
        }
    }
}
