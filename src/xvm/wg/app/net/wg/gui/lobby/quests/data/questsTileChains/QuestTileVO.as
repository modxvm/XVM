package net.wg.gui.lobby.quests.data.questsTileChains
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class QuestTileVO extends DAAPIDataClass
    {
        
        public function QuestTileVO(param1:Object)
        {
            super(param1);
        }
        
        public var chains:Vector.<QuestChainVO>;
        
        public var statistics:QuestTileStatisticsVO;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Object = null;
            var _loc4_:Array = null;
            switch(param1)
            {
                case "chains":
                    _loc4_ = param2 as Array;
                    for each(_loc3_ in _loc4_)
                    {
                        if(_loc3_)
                        {
                            if(this.chains == null)
                            {
                                this.chains = new Vector.<QuestChainVO>();
                            }
                            this.chains.push(new QuestChainVO(_loc3_));
                        }
                    }
                    return false;
                case "statistics":
                    this.statistics = new QuestTileStatisticsVO(param2);
                    return false;
                default:
                    return true;
            }
        }
        
        public function hasTasks() : Boolean
        {
            var _loc1_:QuestChainVO = null;
            for each(_loc1_ in this.chains)
            {
                if(_loc1_.tasks.length > 0)
                {
                    return true;
                }
            }
            return false;
        }
        
        override protected function onDispose() : void
        {
            while((this.chains) && this.chains.length > 0)
            {
                this.chains.pop().dispose();
            }
            this.chains = null;
            this.statistics.dispose();
            this.statistics = null;
            super.onDispose();
        }
    }
}
