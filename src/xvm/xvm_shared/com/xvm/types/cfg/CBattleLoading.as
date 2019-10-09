/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CBattleLoading implements ICloneable
    {
        public var clockFormat:String;
        public var darkenNotReadyIcon:*;
        public var extraFieldsLeft:Array;
        public var extraFieldsRight:Array;
        public var formatLeftNick:String;
        public var formatLeftVehicle:String;
        public var formatRightNick:String;
        public var formatRightVehicle:String;
        public var nameFieldOffsetXLeft:*;
        public var nameFieldOffsetXRight:*;
        public var nameFieldShowBorder:*;
        public var nameFieldWidthDeltaLeft:*;
        public var nameFieldWidthDeltaRight:*;
        public var removeRankBadgeIcon:*;
        public var removeSquadIcon:*;
        public var removeVehicleLevel:*;
        public var removeVehicleTypeIcon:*;
        public var removeTesterIcon:*;
        public var squadIconOffsetXLeft:*;
        public var squadIconOffsetXRight:*;
        public var vehicleFieldOffsetXLeft:*;
        public var vehicleFieldOffsetXRight:*;
        public var vehicleFieldShowBorder:*;
        public var vehicleFieldWidthDeltaLeft:*;
        public var vehicleFieldWidthDeltaRight:*;
        public var vehicleIconAlpha:*;
        public var vehicleIconOffsetXLeft:*;
        public var vehicleIconOffsetXRight:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            nameFieldOffsetXLeft = Macros.FormatNumberGlobal(nameFieldOffsetXLeft, 0);
            nameFieldOffsetXRight = Macros.FormatNumberGlobal(nameFieldOffsetXRight, 0);
            nameFieldShowBorder = Macros.FormatBooleanGlobal(nameFieldShowBorder, false);
            nameFieldWidthDeltaLeft = Macros.FormatNumberGlobal(nameFieldWidthDeltaLeft, 0);
            nameFieldWidthDeltaRight = Macros.FormatNumberGlobal(nameFieldWidthDeltaRight, 0);
            removeRankBadgeIcon = Macros.FormatBooleanGlobal(removeRankBadgeIcon, false);
            removeSquadIcon = Macros.FormatBooleanGlobal(removeSquadIcon, false);
            removeVehicleLevel = Macros.FormatBooleanGlobal(removeVehicleLevel, false);
            removeVehicleTypeIcon = Macros.FormatBooleanGlobal(removeVehicleTypeIcon, false);
            removeTesterIcon = Macros.FormatBooleanGlobal(removeTesterIcon, false);
            squadIconOffsetXLeft = Macros.FormatNumberGlobal(squadIconOffsetXLeft, 0);
            squadIconOffsetXRight = Macros.FormatNumberGlobal(squadIconOffsetXRight, 0);
            vehicleFieldOffsetXLeft = Macros.FormatNumberGlobal(vehicleFieldOffsetXLeft, 0);
            vehicleFieldOffsetXRight = Macros.FormatNumberGlobal(vehicleFieldOffsetXRight, 0);
            vehicleFieldShowBorder = Macros.FormatBooleanGlobal(vehicleFieldShowBorder, false);
            vehicleFieldWidthDeltaLeft = Macros.FormatNumberGlobal(vehicleFieldWidthDeltaLeft, 0);
            vehicleFieldWidthDeltaRight = Macros.FormatNumberGlobal(vehicleFieldWidthDeltaRight, 0);
            vehicleIconAlpha = Macros.FormatNumberGlobal(vehicleIconAlpha, 100);
            vehicleIconOffsetXLeft = Macros.FormatNumberGlobal(vehicleIconOffsetXLeft, 0);
            vehicleIconOffsetXRight = Macros.FormatNumberGlobal(vehicleIconOffsetXRight, 0);
        }
    }
}
