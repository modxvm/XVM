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

            var cfg:CComments = Config.config.hangar.comments;
            if (!cfg.enabled)
                return;

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
            //Logger.add("onGetCommentsReceived");
            try
            {
                var data:Object = {}
                try
                {
                    data = JSONx.parse(json_str);
                }
                catch (ex:Error)
                {
                    Logger.add(ex.getStackTrace());
                }
                if (data.error != null)
                {
                    Logger.add("[XVM:COMMENTS] WARNING: [" + data.error + "] " + (data.errStr || ""));
                }
                else
                {
                    CommentsGlobalData.instance.setData(data.comments);
                }
                page.invalidateData();
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
            Cmd.setComments(this, onGetCommentsReceived, CommentsGlobalData.instance.toJson());
        }
    }
}
