/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.ranked.battleloading
{
	import com.xfw.XfwUtils;
    import com.xvm.battle.shared.battleloading.XvmBattleLoadingItemRendererProxyBase;
    import net.wg.gui.battle.battleloading.renderers.BasePlayerItemRenderer;
    import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import net.wg.gui.battle.ranked.battleloading.renderers.RankedPlayerItemRenderer;

    public class XvmRankedBattleLoadingItemRendererProxy extends XvmBattleLoadingItemRendererProxyBase implements IXvmRankedBattleLoadingItemRenderer
    {
        private var _rankIcon:BattleAtlasSprite;

        public function XvmRankedBattleLoadingItemRendererProxy(ui:BasePlayerItemRenderer, uiType:String,
            container:BaseRendererContainer, position:int, isEnemy:Boolean, selfBg:BattleAtlasSprite, invalidateFunc:Function)
        {
            _rankIcon = XfwUtils.getPrivateField(ui as RankedPlayerItemRenderer, 'xfw_rankIcon');
            super(ui, uiType, container, position, isEnemy, selfBg, invalidateFunc);
        }

        // OVERRIDES

        override public function onDispose():void
        {
            super.onDispose();
            _rankIcon = null;
        }

        override protected function setup():void
        {
            if (cfg.removeSquadIcon)
            {
                _rankIcon.alpha = 0;
            }
        }

        override protected function alignTextFields():void
        {
            if (isLeftPanel)
            {
                _rankIcon.x = DEFAULTS.RANKICON_X + cfg.squadIconOffsetXLeft;
            }
            else
            {
                _rankIcon.x = DEFAULTS.RANKICON_X - cfg.squadIconOffsetXRight;
            }
        }

        // IXvmRankedBattleLoadingItemRenderer

        public function get rankIcon():BattleAtlasSprite
        {
            return _rankIcon;
        }
    }
}
