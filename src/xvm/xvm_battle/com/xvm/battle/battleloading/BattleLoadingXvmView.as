/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.battleloading
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.*;

    public class BattleLoadingXvmView extends XvmViewBase
    {
        public function BattleLoadingXvmView(view:IView)
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
            page.xfw_battleStatisticDataController.componentControllers.splice(page.xfw_battleStatisticDataController.componentControllers.indexOf(page.battleLoading), 1);
            var idx:int = page.getChildIndex(page.battleLoading);
            page.removeChild(page.battleLoading);
            var component:UI_BattleLoading = new UI_BattleLoading();
            component.x = page.battleLoading.x;
            component.y = page.battleLoading.y;

            setup_component(component, page.battleLoading as BattleLoadingUI);

            page.battleLoading = component;
            page.addChildAt(page.battleLoading, idx);
            page.xfw_battleStatisticDataController.registerComponentController(page.battleLoading);
            page.xfw_registerComponent(page.battleLoading, BATTLE_VIEW_ALIASES.BATTLE_LOADING);
        }

        private function setup_component(new_component:UI_BattleLoading, old_component:BattleLoadingUI):void
        {
            //new_component.as_setMapIcon(old_component.form.mapIcon.source);
            //new_component.as_setPlayerData(param1:Number, param2:Number) : void
            //new_component.as_setProgress(param1:Number) : void
            //new_component.as_setTip(param1:String) : void
            //new_component.as_setTipTitle(param1:String) : void
        }
    }
}
