package net.wg.gui.bootcamp.battleResult.containers
{
    import net.wg.gui.components.containers.GroupLayout;
    import flash.display.DisplayObject;
    import flash.geom.Point;

    public class BattleResultGroupLayout extends GroupLayout
    {

        public function BattleResultGroupLayout(param1:int = 0)
        {
            super();
            this.gap = param1;
        }

        override public function invokeLayout() : Object
        {
            var _loc1_:DisplayObject = null;
            var _loc2_:int = _target.numChildren;
            var _loc3_:int = gap;
            var _loc4_:int = -(_loc3_ * _loc2_ - _loc3_ >> 1);
            var _loc5_:* = 0;
            while(_loc5_ < _loc2_)
            {
                _loc1_ = DisplayObject(_target.getChildAt(_loc5_));
                _loc1_.x = _loc4_;
                _loc4_ = _loc4_ + _loc3_;
                _loc5_++;
            }
            return new Point(_loc4_,0);
        }
    }
}
