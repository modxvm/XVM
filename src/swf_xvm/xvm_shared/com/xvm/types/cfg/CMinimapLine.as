/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMinimapLine implements ICloneable
    {
        public var alpha:*;
        public var color:*;
        public var enabled:*;
        public var from:*;
        public var inmeters:*;
        public var thickness:*;
        public var to:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            alpha = Macros.FormatNumberGlobal(alpha);
            color = Macros.FormatNumberGlobal(color);
            enabled = Macros.FormatBooleanGlobal(enabled, true);
            from = Macros.FormatNumberGlobal(from);
            inmeters = Macros.FormatBooleanGlobal(inmeters, true);
            thickness = Macros.FormatNumberGlobal(thickness);
            to = Macros.FormatNumberGlobal(to);
        }
    }
}
