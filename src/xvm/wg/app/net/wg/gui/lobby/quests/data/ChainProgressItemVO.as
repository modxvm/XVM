package net.wg.gui.lobby.quests.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ChainProgressItemVO extends DAAPIDataClass
    {
        
        public function ChainProgressItemVO(param1:Object)
        {
            super(param1);
        }
        
        public var label:String = "";
        
        public var value:String = "";
        
        public var iconSource:String = "";
        
        public var tileID:int = -1;
        
        public var chainID:int = -1;
    }
}
