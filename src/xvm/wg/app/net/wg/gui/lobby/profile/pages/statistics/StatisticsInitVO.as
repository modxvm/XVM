package net.wg.gui.lobby.profile.pages.statistics 
{
    import net.wg.data.daapi.base.*;
    
    public class StatisticsInitVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function StatisticsInitVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public var mainDropDownMenu:Array;

        public var commonScores:Object;

        public var detailedScores:Object;

        public var charts:Array;

        public var battlesOnTech:String="";

        public var chartsTitles:Array;
    }
}
