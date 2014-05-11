class wot.VehicleMarkersManager.VMMEvent
{
    public static var ALT_STATE_INFORM:String = "ALT_STATE_INFORM";

    private var _type:String;
    private var _value:Object;

    public function VMMEvent(type:String, value:Object)
    {
        _type = type;
        _value = value;
    }

    public function get type():String
    {
        return _type;
    }

    public function get value():Object
    {
        return _value;
    }
}
