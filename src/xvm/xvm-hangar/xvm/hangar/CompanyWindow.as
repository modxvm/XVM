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

    public class CompanyWindow extends XvmModBase
    {
        public function CompanyWindow(view:IView)
        {
            super(view);
        }

        public function get page():net.wg.gui.prebattle.company.CompanyWindow
        {
            return super.view as net.wg.gui.prebattle.company.CompanyWindow;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            try
            {
                //Logger.add("onAfterPopulate: " + view.as_alias);

                //page.form.team1List.itemRenderer = LeftItemRendererWrapper;

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
