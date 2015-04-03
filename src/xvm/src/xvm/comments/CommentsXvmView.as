/**
 * XVM - comments
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.comments
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xfw.infrastructure.*;
    import flash.utils.*;
    import net.wg.gui.messenger.*;
    import net.wg.gui.messenger.data.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import xvm.comments.UI.*;

    public class CommentsXvmView extends XvmViewBase
    {
        private static const CMD_XVM_COMMENTS_AS_EDIT_CONTACT_DATA:String = "xvm_contacts.as_edit_contact_data";

        private static const XVM_EDIT_CONTACT_DATA_ALIAS:String = 'XvmEditContactDataView';

        public function CommentsXvmView(view:IView)
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

            Xvm.addEventListener(Defines.XFW_EVENT_CMD_RECEIVED, handleXfwCommand);
            page.treeComponent.list.itemRenderer = UI_ContactsTreeItemRenderer;
            page.xfw_linkageUtils.addEntity(XVM_EDIT_CONTACT_DATA_ALIAS, getQualifiedClassName(UI_EditContactDataView));
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            Xvm.removeEventListener(Defines.XFW_EVENT_CMD_RECEIVED, handleXfwCommand);
        }

        // PRIVATE

        private function handleXfwCommand(e:XfwCmdReceivedEvent):void
        {
            //Logger.add("handleXfwCommand: " + e.result.cmd);
            try
            {
                switch (e.cmd)
                {
                    case CMD_XVM_COMMENTS_AS_EDIT_CONTACT_DATA:
                        e.stopImmediatePropagation();
                        var data:ContactListMainInfo = new ContactListMainInfo(e.args[0], e.args[1]);
                        IUpdatable(page.viewStack.show(getQualifiedClassName(UI_EditContactDataView))).update(data);
                        break;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
