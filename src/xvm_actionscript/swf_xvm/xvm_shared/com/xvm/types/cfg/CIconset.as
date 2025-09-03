/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CIconset implements ICloneable
    {
        public var battleLoadingLeftAtlas:String;
        public var battleLoadingRightAtlas:String;
        public var fullStatsLeftAtlas:String;
        public var fullStatsRightAtlas:String;
        public var playersPanelLeftAtlas:String;
        public var playersPanelRightAtlas:String;
        public var vehicleMarkerAllyAtlas:String;
        public var vehicleMarkerEnemyAtlas:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
