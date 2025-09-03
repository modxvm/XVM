/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMarkersHoverMarker implements ICloneable
    {
        public var alpha:*;
        public var enabled:*;
        public var x:*;
        public var y:*;
        public var glow:CMarkersHoverMarkerGlow;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            if (glow)
            {
               glow.applyGlobalMacros();
            }
            enabled = Macros.FormatBooleanGlobal(enabled, true);
        }
    }
}
