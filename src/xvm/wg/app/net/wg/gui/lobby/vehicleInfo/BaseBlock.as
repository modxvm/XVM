package net.wg.gui.lobby.vehicleInfo
{
    import flash.display.Sprite;
    import flash.text.TextField;
    
    public class BaseBlock extends Sprite
    {
        
        public function BaseBlock() {
            super();
        }
        
        public var baseName:TextField;
        
        public function setData(param1:String) : void {
            this.baseName.text = param1;
        }
    }
}
