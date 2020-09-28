package net.wg.gui.lobby.hangar.tenYearsCountdown
{
    import net.wg.infrastructure.base.meta.impl.TenYearsCountdownEntryPointMeta;
    import net.wg.gui.lobby.hangar.eventEntryPoint.IEventEntryPoint;
    import net.wg.infrastructure.base.meta.ITenYearsCountdownEntryPointMeta;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Linkages;

    public class TenYearsCountdownEntryPointInject extends TenYearsCountdownEntryPointMeta implements IEventEntryPoint, ITenYearsCountdownEntryPointMeta
    {

        private static const WIDTH_SMALL:int = 144;

        private static const WIDTH_BIG:int = 220;

        private static const WIDTH_SMALL_WIDE:int = 270;

        private static const WIDTH_BIG_WIDE:int = 400;

        private static const HEIGHT_SMALL:int = 108;

        private static const HEIGHT_BIG:int = 140;

        private static const ANIMATION_PADDING_RIGHT:int = -40;

        private static const STAGE_STATE_INVALID:String = "stageStateInvalid";

        private static const ANIMATION_INVALID:String = "animationInvalid";

        private var _isSmall:Boolean = false;

        private var _isWide:Boolean = false;

        private var _anim:MovieClip = null;

        private var _isStageActive:Boolean = false;

        private var _isAnimationEnabled:Boolean = false;

        public function TenYearsCountdownEntryPointInject()
        {
            super();
            mouseEnabled = false;
        }

        override public function addChild(param1:DisplayObject) : DisplayObject
        {
            var _loc2_:DisplayObject = super.addChild(param1);
            if(this._anim && contains(this._anim))
            {
                setChildIndex(this._anim,numChildren - 1);
            }
            return _loc2_;
        }

        override protected function draw() : void
        {
            var _loc2_:* = false;
            super.draw();
            var _loc1_:Boolean = isInvalid(InvalidationType.SIZE);
            if(isInvalid(STAGE_STATE_INVALID,ANIMATION_INVALID))
            {
                _loc2_ = this._isAnimationEnabled && this._isStageActive;
                if(_loc2_ && this._anim == null)
                {
                    this.createAnimation();
                }
                this.updateAnimState(_loc2_);
                _loc1_ = _loc1_ || _loc2_;
            }
            if(_loc1_)
            {
                this.updateAnimPosition();
            }
        }

        override protected function onDispose() : void
        {
            super.onDispose();
            if(this._anim)
            {
                this._anim.stop();
                removeChild(this._anim);
                this._anim = null;
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

        public function as_updateActivity(param1:Boolean) : void
        {
            if(this._isStageActive != param1)
            {
                this._isStageActive = param1;
                invalidate(STAGE_STATE_INVALID);
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
            this._anim = App.utils.classFactory.getComponent(Linkages.TEN_YEARS_ENTRY_POINT_ANIM_UI,MovieClip);
            this.addChild(this._anim);
        }

        private function updateAnimState(param1:Boolean) : void
        {
            if(this._anim != null)
            {
                if(param1)
                {
                    this._anim.play();
                    this._anim.visible = true;
                }
                else
                {
                    this._anim.stop();
                    this._anim.visible = false;
                }
            }
        }

        private function updateAnimPosition() : void
        {
            if(this._anim != null && this._anim.visible)
            {
                this._anim.x = _width - this._anim.width - ANIMATION_PADDING_RIGHT | 0;
                this._anim.y = _height - this._anim.height >> 1;
            }
        }

        public function set isSmall(param1:Boolean) : void
        {
            this._isSmall = param1;
            this.updateSize();
        }

        public function set isWide(param1:Boolean) : void
        {
            this._isWide = param1;
            this.updateSize();
        }
    }
}
