package net.wg.gui.notification 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.components.windows.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    
    public class SystemMessageDialog extends net.wg.infrastructure.base.meta.impl.SystemMessageDialogMeta implements net.wg.infrastructure.base.meta.ISystemMessageDialogMeta
    {
        public function SystemMessageDialog()
        {
            super();
            canResize = false;
            isModal = true;
            isCentered = true;
            showWindowBg = false;
            this.visible = false;
            return;
        }

        public function as_setMessageData(arg1:Object):void
        {
            this.messageData = new net.wg.gui.notification.NotificationInfoVO(arg1);
            invalidate(DATA_INVALID);
            return;
        }

        public function as_setInitData(arg1:Object):void
        {
            this.initInfo = new net.wg.gui.notification.NotificationDialogInitInfoVO(arg1);
            invalidate(INIT_DATA_INVALID);
            return;
        }

        public override function set visible(arg1:Boolean):void
        {
            super.visible = this.dimensionsInitialized;
            return;
        }

        public override function set window(arg1:net.wg.infrastructure.interfaces.IWindow):void
        {
            super.window = arg1;
            if (arg1) 
            {
                invalidate(DIMENSIONS_INVALID);
                invalidate(INIT_DATA_INVALID);
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.textField.multiline = true;
            this.textField.wordWrap = true;
            this.icon.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.iconLoadingCompleteHandler, false, 0, true);
            this.icon.addEventListener(net.wg.gui.events.UILoaderEvent.IOERROR, this.iconLoadingErrorHandler, false, 0, true);
            this.closeBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.closeButtonClickHandler, false, 0, true);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=null;
            super.draw();
            if (isInvalid(DATA_INVALID)) 
            {
                if (this.messageData) 
                {
                    loc1 = this.messageData.auxData;
                    if (loc1 && loc1.length > 1) 
                    {
                        App.utils.scheduler.scheduleTask(onWindowCloseS, loc1[1]);
                    }
                    loc2 = this.messageData.messageVO;
                    if (loc2.icon) 
                    {
                        this.icon.source = loc2.icon;
                    }
                    this.textField.htmlText = loc2.message;
                    invalidate(DIMENSIONS_INVALID);
                    invalidate(ICON_POSITION_INV);
                }
            }
            if (isInvalid(DIMENSIONS_INVALID) && window) 
            {
                this.bgMc.height = Math.round(this.textField.height + this.textField.y * 2);
                this.closeBtn.y = this.bgMc.height + 3;
                this.height = this.closeBtn.y + this.closeBtn.height;
                App.utils.scheduler.envokeInNextFrame(this.refreshWindowSize);
            }
            if (isInvalid(ICON_POSITION_INV)) 
            {
                if (this.textField.textHeight < this.icon.height) 
                {
                    this.icon.y = Math.round(this.textField.y + (-this.icon.height + this.textField.height) / 2) + 2;
                }
            }
            if (isInvalid(INIT_DATA_INVALID) && window) 
            {
                window.title = this.initInfo.title;
                this.closeBtn.label = this.initInfo.closeBtnTitle;
            }
            return;
        }

        protected override function onDispose():void
        {
            App.utils.scheduler.cancelTask(onWindowCloseS);
            this.icon.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.iconLoadingCompleteHandler);
            this.icon.removeEventListener(net.wg.gui.events.UILoaderEvent.IOERROR, this.iconLoadingErrorHandler);
            this.closeBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.closeButtonClickHandler);
            super.onDispose();
            return;
        }

        internal function refreshWindowSize():void
        {
            scaleform.clik.core.UIComponent(window).invalidate(net.wg.gui.components.windows.Window.INVALID_SRC_VIEW);
            this.dimensionsInitialized = true;
            this.visible = this.dimensionsInitialized;
            window.validateNow();
            return;
        }

        internal function closeButtonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onWindowCloseS();
            return;
        }

        internal function iconLoadingErrorHandler(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            this.icon.alpha = 0;
            return;
        }

        internal function iconLoadingCompleteHandler(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            var loc1:*=3;
            this.icon.x = loc1 + Math.round((this.textField.x - loc1 - this.icon.width) / 2);
            invalidate(ICON_POSITION_INV);
            return;
        }

        internal static const DATA_INVALID:String="dataInv";

        internal static const DIMENSIONS_INVALID:String="dimInv";

        internal static const ICON_POSITION_INV:String="iconPosInv";

        internal static const INIT_DATA_INVALID:String="initDataInv";

        public var icon:net.wg.gui.components.controls.UILoaderAlt;

        public var textField:flash.text.TextField;

        public var bgMc:flash.display.Sprite;

        public var closeBtn:net.wg.gui.components.controls.SoundButtonEx;

        internal var messageData:net.wg.gui.notification.NotificationInfoVO;

        internal var initInfo:net.wg.gui.notification.NotificationDialogInitInfoVO;

        internal var dimensionsInitialized:Boolean;
    }
}
