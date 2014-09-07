package net.wg.gui.cyberSport.views.autoSearch
{
    import net.wg.gui.components.advanced.FieldSet;
    import flash.display.MovieClip;
    import net.wg.gui.components.advanced.IndicationOfStatus;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
    
    public class WaitingPlayers extends StateViewBase
    {
        
        public function WaitingPlayers()
        {
            super();
            currentState = CYBER_SPORT_ALIASES.AUTO_SEARCH_WAITING_PLAYERS_STATE;
            mainField.text = CYBERSPORT.WINDOW_AUTOSEARCH_WAITINGPLAYERS_MAINTEXT;
            cancelButton.label = CYBERSPORT.WINDOW_AUTOSEARCH_SEARCHCOMMAND_CANCELLBL;
            this.players = new <IndicationOfStatus>[this.player1,this.player2,this.player3,this.player4,this.player5,this.player6,this.player7];
            this.buttonsBG.visible = false;
            cancelButton.visible = false;
        }
        
        public var fieldSet:FieldSet;
        
        public var buttonsBG:MovieClip;
        
        public var player1:IndicationOfStatus = null;
        
        public var player2:IndicationOfStatus = null;
        
        public var player3:IndicationOfStatus = null;
        
        public var player4:IndicationOfStatus = null;
        
        public var player5:IndicationOfStatus = null;
        
        public var player6:IndicationOfStatus = null;
        
        public var player7:IndicationOfStatus = null;
        
        private var players:Vector.<IndicationOfStatus> = null;
        
        override protected function updateView() : void
        {
            super.updateView();
            this.buttonsBG.visible = cancelButton.visible = model.canInvokeAutoSearch;
            updateTime();
            startTimer();
            this.initPlayersState(model.playersReadiness);
        }
        
        private function initPlayersState(param1:Array) : void
        {
            var _loc2_:uint = param1.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                if(param1[_loc3_] == null)
                {
                    this.players[_loc3_].status = IndicationOfStatus.STATUS_LOCKED;
                }
                else
                {
                    this.players[_loc3_].status = param1[_loc3_]?IndicationOfStatus.STATUS_READY:IndicationOfStatus.STATUS_NORMAL;
                }
                _loc3_++;
            }
        }
        
        override protected function onTimer() : void
        {
            super.onTimer();
            updateTime();
            startTimer();
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:IndicationOfStatus = null;
            if(this.players)
            {
                _loc1_ = this.players.pop();
                _loc1_.dispose();
                _loc1_ = null;
                this.players = null;
            }
            super.onDispose();
        }
        
        override protected function cancelButtonOnClick(param1:ButtonEvent = null) : void
        {
            super.cancelButtonOnClick(param1);
            cancelButton.enabled = false;
        }
    }
}
