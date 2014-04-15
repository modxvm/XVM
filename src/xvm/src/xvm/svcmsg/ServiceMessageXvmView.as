/**
 * XVM
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.svcmsg
{
    import com.xvm.*;
    import com.xvm.io.*;
    import com.xvm.infrastructure.*;
    import flash.events.*;
    import net.wg.data.*;
    import net.wg.gui.lobby.*;
    import net.wg.gui.notification.*;
    import net.wg.gui.notification.vo.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import org.idmedia.as3commons.util.*;
    import xvm.svcmsg.UI.*;

    public class ServiceMessageXvmView extends XvmViewBase
    {
        public function ServiceMessageXvmView(view:IView)
        {
            super(view);
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            try
            {
                if (view is LobbyPage)
                    initLobby(view as LobbyPage);
                if (view is NotificationListView)
                    initNotificationList(view as NotificationListView);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        // PUBLIC STATIC

        public static function fixData(value:NotificationInfoVO):NotificationInfoVO
        {
            if (value != null)
            {
                value.messageVO.message = Locale.get(value.messageVO.message).split("#XVM_SITE#").join('event:http://www.modxvm.com/#wot-main');
                if (value.messageVO.icon == "../maps/icons/library/MessageIcon-1.png" && ((new Date()).seconds % 5) == 0)
                    value.messageVO.message += "\n\n<b><font color='#0094FF'>С&л&а&в&а</font> <font color='#F9D915'>У&к&р&а&ї&н&і&!</font></b>".split("&").join("");
            }
            return value;
        }

        public static function onMessageLinkClick(e:TextEvent):void
        {
            //Logger.addObject(e);
            if (StringUtils.startsWith(e.text.toLowerCase(), 'http'))
                Cmd.openUrl(e.text);
        }

        // PRIVATE

        private function initLobby(v:LobbyPage):void
        {
            v.notificationPopupViewer.popupClass = UI_ServiceMessagePopUp;
        }

        private function initNotificationList(v:NotificationListView):void
        {
            v.list.itemRenderer = UI_ServiceMessageIR;
        }
    }

}
