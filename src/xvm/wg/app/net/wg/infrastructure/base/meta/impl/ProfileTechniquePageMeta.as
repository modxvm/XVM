package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.profile.pages.technique.ProfileTechnique;
    import net.wg.data.constants.Errors;
    
    public class ProfileTechniquePageMeta extends ProfileTechnique
    {
        
        public function ProfileTechniquePageMeta() {
            super();
        }
        
        public var setIsInHangarSelected:Function = null;
        
        public function setIsInHangarSelectedS(param1:Boolean) : void {
            App.utils.asserter.assertNotNull(this.setIsInHangarSelected,"setIsInHangarSelected" + Errors.CANT_NULL);
            this.setIsInHangarSelected(param1);
        }
    }
}
