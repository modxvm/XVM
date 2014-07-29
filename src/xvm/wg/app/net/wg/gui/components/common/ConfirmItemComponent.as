package net.wg.gui.components.common
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.IconText;
    import flash.text.TextField;
    import net.wg.gui.components.controls.ActionPrice;
    import net.wg.gui.components.controls.NumericStepper;
    import net.wg.gui.components.advanced.ExtraModuleIcon;
    import net.wg.gui.components.controls.DropdownMenu;
    
    public class ConfirmItemComponent extends UIComponent
    {
        
        public function ConfirmItemComponent()
        {
            super();
        }
        
        public var submitBtn:SoundButtonEx = null;
        
        public var cancelBtn:SoundButtonEx = null;
        
        public var leftResultIT:IconText = null;
        
        public var rightResultIT:IconText = null;
        
        public var countLabel:TextField = null;
        
        public var leftLabel:TextField = null;
        
        public var resultLabel:TextField = null;
        
        public var rightLabel:TextField = null;
        
        public var leftIT:IconText = null;
        
        public var rightIT:IconText = null;
        
        public var actionPrice:ActionPrice = null;
        
        public var nsCount:NumericStepper = null;
        
        public var description:TextField = null;
        
        public var moduleName:TextField = null;
        
        public var moduleIcon:ExtraModuleIcon = null;
        
        public var dropdownMenu:DropdownMenu = null;
        
        override protected function onDispose() : void
        {
            if(this.submitBtn)
            {
                this.submitBtn.dispose();
                this.submitBtn = null;
            }
            if(this.cancelBtn)
            {
                this.cancelBtn.dispose();
                this.cancelBtn = null;
            }
            if(this.leftResultIT)
            {
                this.leftResultIT.dispose();
                this.leftResultIT = null;
            }
            if(this.rightResultIT)
            {
                this.rightResultIT.dispose();
                this.rightResultIT = null;
            }
            if(this.actionPrice)
            {
                this.actionPrice.dispose();
                this.actionPrice = null;
            }
            if(this.nsCount)
            {
                this.nsCount.dispose();
                this.nsCount = null;
            }
            if(this.rightIT)
            {
                this.rightIT.dispose();
                this.rightIT = null;
            }
            if(this.leftIT)
            {
                this.leftIT.dispose();
                this.leftIT = null;
            }
            if(this.moduleIcon)
            {
                this.moduleIcon.dispose();
                this.moduleIcon = null;
            }
            if(this.dropdownMenu)
            {
                this.dropdownMenu.dispose();
                this.dropdownMenu = null;
            }
            this.countLabel = null;
            this.leftLabel = null;
            this.resultLabel = null;
            this.rightLabel = null;
            this.description = null;
            this.moduleName = null;
            super.onDispose();
        }
    }
}
