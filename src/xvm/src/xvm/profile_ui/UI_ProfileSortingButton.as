/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile_ui
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.veh.*;
    import com.xvm.utils.*;
    import flash.text.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;

    public dynamic class UI_ProfileSortingButton extends ProfileSortingButton_UI
    {
        public function UI_ProfileSortingButton()
        {
            //Logger.add("UI_ProfileSortingButton");
            super();
        }

        override protected function showTooltip():void
        {
            if (tooltip == "xvm_xte")
            {
                App.toolTipMgr.show(Locale.get("profile/xvm_xte_tooltip"));
            }
            else
            {
                super.showTooltip();
            }
        }
    }
}
