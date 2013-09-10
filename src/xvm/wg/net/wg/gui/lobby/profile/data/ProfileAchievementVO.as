package net.wg.gui.lobby.profile.data 
{
    import net.wg.data.VO.*;
    
    public class ProfileAchievementVO extends net.wg.data.VO.AchievementItemVO
    {
        public function ProfileAchievementVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public var isInDossier:Boolean;

        public var id:Array;

        public var dossierCompDescr:String="";

        public var dossierType:int;

        public var rareIconId:int;

        public var isRare:Boolean;

        public var lvlUpValue:uint;

        public var lvlUpTotalValue:uint;

        public var isDossierForCurrentUser:Boolean;
    }
}
