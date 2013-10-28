/**
 * XVM - squad window
 * @author Pavel Máca
 */
package xvm.squad
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import net.wg.gui.prebattle.squad.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class SquadXvmView extends XvmViewBase
    {
        public function SquadXvmView(view:IView)
        {
            super(view);
        }

        public function get page():SquadWindow
        {
            return super.view as SquadWindow;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            page.memberList.itemRenderer = UI_SquadItemRenderer;
        }
    }

}
