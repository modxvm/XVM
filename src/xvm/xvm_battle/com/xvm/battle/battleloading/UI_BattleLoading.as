/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.battleloading
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xfw.events.*;
    import com.xvm.battle.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.containers.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.managers.impl.*;

    public dynamic class UI_BattleLoading extends BattleLoadingUI
    {
        public static var leftAtlas:String = AtlasConstants.BATTLE_ATLAS;
        public static var rightAtlas:String = AtlasConstants.BATTLE_ATLAS;

        private var cfg:CStatisticForm;

        //private var _winChance:WinChances = null;

        public function UI_BattleLoading()
        {
            //Logger.add("UI_BattleLoading");
            super();

            //this.xfw_tableCtrl = new BattleLoadingTableCtrlXvm(this.statsTable, this);

            //Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
        }

        /*
        override protected function configUI():void
        {
            super.configUI();
            setup();
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            deleteComponents();
            super.onDispose();
        }
*/
        override public function setCompVisible(value:Boolean):void
        {
            Xvm.dispatchEvent(new BooleanEvent(BattleEvents.BATTLE_LOADING_VISIBLE, value));
            super.setCompVisible(value);
        }

        // PRIVATE

        private function setup(e:Event = null):Object
        {
            //Xvm.swfProfilerBegin("UI_BattleLoading.setup()");
            try
            {
                deleteComponents();

                cfg = Config.config.statisticForm;

                registerVehicleIconAtlases();

                // Components
                if ((Config.networkServicesSettings.statBattle && (Config.networkServicesSettings.chance || Config.networkServicesSettings.chanceLive)) || cfg.showBattleTier)
                {
                    //_winChance = new WinChances(this); // Winning chance info above players list. // TODO: replace with ExtraField
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            //Xvm.swfProfilerEnd("UI_BattleLoading.setup()");
            return null;
        }

        private function deleteComponents():void
        {
            /*if (_winChance != null)
            {
                _winChance.dispose();
                _winChance = null;
            }*/
        }

        private function registerVehicleIconAtlases():void
        {
            leftAtlas = registerVehicleIconAtlas(leftAtlas, Config.config.iconset.battleLoadingLeftAtlas);
            rightAtlas = registerVehicleIconAtlas(rightAtlas, Config.config.iconset.battleLoadingRightAtlas);
        }

        private function registerVehicleIconAtlas(currentAtlas:String, cfgAtlas:String):String
        {
            var newAtlas:String = Macros.FormatStringGlobal(cfgAtlas);
            if (currentAtlas != newAtlas)
            {
                var atlas:Atlas = (App.atlasMgr as AtlasManager).xfw_getAtlas(newAtlas) as Atlas;
                if (atlas == null)
                {
                    App.atlasMgr.registerAtlas(newAtlas);
                    atlas = (App.atlasMgr as AtlasManager).xfw_getAtlas(newAtlas) as Atlas;
                    atlas.addEventListener(AtlasEvent.ATLAS_INITIALIZED, onAtlasInitializedHandler, false, 0, true);
                }
            }
            return newAtlas;
        }

        private function onAtlasInitializedHandler(e:AtlasEvent):void
        {
            e.currentTarget.removeEventListener(AtlasEvent.ATLAS_INITIALIZED, onAtlasInitializedHandler);
            Xvm.dispatchEvent(new Event(Defines.XVM_EVENT_ATLAS_LOADED));
        }
    }
}
