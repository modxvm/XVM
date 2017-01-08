/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.fullStats
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.containers.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.managers.impl.*;

    public dynamic class UI_FullStats extends FullStatsUI
    {
        public static var leftAtlas:String = AtlasConstants.BATTLE_ATLAS;
        public static var rightAtlas:String = AtlasConstants.BATTLE_ATLAS;

        private var cfg:CStatisticForm;

        private var _winChance:WinChances = null;

        public function UI_FullStats()
        {
            //Logger.add("UI_fullStats");
            super();

            this.xfw_tableCtrl = new FullStatsTableCtrlXvm(this.statsTable, this);

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
        }

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

        // PRIVATE

        private function setup(e:Event = null):Object
        {
            //Xvm.swfProfilerBegin("UI_FullStats.setup()");
            try
            {
                deleteComponents();

                cfg = Config.config.statisticForm;

                registerVehicleIconAtlases();

                // Components
                if ((Config.networkServicesSettings.statBattle && (Config.networkServicesSettings.chance || Config.networkServicesSettings.chanceLive)) || cfg.showBattleTier)
                {
                    _winChance = new WinChances(this); // Winning chance info above players list. // TODO: replace with ExtraField
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            //Xvm.swfProfilerEnd("UI_FullStats.setup()");
            return null;
        }

        private function deleteComponents():void
        {
            if (_winChance != null)
            {
                _winChance.dispose();
                _winChance = null;
            }
        }

        private function registerVehicleIconAtlases():void
        {
            leftAtlas = registerVehicleIconAtlas(leftAtlas, Config.config.iconset.fullStatsLeftAtlas);
            rightAtlas = registerVehicleIconAtlas(rightAtlas, Config.config.iconset.fullStatsRightAtlas);
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
