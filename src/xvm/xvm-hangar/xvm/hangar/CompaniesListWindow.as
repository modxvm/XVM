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
    import com.xvm.l10n.Locale;
    import xvm.UI.companiesWindow.*;
    import xvm.hangar.components.Company.*;

    public class CompaniesListWindow extends XvmModBase
    {
        private var updateCheckBox:CheckBox;

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
return;
                if (Config.config.rating.showPlayersStatistics != true)
                    return;
                if (Config.config.rating.enableCompanyStatistics != true)
                    return;

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
                updateCheckBox = new CheckBox();
                updateCheckBox.autoSize = "left";
                updateCheckBox.label = Locale.get("Load statistics");
                updateCheckBox.x = page.createButton.x + page.createButton.width + 5;
                updateCheckBox.y = 7;
                page.addChild(updateCheckBox);
                App.utils.scheduler.envokeInNextFrame(function():void
                {
                    var dx:Number = updateCheckBox.x + updateCheckBox.width - page.filterTextField.x;
                    if (dx > 0)
                    {
                        page.filterTextField.x += dx;
                        page.filterTextField.width -= dx;
                    }
                });
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }
    }
}
