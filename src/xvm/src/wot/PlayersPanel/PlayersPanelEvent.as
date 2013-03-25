class wot.PlayersPanel.PlayersPanelEvent
{
    public static var ENEMY_REVEALED:String = "PP_ENEMY_REVEALED";
    public static var ENEMY_DIED:String = "PP_ENEMY_DIED";
    
    private var _type:String;
    private var _payload:Object;
    
    public function PlayersPanelEvent(type:String, payload:Object) 
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
