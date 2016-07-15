/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkersTurretMarkers extends Object implements ICloneable
    {
        public var highVulnerability:String;
        public var lowVulnerability:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
