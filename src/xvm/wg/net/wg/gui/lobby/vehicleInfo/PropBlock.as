package net.wg.gui.lobby.vehicleInfo 
{
    import flash.display.*;
    import flash.text.*;
    
    public class PropBlock extends flash.display.Sprite
    {
        public function PropBlock()
        {
            super();
            return;
        }

        public function setData(arg1:Object):void
        {
            this.propValue.text = arg1.value;
            this.propName.text = MENU.vehicleinfo_params(arg1.name);
            return;
        }

        public var propValue:flash.text.TextField;

        public var propName:flash.text.TextField;
    }
}
