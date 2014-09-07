package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.prebattle.base.BasePrebattleListView;
    import net.wg.data.constants.Errors;
    
    public class CompanyListMeta extends BasePrebattleListView
    {
        
        public function CompanyListMeta()
        {
            super();
        }
        
        public var createCompany:Function = null;
        
        public var joinCompany:Function = null;
        
        public var getDivisionsList:Function = null;
        
        public var refreshCompaniesList:Function = null;
        
        public var requestPlayersList:Function = null;
        
        public var showFAQWindow:Function = null;
        
        public var getClientID:Function = null;
        
        public function createCompanyS() : void
        {
            App.utils.asserter.assertNotNull(this.createCompany,"createCompany" + Errors.CANT_NULL);
            this.createCompany();
        }
        
        public function joinCompanyS(param1:uint) : void
        {
            App.utils.asserter.assertNotNull(this.joinCompany,"joinCompany" + Errors.CANT_NULL);
            this.joinCompany(param1);
        }
        
        public function getDivisionsListS() : Array
        {
            App.utils.asserter.assertNotNull(this.getDivisionsList,"getDivisionsList" + Errors.CANT_NULL);
            return this.getDivisionsList();
        }
        
        public function refreshCompaniesListS(param1:String, param2:Boolean, param3:uint) : void
        {
            App.utils.asserter.assertNotNull(this.refreshCompaniesList,"refreshCompaniesList" + Errors.CANT_NULL);
            this.refreshCompaniesList(param1,param2,param3);
        }
        
        public function requestPlayersListS(param1:uint) : void
        {
            App.utils.asserter.assertNotNull(this.requestPlayersList,"requestPlayersList" + Errors.CANT_NULL);
            this.requestPlayersList(param1);
        }
        
        public function showFAQWindowS() : void
        {
            App.utils.asserter.assertNotNull(this.showFAQWindow,"showFAQWindow" + Errors.CANT_NULL);
            this.showFAQWindow();
        }
        
        public function getClientIDS() : Number
        {
            App.utils.asserter.assertNotNull(this.getClientID,"getClientID" + Errors.CANT_NULL);
            return this.getClientID();
        }
    }
}
