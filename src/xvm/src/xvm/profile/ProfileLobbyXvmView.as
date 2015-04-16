/**
 * XVM - lobby
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import net.wg.gui.lobby.*;
    import net.wg.gui.lobby.header.headerButtonBar.*;
    import net.wg.gui.lobby.header.vo.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class ProfileLobbyXvmView extends XvmViewBase
    {
        public function ProfileLobbyXvmView(view:IView)
        {
            super(view);
        }

        public function get page():LobbyPage
        {
            return super.view as LobbyPage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            // Save current user name to XvmGlobals
            var accountData:HBC_AccountDataVo = HBC_AccountDataVo(page.header.xfw_headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT));
            if (accountData)
                XvmGlobals[XvmGlobals.CURRENT_USER_NAME] = accountData.userVO.userName;
        }
    }

}
