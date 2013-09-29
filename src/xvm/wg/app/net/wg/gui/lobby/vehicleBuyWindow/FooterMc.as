package net.wg.gui.lobby.vehicleBuyWindow 
{
    import net.wg.gui.components.controls.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    
    public class FooterMc extends scaleform.clik.core.UIComponent
    {
        public function FooterMc()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.expandBtn.buttonMode = true;
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.submitBtn.dispose();
            this.cancelBtn.dispose();
            this.expandBtn.dispose();
            this.totalCreditsPrice.dispose();
            this.totalGoldPrice.dispose();
            return;
        }

        public var submitBtn:scaleform.clik.controls.Button;

        public var cancelBtn:scaleform.clik.controls.Button;

        public var expandBtn:net.wg.gui.lobby.vehicleBuyWindow.ExpandButton;

        public var totalCreditsPrice:net.wg.gui.components.controls.IconText;

        public var totalGoldPrice:net.wg.gui.components.controls.IconText;
    }
}
