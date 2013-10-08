package com.xvm.types.veh
{
    public class VehicleData
    {
        public var id:Number;
        public var level:Number;
        public var type:VehicleType;
        public var hpStock:Number;
        public var hpTop:Number;
        public var turret:Number;
        public var premium:Boolean;
        public var nation:String;
        public var name:String;
        public var translationKey:String;

        public var localizedName:String;

        public var tiersLo:int;
        public var tiersHi:int;
        public var preferredName:String;
        public var shortName:String;

        public var avg:StatValues;
        public var top:StatValues;
    }
}

class StatValues
{
    public var R:Number;
    public var D:Number;
    public var E:Number;
    public var F:Number;
    public var S:Number;
    public var U:Number;
}
