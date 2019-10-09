/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.ranked.battleloading
{
    import com.xvm.battle.shared.battleloading.IXvmBattleLoadingItemRendererBase;
    import net.wg.gui.battle.components.BattleAtlasSprite;

    public interface IXvmRankedBattleLoadingItemRenderer extends IXvmBattleLoadingItemRendererBase
    {
        function get rankIcon():BattleAtlasSprite;
    }
}
