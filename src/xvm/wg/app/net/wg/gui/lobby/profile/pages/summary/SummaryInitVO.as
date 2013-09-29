package net.wg.gui.lobby.profile.pages.summary 
{
    import net.wg.data.daapi.base.*;
    
    public class SummaryInitVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function SummaryInitVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public var significantAwardsLabel:String="";

        public var significantAwardsErrorText:String="";

        public var commonScores:Object;
    }
}
