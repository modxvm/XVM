/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.profile
{
    import com.xfw.*;
    import com.xvm.*;

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
