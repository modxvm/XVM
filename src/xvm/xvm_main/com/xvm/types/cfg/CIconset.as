/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CIconset extends Object implements ICloneable
    {
        public var battleLoadingAlly:String;
        public var battleLoadingEnemy:String;
        public var playersPanelLeftAtlas:String;
        public var playersPanelRightAtlas:String;
        public var fullStatsLeftAtlas:String;
        public var fullStatsRightAtlas:String;
        public var vehicleMarkerLeftAtlas:String;
        public var vehicleMarkerRightAtlas:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
