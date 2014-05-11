class wot.Minimap.MinimapEvent
{
    public static var MINIMAP_READY:String = "MINIMAP_READY";
    public static var PANEL_READY:String = "PANEL_READY";
    public static var ENTRY_REVEALED:String = "ENTRY_REVEALED";
    public static var ENTRY_LOST:String = "ENTRY_LOST";

    /** Used for camera atachments redraw */
    public static var ON_ENTRY_INITED:String = "ON_ENTRY_INITED";

    private var _type:String;
    private var _value:Object;

    public function MinimapEvent(type:String, value:Object)
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
