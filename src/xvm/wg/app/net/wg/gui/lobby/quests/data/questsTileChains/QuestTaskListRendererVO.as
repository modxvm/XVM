package net.wg.gui.lobby.quests.data.questsTileChains
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    
    public class QuestTaskListRendererVO extends Object implements IDisposable
    {
        
        public function QuestTaskListRendererVO(param1:int, param2:Object, param3:String = null)
        {
            super();
            this.type = param1;
            this.tooltip = param3;
            switch(param1)
            {
                case QuestTaskListRendererVO.STATISTICS:
                    this.statData = param2 as QuestTileStatisticsVO;
                    break;
                case QuestTaskListRendererVO.CHAIN:
                    this.chainData = param2 as QuestChainVO;
                    break;
                case QuestTaskListRendererVO.TASK:
                    this.taskData = param2 as QuestTaskVO;
            }
        }
        
        public static var STATISTICS:int = 0;
        
        public static var CHAIN:int = 1;
        
        public static var TASK:int = 2;
        
        public var type:int;
        
        public var statData:QuestTileStatisticsVO;
        
        public var chainData:QuestChainVO;
        
        public var taskData:QuestTaskVO;
        
        public var tooltip:String;
        
        public function dispose() : void
        {
            this.statData = null;
            this.chainData = null;
            this.taskData = null;
            this.tooltip = null;
        }
    }
}
