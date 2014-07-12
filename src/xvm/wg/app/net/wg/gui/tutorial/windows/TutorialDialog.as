package net.wg.gui.tutorial.windows
{
    import net.wg.gui.tutorial.meta.impl.TutorialDialogMeta;
    import net.wg.gui.tutorial.meta.ITutorialDialogMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.Event;
    
    public class TutorialDialog extends TutorialDialogMeta implements ITutorialDialogMeta
    {
        
        public function TutorialDialog() {
            super();
        }
        
        public var message:String;
        
        public var messageField:TextField;
        
        public var cancelBtn:SoundButtonEx;
        
        public var submitBtn:SoundButtonEx;
        
        protected var _data:Object;
        
        public function as_setContent(param1:Object) : void {
            this._data = param1;
            invalidate(InvalidationType.DATA);
        }
        
        public function as_updateContent(param1:Object) : void {
            this._data = param1;
            invalidate(InvalidationType.DATA);
        }
        
        override protected function configUI() : void {
            super.configUI();
            if(this.cancelBtn)
            {
                this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelClick);
            }
            if(this.submitBtn)
            {
                this.submitBtn.addEventListener(ButtonEvent.CLICK,this.onSubmitClick);
            }
        }
        
        override protected function draw() : void {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this._data))
            {
                this.drawData();
            }
        }
        
        override protected function onDispose() : void {
            super.onDispose();
            this._data = null;
            if(this.cancelBtn)
            {
                this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelClick);
                this.cancelBtn.dispose();
                if(this.cancelBtn.parent)
                {
                    this.cancelBtn.parent.removeChild(this.cancelBtn);
                }
                this.cancelBtn = null;
            }
            if(this.submitBtn)
            {
                this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.onSubmitClick);
                this.submitBtn.dispose();
                if(this.submitBtn.parent)
                {
                    this.submitBtn.parent.removeChild(this.submitBtn);
                }
                this.submitBtn = null;
            }
        }
        
        protected function drawData() : void {
        }
        
        protected function onSubmitClick(param1:Event) : void {
            submitS();
        }
        
        protected function onCancelClick(param1:Event) : void {
            cancelS();
        }
    }
}
