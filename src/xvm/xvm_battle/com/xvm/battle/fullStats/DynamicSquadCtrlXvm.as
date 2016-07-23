/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.fullStats
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.gui.battle.components.*;
    import net.wg.gui.battle.components.buttons.*;
    import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.*;
    import net.wg.gui.battle.views.stats.*;
    import net.wg.gui.battle.views.stats.constants.*;
    import net.wg.gui.battle.views.stats.fullStats.*;

    public class DynamicSquadCtrlXvm extends DynamicSquadCtrl
    {
        private var cfg:CStatisticForm;

        public function DynamicSquadCtrlXvm(isLeftPanel:Boolean, squadStatus:SquadInviteStatusView, squadIcon:BattleAtlasSprite,
            squadAcceptBt:BattleButton, squadAddBt:BattleButton, hit:Sprite, noSound:BattleAtlasSprite = null)
        {
            //Logger.add("DynamicSquadCtrl");
            super(squadStatus, squadIcon, squadAcceptBt, squadAddBt, hit, noSound);

            cfg = Config.config.statisticForm;

            if (cfg.removeSquadIcon)
            {
                squadIcon.alpha = 0;
            }

            /*
    // X offset for allies squad icons
    // Cмещение по оси X значка взвода союзников
    "squadIconOffsetXLeft": 0,
    // X offset for enemies squad icons field
    // Cмещение по оси X значка взвода противников
    "squadIconOffsetXRight": 0,
    */
        }
    }
}
