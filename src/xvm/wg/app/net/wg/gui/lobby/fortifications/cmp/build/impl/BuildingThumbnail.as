package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.fortifications.data.BuildingVO;
    import flash.events.MouseEvent;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.gui.utils.ComplexTooltipHelper;
    
    public class BuildingThumbnail extends MovieClip implements IDisposable
    {
        
        public function BuildingThumbnail() {
            super();
            this.init();
        }
        
        private var _model:BuildingVO;
        
        private var _ttHeader:String;
        
        private var _ttBody:String;
        
        public function get model() : BuildingVO {
            return this._model;
        }
        
        public function set model(param1:BuildingVO) : void {
            this._model = param1;
            if((this._model) && (this._model.toolTipData) && this._model.toolTipData.length > 0)
            {
                this._ttHeader = this._model.toolTipData[0];
                this._ttBody = this._model.toolTipData.length > 1?this._model.toolTipData[1]:null;
            }
            else
            {
                this._ttHeader = null;
                this._ttBody = null;
            }
            this.updateView();
        }
        
        private function init() : void {
            addEventListener(MouseEvent.ROLL_OVER,this.onControlOver);
            addEventListener(MouseEvent.ROLL_OUT,this.onControlOut);
        }
        
        public function dispose() : void {
            removeEventListener(MouseEvent.ROLL_OVER,this.onControlOver);
            removeEventListener(MouseEvent.ROLL_OUT,this.onControlOut);
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
        }
        
        private function updateView() : void {
            if(this._model)
            {
                if(this._model.isInFoundationState)
                {
                    gotoAndStop(FORTIFICATION_ALIASES.FORT_FOUNDATION);
                }
                else
                {
                    gotoAndStop(this._model.uid);
                }
            }
        }
        
        private function onControlOut(param1:MouseEvent) : void {
            App.toolTipMgr.hide();
        }
        
        private function onControlOver(param1:MouseEvent) : void {
            var _loc2_:String = new ComplexTooltipHelper().addHeader(this._ttHeader).addBody(this._ttBody).make();
            if(_loc2_.length > 0)
            {
                App.toolTipMgr.showComplex(_loc2_);
            }
        }
    }
}
