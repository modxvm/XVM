/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.classic.battleloading
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.shared.battleloading.Clock;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.battleloading.*;
    import net.wg.gui.battle.battleloading.renderers.*;
    import net.wg.gui.battle.battleloading.vo.*;
    import net.wg.gui.components.containers.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.managers.impl.*;

    public class UI_BattleLoading extends BattleLoadingUI
    {
        static private var _leftAtlas:String = ATLAS_CONSTANTS.BATTLE_ATLAS;
        static private var _rightAtlas:String = ATLAS_CONSTANTS.BATTLE_ATLAS;

        private var cfg:CBattleLoading;

        private var _clock:Clock = null;

        private var defaultVehicleFieldXPosition:Number = NaN;
        private var defaultVehicleFieldWidth:Number = NaN;

        private var battleLoadingForm:BattleLoadingForm = null;
        private var isTipsForm:Boolean = false;

        static public function get leftAtlas():String
        {
            return _leftAtlas;
        }

        static public function get rightAtlas():String
        {
            return _rightAtlas;
        }

        public function UI_BattleLoading()
        {
            //Logger.add("UI_BattleLoading");
            super();

            //Logger.addObject(form);

            battleLoadingForm = form as BattleLoadingForm;
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

        override protected function setVisualTipInfo(data:VisualTipInfoVO):void
        {
            //Logger.addObject(param1);
            super.setVisualTipInfo(data);
            isTipsForm = data.showTipsBackground;
            setup();
            initRenderers();
        }

        override public function setCompVisible(value:Boolean):void
        {
            //value = true; // DEBUG
            BattleGlobalData.battleLoadingVisible = value;
            super.setCompVisible(value);
        }

        override public function set visible(value:Boolean):void
        {
            super.visible = value && BattleGlobalData.battleLoadingVisible;
        }

        // PRIVATE

        private function setup(e:Event = null):void
        {
            //Xvm.swfProfilerBegin("UI_BattleLoading.setup()");
            try
            {
                cfg = isTipsForm ? Config.config.battleLoadingTips : Config.config.battleLoading;

                deleteComponents();

                registerVehicleIconAtlases();

                // Components
                _clock = new Clock(battleLoadingForm); // Realworld time at right side of TipField.
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            //Xvm.swfProfilerEnd("UI_BattleLoading.setup()");
        }

        private function deleteComponents():void
        {
            if (_clock != null)
            {
                _clock.dispose();
                _clock = null;
            }
        }

        private function registerVehicleIconAtlases():void
        {
            _leftAtlas = registerVehicleIconAtlas(_leftAtlas, Config.config.iconset.battleLoadingLeftAtlas);
            _rightAtlas = registerVehicleIconAtlas(_rightAtlas, Config.config.iconset.battleLoadingRightAtlas);
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

        private function initRenderers():void
        {
            var renderer:BasePlayerItemRenderer;
            for each(renderer in battleLoadingForm.xfw_allyRenderers)
            {
                renderer.dispose();
            }
            battleLoadingForm.xfw_allyRenderers.splice(0, battleLoadingForm.xfw_allyRenderers.length);

            for each(renderer in battleLoadingForm.xfw_enemyRenderers)
            {
                renderer.dispose();
            }
            battleLoadingForm.xfw_enemyRenderers.splice(0, battleLoadingForm.xfw_enemyRenderers.length);

            var cls:Class = isTipsForm ? XvmTipPlayerItemRenderer : XvmTablePlayerItemRenderer;
            for (var i:int = 0; i < 15; ++i)
            {
                battleLoadingForm.xfw_allyRenderers.push(new cls(battleLoadingForm.xfw_renderersContainer, i, false));
                battleLoadingForm.xfw_enemyRenderers.push(new cls(battleLoadingForm.xfw_renderersContainer, i, true));
            }
        }
    }
}
