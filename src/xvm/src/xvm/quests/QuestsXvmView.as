/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.quests
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import flash.utils.*;
    import net.wg.gui.lobby.questsWindow.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class QuestsXvmView extends XvmViewBase
    {
        private static const UI_LINKAGE:String = getQualifiedClassName(UI_QuestsTileChainsView);

        public function QuestsXvmView(view:IView)
        {
            super(view);
        }

        public function get page():QuestsWindow
        {
            return super.view as QuestsWindow;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.addObject(page);
        }
    }
}
