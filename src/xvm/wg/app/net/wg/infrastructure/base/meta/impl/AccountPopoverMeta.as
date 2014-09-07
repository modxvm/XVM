package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.SmartPopOverView;
    import net.wg.data.constants.Errors;
    
    public class AccountPopoverMeta extends SmartPopOverView
    {
        
        public function AccountPopoverMeta()
        {
            super();
        }
        
        public var openProfile:Function = null;
        
        public var openClanStatistic:Function = null;
        
        public var openCrewStatistic:Function = null;
        
        public function openProfileS() : void
        {
            App.utils.asserter.assertNotNull(this.openProfile,"openProfile" + Errors.CANT_NULL);
            this.openProfile();
        }
        
        public function openClanStatisticS() : void
        {
            App.utils.asserter.assertNotNull(this.openClanStatistic,"openClanStatistic" + Errors.CANT_NULL);
            this.openClanStatistic();
        }
        
        public function openCrewStatisticS() : void
        {
            App.utils.asserter.assertNotNull(this.openCrewStatistic,"openCrewStatistic" + Errors.CANT_NULL);
            this.openCrewStatistic();
        }
    }
}
