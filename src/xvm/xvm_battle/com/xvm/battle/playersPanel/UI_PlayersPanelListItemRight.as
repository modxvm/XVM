/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.data.constants.*;

    public dynamic class UI_PlayersPanelListItemRight extends PlayersPanelListItemRightUI
    {
        private var proxy:PlayersPanelListItemProxy;

        public function UI_PlayersPanelListItemRight()
        {
            super();
            proxy = new PlayersPanelListItemProxy(this);
        }

        override protected function configUI():void
        {
            super.configUI();
            proxy.configUI();
        }

        override protected function onDispose():void
        {
            proxy.dispose();
            super.onDispose();
        }

        override protected function draw():void
        {
            super.draw();
            if (isInvalid(InvalidationType.STATE))
            {
                proxy.applyState();
            }
        }
    }
}
