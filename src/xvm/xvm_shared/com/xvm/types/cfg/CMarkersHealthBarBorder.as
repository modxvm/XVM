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
            size = Macros.FormatNumberGlobal(size, 1);
            if (color == null)
            {
                color = "{{c:system}}";
            }
            // do not apply Macros.FormatNumberGlobal(), because Macros.FormatNumber() used:
            // alpha
            // color
        }
    }
}
