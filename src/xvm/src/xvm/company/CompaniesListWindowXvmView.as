/**
 * XVM - companies list window
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.company
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.l10n.Locale;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.events.*;
    import net.wg.gui.prebattle.company.*;
    //import scaleform.clik.controls.CheckBox; // conflict with .*
    import xvm.company.UI.*;

    public class CompaniesListWindowXvmView extends XvmViewBase
    {
        private var updateCheckBox:CheckBox;

        public function CompaniesListWindowXvmView(view:IView)
        {
            super(view);
        }

        public function get page():CompaniesListWindow
        {
            return super.view as CompaniesListWindow;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);

            if (Config.config.rating.showPlayersStatistics != true)
                return;
            if (Config.config.rating.enableCompanyStatistics != true)
                return;

            page.cmpList.itemRenderer = UI_CompanyListItemRenderer;

            updateCheckBox = App.utils.classFactory.getComponent("CheckBox", CheckBox);
            updateCheckBox.name = "updateStatCheckBox";
            updateCheckBox.autoSize = "left";
            updateCheckBox.label = Locale.get("Load statistics");
            updateCheckBox.x = page.createButton.x + page.createButton.width + 5;
            updateCheckBox.y = 7;
            page.addChild(updateCheckBox);
            App.utils.scheduler.scheduleTask(function():void
            {
                var dx:Number = updateCheckBox.x + updateCheckBox.width - page.filterTextField.x;
                if (dx > 0)
                {
                    page.filterTextField.x += dx;
                    page.filterTextField.width += 50 - dx;

                    page.filterButton.x += 50;
                    page.filterButton.y += 1;

                    page.refreshButton.x += 50;
                    page.refreshButton.y += 1;

                    page.filterInBattleCheckbox.x += 50;
                    page.filterInBattleCheckbox.width -= 50;

                    page.division.x += 30;
                    page.division.width -= 30;
                }
            }, 100);
        }
    }
}
