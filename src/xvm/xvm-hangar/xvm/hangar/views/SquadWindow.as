/**
 * XVM - squad window
 * @author Pavel Máca
 */
package xvm.hangar.views
{
    import com.xvm.*;
    import net.wg.gui.prebattle.squad.SquadWindow;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.hangar.*;
    import xvm.UI.squadWindow.UI_SquadItemRenderer;

    public class SquadWindow extends XvmModBase
    {
        public function SquadWindow(view:IView)
        {
            super(view);
        }

        public function get page():net.wg.gui.prebattle.squad.SquadWindow
        {
            return super.view as net.wg.gui.prebattle.squad.SquadWindow;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            try
            {
                page.memberList.itemRenderer = UI_SquadItemRenderer;
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }
    }

}
