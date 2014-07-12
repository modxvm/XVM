package net.wg.gui.lobby.retrainCrewWindow
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Tooltips;
    
    public class RetrainCrewRoleIR extends UIComponent
    {
        
        public function RetrainCrewRoleIR() {
            super();
        }
        
        private static function hideTooltip() : void {
            App.toolTipMgr.hide();
        }
        
        public var loader:UILoaderAlt;
        
        private var _data:RetrainTankmanVO;
        
        override protected function configUI() : void {
            super.configUI();
            addEventListener(MouseEvent.MOUSE_OVER,this.showTooltip,false,0,true);
            addEventListener(MouseEvent.MOUSE_OUT,hideTooltip,false,0,true);
        }
        
        override protected function draw() : void {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this._data))
            {
                this.loader.source = this._data.iconPath;
            }
        }
        
        private function showTooltip() : void {
            App.toolTipMgr.showSpecial(Tooltips.TANKMAN,null,this._data.tankmanID,true);
        }
        
        public function get data() : RetrainTankmanVO {
            return this._data;
        }
        
        public function set data(param1:RetrainTankmanVO) : void {
            this._data = param1;
            invalidateData();
        }
        
        override protected function onDispose() : void {
            removeEventListener(MouseEvent.MOUSE_OVER,this.showTooltip);
            removeEventListener(MouseEvent.MOUSE_OUT,hideTooltip);
            super.onDispose();
        }
    }
}
