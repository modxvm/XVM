package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class NotificationsListMeta extends net.wg.infrastructure.base.AbstractView
    {
        public function NotificationsListMeta()
        {
            super();
            return;
        }

        public function onWindowCloseS():void
        {
            App.utils.asserter.assertNotNull(this.onWindowClose, "onWindowClose" + net.wg.data.constants.Errors.CANT_NULL);
            this.onWindowClose();
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

        public var onWindowClose:Function=null;

        public var onMessageShowMore:Function=null;

        public var onSecuritySettingsLinkClick:Function=null;
    }
}
