/**
 * XVM - company window
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.company
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.events.*;
    import net.wg.gui.prebattle.company.*;
    import xvm.company.UI.*;

    public class CompanyWindowXvmView extends XvmViewBase
    {
        public function CompanyWindowXvmView(view:IView)
        {
            super(view);
        }

        public function get page():CompanyWindow
        {
            return super.view as CompanyWindow;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);

            if (Config.config.rating.showPlayersStatistics != true)
                return;
            if (Config.config.rating.enableCompanyStatistics != true)
                return;

            page.assignedList.itemRenderer = UI_TeamMemberRenderer;
            page.unassignedList.itemRenderer = UI_TeamMemberRenderer;
        }
    }
}
