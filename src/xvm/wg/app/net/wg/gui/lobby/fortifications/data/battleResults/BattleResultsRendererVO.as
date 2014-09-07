package net.wg.gui.lobby.fortifications.data.battleResults
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class BattleResultsRendererVO extends DAAPIDataClass
    {
        
        public function BattleResultsRendererVO(param1:Object)
        {
            super(param1);
        }
        
        public var battleID:int = -1;
        
        public var startTime:String = "";
        
        public var building:String = "";
        
        public var clanAbbrev:String = "";
        
        public var result:String = "";
        
        public var description:String = "";
        
        public var participated:Boolean = false;
        
        public var infoNotAvailable:Boolean = false;
    }
}
