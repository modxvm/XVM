package net.wg.gui.lobby.store.shop
{
    import flash.display.Sprite;
    import flash.text.TextField;
    
    public class ShopRent extends Sprite
    {
        
        public function ShopRent()
        {
            super();
        }
        
        public var textField:TextField = null;
        
        public function updateText(param1:String) : void
        {
            this.textField.text = param1;
        }
    }
}
