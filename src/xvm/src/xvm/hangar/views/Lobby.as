/**
 * XVM - lobby
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.hangar.views
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import net.wg.gui.lobby.*;
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
            //Xfw.cmd(XvmCommands.RUN_TEST, "battleResults", "53834549171501.dat");
            //Xfw.cmd(XvmCommands.RUN_TEST, "battleResults", "1894988245539448.dat");
        }
    }

}
