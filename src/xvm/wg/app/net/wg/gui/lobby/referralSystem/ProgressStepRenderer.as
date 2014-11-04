package net.wg.gui.lobby.referralSystem
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.Sprite;
    import net.wg.gui.lobby.referralSystem.data.ProgressStepVO;
    import net.wg.gui.events.UILoaderEvent;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Tooltips;
    
    public class ProgressStepRenderer extends UIComponentEx
    {
        
        public function ProgressStepRenderer()
        {
            super();
        }
        
        public var icon:UILoaderAlt;
        
        public var line:Sprite;
        
        private var _model:ProgressStepVO;
        
        private var _showLine:Boolean = true;
        
        public function get model() : ProgressStepVO
        {
            return this._model;
        }
        
        public function set model(param1:ProgressStepVO) : void
        {
            this._model = param1;
            this.icon.source = this._model.icon;
        }
        
        public function get showLine() : Boolean
        {
            return this._showLine;
        }
        
        public function set showLine(param1:Boolean) : void
        {
            this._showLine = param1;
            this.line.visible = this._showLine;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.icon.autoSize = false;
            this.icon.addEventListener(UILoaderEvent.COMPLETE,this.iconLoadedHandler);
            addEventListener(MouseEvent.ROLL_OVER,this.overHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.outHandler);
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.overHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.outHandler);
            this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.iconLoadedHandler);
            this.icon.dispose();
            this.icon = null;
            this._model.dispose();
            this._model = null;
            this.line = null;
            super.onDispose();
        }
        
        private function outHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function overHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showSpecial(Tooltips.REF_SYS_AWARDS,null,this._model.id);
        }
        
        private function iconLoadedHandler(param1:UILoaderEvent) : void
        {
            this.icon.x = -this.icon.width >> 1;
        }
    }
}
