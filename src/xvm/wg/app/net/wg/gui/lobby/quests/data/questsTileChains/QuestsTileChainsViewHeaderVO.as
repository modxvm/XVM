package net.wg.gui.lobby.quests.data.questsTileChains
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class QuestsTileChainsViewHeaderVO extends DAAPIDataClass
    {
        
        public function QuestsTileChainsViewHeaderVO(param1:Object)
        {
            super(param1);
        }
        
        public var titleText:String = "";
        
        public var backBtnText:String = "";
        
        public var backBtnTooltip:String = "";
        
        public var backgroundImagePath:String = "";
    }
}
