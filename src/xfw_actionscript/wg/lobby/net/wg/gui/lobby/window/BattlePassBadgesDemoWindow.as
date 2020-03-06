package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.meta.impl.BattlePassBadgesDemoWindowMeta;
    import flash.utils.Dictionary;
    import net.wg.gui.components.advanced.BadgeSizes;
    import net.wg.gui.components.controls.BadgeComponent;
    import net.wg.utils.StageSizeBoundaries;
    import net.wg.gui.components.controls.VO.BadgeVisualVO;
    import net.wg.data.constants.Linkages;

    public class BattlePassBadgesDemoWindow extends BattlePassBadgesDemoWindowMeta
    {

        private static const SIZES:Dictionary = new Dictionary();

        private static const OFFSETS:Dictionary = new Dictionary();

        private static const SIZES_STR:Array = [BadgeSizes.X24,BadgeSizes.X48,BadgeSizes.X80,BadgeSizes.X220];

        private static const WIDTH:int = 1500;

        {
            SIZES[BadgeSizes.X24] = 24;
            SIZES[BadgeSizes.X48] = 48;
            SIZES[BadgeSizes.X80] = 80;
            SIZES[BadgeSizes.X220] = 220;
            OFFSETS[BadgeSizes.X24] = 0;
            OFFSETS[BadgeSizes.X48] = 55;
            OFFSETS[BadgeSizes.X80] = 250;
            OFFSETS[BadgeSizes.X220] = 710;
        }

        private var _badges:Vector.<BadgeComponent>;

        public function BattlePassBadgesDemoWindow()
        {
            this._badges = new Vector.<BadgeComponent>();
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            window.title = "badges";
            window.setMaxHeight(StageSizeBoundaries.HEIGHT_1080);
            window.setMaxWidth(StageSizeBoundaries.WIDTH_1920);
        }

        override protected function onPopulate() : void
        {
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:BadgeVisualVO = null;
            var _loc5_:BadgeComponent = null;
            var _loc6_:* = 0;
            super.onPopulate();
            var _loc1_:int = SIZES_STR.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
                _loc3_ = 0;
                while(_loc3_ < 100)
                {
                    _loc4_ = new BadgeVisualVO();
                    _loc4_.content = _loc3_.toString();
                    _loc4_.isDynamic = true;
                    _loc4_.sizeContent = SIZES_STR[_loc2_];
                    _loc4_.icon = "../maps/icons/library/badges/" + SIZES_STR[_loc2_] + "/badge_90.png";
                    _loc5_ = App.utils.classFactory.getComponent(Linkages.BADGE_COMPONENT,BadgeComponent);
                    _loc5_.setData(_loc4_);
                    _loc6_ = SIZES[SIZES_STR[_loc2_]] + 1;
                    _loc5_.x = _loc3_ * _loc6_ % WIDTH;
                    _loc5_.y = Math.floor(_loc3_ * _loc6_ / WIDTH) * _loc6_ + OFFSETS[SIZES_STR[_loc2_]];
                    this._badges.push(_loc5_);
                    addChild(_loc5_);
                    _loc4_.dispose();
                    _loc3_++;
                }
                _loc2_++;
            }
        }

        override protected function onDispose() : void
        {
            var _loc3_:* = 0;
            var _loc4_:BadgeComponent = null;
            var _loc1_:int = SIZES_STR.length;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
                _loc3_ = 0;
                while(_loc3_ < 100)
                {
                    _loc4_ = this._badges.pop();
                    removeChild(_loc4_);
                    _loc4_.dispose();
                    _loc3_++;
                }
                _loc2_++;
            }
            this._badges = null;
        }
    }
}
