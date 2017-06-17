/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CStatisticForm implements ICloneable
    {
        public var showBattleTier:*;
        public var removeSquadIcon:*;
        public var removeRankBadgeIcon:*;
        public var vehicleIconAlpha:*;
        public var removeVehicleLevel:*;
        public var removeVehicleTypeIcon:*;
        public var removePlayerStatusIcon:*;
        public var nameFieldShowBorder:*;
        public var vehicleFieldShowBorder:*;
        public var fragsFieldShowBorder:*;
        public var squadIconOffsetXLeft:*;
        public var squadIconOffsetXRight:*;
        public var nameFieldOffsetXLeft:*;
        public var nameFieldWidthLeft:*;
        public var nameFieldOffsetXRight:*;
        public var nameFieldWidthRight:*;
        public var vehicleFieldOffsetXLeft:*;
        public var vehicleFieldWidthLeft:*;
        public var vehicleFieldOffsetXRight:*;
        public var vehicleFieldWidthRight:*;
        public var vehicleIconOffsetXLeft:*;
        public var vehicleIconOffsetXRight:*;
        public var fragsFieldOffsetXLeft:*;
        public var fragsFieldWidthLeft:*;
        public var fragsFieldOffsetXRight:*;
        public var fragsFieldWidthRight:*;
        public var formatLeftNick:String;
        public var formatLeftVehicle:String;
        public var formatRightNick:String;
        public var formatRightVehicle:String;
        public var formatLeftFrags:String;
        public var formatRightFrags:String;
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
            removeRankBadgeIcon = Macros.FormatBooleanGlobal(removeRankBadgeIcon, false);
            vehicleIconAlpha = Macros.FormatNumberGlobal(vehicleIconAlpha, 100);
            removeVehicleLevel = Macros.FormatBooleanGlobal(removeVehicleLevel, false);
            removeVehicleTypeIcon = Macros.FormatBooleanGlobal(removeVehicleTypeIcon, false);
            removePlayerStatusIcon = Macros.FormatBooleanGlobal(removePlayerStatusIcon, false);
            nameFieldShowBorder = Macros.FormatBooleanGlobal(nameFieldShowBorder, false);
            vehicleFieldShowBorder = Macros.FormatBooleanGlobal(vehicleFieldShowBorder, false);
            fragsFieldShowBorder = Macros.FormatBooleanGlobal(fragsFieldShowBorder, false);
            squadIconOffsetXLeft = Macros.FormatNumberGlobal(squadIconOffsetXLeft, 0);
            squadIconOffsetXRight = Macros.FormatNumberGlobal(squadIconOffsetXRight, 0);
            nameFieldOffsetXLeft = Macros.FormatNumberGlobal(nameFieldOffsetXLeft, 0);
            nameFieldWidthLeft = Macros.FormatNumberGlobal(nameFieldWidthLeft, 174);
            nameFieldOffsetXRight = Macros.FormatNumberGlobal(nameFieldOffsetXRight, 0);
            nameFieldWidthRight = Macros.FormatNumberGlobal(nameFieldWidthRight, 168);
            vehicleFieldOffsetXLeft = Macros.FormatNumberGlobal(vehicleFieldOffsetXLeft, 0);
            vehicleFieldWidthLeft = Macros.FormatNumberGlobal(vehicleFieldWidthLeft, 100);
            vehicleFieldOffsetXRight = Macros.FormatNumberGlobal(vehicleFieldOffsetXRight, 0);
            vehicleFieldWidthRight = Macros.FormatNumberGlobal(vehicleFieldWidthRight, 100);
            vehicleIconOffsetXLeft = Macros.FormatNumberGlobal(vehicleIconOffsetXLeft, 0);
            vehicleIconOffsetXRight = Macros.FormatNumberGlobal(vehicleIconOffsetXRight, 0);
            fragsFieldOffsetXLeft = Macros.FormatNumberGlobal(fragsFieldOffsetXLeft, 0);
            fragsFieldWidthLeft = Macros.FormatNumberGlobal(fragsFieldWidthLeft, 43);
            fragsFieldOffsetXRight = Macros.FormatNumberGlobal(fragsFieldOffsetXRight, 0);
            fragsFieldWidthRight = Macros.FormatNumberGlobal(fragsFieldWidthRight, 43);
            // do not process
            //formatLeftNick
            //formatLeftVehicle
            //formatRightNick
            //formatRightVehicle
            //formatLeftFrags
            //formatRightFrags
            //extraFieldsLeft
            //extraFieldsRight
        }
    }
}
