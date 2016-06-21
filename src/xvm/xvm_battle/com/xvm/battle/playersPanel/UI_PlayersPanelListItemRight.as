/**
on/**
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
            addChild(proxy);
        }

        override protected function configUI():void
        {
            try
            {
                super.configUI();
                proxy.onProxyConfigUI();
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
                proxy.onProxyDispose();
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
                proxy.setPlayerNameProps(userProps);
                if (proxy.xvm_enabled)
                {
                    proxy.invalidate(PlayersPanelListItemProxy.INVALIDATE_USER_PROPS);
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
                        proxy.invalidate(PlayersPanelListItemProxy.INVALIDATE_VEHICLE_NAME);
                    }
                    if (isInvalid(PlayersPanelInvalidationType.FRAGS))
                    {
                        proxy.invalidate(PlayersPanelListItemProxy.INVALIDATE_FRAGS);
                    }
                    if (isInvalid(PlayersPanelInvalidationType.SELECTED))
                    {
                        proxy.invalidate(PlayersPanelListItemProxy.INVALIDATE_SELECTED);
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
