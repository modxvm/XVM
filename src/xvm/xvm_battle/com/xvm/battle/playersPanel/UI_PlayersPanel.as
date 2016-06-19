/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.Linkages;
    import net.wg.infrastructure.interfaces.IDAAPIDataClass;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.events.*;

    public dynamic class UI_PlayersPanel extends PlayersPanelUI
    {
        //private var DEFAULT_CAPTURE_BAR_LINKAGE:String = Linkages.CAPTURE_BAR_LINKAGE;
        //private var XVM_CAPTURE_BAR_LINKAGE:String = getQualifiedClassName(UI_TeamCaptureBar);

        public function UI_PlayersPanel()
        {
            Logger.add("UI_PlayersPanel()");
            super();
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
        }

        override protected function configUI():void
        {
            Logger.add("UI_PlayersPanel.configUI()");
            super.configUI();
            this.panelSwitch.addEventListener(PlayersPanelSwitchEvent.STATE_REQUESTED,this.onSwitchStateRequestedHandler);
            onConfigLoaded(null);
        }
        private function onSwitchStateRequestedHandler(param1:PlayersPanelSwitchEvent) : void
        {
            Logger.add("UI_PlayersPanel.onSwitchStateRequestedHandler()");
            this.requestState(param1.state);
        }

        override public function as_setIsIntaractive(param1:Boolean):void
        {
            Logger.add("UI_PlayersPanel.as_setIsIntaractive(): " + param1);
            super.as_setIsIntaractive(param1);
        }

        override public function as_setPanelMode(param1:int):void
        {
            Logger.add("UI_PlayersPanel.as_setPanelMode(): " + param1);
            super.as_setPanelMode(param1);
        }

        override public function setVehiclesData(param1:IDAAPIDataClass):void
        {
            Logger.add("UI_PlayersPanel.setVehiclesData(): " + param1);
            super.setVehiclesData(param1);
        }

        override public function setArenaInfo(param1:IDAAPIDataClass):void
        {
            Logger.add("UI_PlayersPanel.setVehiclesData(): " + param1);
            super.setArenaInfo(param1);
        }

        // PRIVATE

        private function onConfigLoaded(e:Event):Object
        {
            /*try
            {
                if (Config.config.captureBar.enabled)
                {
                    Linkages.CAPTURE_BAR_LINKAGE = XVM_CAPTURE_BAR_LINKAGE;
                    // hack to hide useless icons
                }
                else
                {
                    Linkages.CAPTURE_BAR_LINKAGE = DEFAULT_CAPTURE_BAR_LINKAGE;
                }
                xfw_updatePositions();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }*/
            return null;
        }
    }
}
