package net.wg.gui.lobby.fortifications.events
{
    import flash.events.Event;
    
    public class FortBattleResultsEvent extends Event
    {
        
        public function FortBattleResultsEvent(param1:String, param2:int = -1)
        {
            super(param1,true,true);
            this.rendererID = param2;
        }
        
        public static var MORE_BTN_CLICK:String = "moreBtnClick";
        
        public var rendererID:int = -1;
    }
}
