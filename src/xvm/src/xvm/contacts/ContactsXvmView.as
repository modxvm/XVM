/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.contacts
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import flash.utils.*;
    import net.wg.gui.messenger.*;
    import net.wg.gui.messenger.data.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import xvm.contacts.UI.*;

    public class ContactsXvmView extends XvmViewBase
    {
        private static const CMD_XVM_CONTACTS_AS_EDIT_CONTACT_DATA:String = "xvm_contacts.as_edit_contact_data";

        private static const XVM_EDIT_CONTACT_DATA_ALIAS:String = 'XvmEditContactDataView';

        public function ContactsXvmView(view:IView)
        {
            super(view);
        }

        public function get page():ContactsListPopover
        {
            return super.view as ContactsListPopover;
        }

        override public function onBeforePopulate(e:LifeCycleEvent):void
        {
            //page.borderLip.y += 100;
            //page.treeComponent.setListTopBound(50);
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            if (!Config.networkServicesSettings.comments)
                return;

            Xfw.addCommandListener(CMD_XVM_CONTACTS_AS_EDIT_CONTACT_DATA, editContactData);
            page.treeComponent.list.itemRenderer = UI_ContactsTreeItemRenderer;
            page.xfw_linkageUtils.addEntity(XVM_EDIT_CONTACT_DATA_ALIAS, getQualifiedClassName(UI_EditContactDataView));
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            Xfw.removeCommandListener(CMD_XVM_CONTACTS_AS_EDIT_CONTACT_DATA, editContactData);
        }

        // PRIVATE

        private function editContactData(name:String, dbID:Number):void
        {
            var data:ContactListMainInfo = new ContactListMainInfo(name, dbID);
            IUpdatable(page.viewStack.show(getQualifiedClassName(UI_EditContactDataView))).update(data);
        }
    }
}
