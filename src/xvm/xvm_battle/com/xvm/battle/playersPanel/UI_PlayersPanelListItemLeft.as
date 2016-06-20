/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.data.constants.*;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.*;
    import net.wg.infrastructure.interfaces.*;

    public dynamic class UI_PlayersPanelListItemLeft extends PlayersPanelListItemLeftUI
    {
        private var proxy:PlayersPanelListItemProxy;

        public function UI_PlayersPanelListItemLeft()
        {
            super();
            proxy = new PlayersPanelListItemProxy(this, true);
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

        override public function setIsSelected(isSelected:Boolean):void
        {
            super.setIsSelected(isSelected);
            proxy.setIsSelected(isSelected);
        }

        override public function setPlayerNameProps(userProps:IUserProps):void
        {
            super.setPlayerNameProps(userProps);
            if (proxy.xvm_enabled)
            {
                proxy.setPlayerNameProps(userProps);
            }
        }

        override protected function draw():void
        {
            super.draw();
            if (proxy.xvm_enabled)
            {
                if (isInvalid(PlayersPanelInvalidationType.VEHILCE_NAME))
                {
                    proxy.updateVehicleName();
                }
                if (isInvalid(PlayersPanelInvalidationType.FRAGS))
                {
                    proxy.updateFrags();
                }
                if (isInvalid(PlayersPanelInvalidationType.SELECTED))
                {
                    proxy.onDrawSelected();
                }
                if (isInvalid(InvalidationType.STATE))
                {
                    proxy.applyState();
                }
            }
        }
    }
}
