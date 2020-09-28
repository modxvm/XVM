package net.wg.gui.lobby.hangar.wtEvent
{
    import net.wg.infrastructure.base.meta.impl.WTEventEntryPointMeta;
    import net.wg.gui.lobby.hangar.eventEntryPoint.IEventEntryPoint;
    import net.wg.infrastructure.base.meta.IWTEventEntryPointMeta;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Linkages;
    import net.wg.data.constants.Values;

    public class WTEventEntryPointInject extends WTEventEntryPointMeta implements IEventEntryPoint, IWTEventEntryPointMeta
    {

        private static const WIDTH_SMALL_WIDE:int = 310;

        private static const WIDTH_BIG_WIDE:int = 400;

        private static const WIDTH_SMALL:int = 144;

        private static const WIDTH_BIG:int = 220;

        private static const HEIGHT_SMALL:int = 108;

        private static const HEIGHT_BIG:int = 140;

        private static const ANIMATION_PADDING_RIGHT_BIG:int = -60;

        private static const ANIMATION_PADDING_RIGHT_SMALL:int = -46;

        private static const ANIMATION_PADDING_TOP_BIG:int = 15;

        private static const ANIMATION_PADDING_TOP_SMALL:int = 12;

        private static const ANIMATION_WIDTH_BIG:int = 550;

        private static const ANIMATION_WIDTH_SMALL:int = 425;

        private static const ANIMATION_HEIGHT_BIG:int = 270;

        private static const ANIMATION_HEIGHT_SMALL:int = 210;

        private static const ANIMATION_INVALID:String = "animationInvalid";

        private static const END_DATE_INVALID:String = "endDateInvalid";

        private static const TF_NAME:String = "textInfo";

        private static const BG_NAME:String = "bg";

        private static const ANIMATION_NAME:String = "animation";

        private static const BG_SIZE_BIG:String = "big";

        private static const BG_SIZE_SMALL:String = "small";

        private static const BG_SIZE_PREF_WIDE:String = "_wide";

        private var _isSmall:Boolean = true;

        private var _isWide:Boolean = true;

        private var _anim:MovieClip = null;

        private var _bg:MovieClip = null;

        private var _textInfo:WTEventEntryPointTextInfo = null;

        private var _animHitArea:Sprite;

        private var _isAnimationEnabled:Boolean = false;

        private var _endDate:String = "";

        public function WTEventEntryPointInject()
        {
            super();
            mouseEnabled = false;
            this.updateSize();
        }

        override protected function onDispose() : void
        {
            super.onDispose();
            this._textInfo.removeEventListener(MouseEvent.CLICK,this.onEventClick);
            this.cleanAnimation();
            this.cleanBg();
            if(this._textInfo)
            {
                this._textInfo.dispose();
                removeChild(this._textInfo);
                this._textInfo = null;
            }
        }

        override protected function draw() : void
        {
            var _loc3_:* = false;
            super.draw();
            var _loc1_:Boolean = isInvalid(InvalidationType.SIZE);
            var _loc2_:Boolean = this._anim == null && this._bg == null;
            if(_loc2_ || isInvalid(ANIMATION_INVALID) || _loc1_)
            {
                _loc3_ = false;
                if(this._isWide && this._isAnimationEnabled && this._anim == null)
                {
                    this.cleanBg();
                    this.createAnimation();
                }
                this.updateAnimState(this._isAnimationEnabled);
                if(this._textInfo == null)
                {
                    this.createTextInfo();
                    _loc3_ = true;
                }
                if((!this._isWide || !this._isAnimationEnabled) && this._bg == null)
                {
                    this.cleanAnimation();
                    this.createBg();
                    _loc3_ = true;
                }
                _loc1_ = _loc1_ || this._isAnimationEnabled || _loc3_;
            }
            if(isInvalid(END_DATE_INVALID) && this._textInfo)
            {
                this._textInfo.updateEndTime(this._endDate);
            }
            if(_loc1_)
            {
                this.updateAnimPosition();
                if(this._textInfo)
                {
                    this._textInfo.updateSize(this._isSmall,this._isWide,_width,_height);
                }
            }
        }

        public function as_setAnimationEnabled(param1:Boolean) : void
        {
            if(this._isAnimationEnabled != param1)
            {
                this._isAnimationEnabled = param1;
                invalidate(ANIMATION_INVALID);
            }
        }

        public function as_setEndDate(param1:String) : void
        {
            if(this._endDate != param1)
            {
                this._endDate = param1;
                invalidate(END_DATE_INVALID);
            }
        }

        private function updateSize() : void
        {
            var _loc1_:* = 0;
            if(this._isWide)
            {
                _loc1_ = this._isSmall?WIDTH_SMALL_WIDE:WIDTH_BIG_WIDE;
            }
            else
            {
                _loc1_ = this._isSmall?WIDTH_SMALL:WIDTH_BIG;
            }
            var _loc2_:int = this._isSmall?HEIGHT_SMALL:HEIGHT_BIG;
            setSize(_loc1_,_loc2_);
        }

        private function createAnimation() : void
        {
            this._anim = App.utils.classFactory.getComponent(Linkages.WT_EVENT_ENTRY_POINT_ANIM_UI,MovieClip);
            this._anim.name = ANIMATION_NAME;
            this._anim.stop();
            this._anim.mouseChildren = this._anim.mouseEnabled = false;
            addChildAt(this._anim,0);
            this._animHitArea = new Sprite();
            addChild(this._animHitArea);
            this._anim.hitArea = this._animHitArea;
        }

        private function createBg() : void
        {
            this._bg = App.utils.classFactory.getComponent(Linkages.WT_EVENT_ENTRY_POINT_STATIC_BG_UI,MovieClip);
            this._bg.name = BG_NAME;
            this._bg.mouseChildren = this._bg.mouseEnabled = false;
            addChildAt(this._bg,0);
        }

        private function createTextInfo() : void
        {
            this._textInfo = App.utils.classFactory.getComponent(Linkages.WT_EVENT_ENTRY_TEXT_INFO_UI,WTEventEntryPointTextInfo);
            this._textInfo.name = TF_NAME;
            addChild(this._textInfo);
            this._textInfo.addEventListener(MouseEvent.CLICK,this.onEventClick);
            this._textInfo.updateSize(this._isSmall,this._isWide,_width,_height,true);
        }

        private function cleanBg() : void
        {
            if(this._bg)
            {
                removeChild(this._bg);
                this._bg = null;
            }
        }

        private function cleanAnimation() : void
        {
            if(this._anim)
            {
                this._anim.stop();
                if(this._animHitArea)
                {
                    removeChild(this._animHitArea);
                    this._animHitArea = null;
                }
                removeChild(this._anim);
                this._anim = null;
            }
        }

        private function updateAnimState(param1:Boolean) : void
        {
            if(this._anim != null)
            {
                if(param1)
                {
                    this._anim.play();
                }
                else
                {
                    this._anim.stop();
                }
            }
        }

        private function updateAnimPosition() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            var _loc3_:String = null;
            if(this._anim != null)
            {
                this._anim.width = this._isSmall?ANIMATION_WIDTH_SMALL:ANIMATION_WIDTH_BIG;
                this._anim.height = this._isSmall?ANIMATION_HEIGHT_SMALL:ANIMATION_HEIGHT_BIG;
                _loc1_ = this._isSmall?ANIMATION_PADDING_RIGHT_SMALL:ANIMATION_PADDING_RIGHT_BIG;
                _loc2_ = this._isSmall?ANIMATION_PADDING_TOP_SMALL:ANIMATION_PADDING_TOP_BIG;
                this._anim.x = _width - this._anim.width - _loc1_ | 0;
                this._anim.y = (_height - this._anim.height >> 1) - _loc2_;
            }
            if(this._bg != null)
            {
                _loc3_ = this._isSmall?BG_SIZE_SMALL:BG_SIZE_BIG;
                _loc3_ = _loc3_ + (this._isWide?BG_SIZE_PREF_WIDE:Values.EMPTY_STR);
                this._bg.gotoAndStop(_loc3_);
            }
        }

        public function set isSmall(param1:Boolean) : void
        {
            if(this._isSmall != param1)
            {
                this._isSmall = param1;
                this.updateSize();
            }
        }

        public function set isWide(param1:Boolean) : void
        {
            if(this._isWide != param1)
            {
                this._isWide = param1;
                this.updateSize();
            }
        }

        private function onEventClick(param1:MouseEvent) : void
        {
            if(App.utils.commons.isLeftButton(param1))
            {
                this.onEntryClickS();
            }
        }
    }
}
