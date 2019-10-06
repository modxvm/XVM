package net.wg.gui.bootcamp.messageWindow
{
    import net.wg.infrastructure.base.meta.impl.BCMessageWindowMeta;
    import net.wg.infrastructure.base.meta.IBCMessageWindowMeta;
    import flash.display.MovieClip;
    import net.wg.gui.bootcamp.messageWindow.views.MessageViewBase;
    import net.wg.gui.bootcamp.messageWindow.data.MessageContentVO;
    import net.wg.infrastructure.base.DefaultWindowGeometry;
    import scaleform.clik.utils.Padding;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.bootcamp.messageWindow.interfaces.IMessageView;
    import net.wg.gui.bootcamp.messageWindow.events.MessageViewEvent;
    import flash.display.DisplayObject;
    import flash.events.Event;

    public class BCMessageWindow extends BCMessageWindowMeta implements IBCMessageWindowMeta
    {

        private static const STAGE_RESIZED:String = "stageResized";

        public var messageContainer:MovieClip = null;

        private var _contentRenderer:MessageViewBase;

        private var _messagesQueue:Vector.<MessageContentVO>;

        private var _messageIndex:uint;

        private var _renderLinkage:String;

        public function BCMessageWindow()
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

        override protected function onPopulate() : void
        {
            super.onPopulate();
            App.toolTipMgr.hide();
            geometry.positionStrategy = DefaultWindowGeometry.POSITION_ALWAYS;
            window.contentPadding = new Padding();
            this.messageContainer.x = _width >> 1;
            this.messageContainer.y = _height >> 1;
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._messagesQueue && isInvalid(InvalidationType.DATA))
            {
                this.createMessage();
            }
            if(this._contentRenderer && isInvalid(STAGE_RESIZED))
            {
                this._contentRenderer.setSize(App.appWidth,App.appHeight);
            }
        }

        override protected function setMessageData(param1:Vector.<MessageContentVO>) : void
        {
            this._messageIndex = 0;
            this._messagesQueue = param1;
            invalidateData();
        }

        override protected function onDispose() : void
        {
            this.disposeMessageView();
            this.messageContainer = null;
            this._messagesQueue = null;
            super.onDispose();
        }

        override protected function onClosingApproved() : void
        {
            super.onClosingApproved();
            if(this._contentRenderer)
            {
                this._contentRenderer.tryToClose();
            }
        }

        private function createMessage() : void
        {
            var _loc1_:MessageContentVO = this._messagesQueue[this._messageIndex];
            var _loc2_:String = _loc1_.messagePreset;
            if(this._renderLinkage != _loc2_)
            {
                if(this._contentRenderer)
                {
                    this.disposeMessageView();
                }
                this._renderLinkage = _loc2_;
                this._contentRenderer = App.utils.classFactory.getComponent(this._renderLinkage,IMessageView);
                this.messageContainer.addChild(this._contentRenderer);
                this._contentRenderer.addEventListener(MessageViewEvent.MESSAGE_REMOVED,this.onContentRendererMessageRemovedHandler);
                this._contentRenderer.addEventListener(MessageViewEvent.MESSAGE_OPEN_NATIONS,this.onContentRendererMessageOpenNationsHandler);
                this._contentRenderer.addEventListener(MessageViewEvent.MESSAGE_DISAPPEAR,this.onContentRendererMessageDisappearHandler);
            }
            this._contentRenderer.setSize(App.appWidth,App.appHeight);
            this._contentRenderer.setMessageData(_loc1_);
            setFocus(this._contentRenderer.getFocusTarget());
            onMessageAppearS(this._renderLinkage);
        }

        private function disposeMessageView() : void
        {
            this._contentRenderer.stop();
            this._contentRenderer.removeEventListener(MessageViewEvent.MESSAGE_REMOVED,this.onContentRendererMessageRemovedHandler);
            this._contentRenderer.removeEventListener(MessageViewEvent.MESSAGE_OPEN_NATIONS,this.onContentRendererMessageOpenNationsHandler);
            this._contentRenderer.removeEventListener(MessageViewEvent.MESSAGE_DISAPPEAR,this.onContentRendererMessageDisappearHandler);
            this.messageContainer.removeChild(DisplayObject(this._contentRenderer));
            this._contentRenderer.dispose();
            this._contentRenderer = null;
        }

        private function onContentRendererMessageOpenNationsHandler(param1:Event) : void
        {
            onMessageButtonClickedS();
        }

        private function onContentRendererMessageDisappearHandler(param1:Event) : void
        {
            onMessageDisappearS(this._renderLinkage);
        }

        private function onContentRendererMessageRemovedHandler(param1:Event) : void
        {
            this._messageIndex++;
            if(this._messageIndex < this._messagesQueue.length)
            {
                invalidateData();
                return;
            }
            onMessageRemovedS();
        }
    }
}
