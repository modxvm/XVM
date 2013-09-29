package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class ProfileMeta extends net.wg.infrastructure.base.AbstractView
    {
        public function ProfileMeta()
        {
            super();
            return;
        }

        public function onCloseProfileS():void
        {
            App.utils.asserter.assertNotNull(this.onCloseProfile, "onCloseProfile" + net.wg.data.constants.Errors.CANT_NULL);
            this.onCloseProfile();
            return;
        }

        public var onCloseProfile:Function=null;
    }
}
