package net.wg.gui.lobby.quests.data.questsTileChains
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class QuestChainVO extends DAAPIDataClass
    {
        
        public function QuestChainVO(param1:Object)
        {
            super(param1);
        }
        
        public var name:String = "";
        
        public var progressText:String = "";
        
        public var tasks:Vector.<QuestTaskVO> = null;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Object = null;
            var _loc4_:Array = null;
            if(param1 == "tasks")
            {
                _loc4_ = param2 as Array;
                for each(_loc3_ in _loc4_)
                {
                    if(_loc3_)
                    {
                        if(this.tasks == null)
                        {
                            this.tasks = new Vector.<QuestTaskVO>();
                        }
                        this.tasks.push(new QuestTaskVO(_loc3_));
                    }
                }
                return false;
            }
            return true;
        }
        
        override protected function onDispose() : void
        {
            while((this.tasks) && this.tasks.length > 0)
            {
                this.tasks.pop().dispose();
            }
            this.tasks = null;
            super.onDispose();
        }
    }
}
