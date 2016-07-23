/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.fullStats
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.text.*;
    import net.wg.gui.battle.components.*;
    import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.*;
    import net.wg.gui.battle.views.stats.*;

    public class StatsTableItemXvm extends StatsTableItem
    {
        public function StatsTableItemXvm(playerNameTF:TextField, vehicleNameTF:TextField, fragsTF:TextField, deadBg:BattleAtlasSprite,
            vehicleType:BattleAtlasSprite, icoIGR:BattleAtlasSprite, vehicleIcon:BattleAtlasSprite, vehicleLevel:BattleAtlasSprite,
            mute:BattleAtlasSprite, speakAnimation:SpeakAnimation, vehicleAction:BattleAtlasSprite, playerStatus:PlayerStatusView)
        {
            //Logger.add("StatsTableItemXvm");
            super(playerNameTF, vehicleNameTF, fragsTF, deadBg, vehicleType, icoIGR, vehicleIcon, vehicleLevel, mute, speakAnimation, vehicleAction, playerStatus);
        }
    }
}
