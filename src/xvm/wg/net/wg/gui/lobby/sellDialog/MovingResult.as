package net.wg.gui.lobby.sellDialog 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class MovingResult extends scaleform.clik.core.UIComponent
    {
        public function MovingResult()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            this.text.text = DIALOGS.CONFIRMMODULEDIALOG_TOTALLABEL;
            this.creditsIT.textFieldYOffset = net.wg.gui.lobby.sellDialog.VehicleSellDialog.ICONS_TEXT_OFFSET;
            return;
        }

        public var creditsIT:net.wg.gui.components.controls.IconText;

        public var text:flash.text.TextField;
    }
}
