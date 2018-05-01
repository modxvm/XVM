/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMarkersDamageIndicator implements ICloneable
    {
        public var enabled:*;
        public var showText:*;
        public var x:*;
        public var y:*;
        public var alpha:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            enabled = Macros.FormatBooleanGlobal(enabled, true);
            showText = Macros.FormatBooleanGlobal(showText, true);
            // do not apply Macros.FormatNumberGlobal(), because Macros.FormatNumber() used:
            // x
            // y
            // alpha
        }
    }
}
