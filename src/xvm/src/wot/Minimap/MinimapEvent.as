class wot.Minimap.MinimapEvent
{
    public static var MINIMAP_READY:String = "MINIMAP_READY";
    public static var ENEMY_PLAYERS_PANEL_READY:String = "ENEMY_PLAYERS_PANEL_READY";
    public static var ALLY_PLAYERS_PANEL_READY:String = "ALLY_PLAYERS_PANEL_READY";
    public static var REMOVE_OBSOLETE_ICON:String = "REMOVE_ICON";
    
    private var _type:String;
    private var _payload:Object;
    
    public function MinimapEvent(type:String, payload:Object) 
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
