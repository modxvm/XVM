/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.winback.battleloading
{
    import com.xvm.battle.shared.battleloading.XvmBattleLoadingItemRendererProxyBase;
    import net.wg.gui.battle.battleloading.renderers.BasePlayerItemRenderer;
    import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import net.wg.gui.battle.random.battleloading.renderers.RandomRendererContainer;

    public class XvmWinbackBattleLoadingItemRendererProxy extends XvmBattleLoadingItemRendererProxyBase implements IXvmWinbackBattleLoadingItemRenderer
    {
        private var _squad:BattleAtlasSprite;

        public function XvmWinbackBattleLoadingItemRendererProxy(ui:BasePlayerItemRenderer, uiType:String,
            container:BaseRendererContainer, position:int, isEnemy:Boolean, selfBg:BattleAtlasSprite, invalidateFunc:Function)
        {
            var randomContainer:RandomRendererContainer = container as RandomRendererContainer;
            if (isEnemy)
            {
                _squad = randomContainer.squadsEnemy[position];
            }
            else
            {
                _squad = randomContainer.squadsAlly[position];
            }

            super(ui, uiType, container, position, isEnemy, selfBg, invalidateFunc);
        }

        // OVERRIDES

        override public function onDispose():void
        {
            super.onDispose();
            _squad = null;
        }

        override protected function setup():void
        {
            if (cfg.removeSquadIcon)
            {
                _squad.alpha = 0;
            }
        }

        override protected function alignTextFields():void
        {
            if (isLeftPanel)
            {
                _squad.x = DEFAULTS.SQUAD_X + cfg.squadIconOffsetXLeft;
            }
            else
            {
                _squad.x = DEFAULTS.SQUAD_X - cfg.squadIconOffsetXRight;
            }
        }

        // XvmWinbackBattleLoadingItemRendererProxy

        public function get squad():BattleAtlasSprite
        {
            return _squad;
        }
    }
}
