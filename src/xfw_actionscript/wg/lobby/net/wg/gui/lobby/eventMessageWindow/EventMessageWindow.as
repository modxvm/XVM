package net.wg.gui.lobby.eventMessageWindow
{
    import net.wg.infrastructure.base.meta.impl.EventMessageWindowMeta;
    import net.wg.infrastructure.base.meta.IEventMessageWindowMeta;
    import net.wg.gui.components.controls.CloseButtonText;
    import flash.display.DisplayObjectContainer;
    import net.wg.gui.lobby.eventMessageWindow.views.MessageViewBase;
    import net.wg.gui.lobby.eventMessageWindow.data.MessageContentVO;
    import flash.display.DisplayObject;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.infrastructure.base.DefaultWindowGeometry;
    import scaleform.clik.utils.Padding;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.components.windows.Window;
    import flash.filters.BlurFilter;
    import flash.filters.BitmapFilterQuality;
    import net.wg.gui.lobby.eventMessageWindow.events.EventMessageWindowEvent;
    import scaleform.clik.events.InputEvent;
    import flash.ui.Keyboard;
    import scaleform.clik.constants.InputValue;
    import net.wg.gui.lobby.eventMessageWindow.data.MessageContentResult;
    import flash.events.Event;

    public class EventMessageWindow extends EventMessageWindowMeta implements IEventMessageWindowMeta
    {

        private static const STAGE_RESIZED:String = "stageResized";

        private static const BLUR_XY:int = 20;

        private static const BTN_CLOSE_PADDING_RIGHT:int = 0;

        private static const BTN_CLOSE_PADDING_TOP:int = 70;

        public var btnClose:CloseButtonText = null;

        public var messageContainer:DisplayObjectContainer = null;

        private var _content:MessageViewBase;

        private var _contentLinkage:String = "";

        private var _data:MessageContentVO;

        private var _blurWindows:Vector.<DisplayObject>;

        public function EventMessageWindow()
        {
            super();
            showWindowBgForm = false;
            showWindowBg = false;
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            invalidate(STAGE_RESIZED);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.btnClose.addEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
            this.btnClose.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATIONHEADER_CLOSE;
            this.btnClose.visible = false;
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            App.toolTipMgr.hide();
            geometry.positionStrategy = DefaultWindowGeometry.POSITION_ALWAYS;
            window.contentPadding = new Padding();
            this.updateContentPosition();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            super.draw();
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                this.updateContent();
            }
            if(isInvalid(STAGE_RESIZED))
            {
                _loc1_ = App.appWidth;
                _loc2_ = App.appHeight;
                if(this.btnClose != null)
                {
                    this.btnClose.y = BTN_CLOSE_PADDING_TOP - (_loc2_ >> 1);
                    this.btnClose.x = (_loc1_ >> 1) - this.btnClose.width - BTN_CLOSE_PADDING_RIGHT | 0;
                }
                if(this._content != null)
                {
                    this._content.setSize(_loc1_,_loc2_);
                }
                this.updateContentPosition();
            }
        }

        override protected function setMessageData(param1:MessageContentVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        override protected function onDispose() : void
        {
            this.clearBlurWindows();
            if(this._content)
            {
                this.disposeContent();
            }
            this.messageContainer = null;
            if(this.btnClose != null)
            {
                this.btnClose.removeEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
                this.btnClose.dispose();
                this.btnClose = null;
            }
            super.onDispose();
        }

        override protected function onClosingApproved() : void
        {
            super.onClosingApproved();
            if(this._content)
            {
                this._content.handleCancel();
            }
        }

        public function as_blurOtherWindows(param1:String) : void
        {
            var _loc4_:uint = 0;
            var _loc5_:uint = 0;
            var _loc6_:DisplayObject = null;
            this.clearBlurWindows();
            this._blurWindows = new Vector.<DisplayObject>(0);
            var _loc2_:Object = Object(App.containerMgr).containersMap;
            var _loc3_:DisplayObjectContainer = _loc2_[param1] as DisplayObjectContainer;
            if(_loc3_)
            {
                _loc4_ = _loc3_.numChildren;
                _loc5_ = 0;
                while(_loc5_ < _loc4_)
                {
                    _loc6_ = _loc3_.getChildAt(_loc5_);
                    if(!(_loc6_ is Window && (_loc6_ as Window).sourceView == this))
                    {
                        this._blurWindows.push(_loc6_);
                        _loc6_.filters = [new BlurFilter(BLUR_XY,BLUR_XY,BitmapFilterQuality.MEDIUM)];
                    }
                    _loc5_++;
                }
            }
        }

        private function updateContentPosition() : void
        {
            this.messageContainer.x = _width >> 1;
            this.messageContainer.y = _height >> 1;
        }

        private function updateContent() : void
        {
            this.btnClose.visible = this._data.showCloseButton;
            var _loc1_:String = this._data.messagePreset;
            if(this._contentLinkage != _loc1_)
            {
                if(this._content)
                {
                    this.disposeContent();
                }
                this._contentLinkage = _loc1_;
                this._content = App.utils.classFactory.getComponent(this._contentLinkage,MessageViewBase);
                this._content.addEventListener(EventMessageWindowEvent.RESULT,this.onResultHandler);
                this._content.addEventListener(EventMessageWindowEvent.ON_OUTRO_ANIMATION_STARTED,this.onOutroAnimationStartedHandler);
                this.messageContainer.addChild(this._content);
            }
            this._content.setSize(App.appWidth,App.appHeight);
            this._content.setData(this._data);
            setFocus(this._content.getFocusTarget());
        }

        private function disposeContent() : void
        {
            this._content.stop();
            this._content.removeEventListener(EventMessageWindowEvent.RESULT,this.onResultHandler);
            this._content.removeEventListener(EventMessageWindowEvent.ON_OUTRO_ANIMATION_STARTED,this.onOutroAnimationStartedHandler);
            this.messageContainer.removeChild(this._content);
            this._content.dispose();
            this._content = null;
        }

        private function clearBlurWindows() : void
        {
            var _loc1_:DisplayObject = null;
            if(this._blurWindows)
            {
                while(this._blurWindows.length)
                {
                    _loc1_ = this._blurWindows.pop();
                    _loc1_.filters = [];
                }
                this._blurWindows = null;
            }
        }

        override public function handleInput(param1:InputEvent) : void
        {
            if(!this._data.closeByEscape && param1.details.code == Keyboard.ESCAPE && param1.details.value == InputValue.KEY_DOWN)
            {
                param1.preventDefault();
                param1.handled = true;
                return;
            }
            super.handleInput(param1);
        }

        private function onResultHandler(param1:EventMessageWindowEvent) : void
        {
            onResultS(param1.result == MessageContentResult.OK);
        }

        private function onOutroAnimationStartedHandler(param1:Event) : void
        {
            this.btnClose.visible = false;
        }

        private function onBtnCloseClickHandler(param1:Event) : void
        {
            if(this._content)
            {
                this._content.handleCancel();
            }
        }
    }
}
