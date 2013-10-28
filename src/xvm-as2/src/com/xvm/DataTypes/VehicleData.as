class com.xvm.DataTypes.VehicleData
{
    public var vid:Number;
    public var key:String;

    public var level:Number;
    public var vclass:String;
    public var nation:String;
    public var premium:Boolean;
    public var hpStock:Number;
    public var hpTop:Number;

    public var tierLo:Number;
    public var tierHi:Number;

    public var localizedName:String; // can be overrided by user
    public var localizedShortName:String;
    public var localizedFullName:String;

    public var turret:Number;

    // additional

    public var shortName:String;

    public var avg;
    public var top;

    // CTOR

    public function VehicleData(obj:Object)
    {
        for (var n in obj)
            this[n] = obj[n];
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
