/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMarkersHealthBar extends Object implements ICloneable
    {
        public var enabled:*;
        public var x:*;
        public var y:*;
        public var alpha:*;
        public var color:*;
        public var lcolor:*;
        public var width:*;
        public var height:*;
        public var border:CMarkersHealthBarBorder;
        public var fill:CMarkersHealthBarFill;
        public var damage:CMarkersHealthBarDamage;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            enabled = Macros.FormatBooleanGlobal(enabled, true);
            x = Macros.FormatNumberGlobal(x);
            y = Macros.FormatNumberGlobal(y);
            width = Macros.FormatNumberGlobal(width);
            height = Macros.FormatNumberGlobal(height);
            if (border)
            {
               border.applyGlobalBattleMacros();
            }
            if (fill)
            {
                fill.applyGlobalBattleMacros();
            }
            if (damage)
            {
                damage.applyGlobalBattleMacros();
            }
            if (color == null)
            {
                color = "{{c:system}}";
            }
            if (lcolor == null)
            {
                lcolor = "{{c:system}}";
            }
            // do not apply Macros.FormatNumberGlobal(), because Macros.FormatNumber() used:
            // alpha
            // color
            // lcolor
        }
    }
}
