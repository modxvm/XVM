/**
 * XVM Config - "battleLoading" section
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CBattleLoading extends Object
    {
        // Show clock at Battle Loading Screen.
        // ### Is there a clock:on\off switch variable supposed to be? ###
        // A: No, it is possible to set clockFormat: "" to disable clock.

        public var clockFormat:String;      // Format: http://php.net/date

        public var showBattleTier:*;
        public var removeSquadIcon:*;
        public var removeVehicleLevel:*;
        public var removeVehicleTypeIcon:*;
        public var squadIconOffsetXLeft:*;
        public var squadIconOffsetXRight:*;
        public var nameFieldShowBorder:*;
        public var vehicleFieldShowBorder:*;
        public var nameFieldOffsetXLeft:*;
        public var nameFieldWidthDeltaLeft:*;
        public var nameFieldOffsetXRight:*;
        public var nameFieldWidthDeltaRight:*;
        public var vehicleFieldOffsetXLeft:*;
        public var vehicleFieldWidthDeltaLeft:*;
        public var vehicleFieldOffsetXRight:*;
        public var vehicleFieldWidthDeltaRight:*;
        public var vehicleIconOffsetXLeft:*;
        public var vehicleIconOffsetXRight:*;
        public var clanIcon:CClanIcon;
        // Dispay formats.
        public var darkenNotReadyIcon:*;
        public var formatLeftNick:String;
        public var formatLeftVehicle:String;
        public var formatRightNick:String;
        public var formatRightVehicle:String;
    }
}
