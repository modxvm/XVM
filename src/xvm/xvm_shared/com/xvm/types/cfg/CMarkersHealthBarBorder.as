/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMarkersHealthBarBorder extends Object implements ICloneable
    {
        public var alpha:*;
        public var color:*;
        public var size:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            alpha = Macros.FormatNumberGlobal(alpha, 35);
            color = Macros.FormatNumberGlobal(color);
            size = Macros.FormatNumberGlobal(size, 1);
        }
    }
}
