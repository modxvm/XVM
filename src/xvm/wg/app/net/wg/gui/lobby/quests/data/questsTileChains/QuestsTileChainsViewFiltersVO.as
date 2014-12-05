package net.wg.gui.lobby.quests.data.questsTileChains
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class QuestsTileChainsViewFiltersVO extends DAAPIDataClass
    {
        
        public function QuestsTileChainsViewFiltersVO(param1:Object)
        {
            super(param1);
        }
        
        public var filtersLabel:String = "";
        
        public var vehicleTypeFilterData:Array = null;
        
        public var taskTypeFilterData:Array = null;
        
        public var hideCompletedTaskText:String = "";
        
        public var defVehicleType:int = -1;
        
        public var defTaskType:String = "";
        
        public var hideCompleted:Boolean;
    }
}
