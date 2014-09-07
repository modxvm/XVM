package net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class FortClanBattleRoomVO extends DAAPIDataClass
    {
        
        public function FortClanBattleRoomVO(param1:Object)
        {
            super(param1);
        }
        
        public var mapName:String = "";
        
        public var mapID:int = -1;
        
        public var headerDescr:String = "";
        
        public var mineClanName:String = "";
        
        public var mineClanIcon:String = "";
        
        public var enemyClanName:String = "";
        
        public var enemyClanIcon:String = "";
    }
}
