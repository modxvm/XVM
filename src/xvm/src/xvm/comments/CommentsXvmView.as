/**
 * XVM - comments
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.comments
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.io.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.events.*;
    import net.wg.gui.messenger.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.interfaces.*;
    import xvm.comments.UI.*;

    public class CommentsXvmView extends XvmViewBase
    {
        private static const XPM_COMMAND_GET_COMMENTS:String = "xpm.get_comments";
        private static const XPM_COMMAND_SET_COMMENTS:String = "xpm.set_comments";

        public function CommentsXvmView(view:IView)
        {
            super(view);
            CommentsGlobalData.instance.clearData();
        }

        public function get page():ContactsListPopover
        {
            return super.view as ContactsListPopover;
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);

            if (Config.networkServicesSettings.comments != true)
                return;

            // TODO: async
            try
            {
                //App.waiting.show("Loading...");
                init();
                updateComments(Xvm.cmd(XPM_COMMAND_GET_COMMENTS), true);
                CommentsGlobalData.instance.addEventListener(Event.CHANGE, onCommentsDataChange);
            }
            finally
            {
                //App.waiting.hide("");
            }
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            //Logger.add("onBeforeDispose: " + view.as_alias);
            CommentsGlobalData.instance.removeEventListener(Event.CHANGE, onCommentsDataChange);
        }

        // PRIVATE

        private function init():void
        {
            Logger.add("init");

            Logger.addObject(page.treeComponent.list);
            page.treeComponent.list.itemRenderer = UI_ContactsTreeItemRenderer;

            /*

            var dp:IDataProvider = page.tabs.dataProvider;
            if (dp == null || dp.length == 0)
            {
                App.utils.scheduler.envokeInNextFrame(initTabs);
            }
            else
            {
                dp[0]["linkage"] = getQualifiedClassName(UI_ContactsListForm);
                page.tabs.selectedIndex = -1;
                page.tabs.selectedIndex = 0;
                page.validateNow();
            }*/
        }

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

        private function onCommentsDataChange(e:Event):void
        {
            try
            {
                //App.waiting.show("Saving...");
                updateComments(Xvm.cmd(XPM_COMMAND_SET_COMMENTS, CommentsGlobalData.instance.toJson()), false);
            }
            finally
            {
                //App.waiting.hide("");
            }
        }
    }
}
