/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.winback.battleloading
{
    import com.xvm.battle.shared.battleloading.IXvmBattleLoadingItemRendererBase;
    import net.wg.gui.battle.components.BattleAtlasSprite;

    public interface IXvmWinbackBattleLoadingItemRenderer extends IXvmBattleLoadingItemRendererBase
    {
        function get squad():BattleAtlasSprite;
    }
}
