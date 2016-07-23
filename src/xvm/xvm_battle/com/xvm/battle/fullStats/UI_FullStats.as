/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.fullStats
{
    public dynamic class UI_FullStats extends FullStatsUI
    {
        public function UI_FullStats()
        {
            //Logger.add("UI_fullStats");
            super();
            this.xfw_tableCtrl = new FullStatsTableCtrlXvm(this.statsTable, this);
        }
    }
}
