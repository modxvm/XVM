/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CBattleLoading extends Object implements ICloneable
    {
        public var clockFormat:String;
        public var showBattleTier:*;
        public var removeSquadIcon:*;
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
        public var formatLeftFrags:String;
        public var formatRightFrags:String;
        public var extraFieldsLeft:Array;
        public var extraFieldsRight:Array;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
