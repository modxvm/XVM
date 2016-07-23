/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkers2 extends Object implements ICloneable
    {
        public var alive:CMarkers3;
        public var dead:CMarkers3;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            if (alive)
            {
                alive.applyGlobalBattleMacros();
            }
            if (dead)
            {
                dead.applyGlobalBattleMacros();
            }
        }
    }
}
