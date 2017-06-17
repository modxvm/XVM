/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkers implements ICloneable
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
