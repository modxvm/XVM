package net.wg.gui.lobby.fortifications.events
{
    import flash.events.Event;
    import flash.display.DisplayObject;
    
    public class FortSettingsEvent extends Event
    {
        
        public function FortSettingsEvent(param1:String)
        {
            super(param1,true,true);
        }
        
        public static var CLICK_BLOCK_BUTTON:String = "clickBlockButton";
        
        public static var ACTIVATE_DEFENCE_PERIOD:String = "activateDefencePeriod";
        
        public static var DISABLE_DEFENCE_PERIOD:String = "disableDefencePeriod";
        
        public static var CANCEL_DISABLE_DEFENCE_PERIOD:String = "cancelDisableDefencePeriod";
        
        private var _blockButtonPoints:DisplayObject = null;
        
        public function get blockButtonPoints() : DisplayObject
        {
            return this._blockButtonPoints;
        }
        
        public function set blockButtonPoints(param1:DisplayObject) : void
        {
            this._blockButtonPoints = param1;
        }
    }
}
