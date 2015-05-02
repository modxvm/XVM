/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.svcmsg.UI
{
    import com.xfw.*;
    import flash.events.*;
    import net.wg.gui.notification.vo.*;
    import xvm.svcmsg.*;

    public dynamic class UI_ServiceMessageIR extends ServiceMessageIR_UI
    {
        public function UI_ServiceMessageIR()
        {
            //Logger.add('UI_ServiceMessageIR');
            super();
        }

        override protected function configUI():void
        {
            try
            {
                super.configUI();
                this.textField.addEventListener(TextEvent.LINK, ServiceMessageXvmView.onMessageLinkClick);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override public function set data(value:Object):void
        {
            try
            {
                super.data = ServiceMessageXvmView.fixData(value as NotificationInfoVO);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
