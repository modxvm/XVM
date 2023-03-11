/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.stronghold.fullStats
{
    import com.xfw.*;
    import com.xfw.XfwAccess;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.interfaces.*;
    import net.wg.gui.components.containers.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.managers.impl.*;
    import net.wg.gui.battle.random.views.stats.components.fullStats.*;

    public class UI_StrongholdFullStats extends FullStatsUI
    {
        private static var _leftAtlas:String = ATLAS_CONSTANTS.BATTLE_ATLAS;
        private static var _rightAtlas:String = ATLAS_CONSTANTS.BATTLE_ATLAS;

        private var cfg:CStatisticForm;

        public static function get leftAtlas():String
        {
            return _leftAtlas;
        }

        public static function get rightAtlas():String
        {
            return _rightAtlas;
        }

        public function UI_StrongholdFullStats()
        {
            Logger.add("UI_StrongholdFullStats");
            super();
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
        }

        override public function getTableCtrl():ITabbedFullStatsTableController
        {
            return new StrongholdFullStatsTableCtrlXvm(FullStatsTable(statsTable), this);
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
            //Xvm.swfProfilerBegin("UI_StrongholdFullStats.setup()");
            try
            {
                cfg = Config.config.statisticForm;

                registerVehicleIconAtlases();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            //Xvm.swfProfilerEnd("UI_StrongholdFullStats.setup()");
            return null;
        }

        private function registerVehicleIconAtlases():void
        {
            _leftAtlas = registerVehicleIconAtlas(_leftAtlas, Config.config.iconset.fullStatsLeftAtlas);
            _rightAtlas = registerVehicleIconAtlas(_rightAtlas, Config.config.iconset.fullStatsRightAtlas);
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