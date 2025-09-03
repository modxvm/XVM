/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkersTurretMarkers implements ICloneable
    {
        public var highVulnerability:String;
        public var lowVulnerability:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
