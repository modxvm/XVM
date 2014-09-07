package net.wg.gui.lobby.fortifications.intelligence.impl
{
    import net.wg.gui.components.advanced.LineIconText;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.fortifications.data.ClanStatItemVO;
    import net.wg.gui.utils.ComplexTooltipHelper;
    
    public class FortIntelClanDescriptionLIT extends LineIconText
    {
        
        public function FortIntelClanDescriptionLIT()
        {
            super();
        }
        
        private static function onRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private var _model:ClanStatItemVO = null;
        
        override protected function onDispose() : void
        {
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
            super.onDispose();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
        }
        
        public function get model() : ClanStatItemVO
        {
            return this._model;
        }
        
        public function set model(param1:ClanStatItemVO) : void
        {
            this._model = param1;
            if(this._model)
            {
                iconSource = this._model.icon;
                text = this._model.value;
            }
        }
        
        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(!this._model)
            {
                return;
            }
            var _loc2_:String = new ComplexTooltipHelper().addHeader(this._model.ttHeader).addBody(this._model.ttBody).make();
            if(_loc2_.length > 0)
            {
                App.toolTipMgr.showComplex(_loc2_);
            }
        }
    }
}
