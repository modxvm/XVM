package net.wg.gui.lobby.vehicleInfo
{
    import flash.display.Sprite;
    import flash.text.TextField;
    
    public class CrewBlock extends Sprite
    {
        
        public function CrewBlock()
        {
            super();
        }
        
        public var crewTankMan:TextField;
        
        public var crewValue:TextField;
        
        public function setData(param1:Object) : void
        {
            this.crewTankMan.text = param1.tankmanType;
            this.crewValue.text = param1.value;
        }
    }
}
