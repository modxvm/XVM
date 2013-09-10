package net.wg.gui.login.impl 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.events.*;
    
    public class LoginQueueWindow extends net.wg.infrastructure.base.meta.impl.LoginQueueWindowMeta implements net.wg.infrastructure.base.meta.ILoginQueueWindowMeta
    {
        public function LoginQueueWindow()
        {
            super();
            canClose = false;
            showWindowBg = false;
            isCentered = true;
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            super.updateStage(arg1, arg2);
            var loc1:*=App.appWidth - window.width >> 1;
            var loc2:*=App.appHeight - window.height >> 1;
            if (this.isFirstUpdateStage) 
                this.isFirstUpdateStage = false;
            else 
            {
                window.x = loc1;
                window.y = loc2;
            }
            return;
        }

        public function as_setTitle(arg1:String):void
        {
            this.titleField.htmlText = arg1;
            return;
        }

        public function as_setMessage(arg1:String):void
        {
            this.messageTextField.htmlText = arg1;
            return;
        }

        public function as_setCancelLabel(arg1:String):void
        {
            this.cancelBtn.label = arg1;
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            this.cancelBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCancelBtnClickHandler, false, 0, true);
            window.getBackground().alpha = 0;
            App.utils.focusHandler.setFocus(this.cancelBtn);
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.cancelBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCancelBtnClickHandler);
            return;
        }

        internal function onCancelBtnClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onCancelClickS();
            return;
        }

        public var cancelBtn:net.wg.gui.components.controls.SoundButtonEx=null;

        public var titleField:flash.text.TextField=null;

        public var messageTextField:flash.text.TextField=null;

        internal var isFirstUpdateStage:Boolean=true;
    }
}
