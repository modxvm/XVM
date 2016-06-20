/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class UI_PlayersPanelListItemLeft extends PlayersPanelListItemLeftUI
    {
        private var proxy:PlayersPanelListItemProxy;

        public function UI_PlayersPanelListItemLeft()
        {
            super();
            proxy = new PlayersPanelListItemProxy(this);
        }

        override protected function configUI():void
        {
            super.configUI();
            proxy.configUI();
        }
    }
}
