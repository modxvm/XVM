package net.wg.gui.lobby.eventAwards
{
    import net.wg.infrastructure.base.meta.impl.EventAwardScreenMeta;
    import net.wg.infrastructure.base.meta.IEventAwardScreenMeta;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.lobby.eventAwards.components.EventAwardScreenAnim;
    import net.wg.gui.lobby.eventAwards.components.EventAwardScreenBtnAnim;
    import net.wg.gui.lobby.eventAwards.components.EventAwardScreenBgAnim;
    import net.wg.gui.lobby.eventAwards.data.EventAwardScreenVO;
    import net.wg.gui.lobby.personalMissions.events.AnimationStateEvent;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.display.InteractiveObject;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import org.idmedia.as3commons.util.StringUtils;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.ui.InputDetails;
    import flash.ui.Keyboard;
    import scaleform.clik.constants.InputValue;

    public class EventAwardScreen extends EventAwardScreenMeta implements IEventAwardScreenMeta
    {

        private static const DEF_BACKGROUND_WIDTH:Number = 1920;

        private static const DEF_BACKGROUND_HEIGHT:Number = 1200;

        private static const BLUR_ADDITIONAL_SIZE:int = 20;

        private static const CLOSE_BTN_OFFSET:int = 29;

        private static const RIBBON_AWARDS_HEIGHT:int = 150;

        private static const CNTRLS_ALPHA_ENABLED:Number = 1;

        private static const CNTRLS_ALPHA_DISABLED:Number = 0.4;

        public static const SCREEN_BREAK_POINT:uint = 837;

        private static const SND_SHOW_VIEW:String = "snd_show_view";

        private static const SND_SHOW_VEHICLE:String = "snd_show_vehicle";

        private static const SND_MINIMIZE_VEHICLE:String = "snd_minimize_vehicle";

        private static const SND_SHOW_ACCEPT_BUTTON:String = "snd_show_accept_btn";

        public var closeBtn:ISoundButtonEx = null;

        public var headerAnim:EventAwardScreenAnim = null;

        public var prizeAnim:EventAwardScreenAnim = null;

        public var awardBtnAnim:EventAwardScreenBtnAnim = null;

        public var background:EventAwardScreenBgAnim = null;

        private var _data:EventAwardScreenVO = null;

        private var _screenW:Number = 0;

        private var _screenH:Number = 0;

        private var _isCloseEnabled:Boolean = true;

        private var _isClosed:Boolean = false;

        public function EventAwardScreen()
        {
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            this._screenW = param1;
            this._screenH = param2;
            if(this.headerAnim)
            {
                this.headerAnim.stageUpdate(param1,param2);
            }
            if(this.prizeAnim)
            {
                this.prizeAnim.stageUpdate(param1,param2);
            }
            invalidateSize();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.closeBtn.focusable = false;
            this.background.addEventListener(AnimationStateEvent.FADE_OUT_COMPLETE,this.onBackgroundFadeOutCompleteHandler);
        }

        override protected function setData(param1:EventAwardScreenVO) : void
        {
            this._data = param1;
            invalidateData();
            this.background.fadeIn();
            onPlaySoundS(SND_SHOW_VIEW);
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.updateData();
                this.playAnimation();
                invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.updateComponentsPosition();
            }
        }

        override protected function onBeforeDispose() : void
        {
            this.awardBtnAnim.removeEventListener(ButtonEvent.CLICK,this.onAwardBtnClickHandler);
            this.awardBtnAnim.removeEventListener(AnimationStateEvent.FADE_IN_COMPLETE,this.onAwardBtnAnimFadeInCompleteHandler);
            this.awardBtnAnim.removeEventListener(AnimationStateEvent.FADE_OUT_COMPLETE,this.onAwardBtnAnimFadeOutCompleteHandler);
            this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            this.prizeAnim.removeEventListener(AnimationStateEvent.FADE_IN_COMPLETE,this.onExtraAwardAnimFadeInCompleteHandler);
            this.prizeAnim.removeEventListener(AnimationStateEvent.MOVE_START,this.onExtraAwardAnimMoveStartHandler);
            this.background.removeEventListener(AnimationStateEvent.FADE_OUT_COMPLETE,this.onBackgroundFadeOutCompleteHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            if(this.headerAnim != null)
            {
                this.headerAnim.dispose();
                this.headerAnim = null;
            }
            this.prizeAnim.dispose();
            this.prizeAnim = null;
            this.closeBtn.dispose();
            this.closeBtn = null;
            this.awardBtnAnim.dispose();
            this.awardBtnAnim = null;
            this.background.dispose();
            this.background = null;
            this._data = null;
            super.onDispose();
        }

        public function as_setCloseBtnEnabled(param1:Boolean) : void
        {
            this._isCloseEnabled = param1;
            this.closeBtn.enabled = param1;
            this.closeBtn.alpha = param1?CNTRLS_ALPHA_ENABLED:CNTRLS_ALPHA_DISABLED;
        }

        private function playAnimation() : void
        {
            this.prizeFadeIn();
            if(this.headerAnim != null)
            {
                this.headerAnim.fadeIn();
            }
        }

        private function updateFocus(param1:InteractiveObject) : void
        {
            if(param1)
            {
                setFocus(param1);
            }
        }

        private function fadeOut() : void
        {
            if(this.headerAnim)
            {
                this.headerAnim.fadeOut();
            }
            this.prizeAnim.fadeOut();
            this.awardBtnAnim.fadeOut();
            if(this._isClosed)
            {
                this.closeBtn.visible = false;
                this.background.fadeOut();
            }
        }

        private function updateComponentsPosition() : void
        {
            var _loc1_:* = 0;
            var _loc3_:* = NaN;
            _loc1_ = this._screenW >> 1;
            var _loc2_:* = this._screenH >> 1;
            _loc3_ = Math.max(this._screenW / DEF_BACKGROUND_WIDTH,this._screenH / DEF_BACKGROUND_HEIGHT);
            this.background.width = DEF_BACKGROUND_WIDTH * _loc3_ + BLUR_ADDITIONAL_SIZE;
            this.background.height = DEF_BACKGROUND_HEIGHT * _loc3_ + BLUR_ADDITIONAL_SIZE;
            this.awardBtnAnim.setPositioning(_loc2_ + RIBBON_AWARDS_HEIGHT,this._screenH);
            this.prizeAnim.y = _loc2_;
            this.closeBtn.x = (this._screenW - this.closeBtn.width - CLOSE_BTN_OFFSET ^ 0) - _loc1_;
            x = _loc1_;
        }

        private function updateData() : void
        {
            this.prizeAnim = App.utils.classFactory.getComponent(this._data.prizeLinkage,MovieClip);
            addChild(DisplayObject(this.prizeAnim));
            this.prizeAnim.stageUpdate(this._screenW,this._screenH);
            this.prizeAnim.setData(this._data.prizeData);
            this.prizeAnim.addEventListener(AnimationStateEvent.FADE_IN_COMPLETE,this.onExtraAwardAnimFadeInCompleteHandler);
            this.prizeAnim.addEventListener(AnimationStateEvent.MOVE_START,this.onExtraAwardAnimMoveStartHandler);
            if(!StringUtils.isEmpty(this._data.headerLinkage))
            {
                this.headerAnim = App.utils.classFactory.getComponent(this._data.headerLinkage,MovieClip);
                this.headerAnim.stageUpdate(this._screenW,this._screenH);
                if(this.headerAnim != null)
                {
                    addChild(DisplayObject(this.headerAnim));
                    this.headerAnim.setData(this._data.headerData);
                }
            }
            this.awardBtnAnim = App.utils.classFactory.getComponent(this._data.buttonLinkage,MovieClip);
            addChild(DisplayObject(this.awardBtnAnim));
            this.awardBtnAnim.setData(this._data.buttonLabel);
            this.awardBtnAnim.addEventListener(AnimationStateEvent.FADE_IN_COMPLETE,this.onAwardBtnAnimFadeInCompleteHandler);
            this.awardBtnAnim.addEventListener(AnimationStateEvent.FADE_OUT_COMPLETE,this.onAwardBtnAnimFadeOutCompleteHandler);
            this.awardBtnAnim.addEventListener(ButtonEvent.CLICK,this.onAwardBtnClickHandler);
            this.closeBtn.label = this._data.closeBtnLabel;
            this.background.setBackground(this._data.background);
        }

        private function prizeFadeIn() : void
        {
            this.prizeAnim.fadeIn();
            onPlaySoundS(SND_SHOW_VEHICLE);
        }

        private function close() : void
        {
            if(!this._isClosed)
            {
                mouseChildren = false;
                this._isClosed = true;
                this.fadeOut();
            }
        }

        override public function handleInput(param1:InputEvent) : void
        {
            if(param1.handled || !this._isCloseEnabled)
            {
                return;
            }
            var _loc2_:InputDetails = param1.details;
            if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
            {
                param1.handled = true;
                this.onCloseBtnClickHandler(null);
            }
        }

        private function onExtraAwardAnimMoveStartHandler(param1:AnimationStateEvent) : void
        {
            onPlaySoundS(SND_MINIMIZE_VEHICLE);
        }

        private function onAwardBtnAnimFadeInCompleteHandler(param1:AnimationStateEvent) : void
        {
            this.updateFocus(InteractiveObject(this.awardBtnAnim.getBtn()));
        }

        private function onAwardBtnAnimFadeOutCompleteHandler(param1:AnimationStateEvent) : void
        {
            this.updateFocus(this);
        }

        private function onCloseBtnClickHandler(param1:ButtonEvent) : void
        {
            this.close();
        }

        private function onAwardBtnClickHandler(param1:ButtonEvent) : void
        {
            onButtonS();
            this.close();
        }

        private function onExtraAwardAnimFadeInCompleteHandler(param1:AnimationStateEvent) : void
        {
            this.awardBtnAnim.fadeIn();
            onPlaySoundS(SND_SHOW_ACCEPT_BUTTON);
        }

        private function onBackgroundFadeOutCompleteHandler(param1:AnimationStateEvent) : void
        {
            onCloseWindowS();
        }
    }
}
