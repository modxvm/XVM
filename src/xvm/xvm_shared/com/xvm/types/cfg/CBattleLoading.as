/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CBattleLoading extends Object implements ICloneable
    {
        public var clockFormat:String;
        public var showBattleTier:*;
        public var removeSquadIcon:*;
        public var removeRankIcon:*;
        public var vehicleIconAlpha:*;
        public var removeVehicleLevel:*;
        public var removeVehicleTypeIcon:*;
        public var nameFieldShowBorder:*;
        public var vehicleFieldShowBorder:*;
        public var squadIconOffsetXLeft:*;
        public var squadIconOffsetXRight:*;
        public var nameFieldOffsetXLeft:*;
        public var nameFieldOffsetXRight:*;
        public var nameFieldWidthDeltaLeft:*;
        public var nameFieldWidthDeltaRight:*;
        public var vehicleFieldOffsetXLeft:*;
        public var vehicleFieldOffsetXRight:*;
        public var vehicleFieldWidthDeltaLeft:*;
        public var vehicleFieldWidthDeltaRight:*;
        public var vehicleIconOffsetXLeft:*;
        public var vehicleIconOffsetXRight:*;
        public var darkenNotReadyIcon:*;
        public var formatLeftNick:String;
        public var formatRightNick:String;
        public var formatLeftVehicle:String;
        public var formatRightVehicle:String;
        public var extraFieldsLeft:Array;
        public var extraFieldsRight:Array;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            showBattleTier = Macros.FormatBooleanGlobal(showBattleTier, true);
            removeSquadIcon = Macros.FormatBooleanGlobal(removeSquadIcon, false);
            removeRankIcon = Macros.FormatBooleanGlobal(removeRankIcon, false);
            vehicleIconAlpha = Macros.FormatNumberGlobal(vehicleIconAlpha, 100);
            removeVehicleLevel = Macros.FormatBooleanGlobal(removeVehicleLevel, false);
            removeVehicleTypeIcon = Macros.FormatBooleanGlobal(removeVehicleTypeIcon, false);
            nameFieldShowBorder = Macros.FormatBooleanGlobal(nameFieldShowBorder, false);
            vehicleFieldShowBorder = Macros.FormatBooleanGlobal(vehicleFieldShowBorder, false);
            squadIconOffsetXLeft = Macros.FormatNumberGlobal(squadIconOffsetXLeft, 0);
            squadIconOffsetXRight = Macros.FormatNumberGlobal(squadIconOffsetXRight, 0);
            nameFieldOffsetXLeft = Macros.FormatNumberGlobal(nameFieldOffsetXLeft, 0);
            nameFieldOffsetXRight = Macros.FormatNumberGlobal(nameFieldOffsetXRight, 0);
            nameFieldWidthDeltaLeft = Macros.FormatNumberGlobal(nameFieldWidthDeltaLeft, 0);
            nameFieldWidthDeltaRight = Macros.FormatNumberGlobal(nameFieldWidthDeltaRight, 0);
            vehicleFieldOffsetXLeft = Macros.FormatNumberGlobal(vehicleFieldOffsetXLeft, 0);
            vehicleFieldOffsetXRight = Macros.FormatNumberGlobal(vehicleFieldOffsetXRight, 0);
            vehicleFieldWidthDeltaLeft = Macros.FormatNumberGlobal(vehicleFieldWidthDeltaLeft, 0);
            vehicleFieldWidthDeltaRight = Macros.FormatNumberGlobal(vehicleFieldWidthDeltaRight, 0);
            vehicleIconOffsetXLeft = Macros.FormatNumberGlobal(vehicleIconOffsetXLeft, 0);
            vehicleIconOffsetXRight = Macros.FormatNumberGlobal(vehicleIconOffsetXRight, 0);
            // do not process
            //clockFormat
            //darkenNotReadyIcon
            //formatLeftNick
            //formatLeftVehicle
            //formatRightNick
            //formatRightVehicle
            //extraFieldsLeft
            //extraFieldsRight
        }
    }
}
