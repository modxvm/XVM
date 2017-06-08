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
            addChildAt(proxy, getChildIndex(vehicleTF) - 1);
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

        override public function setPlayerNameFullWidth(param1:Number):void
        {
            if (!proxy.isXVMEnabled)
            {
                super.setPlayerNameFullWidth(param1);
            }
            else
            {
                // set static value to send only one event
                super.setPlayerNameFullWidth(0);
                proxy.invalidate(PlayersPanelListItemProxy.INVALIDATE_PANEL_STATE);
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

        // TODO:9.15 remove after fix
        override public function setIsInteractive(isInteractive:Boolean):void
        {
            super.setIsInteractive(isInteractive);
            if (proxy.isXVMEnabled)
            {
                proxy.setIsInteractive(isInteractive);
            }
        }

        override public function setState(param1:int):void
        {
            if (xfw_state != param1)
            {
                super.setState(param1);
                proxy.invalidate(PlayersPanelListItemProxy.INVALIDATE_PANEL_STATE);
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
                        proxy.invalidate(PlayersPanelListItemProxy.INVALIDATE_UPDATE_COLORS);
                    }
                    if (isInvalid(InvalidationType.STATE))
                    {
                        proxy.invalidate(PlayersPanelListItemProxy.INVALIDATE_PANEL_STATE);
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
