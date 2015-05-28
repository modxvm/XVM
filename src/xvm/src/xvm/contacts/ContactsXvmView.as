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
    import org.idmedia.as3commons.util.StringUtils;

    public class ContactsXvmView extends XvmViewBase
    {
        private static const CMD_XVM_CONTACTS_AS_EDIT_CONTACT_DATA:String = "xvm_contacts.as_edit_contact_data";

        private static const XVM_EDIT_CONTACT_DATA_ALIAS:String = 'XvmEditContactDataView';

        private static const _name:String = "xvm_contacts";
        private static const _ui_name:String = _name + "_ui.swf";
        private static const _preloads:Array = [];// [ "messengerControls.swf", "contactsTreeComponents.swf", "contactsListPopover.swf" ];

        private static var _ui_swf_loaded:Boolean = false;

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

            App.instance.loaderMgr.addEventListener(LibraryLoaderEvent.LOADED, onLibLoaded);

            if (!_ui_swf_loaded)
            {
                _ui_swf_loaded = true;
                Xfw.load_ui_swf(_name, _ui_name, _preloads);
            }
            else
            {
                init();
            }
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            if (!Config.networkServicesSettings.comments)
                return;

            App.instance.loaderMgr.removeEventListener(LibraryLoaderEvent.LOADED, onLibLoaded);
            Xfw.removeCommandListener(CMD_XVM_CONTACTS_AS_EDIT_CONTACT_DATA, editContactData);
        }

        // PRIVATE

        private function onLibLoaded(e:LibraryLoaderEvent):void
        {
            if (StringUtils.endsWith(e.url.toLowerCase(), _ui_name))
            {
                init();
                App.utils.scheduler.envokeInNextFrame(function():void
                {
                    page.treeComponent.list.invalidate();
                });
            }
        }

        private function init():void
        {
            page.treeComponent.list.itemRendererName =  "xvm.contacts_ui::UI_ContactsTreeItemRenderer";
            Xfw.addCommandListener(CMD_XVM_CONTACTS_AS_EDIT_CONTACT_DATA, editContactData);
            page.xfw_linkageUtils.addEntity(XVM_EDIT_CONTACT_DATA_ALIAS, "xvm.contacts_ui::UI_EditContactDataView");
        }

        private function editContactData(name:String, dbID:Number):void
        {
            var data:ContactListMainInfo = new ContactListMainInfo(name, dbID);
            IUpdatable(page.viewStack.show("xvm.contacts_ui::UI_EditContactDataView")).update(data);
        }
    }
}
