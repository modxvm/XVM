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
    import xvm.hangar.components.Company.*;

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
                // Components
                //new Clock(page);  // Realworld time at right side of TipField.

        //var $this = this;
        //wrapper.onRollOver = function()
        //{
            //if ($this.stat)
                //ToolTipManager.instance.show(TeamRendererHelper.GetToolTipData($this.wrapper.data, $this.stat));
            //else
            //{
                //if ($this.wrapper.toolTip)
                    //ToolTipManager.instance.show($this.wrapper.toolTip);
            //}
        //}

        //if (m_effField == null)
        //{
            //m_effField = Utils.duplicateTextField(wrapper, "eff", wrapper.textField, 0, "left");
            //m_effField._x = wrapper.textField._x + wrapper.textField._width - 20;
        //}
        //m_effField.htmlText = "";


        var updateButton:UpdateCompanyButton = new UpdateCompanyButton();
        page.addChild(updateButton);
        updateButton.x = page.filterTextField.x;
        updateButton.y = page.refreshButton.y;
        var w:Number = page.refreshButton.width;
        updateButton.width = w;
        updateButton.height = page.refreshButton.height;
        updateButton.visible = true;
        page.filterTextField.x += w + 5;
        page.filterTextField.width -= w + 5;
        Logger.add("updateButton");

        //afterSetDataXVM();
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }
    }
}
