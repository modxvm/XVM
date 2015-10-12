class wot.Minimap.MinimapEvent
{
    public static var ENTRY_INITED:String = "ENTRY_INITED";
    public static var ENTRY_UPDATED:String = "ENTRY_UPDATED";
    public static var ENTRY_NAME_UPDATED:String = "ENTRY_NAME_UPDATED";
    public static var CAMERA_UPDATED:String = "CAMERA_UPDATED";
    public static var ENTRY_LOST:String = "ENTRY_LOST";
    public static var REFRESH:String = "REFRESH";
    public static var SET_STRATEGIC_POS:String = "SET_STRATEGIC_POS";

    private var _type:String;
    private var _entry:net.wargaming.ingame.MinimapEntry;
    private var _value:Object;

    public function MinimapEvent(type:String, entry:net.wargaming.ingame.MinimapEntry, value:Object)
    {
        _type = type;
        _entry = entry;
        _value = value;
    }

    public function get type():String
    {
        return _type;
    }

    public function get entry():net.wargaming.ingame.MinimapEntry
    {
        return _entry;
    }

    public function get value():Object
    {
        return _value;
    }
}
