package net.wg.gui.rally.views.list
{
    import flash.display.Sprite;
    import net.wg.gui.rally.interfaces.IRallyNoSortieScreen;
    import flash.text.TextField;
    
    public class RallyNoSortieScreen extends Sprite implements IRallyNoSortieScreen
    {
        
        public function RallyNoSortieScreen()
        {
            super();
            this.textField.visible = true;
        }
        
        public var textField:TextField = null;
        
        public function showText(param1:Boolean) : void
        {
            this.textField.visible = param1;
        }
        
        public function dispose() : void
        {
            this.textField = null;
        }
        
        public function update(param1:Object) : void
        {
            this.textField.text = param1.toString();
        }
    }
}
