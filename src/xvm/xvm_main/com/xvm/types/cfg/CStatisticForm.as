/**
 * XVM Config - "statisticForm" section
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CStatisticForm extends Object
    {
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
        public var formatLeftNick:String;
        public var formatLeftVehicle:String;
        public var formatRightNick:String;
        public var formatRightVehicle:String;
    }
}
