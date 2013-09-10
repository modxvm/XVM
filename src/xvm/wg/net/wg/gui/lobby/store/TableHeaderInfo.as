package net.wg.gui.lobby.store 
{
    import flash.text.*;
    import scaleform.clik.core.*;
    
    public class TableHeaderInfo extends scaleform.clik.core.UIComponent
    {
        public function TableHeaderInfo()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.textField.text = MENU.SHOP_TABLE_HEADER_PRICE;
            return;
        }

        public var countField:flash.text.TextField=null;

        public var textField:flash.text.TextField=null;
    }
}
