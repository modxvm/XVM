package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.data.constants.Errors;
    
    public class ProfileMeta extends AbstractView
    {
        
        public function ProfileMeta() {
            super();
        }
        
        public var onCloseProfile:Function = null;
        
        public function onCloseProfileS() : void {
            App.utils.asserter.assertNotNull(this.onCloseProfile,"onCloseProfile" + Errors.CANT_NULL);
            this.onCloseProfile();
        }
    }
}
