package com.xvm.battle.stronghold.battleloading
{
    import com.xfw.XfwAccess;
    import com.xfw.XfwUtils;
    import com.xvm.infrastructure.XvmViewBase;
    import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
    import net.wg.gui.battle.random.views.BattlePage;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import net.wg.infrastructure.interfaces.IView;
    import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
    import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;

    public class StrongholdBattleLoadingXvmView extends XvmViewBase
    {

        public function StrongholdBattleLoadingXvmView(view:IView)
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
            page.unregisterComponent(BATTLE_VIEW_ALIASES.BATTLE_LOADING);
            var bsdc:BattleStatisticDataController = XfwAccess.getPrivateField(page, 'xfw_battleStatisticDataController');
            var cc:Vector.<IBattleComponentDataController> =XfwAccess.getPrivateField(bsdc, 'xfw_componentControllers');

            cc.splice(cc.indexOf(page.battleLoading), 1);
            var idx:int = page.getChildIndex(page.battleLoading);
            page.removeChild(page.battleLoading);
            var component:UI_StrongholdBattleLoading = new UI_StrongholdBattleLoading();
            component.x = page.battleLoading.x;
            component.y = page.battleLoading.y;
            component.setCompVisible(page.battleLoading.visible);
            page.battleLoading = component;
            page.addChildAt(page.battleLoading, idx);
            bsdc.registerComponentController(page.battleLoading);
            XfwAccess.getPrivateField(page, 'xfw_registerComponent')(page.battleLoading, BATTLE_VIEW_ALIASES.BATTLE_LOADING);
        }

    }

}