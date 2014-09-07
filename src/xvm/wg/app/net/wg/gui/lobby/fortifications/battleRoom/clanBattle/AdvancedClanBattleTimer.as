package net.wg.gui.lobby.fortifications.battleRoom.clanBattle
{
    import net.wg.gui.lobby.fortifications.events.ClanBattleTimerEvent;
    import scaleform.gfx.TextFieldEx;
    
    public class AdvancedClanBattleTimer extends ClanBattleTimer
    {
        
        public function AdvancedClanBattleTimer()
        {
            super();
            this.setVerticalAlign();
        }
        
        private static var NORMAL_STATE:String = "normal";
        
        private static var ALERT_STATE:String = "alert";
        
        private static var ALERT_MIN_TIME:int = 0;
        
        private static var ALERT_SEC_TIME:int = 10;
        
        private var isInAlertState:Boolean = false;
        
        override public function timerTick() : void
        {
            super.timerTick();
            if(this.isInAlertState)
            {
                dispatchEvent(new ClanBattleTimerEvent(ClanBattleTimerEvent.ALERT_TICK));
            }
        }
        
        override protected function updateFilters() : void
        {
            var _loc1_:Array = [];
            if(model)
            {
                if(currentLabel == NORMAL_STATE)
                {
                    _loc1_ = getGlowFilter(model.glowColor);
                }
                else if(currentLabel == ALERT_STATE)
                {
                    _loc1_ = getGlowFilter(model.alertGlowColor);
                }
                
            }
            minutes.filters = _loc1_;
            seconds.filters = _loc1_;
            separator.filters = _loc1_;
        }
        
        override protected function updateText() : void
        {
            var _loc1_:int = getMinutes();
            var _loc2_:int = getSeconds();
            var _loc3_:* = false;
            if(_loc1_ == ALERT_MIN_TIME && _loc2_ <= ALERT_SEC_TIME)
            {
                if(currentLabel != ALERT_STATE)
                {
                    gotoAndStop(ALERT_STATE);
                    _loc3_ = true;
                    this.isInAlertState = true;
                }
            }
            else if(currentLabel != NORMAL_STATE)
            {
                gotoAndStop(NORMAL_STATE);
                _loc3_ = true;
                this.isInAlertState = false;
            }
            
            if(_loc3_)
            {
                this.updateFilters();
                updateSeparator();
                this.setVerticalAlign();
            }
            super.updateText();
        }
        
        override protected function replaceFormatter(param1:String) : String
        {
            if(currentLabel == NORMAL_STATE)
            {
                return super.replaceFormatter(param1);
            }
            if(currentLabel == ALERT_STATE)
            {
                return model.alertHtmlFormatter.replace("###",param1);
            }
            return "error";
        }
        
        private function setVerticalAlign() : void
        {
            TextFieldEx.setVerticalAutoSize(minutes,TextFieldEx.VALIGN_CENTER);
            TextFieldEx.setVerticalAutoSize(seconds,TextFieldEx.VALIGN_CENTER);
            TextFieldEx.setVerticalAutoSize(separator,TextFieldEx.VALIGN_CENTER);
        }
    }
}
