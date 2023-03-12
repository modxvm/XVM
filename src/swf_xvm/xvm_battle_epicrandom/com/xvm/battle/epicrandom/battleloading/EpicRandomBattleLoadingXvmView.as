/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.epicrandom.battleloading
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.epicRandom.views.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
    import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;

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
            var bsdc:BattleStatisticDataController = XfwAccess.getPrivateField(page, 'battleStatisticDataController');
            var cc:Vector.<IBattleComponentDataController> =XfwAccess.getPrivateField(bsdc, '_componentControllers');

            cc.splice(cc.indexOf(page.battleLoading), 1);
            var idx:int = page.getChildIndex(page.battleLoading);
            page.removeChild(page.battleLoading);
            var component:UI_EpicRandomBattleLoading = new UI_EpicRandomBattleLoading();
            component.x = page.battleLoading.x;
            component.y = page.battleLoading.y;
            component.setCompVisible(page.battleLoading.visible);
            page.battleLoading = component;
            page.addChildAt(page.battleLoading, idx);
            bsdc.registerComponentController(page.battleLoading);
            XfwAccess.getPrivateField(page, 'registerComponent')(page.battleLoading, BATTLE_VIEW_ALIASES.BATTLE_LOADING);
        }
    }
}
