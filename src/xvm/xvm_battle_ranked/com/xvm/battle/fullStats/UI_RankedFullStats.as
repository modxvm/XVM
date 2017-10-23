/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.fullStats
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.components.containers.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.managers.impl.*;

    public /*dynamic*/ class UI_RankedFullStats extends RankedFullStatsUI
    {
        public static var leftAtlas:String = ATLAS_CONSTANTS.BATTLE_ATLAS;
        public static var rightAtlas:String = ATLAS_CONSTANTS.BATTLE_ATLAS;

        private var cfg:CStatisticForm;

        public function UI_RankedFullStats()
        {
            //Logger.add("UI_RankedFullStats");
            super();

            this.xfw_tableCtrl = new FullStatsTableCtrlXvm(this.statsTable);

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
            super.onDispose();
        }

        // PRIVATE

        private function setup(e:Event = null):Object
        {
            //Xvm.swfProfilerBegin("UI_RankedFullStats.setup()");
            try
            {
                cfg = Config.config.statisticForm;

                registerVehicleIconAtlases();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            //Xvm.swfProfilerEnd("UI_RankedFullStats.setup()");
            return null;
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
