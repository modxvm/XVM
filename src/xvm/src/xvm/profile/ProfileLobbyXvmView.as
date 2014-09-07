/**
 * XVM - lobby
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.profile
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.misc.*;
    import com.xvm.utils.*;
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
            var accountData:HBC_AccountDataVo = HBC_AccountDataVo(page.header._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT));
            if (accountData)
                Globals[Globals.NAME] = accountData.userVO.userName;
        }
    }

}
