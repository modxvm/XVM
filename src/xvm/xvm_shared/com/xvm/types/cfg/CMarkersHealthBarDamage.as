/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMarkersHealthBarDamage extends Object implements ICloneable
    {
        public var alpha:*;
        public var color:*;
        public var fade:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            fade = Macros.FormatNumberGlobal(fade);
        }
    }
}
