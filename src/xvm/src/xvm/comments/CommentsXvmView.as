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
    import flash.utils.*;
    import net.wg.gui.messenger.windows.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.interfaces.*;
    import xvm.comments.UI.*;

    public class CommentsXvmView extends XvmViewBase
    {
        public static var comments:Object;

        public function CommentsXvmView(view:IView)
        {
            super(view);
            comments = null;
        }

        public function get page():ContactsWindow
        {
            return super.view as ContactsWindow;
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);
            createComments();
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            //Logger.add("onBeforeDispose: " + view.as_alias);
            removeComments();
        }

        // PRIVATE

        private function createComments():void
        {
            var cfg:CComments = Config.config.hangar.comments;
            if (!cfg.enabled)
                return;

            try
            {
                initTabs();

                Cmd.getComments(this, onGetCommentsReceived);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function removeComments():void
        {
            App.utils.scheduler.cancelTask(initTabs);
        }

        private function initTabs():void
        {
            var dp:IDataProvider = page.tabs.dataProvider;
            if (dp == null || dp.length == 0)
            {
                App.utils.scheduler.envokeInNextFrame(initTabs);
                return;
            }

            dp[0]["linkage"] = getQualifiedClassName(UI_ContactsListForm);
            page.tabs.selectedIndex = -1;
            page.tabs.selectedIndex = 0;
            page.validateNow();
        }

        private function onGetCommentsReceived(json_str:String):void
        {
            try
            {
                var data:Object = JSONx.parse(json_str);
                if (data.comments != null)
                    comments = data.comments;
                page.invalidateData();
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }
    }
}
