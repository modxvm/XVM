/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CBattle implements ICloneable
    {
        public var mirroredVehicleIcons:*;
        public var highlightVehicleIcon:*;
        public var clockFormat:String;
        public var sixthSenseIcon:String;
        public var elements:Array;
        public var camera:CCamera;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            mirroredVehicleIcons = Macros.FormatBooleanGlobal(mirroredVehicleIcons, true);
            highlightVehicleIcon = Macros.FormatBooleanGlobal(highlightVehicleIcon, true);
            clockFormat = Macros.FormatStringGlobal(clockFormat, "H:i");
            sixthSenseIcon = Macros.FormatStringGlobal(sixthSenseIcon, "xvm://res/SixthSense.png");
        }
    }
}
