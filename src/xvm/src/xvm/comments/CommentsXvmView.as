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
    import net.wg.gui.messenger.windows.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.interfaces.*;
    import xvm.comments.UI.*;

    public class CommentsXvmView extends XvmViewBase
    {
        private var lastCommand:String = null;

        public function CommentsXvmView(view:IView)
        {
            super(view);
            CommentsGlobalData.instance.clearData();
        }

        public function get page():ContactsWindow
        {
            return super.view as ContactsWindow;
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);

            if (!Config.config.rating.showPlayersStatistics)
                return;

            var cfg:CComments = Config.config.hangar.comments;
            if (!cfg.enabled)
                return;

            // TODO: async
            //App.waiting.show("Loading...");
            lastCommand = Cmd.COMMAND_GETCOMMENTS;
            Cmd.getComments(this, onGetCommentsReceived);
            initTabs();
            CommentsGlobalData.instance.addEventListener(Event.CHANGE, onCommentsDataChange);
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            //Logger.add("onBeforeDispose: " + view.as_alias);
            App.utils.scheduler.cancelTask(initTabs);
            CommentsGlobalData.instance.removeEventListener(Event.CHANGE, onCommentsDataChange);
        }

        // PRIVATE

        private function onGetCommentsReceived(json_str:String):void
        {
            //Logger.add("onGetCommentsReceived: " + json_str);
            try
            {
                //App.waiting.hide("");

                var data:Object = {}
                try
                {
                    data = JSONx.parse(json_str);
                    if (data == null)
                        data = {}
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
                    if (lastCommand == Cmd.COMMAND_GETCOMMENTS)
                    {
                        err = Defines.SYSTEM_MESSAGE_HEADER.replace("%VALUE%", "<b>" + Locale.get("Error loading comments") + "</b>\n\n" + err);
                        Xvm.cmd(Xvm.XPM_COMMAND_SYSMESSAGE, err, "Warning");
                    }
                    else
                    {
                        Xvm.cmd(Xvm.XPM_COMMAND_MESSAGEBOX, Locale.get("Error saving comments"), err);
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

        private function initTabs():void
        {
            //Logger.add("initTabs");

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
            }
        }

        private function onCommentsDataChange(e:Event):void
        {
            //App.waiting.show("Saving...");
            lastCommand = Cmd.COMMAND_SETCOMMENTS;
            Cmd.setComments(this, onGetCommentsReceived, CommentsGlobalData.instance.toJson());
        }
    }
}
