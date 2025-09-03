/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.classic.battleloading
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.BattleGlobalData;
    import com.xvm.battle.shared.battleloading.Clock;
    import com.xvm.battle.shared.battleloading.XvmBattleLoadingItemRendererProxyBase;
    import com.xvm.types.cfg.CBattleLoading;
    import flash.events.Event;
    import net.wg.gui.battle.battleloading.BattleLoadingForm;
    import net.wg.gui.battle.battleloading.renderers.IBattleLoadingRenderer;
    import net.wg.gui.battle.battleloading.renderers.BasePlayerItemRenderer;
    import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
    import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
    import net.wg.gui.components.containers.Atlas;
    import net.wg.infrastructure.events.AtlasEvent;
    import net.wg.infrastructure.managers.impl.AtlasManager;

    public class UI_RandomBattleLoading extends BattleLoadingUI
    {
        private var cfg:CBattleLoading;

        private var _clock:Clock = null;

        private var battleLoadingForm:BattleLoadingForm = null;
        private var isTipsForm:Boolean = false;

        public function UI_RandomBattleLoading()
        {
            //Logger.add("UI_RandomBattleLoading");
            super();

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
            try
            {
                //Logger.addObject(param1);
                super.setVisualTipInfo(data);
                isTipsForm = data.showTipsBackground;
                setup();
                initRenderers();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
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
            //Xvm.swfProfilerBegin("UI_RandomBattleLoading.setup()");
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
            //Xvm.swfProfilerEnd("UI_RandomBattleLoading.setup()");
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
            XvmBattleLoadingItemRendererProxyBase.leftAtlas = registerVehicleIconAtlas(XvmBattleLoadingItemRendererProxyBase.leftAtlas, Config.config.iconset.battleLoadingLeftAtlas);
            XvmBattleLoadingItemRendererProxyBase.rightAtlas = registerVehicleIconAtlas(XvmBattleLoadingItemRendererProxyBase.rightAtlas, Config.config.iconset.battleLoadingRightAtlas);
        }

        private function registerVehicleIconAtlas(currentAtlas:String, cfgAtlas:String):String
        {
            var newAtlas:String = Macros.FormatStringGlobal(cfgAtlas);
            if (currentAtlas != newAtlas)
            {
                var atlasMgr:AtlasManager = App.atlasMgr as AtlasManager;

                var atlas:Atlas = XfwAccess.getPrivateField(atlasMgr, 'getAtlas')(newAtlas) as Atlas;
                if (atlas == null)
                {
                    atlasMgr.registerAtlas(newAtlas);
                    atlas = XfwAccess.getPrivateField(atlasMgr, 'getAtlas')(newAtlas) as Atlas;
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
            var allyRenderers:Vector.<IBattleLoadingRenderer> = XfwAccess.getPrivateField(battleLoadingForm, 'xfw_allyRenderers');
            var enemyRenderers:Vector.<IBattleLoadingRenderer> = XfwAccess.getPrivateField(battleLoadingForm, 'xfw_enemyRenderers');
            var renderersContainer:BaseRendererContainer = XfwAccess.getPrivateField(battleLoadingForm, 'xfw_renderersContainer');


            var renderer:BasePlayerItemRenderer;
            for each(renderer in allyRenderers)
            {
                renderer.dispose();
            }
            allyRenderers.splice(0, allyRenderers.length);

            for each(renderer in enemyRenderers)
            {
                renderer.dispose();
            }
            enemyRenderers.splice(0, enemyRenderers.length);

            var cls:Class = isTipsForm ? XvmRandomTipPlayerItemRenderer : XvmRandomTablePlayerItemRenderer;
            for (var i:int = 0; i < 15; ++i)
            {
                allyRenderers.push(new cls(renderersContainer, i, false));
                enemyRenderers.push(new cls(renderersContainer, i, true));
            }
        }
    }
}
