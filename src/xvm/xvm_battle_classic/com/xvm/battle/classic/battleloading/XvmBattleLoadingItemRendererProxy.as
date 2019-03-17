/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.classic.battleloading
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
                _ui.squad.alpha = 0;
            }
        }

        override protected function alignTextFields():void
        {
            if (isLeftPanel)
            {
                _ui.squad.x = _ui.DEFAULTS.SQUAD_X + cfg.squadIconOffsetXLeft;
            }
            else
            {
                _ui.squad.x = _ui.DEFAULTS.SQUAD_X - cfg.squadIconOffsetXRight;
            }
        }
    }
}
