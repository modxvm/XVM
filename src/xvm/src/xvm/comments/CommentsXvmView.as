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
    import flash.external.*;
    import net.wg.gui.lobby.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class CommentsXvmView extends XvmViewBase
    {
        public function CommentsXvmView(view:IView)
        {
            super(view);
        }

        public function get page():LobbyPage
        {
            return super.view as LobbyPage;
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

        private var comments:CommentsControl = null;

        private function createComments():void
        {
            //var cfg:CComments = Config.config.hangar.comments;
            //if (cfg.enabled)
            {
                comments = page.addChildAt(new CommentsControl(), page.getChildIndex(page.header) + 1) as CommentsControl;
                ExternalInterface.addCallback(Cmd.RESPOND_GETCOMMENTS, onGetCommentsReceived);
                Cmd.getComments();
            }
        }

        private function removeComments():void
        {
            if (comments != null)
            {
                comments.dispose();
                comments = null;
            }
        }

        private function onGetCommentsReceived(json_str:String):void
        {
            Logger.add(json_str);
        }
    }
}
