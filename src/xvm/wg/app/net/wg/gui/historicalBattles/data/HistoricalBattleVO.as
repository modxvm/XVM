package net.wg.gui.historicalBattles.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class HistoricalBattleVO extends DAAPIDataClass
    {
        
        public function HistoricalBattleVO(param1:Object)
        {
            super(param1);
        }
        
        public var id:Number = -1;
        
        public var name:String = "";
        
        public var isFuture:Boolean = false;
        
        public var remainingTimeInfo:String = "";
        
        public var datesInfo:String = "";
        
        public var descriptionText:String = "";
        
        public var mapName:String = "";
        
        public var mapImage:String = "";
        
        public var mapInfo:String = "";
        
        public var sideA:String = "";
        
        public var sideB:String = "";
        
        public var descriptionURL:String = "";
        
        public var arenaID:Number = -1;
    }
}
