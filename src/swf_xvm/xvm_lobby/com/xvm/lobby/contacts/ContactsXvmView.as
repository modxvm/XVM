/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.contacts
{
    import com.xfw.*;
    import com.xfw.XfwAccess;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import net.wg.gui.lobby.profile.LinkageUtils;
    import net.wg.gui.messenger.*;
    import net.wg.gui.messenger.data.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import org.idmedia.as3commons.util.*;

    public class ContactsXvmView extends XvmViewBase
    {
        private static const CMD_XVM_CONTACTS_AS_EDIT_CONTACT_DATA:String = "xvm_contacts.as_edit_contact_data";
        private static const XVM_EDIT_CONTACT_DATA_ALIAS:String = 'XvmEditContactDataView';

        private static const _swf_name:String = "xvm_lobbycontacts_ui.swf";

        public function ContactsXvmView(view:IView)
        {
            super(view);
        }

        public function get page():ContactsListPopover
        {
            return super.view as ContactsListPopover;
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            super.onAfterPopulate(e);
            if (Config.networkServicesSettings.comments)
            {
                App.instance.loaderMgr.addEventListener(LibraryLoaderEvent.LOADED, onLibLoaded, false, 0, true);

                if (XfwComponent.tryLoadUISWF("xvm_lobby", "xvm_lobbycontacts_ui.swf") != XfwConst.SWF_START_LOADING)
                    init();
            }
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            super.onBeforeDispose(e);
            App.instance.loaderMgr.removeEventListener(LibraryLoaderEvent.LOADED, onLibLoaded);
            Xfw.removeCommandListener(CMD_XVM_CONTACTS_AS_EDIT_CONTACT_DATA, editContactData);
        }

        // PRIVATE

        private function onLibLoaded(e:LibraryLoaderEvent):void
        {
            if (StringUtils.endsWith(e.url.toLowerCase(), _swf_name))
            {
                init();
                App.utils.scheduler.scheduleOnNextFrame(function():void
                {
                    page.treeComponent.list.invalidate();
                });
            }
        }

        private function init():void
        {
            page.treeComponent.list.itemRendererName =  "com.xvm.lobby.ui.contacts::UI_ContactsTreeItemRenderer";
            Xfw.addCommandListener(CMD_XVM_CONTACTS_AS_EDIT_CONTACT_DATA, editContactData);

            var linkageUtils:LinkageUtils = XfwAccess.getPrivateField(page, "xfw_linkageUtils");
            linkageUtils.addEntity(XVM_EDIT_CONTACT_DATA_ALIAS, "com.xvm.lobby.ui.contacts::UI_EditContactDataView");
        }

        private function editContactData(name:String, dbID:Number):Object
        {
            const cls:String = "com.xvm.lobby.ui.contacts::UI_EditContactDataView";
            var data:ContactListMainInfo = new ContactListMainInfo(name, dbID);
            IUpdatable(page.viewStack.show(cls, cls)).update(data);
            return null;
        }
    }
}
