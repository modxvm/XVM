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

        override protected function onDispose():void
        {
            try
            {
                proxy.dispose();
                proxy = null;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            super.onDispose();
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

        override public function setVehicleIcon(vehicleImage:String):void
        {
            try
            {
                //super.setVehicleIcon(vehicleImage);
                proxy.setVehicleIcon(vehicleImage);
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
                    if (isInvalid(PlayersPanelInvalidationType.PLAYER_SCHEME))
                    {
                        proxy.invalidate(PlayersPanelListItemProxy.INVALIDATE_UPDATE_COLORS);
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
