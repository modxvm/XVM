/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.sixthSense
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.views.*;
    import net.wg.gui.battle.views.sixthSense.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class SixthSenseXvmView extends XvmViewBase
    {
        public function SixthSenseXvmView(view:IView)
        {
            super(view);
        }

        public function get battlePage():BaseBattlePage
        {
            return super.view as BaseBattlePage;
        }

        public function get battlePageSixthSense():SixthSense
        {
            try
            {
                return battlePage["sixthSense"];
            }
            catch (ex:Error)
            {
            }
            return null;
        }

        public function set battlePageSixthSense(value:SixthSense):void
        {
            try
            {
                battlePage["sixthSense"] = value;
            }
            catch (ex:Error)
            {
            }
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            super.onAfterPopulate(e);
            init();
        }

        private function init():void
        {
            if (battlePage != null && battlePageSixthSense != null)
            {
                battlePage.unregisterComponent(BATTLE_VIEW_ALIASES.SIXTH_SENSE);
                var currentIndex:int = battlePage.getChildIndex(battlePageSixthSense);
                battlePage.removeChild(battlePageSixthSense);
                var customSixthSense:UI_SixthSense = new UI_SixthSense();
                customSixthSense.x = battlePageSixthSense.x;
                customSixthSense.y = battlePageSixthSense.y;
                customSixthSense.visible = battlePageSixthSense.visible;
                battlePageSixthSense = customSixthSense;
                battlePage.addChildAt(battlePageSixthSense, currentIndex);

                XfwAccess.getPrivateField(battlePage, 'xfw_registerComponent')(battlePageSixthSense, BATTLE_VIEW_ALIASES.SIXTH_SENSE);
            }
            else
            {
                Logger.err(new Error("SixthSenseXvmView#init : view is not BaseBattlePage"));
            }
        }
    }
}
