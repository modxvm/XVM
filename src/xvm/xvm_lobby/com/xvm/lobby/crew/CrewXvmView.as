/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.crew
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.events.*;

    public class CrewXvmView extends XvmViewBase
    {
        private static const SETTINGS_AUTO_PREV_CREW:String = "users/{accountDBID}/crew/auto_prev_crew/";

        private static const COMMAND_XVM_CREW_PUT_PREVIOUS_CREW:String = 'xvm_crew.put_previous_crew';
        private static const COMMAND_XVM_CREW_AS_VEHICLE_CHANGED:String = 'xvm_crew.as_vehicle_changed';

        private static const L10N_ENABLE_PREV_CREW:String = "lobby/crew/enable_prev_crew";
        private static const L10N_ENABLE_PREV_CREW_TOOLTIP:String = "lobby/crew/enable_prev_crew_tooltip";

        private var enablePrevCrewCheckBox:CheckBox;
        private var prevInvID:Number;
        private var currentInvID:Number;
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
            //Logger.add("onBeforePopulate");
            super.onBeforePopulate(e);

            page.addEventListener(Event.RESIZE, onHangarResize);

            if (Config.config.hangar.enableCrewAutoReturn)
            {
                Xfw.addCommandListener(COMMAND_XVM_CREW_AS_VEHICLE_CHANGED, onVehicleChanged);
                initTmenXpPanel();
            }
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            super.onAfterPopulate(e);
            CrewLoader.init(page);
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            //Logger.add("onBeforeDispose");
            super.onBeforeDispose(e);
            CrewLoader.dispose(page);
            if (enablePrevCrewCheckBox)
            {
                Xfw.removeCommandListener(COMMAND_XVM_CREW_AS_VEHICLE_CHANGED, onVehicleChanged);
                enablePrevCrewCheckBox.dispose();
                enablePrevCrewCheckBox = null;
            }
        }

        // PRIVATE

        // Tankmen XP Panel

        private function initTmenXpPanel():void
        {
            try
            {
                xpToTmenCheckbox_y = page.tmenXpPanel.xpToTmenCheckbox.y;
                enablePrevCrewCheckBox = page.tmenXpPanel.addChild(new CheckBoxTankers()) as CheckBox;
                enablePrevCrewCheckBox.autoSize = "left";
                enablePrevCrewCheckBox.addEventListener(MouseEvent.ROLL_OVER, handleMouseRollOver, false, 0, true);
                enablePrevCrewCheckBox.addEventListener(Event.SELECT, onEnablePrevCrewSwitched, false, 0, true);
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
            {
                setTimeout(function():void
                {
                    App.toolTipMgr.show(e.target.toolTip);
                }, 1);
            }
        }

        private function onVehicleChanged(invID:Number, isElite:Boolean):Object
        {
            //Logger.add('onVehicleChanged: ' + invID);

            currentInvID = invID;

            enablePrevCrewCheckBox.enabled = enablePrevCrewCheckBox.visible = invID > 0;
            if (!enablePrevCrewCheckBox.enabled)
            {
                page.tmenXpPanel.xpToTmenCheckbox.y = xpToTmenCheckbox_y;
                return null;
            }

            savedValue = Xfw.cmd(XvmCommands.LOAD_SETTINGS, SETTINGS_AUTO_PREV_CREW + currentInvID, Config.config.hangar.crewReturnByDefault);
            enablePrevCrewCheckBox.selected = savedValue;

            page.tmenXpPanel.validateNow();

            page.tmenXpPanel.checkboxTankersBg.visible = true;
            page.tmenXpPanel.xpToTmenCheckbox.y = xpToTmenCheckbox_y - 10;
            enablePrevCrewCheckBox.y = xpToTmenCheckbox_y + (isElite ? 7 : 0);

            if (prevInvID != currentInvID)
            {
                prevInvID = currentInvID;
                tryPutPrevCrew();
            }

            return null;
        }

        private function onEnablePrevCrewSwitched(e:Event):void
        {
            if (enablePrevCrewCheckBox.enabled)
            {
                if (enablePrevCrewCheckBox.selected != savedValue)
                {
                    Xfw.cmd(XvmCommands.SAVE_SETTINGS, SETTINGS_AUTO_PREV_CREW + currentInvID, enablePrevCrewCheckBox.selected);
                    savedValue = enablePrevCrewCheckBox.selected;
                    tryPutPrevCrew();
                }
            }
        }

        private function tryPutPrevCrew():void
        {
            if (savedValue)
            {
                Xfw.cmd(COMMAND_XVM_CREW_PUT_PREVIOUS_CREW);
            }
        }

        private function onHangarResize():void
        {
            var updated:Boolean = false;
            if (page.crew.list.itemRendererName == Linkages.CREW_DEFAULT_RENDERER_LINKAGE)
            {
                page.crew.list.itemRendererName = "com.xvm.lobby.ui.crew::UI_CrewItemRenderer";
                updated = true;
            }
            else if (page.crew.list.itemRendererName == Linkages.CREW_SMALL_RENDERER_LINKAGE)
            {
                page.crew.list.itemRendererName = "com.xvm.lobby.ui.crew::UI_CrewItemRendererSmall";
                updated = true;
            }
            if (updated)
            {
                page.crew.list.validateNow();
                page.crew.list.invalidateData();
            }
        }
    }
}
