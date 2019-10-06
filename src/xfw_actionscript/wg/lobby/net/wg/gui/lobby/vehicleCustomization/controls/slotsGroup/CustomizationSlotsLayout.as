package net.wg.gui.lobby.vehicleCustomization.controls.slotsGroup
{
    import net.wg.gui.components.containers.GroupLayout;
    import flash.display.DisplayObject;
    import flash.geom.Point;

    public class CustomizationSlotsLayout extends GroupLayout
    {

        public static const BACKGROUND_SMALL_WIDTH:int = 825;

        public static const BACKGROUND_BIG_WIDTH:int = 1025;

        public static const SMALL_SCREEN_WIDTH:int = 1280;

        public static const SMALL_SCREEN_HEIGHT:int = 900;

        private var _slotWidth:int;

        private var _slotWideWidth:int;

        private var _gapX:int = 0;

        private var _gapY:int = 0;

        public function CustomizationSlotsLayout(param1:int, param2:int, param3:int, param4:int)
        {
            super();
            this._slotWidth = param1;
            this._slotWideWidth = param2;
            this._gapX = param3;
            this._gapY = param4;
            this.gap = param3;
        }

        override public function invokeLayout() : Object
        {
            var _loc1_:DisplayObject = null;
            var _loc2_:DisplayObject = null;
            var _loc4_:* = 0;
            var _loc3_:int = _target.numChildren;
            _loc4_ = _target.width;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            _loc1_ = DisplayObject(_target.getChildAt(0));
            _loc1_.x = _loc5_;
            _loc1_.y = _loc6_;
            _loc1_.width = ICustomizationSlot(_loc1_).isWide()?this._slotWideWidth:this._slotWidth;
            var _loc7_:* = 1;
            while(_loc7_ < _loc3_)
            {
                _loc2_ = DisplayObject(_target.getChildAt(_loc7_ - 1));
                _loc1_ = DisplayObject(_target.getChildAt(_loc7_));
                _loc1_.width = (_loc1_ as ICustomizationSlot).isWide()?this._slotWideWidth:this._slotWidth;
                _loc5_ = _loc2_.x + _loc2_.width + this._gapX;
                if(_loc5_ + _loc1_.width > _loc4_)
                {
                    _loc5_ = 0;
                    _loc6_ = _loc6_ + (_loc2_.height + this._gapY);
                }
                else
                {
                    _loc5_ = _loc2_.x + _loc2_.width + this._gapX;
                }
                _loc1_.x = _loc5_;
                _loc1_.y = _loc6_;
                _loc7_++;
            }
            _target.height = _loc6_;
            return new Point(_loc4_,_target.height);
        }
    }
}
