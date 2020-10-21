package net.wg.gui.lobby.eventStylesShopTab.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventStylesShopTab.events.StylesShopTabEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.eventStylesShopTab.data.EventStylesShopTabDataVO;
    import net.wg.data.constants.ComponentState;

    public class ShopTabContent extends UIComponentEx
    {

        private static const SCALE_NOMAL:Number = 1;

        private static const SCALE_MIN:Number = 0.6;

        private static const WIDTH_MIN:int = 1500;

        private static const HEIGHT_MIN:int = 900;

        private static const BANNERS_PADDING_NORMAL:int = 170;

        private static const BANNERS_PADDING_MIN:int = 110;

        private static const NAMES_PADDING_NORMAL:int = 0;

        private static const NAMES_PADDING_MIN:int = -10;

        private static const TANK_PADDING_BASE:int = 460;

        private static const TANK_PADDING_MAX:int = 300;

        public var banners:ShopTabBanners = null;

        public var tankButton1:ShopTankButtonContainer = null;

        public var tankButton2:ShopTankButtonContainer = null;

        public var tankButton3:ShopTankButtonContainer = null;

        public var tankButton4:ShopTankButtonContainer = null;

        public var tankButton5:ShopTankButtonContainer = null;

        public var tank1:MovieClip = null;

        public var tank2:MovieClip = null;

        public var tank3:MovieClip = null;

        public var tank4:MovieClip = null;

        public var tank5:MovieClip = null;

        public var tanksBg:MovieClip = null;

        private var _tanks:Vector.<MovieClip> = null;

        private var _shopTankButtons:Vector.<ShopTankButtonContainer> = null;

        public function ShopTabContent()
        {
            super();
            this._tanks = new <MovieClip>[this.tank1,this.tank2,this.tank3,this.tank4,this.tank5];
            this._shopTankButtons = new <ShopTankButtonContainer>[this.tankButton1,this.tankButton2,this.tankButton3,this.tankButton4,this.tankButton5];
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(StylesShopTabEvent.TANK_OVER,this.onButtonTankOverHandler);
            addEventListener(StylesShopTabEvent.TANK_OUT,this.onButtonTankOutHandler);
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            var _loc2_:* = NaN;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            var _loc8_:* = 0;
            var _loc9_:MovieClip = null;
            var _loc10_:ShopTankButtonContainer = null;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                _loc1_ = _width < WIDTH_MIN || _height < HEIGHT_MIN;
                _loc2_ = _loc1_?SCALE_MIN:SCALE_NOMAL;
                this.tanksBg.scaleX = this.tanksBg.scaleY = _loc2_;
                _loc3_ = TANK_PADDING_MAX * _loc2_ >> 0;
                _loc4_ = _width - TANK_PADDING_BASE * _loc2_ >> 2;
                if(_loc4_ > _loc3_)
                {
                    _loc4_ = _loc3_;
                }
                _loc5_ = this._tanks.length;
                _loc6_ = -(_loc4_ * (_loc5_ - 1) + TANK_PADDING_BASE * _loc2_) >> 1;
                _loc7_ = _loc1_?NAMES_PADDING_MIN:NAMES_PADDING_NORMAL;
                _loc8_ = 0;
                while(_loc8_ < _loc5_)
                {
                    _loc9_ = this._tanks[_loc8_];
                    _loc9_.scaleX = _loc9_.scaleY = _loc2_;
                    _loc9_.x = _loc6_;
                    _loc6_ = _loc6_ + _loc4_;
                    _loc9_.y = this.tanksBg.height - _loc9_.height >> 0;
                    _loc10_ = this._shopTankButtons[_loc8_];
                    _loc10_.x = _loc9_.x + (_loc9_.width >> 1);
                    _loc10_.y = _loc9_.y + _loc9_.height + _loc7_ >> 0;
                    _loc10_.setIsMin(_loc1_);
                    _loc8_++;
                }
                this.banners.y = this.tankButton1.y + (_loc1_?BANNERS_PADDING_MIN:BANNERS_PADDING_NORMAL);
                this.banners.x = -this.banners.width >> 1;
            }
        }

        public function getContentHeight() : int
        {
            return this.banners.y + this.banners.height >> 0;
        }

        public function setData(param1:EventStylesShopTabDataVO) : void
        {
            this.banners.setData(param1.banners);
            var _loc2_:int = param1.skins.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                this._shopTankButtons[_loc3_].setData(param1.skins[_loc3_],_loc3_);
                _loc3_++;
            }
            invalidateSize();
        }

        override protected function onBeforeDispose() : void
        {
            removeEventListener(StylesShopTabEvent.TANK_OVER,this.onButtonTankOverHandler);
            removeEventListener(StylesShopTabEvent.TANK_OUT,this.onButtonTankOutHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            var _loc1_:ShopTankButtonContainer = null;
            this._tanks.splice(0,this._tanks.length);
            this._tanks = null;
            for each(_loc1_ in this._shopTankButtons)
            {
                _loc1_.dispose();
            }
            this._shopTankButtons.splice(0,this._shopTankButtons.length);
            this._shopTankButtons = null;
            this.banners.dispose();
            this.banners = null;
            this.tankButton1 = null;
            this.tankButton2 = null;
            this.tankButton3 = null;
            this.tankButton4 = null;
            this.tankButton5 = null;
            this.tank1 = null;
            this.tank2 = null;
            this.tank3 = null;
            this.tank4 = null;
            this.tank5 = null;
            this.tanksBg = null;
            super.onDispose();
        }

        private function onButtonTankOverHandler(param1:StylesShopTabEvent) : void
        {
            this._tanks[param1.index].gotoAndPlay(ComponentState.OVER);
            param1.stopImmediatePropagation();
        }

        private function onButtonTankOutHandler(param1:StylesShopTabEvent) : void
        {
            this._tanks[param1.index].gotoAndPlay(ComponentState.OUT);
            param1.stopImmediatePropagation();
        }
    }
}
