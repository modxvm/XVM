/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.fullStats
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import flash.display.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.epicRandom.views.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class EpicRandomFullStatsXvmView extends XvmViewBase
    {
        public function EpicRandomFullStatsXvmView(view:IView)
        {
            super(view);
        }

        public function get page():EpicRandomPage
        {
            return super.view as EpicRandomPage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            super.onAfterPopulate(e);
            init();
        }

        // PRIVATE

        private function init():void
        {
            page.unregisterComponent(BATTLE_VIEW_ALIASES.FULL_STATS);
            page.xfw_battleStatisticDataController.componentControllers.splice(page.xfw_battleStatisticDataController.componentControllers.indexOf(page.fullStats), 1);
            var fullStats:DisplayObject = page.fullStats as DisplayObject
            var idx:int = page.getChildIndex(fullStats);
            page.removeChild(fullStats);
            var component:UI_EpicRandomFullStats = new UI_EpicRandomFullStats();
            component.x = fullStats.x;
            component.y = fullStats.y;
            component.visible = fullStats.visible;
            page.fullStats = component;
            page.addChildAt(component, idx);
            page.xfw_battleStatisticDataController.registerComponentController(page.fullStats);
            page.xfw_registerComponent(page.fullStats, BATTLE_VIEW_ALIASES.FULL_STATS);
        }
    }
}
