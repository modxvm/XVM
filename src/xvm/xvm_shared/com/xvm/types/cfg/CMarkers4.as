/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkers4 extends Object implements ICloneable
    {
        public var vehicleIcon:*;
        public var healthBar:CMarkersHealthBar;
        public var damageText:*;
        public var damageTextPlayer:*;
        public var damageTextSquadman:*;
        public var contourIcon:*;
        public var levelIcon:*;
        public var actionMarker:*;
        public var textFields:Array;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
