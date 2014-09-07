package net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ClanBattleListVO extends DAAPIDataClass
    {
        
        public function ClanBattleListVO(param1:Object)
        {
            super(param1);
        }
        
        public var actionDescr:String = "";
        
        public var titleLbl:String = "";
        
        public var descrLbl:String = "";
        
        public var battlesCountTitle:String = "";
    }
}
