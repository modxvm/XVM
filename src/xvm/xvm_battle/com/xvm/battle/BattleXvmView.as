/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.*;

    public class BattleXvmView extends XvmViewBase
    {
        private static const XVM_BATTLE_COMMAND_BATTLE_CTRL_SET_VEHICLE_DATA:String = "xvm_battle.battleCtrlSetVehicleData";

        public function BattleXvmView(view:IView)
        {
            super(view);
        }

        public function get page():BattlePage
        {
            return super.view as BattlePage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);
            super.onAfterPopulate(e);
            //App.utils.scheduler.scheduleOnNextFrame(function():void{
            Xfw.cmd(XVM_BATTLE_COMMAND_BATTLE_CTRL_SET_VEHICLE_DATA);
            page.updateStage(App.appWidth, App.appHeight);
            //});
        }

        // PRIVATE

    }
}
