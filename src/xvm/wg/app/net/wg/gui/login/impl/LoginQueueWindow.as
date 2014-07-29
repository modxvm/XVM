package net.wg.gui.login.impl
{
    import net.wg.infrastructure.base.meta.impl.LoginQueueWindowMeta;
    import net.wg.infrastructure.base.meta.ILoginQueueWindowMeta;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextField;
    import scaleform.clik.events.ButtonEvent;
    
    public class LoginQueueWindow extends LoginQueueWindowMeta implements ILoginQueueWindowMeta
    {
        
        public function LoginQueueWindow()
        {
            super();
            canClose = false;
            showWindowBg = false;
            isCentered = true;
        }
        
        public var cancelBtn:SoundButtonEx = null;
        
        public var titleField:TextField = null;
        
        public var messageTextField:TextField = null;
        
        private var isFirstUpdateStage:Boolean = true;
        
        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            var _loc3_:Number = App.appWidth - window.width >> 1;
            var _loc4_:Number = App.appHeight - window.height >> 1;
            if(!this.isFirstUpdateStage)
            {
                window.x = _loc3_;
                window.y = _loc4_;
            }
            else
            {
                this.isFirstUpdateStage = false;
            }
        }
        
        public function as_setTitle(param1:String) : void
        {
            this.titleField.htmlText = param1;
        }
        
        public function as_setMessage(param1:String) : void
        {
            this.messageTextField.htmlText = param1;
        }
        
        public function as_setCancelLabel(param1:String) : void
        {
            this.cancelBtn.label = param1;
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler,false,0,true);
            window.getBackground().alpha = 0;
            setFocus(this.cancelBtn);
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
        }
        
        private function onCancelBtnClickHandler(param1:ButtonEvent) : void
        {
            onCancelClickS();
        }
    }
}
