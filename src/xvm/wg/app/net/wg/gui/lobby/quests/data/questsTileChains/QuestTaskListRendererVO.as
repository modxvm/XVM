package net.wg.gui.lobby.quests.data.questsTileChains
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    
    public class QuestTaskListRendererVO extends Object implements IDisposable
    {
        
        public function QuestTaskListRendererVO(param1:int, param2:Object, param3:String = null)
        {
            super();
            this.type = param1;
            this.data = param2;
            this.tooltip = param3;
        }
        
        public static var STATISTICS:int = 0;
        
        public static var CHAIN:int = 1;
        
        public static var TASK:int = 2;
        
        public var type:int;
        
        public var data:Object;
        
        public var tooltip:String;
        
        public function dispose() : void
        {
            this.data = null;
            this.tooltip = null;
        }
    }
}
