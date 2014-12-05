package net.wg.gui.lobby.profile.data
{
    import net.wg.data.VO.AchievementProgressVO;
    
    public class AchievementProfileVO extends AchievementProgressVO
    {
        
        public function AchievementProfileVO(param1:Object)
        {
            super(param1);
        }
        
        public var rareIconId:String = "";
        
        public var isRare:Boolean;
        
        public var isDossierForCurrentUser:Boolean;
    }
}
