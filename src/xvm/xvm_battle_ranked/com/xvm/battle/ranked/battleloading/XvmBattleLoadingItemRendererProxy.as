/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.ranked.battleloading
{
    import com.xvm.battle.shared.battleloading.XvmBattleLoadingItemRendererProxyBase;

    public class XvmBattleLoadingItemRendererProxy extends XvmBattleLoadingItemRendererProxyBase
    {
        private var _ui:IXvmBattleLoadingItemRenderer;

        public function XvmBattleLoadingItemRendererProxy(ui:IXvmBattleLoadingItemRenderer, uiType:String, isLeftPanel:Boolean)
        {
            _ui = ui;
            super(ui, uiType, isLeftPanel);
        }

        // OVERRIDES

        override protected function setup():void
        {
            if (cfg.removeSquadIcon)
            {
                _ui.rankIcon.alpha = 0;
            }
        }

        override protected function alignTextFields():void
        {
            if (isLeftPanel)
            {
                _ui.rankIcon.x = _ui.DEFAULTS.RANKICON_X + cfg.squadIconOffsetXLeft;
            }
            else
            {
                _ui.rankIcon.x = _ui.DEFAULTS.RANKICON_X - cfg.squadIconOffsetXRight;
            }
        }
    }
}
