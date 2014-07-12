package net.wg.gui.components.common.containers
{
    import flash.display.DisplayObject;
    import flash.geom.Point;
    
    public class VerticalGroupLayout extends GroupLayout
    {
        
        public function VerticalGroupLayout() {
            super();
        }
        
        override public function invokeLayout() : Object {
            var _loc1_:DisplayObject = null;
            var _loc2_:int = _target.numChildren;
            var _loc3_:* = 0;
            var _loc4_:uint = 0;
            var _loc5_:* = 0;
            while(_loc5_ < _loc2_)
            {
                _loc1_ = DisplayObject(_target.getChildAt(_loc5_));
                _loc1_.y = _loc4_;
                _loc4_ = _loc4_ + Math.round(_loc1_.height + gap);
                if(_loc3_ < _loc1_.width)
                {
                    _loc3_ = Math.round(_loc1_.width);
                }
                _loc5_++;
            }
            if(_loc4_ > 0)
            {
                _loc4_ = _loc4_ - gap;
            }
            return new Point(_loc3_,_loc4_);
        }
    }
}
