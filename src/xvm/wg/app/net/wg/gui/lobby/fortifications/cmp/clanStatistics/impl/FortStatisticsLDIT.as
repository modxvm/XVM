package net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl
{
    import net.wg.gui.components.advanced.LineDescrIconText;
    import net.wg.gui.lobby.fortifications.data.ClanStatItemVO;
    import net.wg.data.managers.IToolTipParams;
    import net.wg.gui.utils.ComplexTooltipHelper;
    
    public class FortStatisticsLDIT extends LineDescrIconText
    {
        
        public function FortStatisticsLDIT() {
            super();
        }
        
        private var _model:ClanStatItemVO;
        
        override protected function onDispose() : void {
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
            super.onDispose();
        }
        
        override protected function showToolTip(param1:IToolTipParams) : void {
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
        
        public function get model() : ClanStatItemVO {
            return this._model;
        }
        
        public function set model(param1:ClanStatItemVO) : void {
            this._model = param1;
            if(this._model)
            {
                iconSource = this._model.icon;
                description = this._model.label;
                text = this._model.value;
                tooltip = this._model.ttHeader;
                enabled = this._model.enabled;
            }
        }
    }
}
