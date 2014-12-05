package net.wg.gui.lobby.quests.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class SeasonTileVO extends DAAPIDataClass
    {
        
        public function SeasonTileVO(param1:Object)
        {
            super(param1);
        }
        
        public var id:Number = -1;
        
        public var isNew:Boolean = false;
        
        public var isCompleted:Boolean = false;
        
        public var image:String = "";
        
        public var imageOver:String = "";
        
        public var animation:String = "";
        
        public var label:String = "";
        
        public var progress:String = "";
        
        public var enabled:Boolean = true;
    }
}
