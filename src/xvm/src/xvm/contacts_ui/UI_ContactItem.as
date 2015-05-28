/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.contacts_ui
{
    import com.xfw.*;
    import net.wg.gui.messenger.data.*;
    import scaleform.clik.constants.*;

    public class UI_ContactItem extends ContactItemUI
    {
        private var xvm_contact_data:Object = null;

        public function UI_ContactItem()
        {
            //Logger.add("UI_ContactItem");
            super();
        }

        override public function set data(value:ContactItemVO):void
        {
            super.data = value;
            xvm_contact_data = value.xvm_contact_data;
        }

        override public function applyLayout():void
        {
            var d:ContactItemVO = data as ContactItemVO;
            if (!d || !xvm_contact_data)
            {
                super.applyLayout();
                return;
            }

            var nick:String = xvm_contact_data.nick;
            if (!nick || nick == null || nick == "")
            {
                super.applyLayout();
                return;
            }

            var userName:String = d.userPropsVO.userName;
            d.userPropsVO.userName = nick;
            super.applyLayout();
            d.userPropsVO.userName = userName;
        }
    }
}
