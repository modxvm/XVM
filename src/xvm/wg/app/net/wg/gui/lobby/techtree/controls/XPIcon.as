package net.wg.gui.lobby.techtree.controls
{
    import scaleform.clik.core.UIComponent;
    import scaleform.clik.constants.InvalidationType;
    
    public class XPIcon extends UIComponent
    {
        
        public function XPIcon() {
            super();
        }
        
        private var _type:String = null;
        
        public function get type() : String {
            return this._type;
        }
        
        public function set type(param1:String) : void {
            if(this._type == param1)
            {
                return;
            }
            this._type = param1;
            if(this._type != currentFrameLabel)
            {
                invalidateData();
            }
        }
        
        override protected function configUI() : void {
            mouseEnabled = mouseChildren = focusable = false;
            super.configUI();
        }
        
        override protected function draw() : void {
            if(isInvalid(InvalidationType.DATA))
            {
                this.updateIcon();
            }
            super.draw();
        }
        
        private function updateIcon() : void {
            if((_labelHash[this._type]) && !(this._type == currentFrameLabel))
            {
                gotoAndStop(this._type);
            }
        }
    }
}
