package net.wg.gui.components.common.containers
{
    import flash.display.DisplayObject;
    import flash.geom.Point;
    
    public class EqualWidthHorizontalLayout extends GroupLayout
    {
        
        public function EqualWidthHorizontalLayout() {
            super();
        }
        
        private var _availableSize:Number = 0;
        
        override public function invokeLayout() : Object {
            var _loc1_:DisplayObject = null;
            var _loc2_:int = _target.numChildren;
            var _loc3_:* = 0;
            var _loc4_:uint = (this._availableSize - gap * (_loc2_ + 1)) / _loc2_;
            var _loc5_:int = gap;
            var _loc6_:* = 0;
            while(_loc6_ < _loc2_)
            {
                _loc1_ = DisplayObject(_target.getChildAt(_loc6_));
                _loc1_.x = _loc5_;
                _loc1_.width = _loc4_;
                _loc5_ = _loc5_ + Math.round(_loc1_.width + gap);
                _loc3_ = Math.max(_loc3_,_loc1_.height);
                _loc6_++;
            }
            return new Point(_loc5_,_loc3_);
        }
        
        public function get availableSize() : Number {
            return this._availableSize;
        }
        
        public function set availableSize(param1:Number) : void {
            this._availableSize = param1;
        }
    }
}
