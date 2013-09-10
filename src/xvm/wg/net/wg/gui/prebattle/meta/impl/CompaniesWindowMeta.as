package net.wg.gui.prebattle.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class CompaniesWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function CompaniesWindowMeta()
        {
            super();
            return;
        }

        public function createCompanyS():void
        {
            App.utils.asserter.assertNotNull(this.createCompany, "createCompany" + net.wg.data.constants.Errors.CANT_NULL);
            this.createCompany();
            return;
        }

        public function joinCompanyS(arg1:uint):void
        {
            App.utils.asserter.assertNotNull(this.joinCompany, "joinCompany" + net.wg.data.constants.Errors.CANT_NULL);
            this.joinCompany(arg1);
            return;
        }

        public function getDivisionsListS():Array
        {
            App.utils.asserter.assertNotNull(this.getDivisionsList, "getDivisionsList" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getDivisionsList();
        }

        public function refreshCompaniesListS(arg1:String, arg2:Boolean, arg3:uint):void
        {
            App.utils.asserter.assertNotNull(this.refreshCompaniesList, "refreshCompaniesList" + net.wg.data.constants.Errors.CANT_NULL);
            this.refreshCompaniesList(arg1, arg2, arg3);
            return;
        }

        public function requestPlayersListS(arg1:uint):void
        {
            App.utils.asserter.assertNotNull(this.requestPlayersList, "requestPlayersList" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestPlayersList(arg1);
            return;
        }

        public function showFAQWindowS():void
        {
            App.utils.asserter.assertNotNull(this.showFAQWindow, "showFAQWindow" + net.wg.data.constants.Errors.CANT_NULL);
            this.showFAQWindow();
            return;
        }

        public function getClientIDS():Number
        {
            App.utils.asserter.assertNotNull(this.getClientID, "getClientID" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getClientID();
        }

        public var createCompany:Function=null;

        public var joinCompany:Function=null;

        public var getDivisionsList:Function=null;

        public var refreshCompaniesList:Function=null;

        public var requestPlayersList:Function=null;

        public var showFAQWindow:Function=null;

        public var getClientID:Function=null;
    }
}
