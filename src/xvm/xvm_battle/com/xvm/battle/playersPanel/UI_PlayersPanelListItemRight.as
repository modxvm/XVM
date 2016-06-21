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

    public dynamic class UI_PlayersPanelListItemRight extends PlayersPanelListItemRightUI
    {
        private var proxy:PlayersPanelListItemProxy;

        public function UI_PlayersPanelListItemRight()
        {
            super();
            proxy = new PlayersPanelListItemProxy(this, false);
        }

        override protected function configUI():void
        {
            try
            {
                super.configUI();
                proxy.configUI();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override protected function onDispose():void
        {
            try
            {
                proxy.dispose();
                super.onDispose();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override public function setIsSelected(isSelected:Boolean):void
        {
            try
            {
                super.setIsSelected(isSelected);
                proxy.setIsSelected(isSelected);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override public function setPlayerNameProps(userProps:IUserProps):void
        {
            try
            {
                super.setPlayerNameProps(userProps);
                if (proxy.xvm_enabled)
                {
                    proxy.setPlayerNameProps(userProps);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override protected function draw():void
        {
            try
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
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
