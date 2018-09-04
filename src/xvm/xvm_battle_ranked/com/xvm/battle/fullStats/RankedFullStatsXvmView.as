/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.fullStats
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import flash.display.*;
    import net.wg.gui.battle.interfaces.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.ranked.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

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
            var qidx:int = page.xfw_battleStatisticDataController.xfw_questProgressViews.indexOf((fullStats as IFullStats).getStatsProgressView());
            page.unregisterComponent(BATTLE_VIEW_ALIASES.FULL_STATS);
            page.xfw_battleStatisticDataController.xfw_componentControllers.splice(page.xfw_battleStatisticDataController.xfw_componentControllers.indexOf(page.fullStats), 1);
            page.removeChild(fullStats);
            var component:UI_RankedFullStats = new UI_RankedFullStats();
            component.x = fullStats.x;
            component.y = fullStats.y;
            component.visible = fullStats.visible;
            page.xfw_battleStatisticDataController.xfw_questProgressViews[qidx] = component.getStatsProgressView();
            page.fullStats = component;
            page.addChildAt(component, idx);
            page.xfw_battleStatisticDataController.registerComponentController(page.fullStats);
            page.xfw_registerComponent(page.fullStats, BATTLE_VIEW_ALIASES.FULL_STATS);
        }
    }
}
