/**
 * XVM - comments
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.comments
{
    import com.xvm.*;
    import com.xvm.events.*;
    import com.xvm.infrastructure.*;
    import net.wg.gui.messenger.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.comments.UI.*;

    public class CommentsXvmView extends XvmViewBase
    {
        //private static const CMD_XVM_COMMENTS_GET_COMMENTS:String = "xvm_comments.get_comments";
        //private static const CMD_XVM_COMMENTS_EDIT_CONTACT_DATA:String = "xvm_comments.as_edit_contact_data";
        //private static const CMD_XVM_COMMENTS_UPDATE_DATA:String = "xvm_comments.as_update_data";

        //private static const XVM_EDIT_CONTACT_DATA_ALIAS:String = 'XvmEditContactDataView';

        public function CommentsXvmView(view:IView)
        {
            super(view);
            //CommentsGlobalData.instance.clearData();
        }

        public function get page():ContactsListPopover
        {
            return super.view as ContactsListPopover;
        }

        override public function onBeforePopulate(e:LifeCycleEvent):void
        {
            page.borderLip.y += 100;
            page.treeComponent.setListTopBound(50);
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            if (!Config.networkServicesSettings.comments)
                return;

            Xvm.addEventListener(Defines.XPM_EVENT_CMD_RECEIVED, handleXpmCommand);
            page.treeComponent.list.itemRenderer = UI_ContactsTreeItemRenderer;
            //page.xvm_linkageUtils.addEntity(XVM_EDIT_CONTACT_DATA_ALIAS, getQualifiedClassName(UI_EditContactDataView));
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            Xvm.removeEventListener(Defines.XPM_EVENT_CMD_RECEIVED, handleXpmCommand);
        }

        // PRIVATE

        private function handleXpmCommand(e:ObjectEvent):void
        {
            //Logger.add("handleXpmCommand: " + e.result.cmd);
            try
            {
                switch (e.result.cmd)
                {
                    /*
                    case CMD_XVM_COMMENTS_EDIT_CONTACT_DATA:
                        var data:ContactListMainInfo = new ContactListMainInfo(e.result.args[0], e.result.args[1]);
                        IUpdatable(page.viewStack.show(getQualifiedClassName(UI_EditContactDataView))).update(data);
                        break;
                    case CMD_XVM_COMMENTS_UPDATE_DATA:
                        updateComments.apply(this, e.result.args);
                    */
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        /*
        private function updateComments(json_str:String, isGetCommand:Boolean):void
        {
            //Logger.add("updateComments: " + json_str);
            try
            {
                var data:Object = { };
                try
                {
                    data = JSONx.parse(json_str);
                    if (data == null)
                        data = { };
                }
                catch (ex:Error)
                {
                    Logger.add(ex.getStackTrace());
                }
                if (data.error != null)
                {
                    CommentsGlobalData.instance.clearData();
                    Logger.add("[XVM:COMMENTS] WARNING: [" + data.error + "] " + (data.errStr || ""));
                    var err:String = "[" + data.error + "] " + (data.errStr || "") + "\n\n" + Locale.get("Comments disabled");
                    if (isGetCommand)
                    {
                        err = Defines.SYSTEM_MESSAGE_HEADER.replace("%VALUE%", "<b>" + Locale.get("Error loading comments") + "</b>\n\n" + err);
                        Xvm.cmd(Defines.XPM_COMMAND_SYSMESSAGE, err, "Warning");
                    }
                    else
                    {
                        Xvm.cmd(Defines.XPM_COMMAND_MESSAGEBOX, Locale.get("Error saving comments"), err);
                    }
                }
                else
                {
                    CommentsGlobalData.instance.setData(data);
                }
                page.invalidate("invalidateView");
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }
        */
    }
}
