/**
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.comments.UI
{
    import com.xvm.*;
    import net.wg.gui.messenger.data.*;

    public class UI_ContactItem extends ContactItemUI
    {
        private var xvm_contact_data:Object = null;

        public function UI_ContactItem()
        {
            //Logger.add("UI_ContactItem");
            super();
        }

        override public function set data(value:Object):void
        {
            super.data = value;
            xvm_contact_data = value.xvm_contact_data;
        }

        override protected function draw():void
        {
            var d:ContactItemVO = data as ContactItemVO;
            if (!d || !xvm_contact_data)
            {
                super.draw();
                return;
            }

            var nick:String = xvm_contact_data.nick;
            if (!nick || nick == null || nick == "")
            {
                super.draw();
                return;
            }

            var userName:String = d.userPropsVO.userName;
            d.userPropsVO.userName = nick;
            super.draw();
            d.userPropsVO.userName = userName;
        }
    }
}
