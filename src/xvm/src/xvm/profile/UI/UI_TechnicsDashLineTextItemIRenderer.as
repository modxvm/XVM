/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile.UI
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.data.managers.*;

    public dynamic class UI_TechnicsDashLineTextItemIRenderer extends TechnicsDashLineTextItemIRenderer_UI
    {
        public function UI_TechnicsDashLineTextItemIRenderer()
        {
            //Logger.add("UI_TechnicsDashLineTextItemIRenderer");
        }

        override protected function showToolTip(param1:IToolTipParams):void
        {
            if (tooltip == "profile/xvm_xte_tooltip")
            {
                App.toolTipMgr.show(Locale.get(tooltip));
            }
            else
            {
                super.showToolTip(param1);
            }
        }
    }
}
