/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.ranked.battleloading
{
    import com.xfw.*;
    import com.xvm.infrastructure.XvmViewBase;
    import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
    import net.wg.gui.battle.ranked.RankedBattlePage;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import net.wg.infrastructure.interfaces.IView;
    import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
    import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;

    public class RankedBattleLoadingXvmView extends XvmViewBase
    {
        public function RankedBattleLoadingXvmView(view:IView)
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
            page.unregisterComponent(BATTLE_VIEW_ALIASES.BATTLE_LOADING);
            var bsdc:BattleStatisticDataController = XfwUtils.getPrivateField(page, 'xfw_battleStatisticDataController');
            var cc:Vector.<IBattleComponentDataController> = XfwUtils.getPrivateField(bsdc, 'xfw_componentControllers');

            cc.splice(cc.indexOf(page.battleLoading), 1);
            var idx:int = page.getChildIndex(page.battleLoading);
            page.removeChild(page.battleLoading);
            var component:UI_RankedBattleLoading = new UI_RankedBattleLoading();
            component.x = page.battleLoading.x;
            component.y = page.battleLoading.y;
            component.setCompVisible(page.battleLoading.visible);
            page.battleLoading = component;
            page.addChildAt(page.battleLoading, idx);
            bsdc.registerComponentController(page.battleLoading);
            XfwUtils.getPrivateField(page, 'xfw_registerComponent')(page.battleLoading, BATTLE_VIEW_ALIASES.BATTLE_LOADING);
        }
    }
}
