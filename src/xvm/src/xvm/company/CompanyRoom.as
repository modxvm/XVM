/**
 * XVM - company window
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.company
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.gui.prebattle.company.*;

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
                Logger.err(ex);
            }
        }

        // PRIVATE

        private function init():void
        {
            Logger.add("init: " + view.as_getPyAlias());

            if (Config.networkServicesSettings.statCompany != true)
                return;

            view.assignedList.itemRendererName = "xvm.company_ui::UI_TeamMemberRenderer";
            view.unassignedList.itemRendererName = "xvm.company_ui::UI_TeamMemberRenderer";
        }
    }
}
