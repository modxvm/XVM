/**
 * XVM - hangar
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.crew
{
    import com.xfw.*;
    import com.xfw.events.*;
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
        private var prevVehId:Number;
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

        override public function onBeforePopulate(e:LifeCycleEvent):void
        {
            //Logger.add('onBeforePopulate');
            if (Config.config.hangar.enableCrewAutoReturn)
            {
                Xvm.addEventListener(Defines.XFW_EVENT_CMD_RECEIVED, handleXfwCommand);
                initTmenXpPanel();
            }
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            init();
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            if (enablePrevCrewCheckBox != null)
            {
                Xvm.removeEventListener(Defines.XFW_EVENT_CMD_RECEIVED, handleXfwCommand);
                enablePrevCrewCheckBox.dispose();
                enablePrevCrewCheckBox = null;
            }
        }

        // PRIVATE

        private function init():void
        {
            CrewLoader.init(page);
        }

        // Tankmen XP Panel

        private function initTmenXpPanel():void
        {
            try
            {
                xpToTmenCheckbox_y = page.tmenXpPanel.xpToTmenCheckbox.y;
                enablePrevCrewCheckBox = page.tmenXpPanel.addChild(new CheckBoxTankers()) as CheckBox;
                enablePrevCrewCheckBox.autoSize = "left";
                enablePrevCrewCheckBox.addEventListener(MouseEvent.ROLL_OVER, handleMouseRollOver);
                enablePrevCrewCheckBox.addEventListener(Event.SELECT, onEnablePrevCrewSwitched);
                enablePrevCrewCheckBox.x = page.tmenXpPanel.xpToTmenCheckbox.x;
                enablePrevCrewCheckBox.label = Locale.get(L10N_ENABLE_PREV_CREW);
                enablePrevCrewCheckBox.toolTip = Locale.get(L10N_ENABLE_PREV_CREW_TOOLTIP);

                //Logger.add('init');
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function handleMouseRollOver(e:MouseEvent):void
        {
            if (e.target.toolTip)
                setTimeout(function():void { App.toolTipMgr.show(e.target.toolTip); }, 1);
        }

        private function handleXfwCommand(e:XfwCmdReceivedEvent):void
        {
            //Logger.add("handleXfwCommand");
            try
            {
                switch (e.cmd)
                {
                    case AS_VEHICLE_CHANGED:
                        e.stopImmediatePropagation();
                        onVehicleChanged.apply(this, e.args);
                        return;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
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

            savedValue = Xvm.cmd(XvmCommands.LOAD_SETTINGS, SETTINGS_AUTO_PREV_CREW + currentVehId, false);
            enablePrevCrewCheckBox.selected = savedValue;

            page.tmenXpPanel.validateNow();

            page.tmenXpPanel.checkboxTankersBg.visible = true;
            page.tmenXpPanel.xpToTmenCheckbox.y = xpToTmenCheckbox_y - 10;
            enablePrevCrewCheckBox.y = xpToTmenCheckbox_y + (isElite ? 7 : 0);

            if (prevVehId != currentVehId)
            {
                prevVehId = currentVehId;
                tryPutPrevCrew();
            }
        }

        private function onEnablePrevCrewSwitched(e:Event):void
        {
            if (enablePrevCrewCheckBox.enabled && enablePrevCrewCheckBox.selected != savedValue)
            {
                Xvm.cmd(XvmCommands.SAVE_SETTINGS, SETTINGS_AUTO_PREV_CREW + currentVehId, enablePrevCrewCheckBox.selected);
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
