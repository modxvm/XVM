package net.wg.gui.lobby.quests.data.questsTileChains
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class QuestsTileChainsViewVO extends DAAPIDataClass
    {
        
        public function QuestsTileChainsViewVO(param1:Object)
        {
            super(param1);
        }
        
        public var noTasksText:String = "";
        
        public var header:QuestsTileChainsViewHeaderVO;
        
        public var filters:QuestsTileChainsViewFiltersVO;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            switch(param1)
            {
                case "header":
                    this.header = new QuestsTileChainsViewHeaderVO(param2);
                    return false;
                case "filters":
                    this.filters = new QuestsTileChainsViewFiltersVO(param2);
                    return false;
                default:
                    return true;
            }
        }
        
        override protected function onDispose() : void
        {
            this.header.dispose();
            this.header = null;
            this.filters.dispose();
            this.filters = null;
            super.onDispose();
        }
    }
}
