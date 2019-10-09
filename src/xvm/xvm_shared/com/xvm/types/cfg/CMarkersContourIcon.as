/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMarkersContourIcon implements ICloneable
    {
        public var alpha:*;
        public var amount:*;
        public var color:*;
        public var enabled:*;
        public var x:*;
        public var y:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            alpha = Macros.FormatNumberGlobal(alpha, 100);
            amount = Macros.FormatNumberGlobal(amount, 0);
            color = Macros.FormatNumberGlobal(color);
            enabled = Macros.FormatBooleanGlobal(enabled, true);
            x = Macros.FormatNumberGlobal(x);
            y = Macros.FormatNumberGlobal(y);
        }
    }
}
