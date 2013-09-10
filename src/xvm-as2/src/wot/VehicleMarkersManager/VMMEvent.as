class wot.VehicleMarkersManager.VMMEvent
{
    public static var ALT_STATE_INFORM:String = "ALT_STATE_INFORM";

    private var _type:String;
    private var _payload:Object;

    public function VMMEvent(type:String, payload:Object)
    {
        _type = type;
        if (payload)
            _payload = payload;
    }

    public function get type():String
    {
        return _type;
    }

    public function get payload():Object
    {
        return _payload;
    }
}
