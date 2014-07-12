package net.wg.gui.components.common.crosshair
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.infrastructure.interfaces.IFormattedInt;
    
    public class ReloadingTimer extends UIComponent
    {
        
        public function ReloadingTimer() {
            super();
            this.leftTF = this.contentContainer.leftTF;
            this.delimiterTF = this.contentContainer.delimiterTF;
            this.rightTF = this.contentContainer.rightTF;
        }
        
        private static var FRACTIONAL_SIGNS:Number = 2;
        
        public var contentContainer:MovieClip;
        
        private var leftTF:TextField;
        
        private var delimiterTF:TextField;
        
        private var rightTF:TextField;
        
        private var _time:Number = 0;
        
        public function setup(param1:Number) : void {
            this.contentContainer.alpha = param1;
        }
        
        public function updateTime(param1:Number, param2:Boolean) : void {
            var _loc3_:String = null;
            var _loc4_:IFormattedInt = null;
            var _loc5_:String = null;
            var _loc6_:String = null;
            var _loc7_:String = null;
            if(!isNaN(param1))
            {
                this._time = param1;
                this.contentContainer.gotoAndStop(param2?"progress":"complete");
                _loc3_ = App.utils.locale.float(String(this._time));
                _loc4_ = App.utils.locale.parseFormattedInteger(_loc3_);
                _loc5_ = _loc4_.delimiter;
                _loc6_ = _loc3_.slice(0,_loc3_.indexOf(_loc5_));
                _loc7_ = _loc3_.slice(_loc3_.indexOf(_loc5_) + 1,_loc3_.length);
                if(_loc7_.length > FRACTIONAL_SIGNS)
                {
                    _loc7_ = _loc7_.slice(0,FRACTIONAL_SIGNS);
                }
                this.leftTF.text = _loc6_;
                this.delimiterTF.text = _loc5_;
                this.rightTF.text = _loc7_;
            }
        }
    }
}
