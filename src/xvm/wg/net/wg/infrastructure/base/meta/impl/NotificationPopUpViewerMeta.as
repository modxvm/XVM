package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class NotificationPopUpViewerMeta extends net.wg.infrastructure.base.BaseDAAPIComponent
    {
        public function NotificationPopUpViewerMeta()
        {
            super();
            return;
        }

        public function setListClearS():void
        {
            App.utils.asserter.assertNotNull(this.setListClear, "setListClear" + net.wg.data.constants.Errors.CANT_NULL);
            this.setListClear();
            return;
        }

        public function onMessageHidedS(arg1:Boolean, arg2:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.onMessageHided, "onMessageHided" + net.wg.data.constants.Errors.CANT_NULL);
            this.onMessageHided(arg1, arg2);
            return;
        }

        public function onMessageShowMoreS(arg1:Object):void
        {
            App.utils.asserter.assertNotNull(this.onMessageShowMore, "onMessageShowMore" + net.wg.data.constants.Errors.CANT_NULL);
            this.onMessageShowMore(arg1);
            return;
        }

        public function onSecuritySettingsLinkClickS():void
        {
            App.utils.asserter.assertNotNull(this.onSecuritySettingsLinkClick, "onSecuritySettingsLinkClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.onSecuritySettingsLinkClick();
            return;
        }

        public var setListClear:Function=null;

        public var onMessageHided:Function=null;

        public var onMessageShowMore:Function=null;

        public var onSecuritySettingsLinkClick:Function=null;
    }
}
