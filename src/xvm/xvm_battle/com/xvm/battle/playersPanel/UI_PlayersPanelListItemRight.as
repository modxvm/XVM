/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class UI_PlayersPanelListItemRight extends PlayersPanelListItemRightUI
    {
        private var proxy:XvmPlayersPanelListItem;

        public function UI_PlayersPanelListItemRight()
        {
            super();
            proxy = new XvmPlayersPanelListItem(this);
        }

        override protected function configUI():void
        {
            super.configUI();
            proxy.configUI();
        }
    }
}
