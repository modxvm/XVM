package net.wg.gui.login.EULA 
{
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.utils.*;
    
    public class EULAFullDlg extends net.wg.gui.login.EULA.EULADlg
    {
        public function EULAFullDlg()
        {
            super();
            isModal = true;
            isCentered = true;
            canClose = false;
            canDrag = false;
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            constraints.addElement(this.agreeCheckBox.name, this.agreeCheckBox, scaleform.clik.utils.Constraints.BOTTOM | scaleform.clik.utils.Constraints.RIGHT);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            textArea.editable = false;
            textArea.selectable = true;
            textArea.textField.selectable = true;
            textArea.addEventListener(flash.events.Event.SCROLL, this.handleScroll);
            applyButton.enabled = false;
            this.agreeCheckBox.enabled = false;
            this.agreeCheckBox.addEventListener(flash.events.Event.SELECT, this.agreeCheckBoxHandler);
            return;
        }

        protected override function isAutoResize():Boolean
        {
            return false;
        }

        protected override function onDispose():void
        {
            textArea.removeEventListener(flash.events.Event.SCROLL, this.handleScroll);
            this.agreeCheckBox.removeEventListener(flash.events.Event.SELECT, this.agreeCheckBoxHandler);
            this.agreeCheckBox.dispose();
            super.onDispose();
            return;
        }

        internal function handleScroll(arg1:flash.events.Event):void
        {
            if (this.agreeCheckBox.enabled) 
                return;
            if (textArea.textField.scrollV == textArea.textField.maxScrollV || !textArea.scrollBar.visible) 
                this.agreeCheckBox.enabled = true;
            return;
        }

        internal function agreeCheckBoxHandler(arg1:flash.events.Event):void
        {
            applyButton.enabled = arg1.target.selected;
            return;
        }

        public var agreeCheckBox:net.wg.gui.components.controls.CheckBox;
    }
}
