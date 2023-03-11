/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.ranked.fullStats
{
    import com.xfw.*;
    import com.xfw.XfwAccess;
    import com.xvm.infrastructure.*;
    import flash.display.*;
    import net.wg.gui.battle.interfaces.*;
    import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressViewUpdatable;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.ranked.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
    import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;

    public class RankedFullStatsXvmView extends XvmViewBase
    {
        public function RankedFullStatsXvmView(view:IView)
        {
            super(view);
        }

        public function get page():RankedBattlePage
        {
            return super.view as RankedBattlePage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            super.onAfterPopulate(e);
            init();
        }

        // PRIVATE

        private function init():void
        {
            var fullStats:DisplayObject = page.fullStats as DisplayObject;
            var idx:int = page.getChildIndex(fullStats);

            var bsdController:BattleStatisticDataController = XfwAccess.getPrivateField(page, 'xfw_battleStatisticDataController');
            var qpw:Vector.<IQuestProgressViewUpdatable> = XfwAccess.getPrivateField(bsdController, 'xfw_questProgressViews');
            var cController:Vector.<IBattleComponentDataController> = XfwAccess.getPrivateField(bsdController, 'xfw_componentControllers');

            var qidx:int = qpw.indexOf((fullStats as IFullStats).getStatsProgressView());
            page.unregisterComponent(BATTLE_VIEW_ALIASES.FULL_STATS);
            cController.splice(cController.indexOf(page.fullStats), 1);
            page.removeChild(fullStats);
            var component:UI_RankedFullStats = new UI_RankedFullStats();
            component.x = fullStats.x;
            component.y = fullStats.y;
            component.visible = fullStats.visible;
            if (qidx >= 0)
            {
                qpw[qidx] = component.getStatsProgressView();
            }
            page.fullStats = component;
            page.addChildAt(component, idx);
            bsdController.registerComponentController(page.fullStats);
            XfwAccess.getPrivateField(page, 'xfw_registerComponent')(page.fullStats, BATTLE_VIEW_ALIASES.FULL_STATS);
        }
    }
}
