/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
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
        public var maxScale:*;
        public var offsetX:*;
        public var offsetY:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            enabled = Macros.FormatBooleanGlobal(enabled, true);
            showSpeaker = Macros.FormatBooleanGlobal(showSpeaker, true);
            x = Macros.FormatNumberGlobal(x);
            y = Macros.FormatNumberGlobal(y);
            maxScale = Macros.FormatNumberGlobal(maxScale, 100);
            offsetX = Macros.FormatNumberGlobal(offsetX, 0);
            offsetY = Macros.FormatNumberGlobal(offsetY, 0);
        }
    }
}
