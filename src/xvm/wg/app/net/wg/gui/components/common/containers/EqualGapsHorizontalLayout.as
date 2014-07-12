package net.wg.gui.components.common.containers
{
    import flash.display.DisplayObject;
    import flash.geom.Point;
    
    public class EqualGapsHorizontalLayout extends GroupLayout
    {
        
        public function EqualGapsHorizontalLayout() {
            super();
        }
        
        private var _availableSize:Number = 0;
        
        override public function invokeLayout() : Object {
            var _loc1_:DisplayObject = null;
            var _loc6_:uint = 0;
            var _loc2_:int = _target.numChildren;
            var _loc3_:* = 0;
            var _loc4_:uint = 0;
            var _loc5_:* = 0;
            while(_loc5_ < _loc2_)
            {
                _loc1_ = DisplayObject(_target.getChildAt(_loc5_));
                _loc4_ = _loc4_ + Math.round(_loc1_.width);
                _loc5_++;
            }
            _loc6_ = Math.round((this._availableSize - _loc4_) / (_loc2_ + 1));
            var _loc7_:int = _loc6_;
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
                _loc1_ = DisplayObject(_target.getChildAt(_loc5_));
                _loc1_.x = _loc7_;
                _loc7_ = _loc7_ + Math.round(_loc1_.width + _loc6_);
                _loc5_++;
            }
            return new Point(_loc7_,_loc3_);
        }
        
        public function get availableSize() : Number {
            return this._availableSize;
        }
        
        public function set availableSize(param1:Number) : void {
            this._availableSize = param1;
        }
    }
}
