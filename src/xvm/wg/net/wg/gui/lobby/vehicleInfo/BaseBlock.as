package net.wg.gui.lobby.vehicleInfo 
{
    import flash.display.*;
    import flash.text.*;
    
    public class BaseBlock extends flash.display.Sprite
    {
        public function BaseBlock()
        {
            super();
            return;
        }

        public function setData(arg1:String):void
        {
            this.baseName.text = arg1;
            return;
        }

        public var baseName:flash.text.TextField;
    }
}
