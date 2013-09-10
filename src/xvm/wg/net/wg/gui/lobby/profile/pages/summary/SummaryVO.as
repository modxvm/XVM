package net.wg.gui.lobby.profile.pages.summary 
{
    import __AS3__.vec.*;
    import net.wg.data.daapi.base.*;
    
    public class SummaryVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function SummaryVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public var significantAwards:Array;

        internal var _significantAwardsVec:__AS3__.vec.Vector.<net.wg.gui.lobby.profile.data.ProfileAchievementVO>;
    }
}
