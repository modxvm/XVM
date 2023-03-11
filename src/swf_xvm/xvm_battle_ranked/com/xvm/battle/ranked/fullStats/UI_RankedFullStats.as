/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.ranked.fullStats
{
    import com.xfw.*;
    import com.xfw.XfwAccess;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.interfaces.*;
    import net.wg.gui.battle.ranked.stats.components.fullStats.*;
    import net.wg.gui.components.containers.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.managers.impl.*;

    public class UI_RankedFullStats extends RankedFullStatsUI
    {
        static private var _leftAtlas:String = ATLAS_CONSTANTS.BATTLE_ATLAS;
        static private var _rightAtlas:String = ATLAS_CONSTANTS.BATTLE_ATLAS;

        private var cfg:CStatisticForm;

        static public function get leftAtlas():String
        {
            return _leftAtlas;
        }

        static public function get rightAtlas():String
        {
            return _rightAtlas;
        }

        public function UI_RankedFullStats()
        {
            //Logger.add("UI_RankedFullStats");
            super();
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
        }

        override public function getTableCtrl():ITabbedFullStatsTableController
        {
            return new FullStatsTableCtrlXvm(FullStatsTable(statsTable));
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
            _leftAtlas = registerVehicleIconAtlas(leftAtlas, Config.config.iconset.fullStatsLeftAtlas);
            _rightAtlas = registerVehicleIconAtlas(rightAtlas, Config.config.iconset.fullStatsRightAtlas);
        }

        private function registerVehicleIconAtlas(currentAtlas:String, cfgAtlas:String):String
        {
            var newAtlas:String = Macros.FormatStringGlobal(cfgAtlas);
            if (currentAtlas != newAtlas)
            {
                var atlasMgr:AtlasManager = App.atlasMgr as AtlasManager;

                var atlas:Atlas = XfwAccess.getPrivateField(atlasMgr, 'xfw_getAtlas')(newAtlas) as Atlas;
                if (atlas == null)
                {
                    atlasMgr.registerAtlas(newAtlas);
                    atlas = XfwAccess.getPrivateField(atlasMgr, 'xfw_getAtlas')(newAtlas) as Atlas;
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
