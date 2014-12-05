package net.wg.gui.lobby.profile.components
{
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Tooltips;
    
    public class TechMasteryIcon extends UILoaderAlt
    {
        
        public function TechMasteryIcon()
        {
            super();
            this.addEventListener(MouseEvent.ROLL_OVER,this.rollOverHandler,false,0,true);
            this.addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler,false,0,true);
        }
        
        private var _data:TechniqueListVehicleVO = null;
        
        private function rollOverHandler(param1:MouseEvent) : void
        {
            if(this._data)
            {
                App.toolTipMgr.showSpecial(Tooltips.MARK_OF_MASTERY,null,this._data.markOfMasteryBlock,"markOfMastery",this._data.markOfMastery);
            }
        }
        
        private function rollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public function set data(param1:TechniqueListVehicleVO) : void
        {
            this._data = param1;
        }
        
        override protected function onDispose() : void
        {
            this.removeEventListener(MouseEvent.ROLL_OVER,this.rollOverHandler);
            this.removeEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler);
            super.onDispose();
        }
    }
}
