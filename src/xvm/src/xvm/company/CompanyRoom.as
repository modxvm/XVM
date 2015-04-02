/**
 * XVM - company window
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.company
{
    import com.xfw.*;
    import net.wg.infrastructure.interfaces.*;
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

            if (Config.networkServicesSettings.statCompany != true)
                return;

            view.assignedList.itemRenderer = UI_TeamMemberRenderer;
            view.unassignedList.itemRenderer = UI_TeamMemberRenderer;
        }
    }
}
