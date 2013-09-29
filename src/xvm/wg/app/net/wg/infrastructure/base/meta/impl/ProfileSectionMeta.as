package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class ProfileSectionMeta extends net.wg.infrastructure.base.BaseDAAPIComponent
    {
        public function ProfileSectionMeta()
        {
            super();
            return;
        }

        public function setActiveS(arg1:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.setActive, "setActive" + net.wg.data.constants.Errors.CANT_NULL);
            this.setActive(arg1);
            return;
        }

        public function requestDataS(arg1:Object):void
        {
            App.utils.asserter.assertNotNull(this.requestData, "requestData" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestData(arg1);
            return;
        }

        public var setActive:Function=null;

        public var requestData:Function=null;
    }
}
