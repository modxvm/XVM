/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.battleloading
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.epicRandom.views.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class EpicRandomBattleLoadingXvmView extends XvmViewBase
    {
        public function EpicRandomBattleLoadingXvmView(view:IView)
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
            page.unregisterComponent(BATTLE_VIEW_ALIASES.BATTLE_LOADING);
            page.xfw_battleStatisticDataController.xfw_componentControllers.splice(page.xfw_battleStatisticDataController.xfw_componentControllers.indexOf(page.battleLoading), 1);
            var idx:int = page.getChildIndex(page.battleLoading);
            page.removeChild(page.battleLoading);
            var component:UI_EpicRandomBattleLoading = new UI_EpicRandomBattleLoading();
            component.x = page.battleLoading.x;
            component.y = page.battleLoading.y;
            component.setCompVisible(page.battleLoading.visible);
            page.battleLoading = component;
            page.addChildAt(page.battleLoading, idx);
            page.xfw_battleStatisticDataController.registerComponentController(page.battleLoading);
            page.xfw_registerComponent(page.battleLoading, BATTLE_VIEW_ALIASES.BATTLE_LOADING);
        }
    }
}
