package net.wg.gui.lobby.sellDialog 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class TotalResult extends scaleform.clik.core.UIComponent
    {
        public function TotalResult()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            this.headerTF.text = DIALOGS.VEHICLESELLDIALOG_COMMONRESULT;
            this.creditsIT.textFieldYOffset = net.wg.gui.lobby.sellDialog.VehicleSellDialog.ICONS_TEXT_OFFSET;
            this.goldIT.textFieldYOffset = net.wg.gui.lobby.sellDialog.VehicleSellDialog.ICONS_TEXT_OFFSET;
            return;
        }

        public function getSize():int
        {
            return this.headerTF.y + this.headerTF.height + PADDING_NEXT_BLOCK;
        }

        internal static const PADDING_NEXT_BLOCK:int=25;

        public var headerTF:flash.text.TextField;

        public var creditsIT:net.wg.gui.components.controls.IconText;

        public var goldIT:net.wg.gui.components.controls.IconText;
    }
}
