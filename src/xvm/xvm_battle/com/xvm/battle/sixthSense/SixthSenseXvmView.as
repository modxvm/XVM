/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.battle.sixthSense
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class SixthSenseXvmView extends XvmViewBase
    {
        public function SixthSenseXvmView(view:IView)
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

        private function init():void
        {
            if (page)
            {
                page.unregisterComponent(BATTLE_VIEW_ALIASES.SIXTH_SENSE);
                var currentIndex:int = page.getChildIndex(page.sixthSense);
                page.removeChild(page.sixthSense);
                var customSixthSense:UI_SixthSense = new UI_SixthSense();
                customSixthSense.x = page.sixthSense.x;
                customSixthSense.y = page.sixthSense.y;
                customSixthSense.visible = page.sixthSense.visible;
                page.sixthSense = customSixthSense;
                page.addChildAt(page.sixthSense, currentIndex);
                page.xfw_registerComponent(page.sixthSense, BATTLE_VIEW_ALIASES.SIXTH_SENSE);
            }
            else
            {
                Logger.err(new Error("SixthSenseXvmView#init : view is not BattlePage"));
            }
        }
    }
}
