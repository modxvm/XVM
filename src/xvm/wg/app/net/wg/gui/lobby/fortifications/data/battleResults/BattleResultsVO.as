package net.wg.gui.lobby.fortifications.data.battleResults
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class BattleResultsVO extends DAAPIDataClass
    {
        
        public function BattleResultsVO(param1:Object)
        {
            this.battles = [];
            super(param1);
        }
        
        public var windowTitle:String = "";
        
        public var resultText:String = "";
        
        public var descriptionStartText:String = "";
        
        public var descriptionEndText:String = "";
        
        public var journalText:String = "";
        
        public var defResReceivedText:String = "";
        
        public var byClanText:String = "";
        
        public var byPlayerText:String = "";
        
        public var battleResult:String = "";
        
        public var clanResText:String = "";
        
        public var playerResText:String = "";
        
        public var battles:Array;
    }
}
