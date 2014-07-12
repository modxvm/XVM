package net.wg.gui.lobby.hangar.ammunitionPanel
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Tooltips;
    
    public class HistoricalModulesOverlay extends UIComponent
    {
        
        public function HistoricalModulesOverlay() {
            super();
        }
        
        public var textField:TextField;
        
        public var historicalBattleID:int = -1;
        
        override protected function configUI() : void {
            super.configUI();
            this.textField.text = HISTORICAL_BATTLES.AMMOPANEL_HISTORICALMODULES;
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
        }
        
        override protected function onDispose() : void {
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
            super.onDispose();
        }
        
        private function onRollOut(param1:MouseEvent) : void {
            App.toolTipMgr.hide();
        }
        
        private function onRollOver(param1:MouseEvent) : void {
            if(this.historicalBattleID != -1)
            {
                App.toolTipMgr.showSpecial(Tooltips.HISTORICAL_MODULES,null,this.historicalBattleID);
            }
        }
    }
}
