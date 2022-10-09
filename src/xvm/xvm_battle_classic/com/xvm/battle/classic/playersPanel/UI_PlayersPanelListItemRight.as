/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.classic.playersPanel
{
    import com.xvm.battle.shared.playersPanel.PlayersPanelListItemProxyBase;
    import com.xfw.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.*;
    import net.wg.infrastructure.interfaces.*;

    public class UI_PlayersPanelListItemRight extends PlayersPanelListItemRightUI
    {
        private var proxy:PlayersPanelListItemProxy;

        public function UI_PlayersPanelListItemRight()
        {
            super();
            proxy = new PlayersPanelListItemProxy(this, false);
            addChildAt(proxy, getChildIndex(vehicleIcon) + 1);
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
            if (!proxy.isXVMEnabled)
            {
                super.setPlayerNameProps(userProps);
            }
            else
            {
                proxy.setPlayerNameProps(userProps);
            }
        }

        override public function setPlayerNameFullWidth(param1:uint):void
        {
            if (!proxy.isXVMEnabled)
            {
                super.setPlayerNameFullWidth(param1);
            }
            else
            {
                // set static value to send only one event
                super.setPlayerNameFullWidth(0);
                proxy.invalidate(PlayersPanelListItemProxyBase.INVALIDATE_PANEL_STATE);
                proxy.validateNow();
            }
        }

        override public function setVehicleName(param1:String):void
        {
            if (!proxy.isXVMEnabled)
            {
                super.setVehicleName(param1);
            }
            else
            {
                // set static value to send only one event
                super.setVehicleName("");
            }
        }

        override public function setFrags(param1:int):void
        {
            if (!proxy.isXVMEnabled)
            {
                super.setFrags(param1);
            }
            else
            {
                // set static value to send only one event
                super.setFrags(0);
            }
        }

        override public function setState(param1:uint):void
        {
            if (XfwUtils.getPrivateField(this, "") != param1)
            {
                super.setState(param1);
                proxy.invalidate(PlayersPanelListItemProxyBase.INVALIDATE_PANEL_STATE);
                proxy.validateNow();
            }
        }

        override public function setVehicleIcon(vehicleImage:String):void
        {
            try
            {
                if (!proxy.isXVMEnabled)
                {
                    super.setVehicleIcon(vehicleImage);
                }
                else
                {
                    proxy.setVehicleIcon(vehicleImage);
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
                if (proxy.isXVMEnabled)
                {
                    if (isInvalid(PlayersPanelInvalidationType.PLAYER_SCHEME))
                    {
                        proxy.invalidate(PlayersPanelListItemProxyBase.INVALIDATE_UPDATE_COLORS);
                    }
                    if (isInvalid(InvalidationType.STATE))
                    {
                        proxy.invalidate(PlayersPanelListItemProxyBase.INVALIDATE_PANEL_STATE);
                    }
                    proxy.validateNow();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
