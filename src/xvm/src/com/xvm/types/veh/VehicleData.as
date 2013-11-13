package com.xvm.types.veh
{
    import net.wg.data.daapi.base.*;

    //public dynamic class VehicleData extends DAAPIDataClass
    public class VehicleData extends DAAPIDataClass
    {
        public var vid:int;
        public var key:String;

        public var level:int;
        public var vclass:String;
        public var nation:String;
        public var premium:Boolean;
        public var visRadius:int;
        public var hpStock:int;
        public var hpTop:int;

        public var tierLo:int;
        public var tierHi:int;

        public var localizedName:String; // can be overrided by user
        public var localizedShortName:String;
        public var localizedFullName:String;

        public var turret:int;

        // additional

        public var shortName:String;

        public var avg:StatValues;
        public var top:StatValues;

        public function VehicleData(data:Object)
        {
            if (data.avg != null && !(data.avg is StatValues))
                data.avg = new StatValues(data.avg);
            if (data.top != null && !(data.top is StatValues))
                data.top = new StatValues(data.top);
            super(data);
        }

        // PROPERTIES

        public function get vtype():String
        {
            return VClassToVType(vclass);
        }

        // PRIVATE

        // vclass = "mediumTank"
        // vtype = "MT"
        private static function VClassToVType(vclass:String):String
        {
            switch (vclass)
            {
                case "lightTank": return "LT";
                case "mediumTank": return "MT";
                case "heavyTank": return "HT";
                case "AT-SPG": return "TD";
                case "SPG": return "SPG";
                default: return "";
            }
        }
   }
}

class StatValues extends net.wg.data.daapi.base.DAAPIDataClass
{
    public var R:Number;
    public var D:Number;
    public var E:Number;
    public var F:Number;
    public var S:Number;
    public var U:Number;

    public function StatValues(data:Object)
    {
      super(data);
    }
}
