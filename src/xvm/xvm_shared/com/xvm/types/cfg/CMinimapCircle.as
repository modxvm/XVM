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
        public var enabled:*;
        public var distance:*;
        public var scale:*;
        public var thickness:*;
        public var alpha:*;
        public var color:*;
        public var state:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal static function parse(format:Object):CMinimapCircle
        {
            return ObjectConverter.convertData(format, CMinimapCircle);
        }

        internal function applyGlobalBattleMacros():void
        {
            enabled = Macros.FormatBooleanGlobal(enabled, true);
            distance = Macros.Format(distance, null);
            scale = Macros.FormatNumberGlobal(scale);
            thickness = Macros.FormatNumberGlobal(thickness);
            alpha = Macros.FormatNumberGlobal(alpha);
            color = Macros.FormatNumberGlobal(color);
            state = Macros.FormatNumberGlobal(state, 0);
        }
    }
}
