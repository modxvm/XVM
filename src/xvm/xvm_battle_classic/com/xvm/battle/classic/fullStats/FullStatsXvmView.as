/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.classic.fullStats
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import flash.display.*;
    import net.wg.gui.battle.interfaces.*;
    import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressViewUpdatable;
    import net.wg.infrastructure.events.*;
	import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
    import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.*;

    public class FullStatsXvmView extends XvmViewBase
    {
        public function FullStatsXvmView(view:IView)
        {
            super(view);
        }

        public function get page():BattlePage
        {
            return super.view as BattlePage;
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

			var bsdController:BattleStatisticDataController = XfwUtils.getPrivateField(page, 'xfw_battleStatisticDataController');
			var qpw:Vector.<IQuestProgressViewUpdatable> = XfwUtils.getPrivateField(bsdController, 'xfw_questProgressViews');
			var cController:Vector.<IBattleComponentDataController> = XfwUtils.getPrivateField(bsdController, 'xfw_componentControllers');
		
            var qidx:int = qpw.indexOf((fullStats as IFullStats).getStatsProgressView());
			
            page.unregisterComponent(BATTLE_VIEW_ALIASES.FULL_STATS);
            cController.splice(cController.indexOf(page.fullStats), 1);
            page.removeChild(fullStats);
            var component:UI_FullStats = new UI_FullStats();
            component.x = fullStats.x;
            component.y = fullStats.y;
            component.visible = fullStats.visible;
            qpw[qidx] = component.getStatsProgressView();
            page.fullStats = component;
            page.addChildAt(component, idx);
            bsdController.registerComponentController(page.fullStats);
            XfwUtils.getPrivateField(page,'xfw_registerComponent')(page.fullStats, BATTLE_VIEW_ALIASES.FULL_STATS);
        }
    }
}
