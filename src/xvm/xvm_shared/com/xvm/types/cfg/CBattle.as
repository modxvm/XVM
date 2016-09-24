/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CBattle extends Object implements ICloneable
    {
        public var mirroredVehicleIcons:*;
        public var showPostmortemTips:*;
        public var highlightVehicleIcon:*;
        public var clockFormat:String;
        public var clanIconsFolder:String;
        public var sixthSenseIcon:String;
        public var sixthSenseDuration:Number;
        public var elements:Array;
        public var camera:CCamera;
        public var minimapDeadSwitch:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            mirroredVehicleIcons = Macros.FormatBooleanGlobal(mirroredVehicleIcons, true);
            showPostmortemTips = Macros.FormatBooleanGlobal(showPostmortemTips, true);
            highlightVehicleIcon = Macros.FormatBooleanGlobal(highlightVehicleIcon, true);
            clockFormat = Macros.FormatStringGlobal(clockFormat, "H:i");
            clanIconsFolder = Macros.FormatStringGlobal(clanIconsFolder, "clanicons/");
            sixthSenseIcon = Macros.FormatStringGlobal(sixthSenseIcon, "xvm://res/SixthSense.png");
            //elements:Array;
            //camera:CCamera;
            minimapDeadSwitch = Macros.FormatBooleanGlobal(minimapDeadSwitch, true);
        }
    }
}
