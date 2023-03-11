/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMinimapCircle implements ICloneable
    {
        public var alpha:*;
        public var color:*;
        public var distance:*;
        public var enabled:*;
        public var scale:*;
        public var thickness:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            alpha = Macros.FormatNumberGlobal(alpha);
            color = Macros.FormatNumberGlobal(color);
            distance = Macros.Format(distance, null);
            enabled = Macros.FormatBooleanGlobal(enabled, true);
            scale = Macros.FormatNumberGlobal(scale);
            thickness = Macros.FormatNumberGlobal(thickness);
        }
    }
}
