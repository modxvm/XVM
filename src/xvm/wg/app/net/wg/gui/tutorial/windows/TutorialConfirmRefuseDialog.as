package net.wg.gui.tutorial.windows
{
    import net.wg.gui.tutorial.meta.impl.TutorialConfirmRefuseDialogMeta;
    import net.wg.gui.tutorial.meta.ITutorialConfirmRefuseDialogMeta;
    import net.wg.gui.components.controls.CheckBox;
    import flash.display.InteractiveObject;
    import flash.events.Event;
    
    public class TutorialConfirmRefuseDialog extends TutorialConfirmRefuseDialogMeta implements ITutorialConfirmRefuseDialogMeta
    {
        
        public function TutorialConfirmRefuseDialog()
        {
            super();
            isModal = true;
        }
        
        public var checkBox:CheckBox;
        
        override protected function drawData() : void
        {
            super.drawData();
            if(window)
            {
                window.title = _data.title;
            }
            if(messageField)
            {
                messageField.htmlText = _data.message;
            }
            if(this.checkBox)
            {
                this.checkBox.multiline = true;
                this.checkBox.wordWrap = true;
                this.checkBox.label = _data.checkBoxLabel;
                this.checkBox.selected = _data.doStartOnNextLogin;
            }
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            if(_data)
            {
                window.title = _data.title;
            }
            window.useBottomBtns = true;
        }
        
        override protected function onDispose() : void
        {
            this.checkBox.dispose();
            this.checkBox = null;
            super.onDispose();
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(cancelBtn);
        }
        
        override protected function onSubmitClick(param1:Event) : void
        {
            setStartOnNextLoginS(this.checkBox.selected);
            super.onSubmitClick(param1);
        }
    }
}
