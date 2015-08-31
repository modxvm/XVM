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

        public var showBattleTier:Boolean;
        public var removeSquadIcon:Boolean;
        public var removeVehicleLevel:Boolean;
        public var removeVehicleTypeIcon:Boolean;
        public var squadIconOffsetXLeft:Number;
        public var squadIconOffsetXRight:Number;
        public var nameFieldOffsetXLeft:Number;
        public var nameFieldOffsetXRight:Number;
        public var vehicleFieldOffsetXLeft:Number;
        public var vehicleFieldOffsetXRight:Number;
        public var vehicleIconOffsetXLeft:Number;
        public var vehicleIconOffsetXRight:Number;
        public var clanIcon:CClanIcon;
        // Dispay formats.
        public var darkenNotReadyIcon:Boolean;
        public var formatLeftNick:String;
        public var formatLeftVehicle:String;
        public var formatRightNick:String;
        public var formatRightVehicle:String;
    }
}
