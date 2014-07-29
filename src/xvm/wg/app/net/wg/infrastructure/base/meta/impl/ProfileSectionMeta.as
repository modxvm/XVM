package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;
    
    public class ProfileSectionMeta extends BaseDAAPIComponent
    {
        
        public function ProfileSectionMeta()
        {
            super();
        }
        
        public var setActive:Function = null;
        
        public var requestData:Function = null;
        
        public var requestDossier:Function = null;
        
        public function setActiveS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.setActive,"setActive" + Errors.CANT_NULL);
            this.setActive(param1);
        }
        
        public function requestDataS(param1:Object) : void
        {
            App.utils.asserter.assertNotNull(this.requestData,"requestData" + Errors.CANT_NULL);
            this.requestData(param1);
        }
        
        public function requestDossierS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.requestDossier,"requestDossier" + Errors.CANT_NULL);
            this.requestDossier(param1);
        }
    }
}
