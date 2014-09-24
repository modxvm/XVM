/**
 * XVM - company window
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.company
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.rally.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.events.*;
    import net.wg.gui.events.*;
    import net.wg.gui.prebattle.company.*;

    public class CompanyXvmView extends XvmViewBase
    {
        public function CompanyXvmView(view:IView)
        {
            super(view);
        }

        public function get page():CompanyMainWindow
        {
            return super.view as CompanyMainWindow;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);

            if (Config.config.rating.showPlayersStatistics != true)
                return;
            if (Config.config.rating.enableCompanyStatistics != true)
                return;

            page.stack.addEventListener(ViewStackEvent.VIEW_CHANGED, onViewChanged);

            //page.assignedList.itemRenderer = UI_TeamMemberRenderer;
            //page.unassignedList.itemRenderer = UI_TeamMemberRenderer;
        }

        // PRIVATE

        private function onViewChanged(e:ViewStackEvent):void
        {
            switch (e.linkage)
            {
                case PREBATTLE_ALIASES.COMPANY_LIST_VIEW_UI:
                    new CompanyList(e.view);
                    break;
                case PREBATTLE_ALIASES.COMPANY_ROOM_VIEW_UI:
                    new CompanyRoom(e.view);
                    break;
                default:
                    Logger.addObject(e);
                    break;
            }
        }
    }
}
