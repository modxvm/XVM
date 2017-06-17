/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMarkersContourIcon implements ICloneable
    {
        public var enabled:*;
        public var x:*;
        public var y:*;
        public var alpha:*;
        public var color:*;
        public var amount:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            enabled = Macros.FormatBooleanGlobal(enabled, true);
            x = Macros.FormatNumberGlobal(x);
            y = Macros.FormatNumberGlobal(y);
            alpha = Macros.FormatNumberGlobal(alpha, 100);
            color = Macros.FormatNumberGlobal(color);
            amount = Macros.FormatNumberGlobal(amount, 0);
        }
    }
}
