/**
 * XVM - login page
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.hangar
{
    import flash.events.*;
    import flash.utils.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.events.*;
    import net.wg.gui.prebattle.company.*;
    import com.xvm.*;
    import xvm.UI.companiesWindow.*;

    public class CompaniesListWindow extends XvmModBase
    {
        public function CompaniesListWindow(view:IView)
        {
            super(view);
        }

        public function get page():net.wg.gui.prebattle.company.CompaniesListWindow
        {
            return super.view as net.wg.gui.prebattle.company.CompaniesListWindow;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            try
            {
                //Logger.add("onAfterPopulate: " + view.as_alias);

                page.cmpList.itemRenderer = UI_CompanyListItemRenderer;

                if (page.initialized)
                {
                    initComponents();
                }
                else
                {
                    // TODO: find event
                    setTimeout(initComponents, 1);
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        public override function onBeforeDispose(e:LifeCycleEvent):void
        {
            //Logger.add("onBeforeDispose: " + view.as_alias);
        }

        // PRIVATE

        private function initComponents():void
        {
            try
            {
                // Components
                //new Clock(page);  // Realworld time at right side of TipField.
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }
    }
}
