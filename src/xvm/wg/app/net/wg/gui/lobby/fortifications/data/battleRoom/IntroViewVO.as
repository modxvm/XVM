package net.wg.gui.lobby.fortifications.data.battleRoom
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class IntroViewVO extends DAAPIDataClass
    {
        
        public function IntroViewVO(param1:Object)
        {
            super(param1);
        }
        
        public var enableBtn:Boolean = false;
        
        public var fortBattleTitle:String = "";
        
        public var fortBattleDescr:String = "";
        
        public var fortBattleBtnTitle:String = "";
        
        public var clanBattleAdditionalText:String = "";
        
        public var clanBattleBtnSimpleTooltip:String = "";
        
        public var clanBattleBtnComplexTooltip:String = "";
    }
}
