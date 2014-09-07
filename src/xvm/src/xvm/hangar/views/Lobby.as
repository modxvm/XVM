/**
 * XVM - lobby
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.hangar.views
{
    import com.xvm.*;
    import com.xvm.io.*;
    import com.xvm.infrastructure.*;
    import net.wg.data.*;
    import net.wg.gui.lobby.*;
    import net.wg.gui.notification.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class Lobby extends XvmViewBase
    {
        public function Lobby(view:IView)
        {
            super(view);
        }

        public function get page():LobbyPage
        {
            return super.view as LobbyPage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);
            initStatToken();
            hideTutorial();

            //Cmd.runTest("battleResults", "11390684172629596");
            //Cmd.runTest("battleResults", "9734308549388187");
        }

        public override function onBeforeDispose(e:LifeCycleEvent):void
        {
            //Logger.add("onBeforeDispose: " + view.as_alias);
        }

        // PRIVATE

        // xvm stat token

        private function initStatToken():void
        {
            if (Config.config.rating.showPlayersStatistics == true)
                Cmd.getXvmStatTokenData(this, getXvmStatTokenDataCallback);
        }

        private function getXvmStatTokenDataCallback(json_str:String):void
        {
            //Logger.add(json_str);
        }

        // hide tutorial

        private function hideTutorial():void
        {
            // TODO:0.9.3 if (Config.config.hangar.hideTutorial == true)
            // TODO:0.9.3     page.header.tutorialControl.y = -10000;
        }
    }

}
