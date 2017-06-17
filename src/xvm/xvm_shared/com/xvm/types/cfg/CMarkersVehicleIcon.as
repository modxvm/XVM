/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMarkersVehicleIcon implements ICloneable
    {
        public var enabled:*;
        public var showSpeaker:*;
        public var x:*;
        public var y:*;
        public var alpha:*;
        public var color:*;
        public var maxScale:*;
        public var offsetX:*;
        public var offsetY:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            enabled = Macros.FormatBooleanGlobal(enabled, true);
            showSpeaker = Macros.FormatBooleanGlobal(showSpeaker, true);
            x = Macros.FormatNumberGlobal(x);
            y = Macros.FormatNumberGlobal(y);
            color = Macros.FormatNumberGlobal(color);
            maxScale = Macros.FormatNumberGlobal(maxScale, 100);
            offsetX = Macros.FormatNumberGlobal(offsetX, 0);
            offsetY = Macros.FormatNumberGlobal(offsetY, 0);
            // do not apply Macros.FormatNumberGlobal(), because Macros.FormatNumber() used:
            // alpha
        }
    }
}
