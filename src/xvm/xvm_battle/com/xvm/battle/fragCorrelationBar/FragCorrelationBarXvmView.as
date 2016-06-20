/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.fragCorrelationBar
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.*;

    public class FragCorrelationBarXvmView extends XvmViewBase
    {
        public function FragCorrelationBarXvmView(view:IView)
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
            page.unregisterComponent(BATTLE_VIEW_ALIASES.FRAG_CORRELATION_BAR);
            page.xfw_battleStatisticDataController.componentControllers.splice(page.xfw_battleStatisticDataController.componentControllers.indexOf(page.fragCorrelationBar), 1);
            var idx:int = page.getChildIndex(page.fragCorrelationBar);
            page.removeChild(page.fragCorrelationBar);
            var component:UI_fragCorrelationBar = new UI_fragCorrelationBar();
            component.x = page.fragCorrelationBar.x;
            component.y = page.fragCorrelationBar.y;
            page.fragCorrelationBar = component;
            page.addChildAt(page.fragCorrelationBar, idx);
            page.xfw_battleStatisticDataController.registerComponentController(page.fragCorrelationBar);
            page.xfw_registerComponent(page.fullStats, BATTLE_VIEW_ALIASES.FRAG_CORRELATION_BAR);
        }
    }
}
