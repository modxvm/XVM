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

    public class CompanyRoom
    {
        private var view:CompanyRoomView;

        public function CompanyRoom(view:IViewStackContent)
        {
            try
            {
                this.view = view as CompanyRoomView;
                init();
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        // PRIVATE

        private function init():void
        {
            Logger.add("init: " + view.as_getPyAlias());

            if (Config.config.rating.showPlayersStatistics != true)
                return;
            if (Config.config.rating.enableCompanyStatistics != true)
                return;

            view.assignedList.itemRenderer = UI_TeamMemberRenderer;
            view.unassignedList.itemRenderer = UI_TeamMemberRenderer;
        }
    }
}
