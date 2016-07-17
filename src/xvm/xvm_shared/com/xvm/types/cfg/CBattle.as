/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CBattle extends Object implements ICloneable
    {
        public var mirroredVehicleIcons:*;
        public var showPostmortemTips:*;
        public var highlightVehicleIcon:*;
        public var clockFormat:String;
        public var clanIconsFolder:String;
        public var sixthSenseIcon:String;
        public var elements:Array;
        public var camera:CCamera;
        public var minimapDeadSwitch:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
