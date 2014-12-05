package net.wg.gui.lobby.quests.data.seasonAwards
{
    public class VehicleSeasonAwardVO extends BaseSeasonAwardVO
    {
        
        public function VehicleSeasonAwardVO(param1:Object)
        {
            super(param1);
        }
        
        public var iconPath:String = "";
        
        public var levelIconPath:String = "";
        
        public var vehicleType:String = "";
        
        public var name:String = "";
        
        public var buttonText:String = "";
        
        public var vehicleId:Number = -1.0;
        
        public var buttonTooltipId:String = "";
        
        public var nation:String = "";
    }
}
