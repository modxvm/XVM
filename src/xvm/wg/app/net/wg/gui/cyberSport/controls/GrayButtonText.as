package net.wg.gui.cyberSport.controls
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextFormat;
    import scaleform.clik.constants.InvalidationType;
    import flash.filters.DropShadowFilter;
    
    public class GrayButtonText extends SoundButtonEx
    {
        
        public function GrayButtonText() {
            super();
        }
        
        private var _applyTextFilter:Boolean = false;
        
        public function get applyTextFilter() : Boolean {
            return this._applyTextFilter;
        }
        
        public function set applyTextFilter(param1:Boolean) : void {
            this._applyTextFilter = param1;
        }
        
        override protected function configUI() : void {
            super.configUI();
        }
        
        override protected function draw() : void {
            var _loc1_:TextFormat = null;
            super.draw();
            if((isInvalid(InvalidationType.STATE)) && (this.applyTextFilter))
            {
                _loc1_ = textField.getTextFormat();
                _loc1_.color = 14406031;
                textField.setTextFormat(_loc1_);
                textField.filters = [this.getDropShadowFilter()];
            }
        }
        
        override public function set enabled(param1:Boolean) : void {
            super.enabled = param1;
            this.alpha = param1?1:0.5;
        }
        
        private function getDropShadowFilter() : DropShadowFilter {
            var _loc1_:DropShadowFilter = new DropShadowFilter();
            _loc1_.color = 14787651;
            _loc1_.angle = 0;
            _loc1_.alpha = 1;
            _loc1_.blurX = 8;
            _loc1_.blurY = 9;
            _loc1_.distance = 1;
            _loc1_.strength = 2;
            _loc1_.inner = false;
            _loc1_.knockout = false;
            _loc1_.quality = 3;
            return _loc1_;
        }
    }
}
