package net.wg.gui.components.common.ticker
{
    import scaleform.clik.controls.Button;
    import flash.text.TextFieldAutoSize;
    
    public class TickerItem extends Button
    {
        
        public function TickerItem() {
            super();
            autoSize = TextFieldAutoSize.LEFT;
        }
        
        private static var INVALID_MODEL:String = "invalidModel";
        
        private var _model:RSSEntryVO;
        
        public function get model() : RSSEntryVO {
            return this._model;
        }
        
        public function set model(param1:RSSEntryVO) : void {
            this._model = param1;
            invalidate(INVALID_MODEL);
        }
        
        override protected function onDispose() : void {
            super.onDispose();
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
        }
        
        override protected function draw() : void {
            if((isInvalid(INVALID_MODEL)) && (this._model))
            {
                label = this._model.title;
            }
            super.draw();
        }
    }
}
