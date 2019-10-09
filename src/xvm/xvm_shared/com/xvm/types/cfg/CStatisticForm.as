/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CStatisticForm implements ICloneable
    {
        public var extraFieldsLeft:Array;
        public var extraFieldsRight:Array;
        public var formatLeftFrags:String;
        public var formatLeftNick:String;
        public var formatLeftVehicle:String;
        public var formatRightFrags:String;
        public var formatRightNick:String;
        public var formatRightVehicle:String;
        public var fragsFieldOffsetXLeft:*;
        public var fragsFieldOffsetXRight:*;
        public var fragsFieldShowBorder:*;
        public var fragsFieldWidthLeft:*;
        public var fragsFieldWidthRight:*;
        public var nameFieldOffsetXLeft:*;
        public var nameFieldOffsetXRight:*;
        public var nameFieldShowBorder:*;
        public var nameFieldWidthLeft:*;
        public var nameFieldWidthRight:*;
        public var removePlayerStatusIcon:*;
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
        public var vehicleFieldWidthLeft:*;
        public var vehicleFieldWidthRight:*;
        public var vehicleIconAlpha:*;
        public var vehicleIconOffsetXLeft:*;
        public var vehicleIconOffsetXRight:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            fragsFieldOffsetXLeft = Macros.FormatNumberGlobal(fragsFieldOffsetXLeft, 0);
            fragsFieldOffsetXRight = Macros.FormatNumberGlobal(fragsFieldOffsetXRight, 0);
            fragsFieldShowBorder = Macros.FormatBooleanGlobal(fragsFieldShowBorder, false);
            fragsFieldWidthLeft = Macros.FormatNumberGlobal(fragsFieldWidthLeft, 43);
            fragsFieldWidthRight = Macros.FormatNumberGlobal(fragsFieldWidthRight, 43);
            nameFieldOffsetXLeft = Macros.FormatNumberGlobal(nameFieldOffsetXLeft, 0);
            nameFieldOffsetXRight = Macros.FormatNumberGlobal(nameFieldOffsetXRight, 0);
            nameFieldShowBorder = Macros.FormatBooleanGlobal(nameFieldShowBorder, false);
            nameFieldWidthLeft = Macros.FormatNumberGlobal(nameFieldWidthLeft, 174);
            nameFieldWidthRight = Macros.FormatNumberGlobal(nameFieldWidthRight, 168);
            removePlayerStatusIcon = Macros.FormatBooleanGlobal(removePlayerStatusIcon, false);
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
            vehicleFieldWidthLeft = Macros.FormatNumberGlobal(vehicleFieldWidthLeft, 100);
            vehicleFieldWidthRight = Macros.FormatNumberGlobal(vehicleFieldWidthRight, 100);
            vehicleIconAlpha = Macros.FormatNumberGlobal(vehicleIconAlpha, 100);
            vehicleIconOffsetXLeft = Macros.FormatNumberGlobal(vehicleIconOffsetXLeft, 0);
            vehicleIconOffsetXRight = Macros.FormatNumberGlobal(vehicleIconOffsetXRight, 0);
        }
    }
}
