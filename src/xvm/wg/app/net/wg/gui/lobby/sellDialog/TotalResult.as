package net.wg.gui.lobby.sellDialog
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.IconText;
    
    public class TotalResult extends UIComponent
    {
        
        public function TotalResult()
        {
            super();
        }
        
        private static var PADDING_NEXT_BLOCK:int = 25;
        
        public var headerTF:TextField;
        
        public var creditsIT:IconText;
        
        public var goldIT:IconText;
        
        override protected function configUI() : void
        {
            this.headerTF.text = DIALOGS.VEHICLESELLDIALOG_COMMONRESULT;
            this.creditsIT.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
            this.goldIT.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
        }
        
        public function getSize() : int
        {
            return this.headerTF.y + this.headerTF.height + PADDING_NEXT_BLOCK;
        }
    }
}
