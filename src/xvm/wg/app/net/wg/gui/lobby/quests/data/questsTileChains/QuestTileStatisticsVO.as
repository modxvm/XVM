package net.wg.gui.lobby.quests.data.questsTileChains
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class QuestTileStatisticsVO extends DAAPIDataClass
    {
        
        public function QuestTileStatisticsVO(param1:Object)
        {
            super(param1);
        }
        
        public var label:String = "";
        
        public var arrowIconPath:String = "";
        
        public var tooltip:String = "";
    }
}
