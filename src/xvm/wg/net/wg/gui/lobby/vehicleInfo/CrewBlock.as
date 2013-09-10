package net.wg.gui.lobby.vehicleInfo 
{
    import flash.display.*;
    import flash.text.*;
    
    public class CrewBlock extends flash.display.Sprite
    {
        public function CrewBlock()
        {
            super();
            return;
        }

        public function setData(arg1:Object):void
        {
            this.crewTankMan.text = arg1.tankmanType;
            this.crewValue.text = arg1.value;
            return;
        }

        public var crewTankMan:flash.text.TextField;

        public var crewValue:flash.text.TextField;
    }
}
