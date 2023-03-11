/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.classic.battleloading
{
    import com.xvm.battle.shared.battleloading.IXvmBattleLoadingItemRendererBase;
    import net.wg.gui.battle.components.BattleAtlasSprite;

    public interface IXvmRandomBattleLoadingItemRenderer extends IXvmBattleLoadingItemRendererBase
    {
        function get squad():BattleAtlasSprite;
    }
}
