/**
 * XVM - hangar
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.crew
{
    import com.xvm.*;
    import com.xvm.events.*;
    import com.xvm.infrastructure.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.events.*;

    public class CrewXvmView extends XvmViewBase
    {
        private static const SETTINGS_AUTO_PREV_CREW:String = "xvm_crew/auto_prev_crew/";

        private static const COMMAND_PUT_PREVIOUS_CREW:String = 'xvm_crew.put_previous_crew';
        private static const AS_VEHICLE_CHANGED:String = 'xvm_crew.as_vehicle_changed';

        private static const L10N_ENABLE_PREV_CREW:String = "lobby/crew/enable_prev_crew";
        private static const L10N_ENABLE_PREV_CREW_TOOLTIP:String = "lobby/crew/enable_prev_crew_tooltip";

        private var enablePrevCrewCheckBox:CheckBox;
        private var currentVehId:Number;
        private var savedValue:Boolean = false;
        private var xpToTmenCheckbox_y:Number;

        public function CrewXvmView(view:IView)
        {
            super(view);
        }

        public function get page():net.wg.gui.lobby.hangar.Hangar
        {
            return super.view as net.wg.gui.lobby.hangar.Hangar;
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            init();
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            super.onBeforeDispose(e);

            if (enablePrevCrewCheckBox != null)
            {
                Xvm.removeEventListener(Defines.XPM_EVENT_CMD_RECEIVED, handleXpmCommand);
                enablePrevCrewCheckBox.dispose();
                enablePrevCrewCheckBox = null;
            }
        }

        // PRIVATE

        private function init():void
        {
            CrewLoader.init(page);

            if (Config.config.hangar.autoPutPreviousCrewInTanks)
                initTmenXpPanel();
        }

        // Tankmen XP Panel

        private function initTmenXpPanel():void
        {
            try
            {
                xpToTmenCheckbox_y = page.tmenXpPanel.xpToTmenCheckbox.y;
                enablePrevCrewCheckBox = page.tmenXpPanel.addChild(new CheckBoxTankers()) as CheckBox;
                enablePrevCrewCheckBox.addEventListener(MouseEvent.ROLL_OVER, handleMouseRollOver);
                enablePrevCrewCheckBox.addEventListener(Event.SELECT, onEnablePrevCrewSwitched);
                enablePrevCrewCheckBox.x = page.tmenXpPanel.xpToTmenCheckbox.x;
                enablePrevCrewCheckBox.label = Locale.get(L10N_ENABLE_PREV_CREW);
                enablePrevCrewCheckBox.toolTip = Locale.get(L10N_ENABLE_PREV_CREW_TOOLTIP);

                Xvm.addEventListener(Defines.XPM_EVENT_CMD_RECEIVED, handleXpmCommand);

                //Logger.add('init');
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function handleMouseRollOver(e:MouseEvent):void
        {
            if (e.target.toolTip)
                setTimeout(function():void { App.toolTipMgr.show(e.target.toolTip); }, 1);
        }

        private function handleXpmCommand(e:ObjectEvent):void
        {
            try
            {
                switch (e.result.cmd)
                {
                    case AS_VEHICLE_CHANGED:
                        onVehicleChanged.apply(this, e.result.args);
                        break;
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function onVehicleChanged(vehId:Number, isElite:Boolean):void
        {
            //Logger.add('onVehicleChanged: ' + vehId);

            currentVehId = vehId;

            enablePrevCrewCheckBox.enabled = enablePrevCrewCheckBox.visible = vehId > 0;
            if (!enablePrevCrewCheckBox.enabled)
            {
                page.tmenXpPanel.xpToTmenCheckbox.y = xpToTmenCheckbox_y;
                return;
            }

            savedValue = Xvm.cmd(Defines.XVM_COMMAND_LOAD_SETTINGS, SETTINGS_AUTO_PREV_CREW + currentVehId, false);
            enablePrevCrewCheckBox.selected = savedValue;

            page.tmenXpPanel.checkboxTankersBg.visible = true;
            page.tmenXpPanel.xpToTmenCheckbox.y = xpToTmenCheckbox_y - 10;
            enablePrevCrewCheckBox.y = xpToTmenCheckbox_y + (isElite ? 7 : 0);

            tryPutPrevCrew();
        }

        private function onEnablePrevCrewSwitched(e:Event):void
        {
            if (enablePrevCrewCheckBox.enabled && enablePrevCrewCheckBox.selected != savedValue)
            {
                Xvm.cmd(Defines.XVM_COMMAND_SAVE_SETTINGS, SETTINGS_AUTO_PREV_CREW + currentVehId, enablePrevCrewCheckBox.selected);
                savedValue = enablePrevCrewCheckBox.selected;
                tryPutPrevCrew();
            }
        }

        private function tryPutPrevCrew():void
        {
            if (savedValue)
                Xvm.cmd(COMMAND_PUT_PREVIOUS_CREW);
        }

    }
}
