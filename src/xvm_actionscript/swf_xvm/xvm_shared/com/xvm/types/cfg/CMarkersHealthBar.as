/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMarkersHealthBar implements ICloneable
    {
        public var alpha:*;
        public var border:CMarkersHealthBarBorder;
        public var color:*;
        public var damage:CMarkersHealthBarDamage;
        public var enabled:*;
        public var fill:CMarkersHealthBarFill;
        public var height:*;
        public var lcolor:*;
        public var width:*;
        public var x:*;
        public var y:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            if (border)
            {
               border.applyGlobalMacros();
            }
            if (color == null)
            {
                color = "{{c:system}}";
            }
            if (damage)
            {
                damage.applyGlobalMacros();
            }
            enabled = Macros.FormatBooleanGlobal(enabled, true);
            height = Macros.FormatNumberGlobal(height);
            if (lcolor == null)
            {
                lcolor = "{{c:system}}";
            }
            width = Macros.FormatNumberGlobal(width);
            x = Macros.FormatNumberGlobal(x);
            y = Macros.FormatNumberGlobal(y);
        }
    }
}
