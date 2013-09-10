package net.wg.gui.tutorial.windows 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.tutorial.meta.*;
    import net.wg.gui.tutorial.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    
    public class TutorialDialog extends net.wg.gui.tutorial.meta.impl.TutorialDialogMeta implements net.wg.gui.tutorial.meta.ITutorialDialogMeta
    {
        public function TutorialDialog()
        {
            super();
            return;
        }

        public function as_setContent(arg1:Object):void
        {
            this._data = arg1;
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        public function as_updateContent(arg1:Object):void
        {
            this._data = arg1;
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            if (this.cancelBtn) 
                this.cancelBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCancelClick);
            if (this.submitBtn) 
                this.submitBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSubmitClick);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && this._data) 
                this.drawData();
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this._data = null;
            if (this.cancelBtn) 
            {
                this.cancelBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCancelClick);
                this.cancelBtn.dispose();
                if (this.cancelBtn.parent) 
                    this.cancelBtn.parent.removeChild(this.cancelBtn);
                this.cancelBtn = null;
            }
            if (this.submitBtn) 
            {
                this.submitBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSubmitClick);
                this.submitBtn.dispose();
                if (this.submitBtn.parent) 
                    this.submitBtn.parent.removeChild(this.submitBtn);
                this.submitBtn = null;
            }
            return;
        }

        protected function drawData():void
        {
            return;
        }

        protected function onSubmitClick(arg1:flash.events.Event):void
        {
            submitS();
            return;
        }

        protected function onCancelClick(arg1:flash.events.Event):void
        {
            cancelS();
            return;
        }

        public var message:String;

        public var messageField:flash.text.TextField;

        public var cancelBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var submitBtn:net.wg.gui.components.controls.SoundButtonEx;

        protected var _data:Object;
    }
}
