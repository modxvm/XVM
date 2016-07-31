/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkers3 extends Object implements ICloneable
    {
        public var normal:CMarkers4;
        public var extended:CMarkers4;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            if (normal)
            {
                normal.applyGlobalBattleMacros();
            }
            if (extended)
            {
                extended.applyGlobalBattleMacros();
            }
        }
    }
}
