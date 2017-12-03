/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import net.wg.data.constants.*;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.*;
    import net.wg.infrastructure.interfaces.*;

    public dynamic class UI_RankedPlayersPanelListItemRight extends RankedPlayersPanelListItemRightUI
    {
        private var proxy:RankedPlayersPanelListItemProxy;

        public function UI_RankedPlayersPanelListItemRight()
        {
            super();
            proxy = new RankedPlayersPanelListItemProxy(this, false);
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
            if (!proxy.xvm_enabled)
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
            if (!proxy.xvm_enabled)
            {
                super.setPlayerNameFullWidth(param1);
            }
            else
            {
                // set static value to send only one event
                super.setPlayerNameFullWidth(0);
                proxy.invalidate(RankedPlayersPanelListItemProxy.INVALIDATE_PANEL_STATE);
                proxy.validateNow();
            }
        }

        override public function setVehicleName(param1:String):void
        {
            if (!proxy.xvm_enabled)
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
            if (!proxy.xvm_enabled)
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
            if (xfw_state != param1)
            {
                super.setState(param1);
                proxy.invalidate(RankedPlayersPanelListItemProxy.INVALIDATE_PANEL_STATE);
                proxy.validateNow();
            }
        }

        override public function setVehicleIcon(vehicleImage:String):void
        {
            try
            {
                if (!proxy.xvm_enabled)
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
                if (proxy.xvm_enabled)
                {
                    if (isInvalid(PlayersPanelInvalidationType.PLAYER_SCHEME))
                    {
                        proxy.invalidate(RankedPlayersPanelListItemProxy.INVALIDATE_UPDATE_COLORS);
                    }
                    if (isInvalid(InvalidationType.STATE))
                    {
                        proxy.invalidate(RankedPlayersPanelListItemProxy.INVALIDATE_PANEL_STATE);
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
