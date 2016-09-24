/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMinimapLine extends Object implements ICloneable
    {
        public var enabled:*;
        public var inmeters:*;
        public var color:*;
        public var from:*;
        public var to:*;
        public var thickness:*;
        public var alpha:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal static function parse(format:Object):CMinimapLine
        {
            return ObjectConverter.convertData(format, CMinimapLine);
        }

        internal function applyGlobalBattleMacros():void
        {
            enabled = Macros.FormatBooleanGlobal(enabled, true);
            inmeters = Macros.FormatBooleanGlobal(inmeters, true);
            color = Macros.FormatNumberGlobal(color);
            from = Macros.FormatNumberGlobal(from);
            to = Macros.FormatNumberGlobal(to);
            thickness = Macros.FormatNumberGlobal(thickness);
            alpha = Macros.FormatNumberGlobal(alpha);
        }
    }
}
