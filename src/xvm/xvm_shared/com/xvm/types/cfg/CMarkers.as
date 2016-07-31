/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkers extends Object implements ICloneable
    {
        public var enabled:*;
        public var turretMarkers:CMarkersTurretMarkers;
        public var ally:CMarkers2;
        public var enemy:CMarkers2;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            if (ally)
            {
                ally.applyGlobalBattleMacros();
            }
            if (enemy)
            {
                enemy.applyGlobalBattleMacros();
            }
        }
    }
}
