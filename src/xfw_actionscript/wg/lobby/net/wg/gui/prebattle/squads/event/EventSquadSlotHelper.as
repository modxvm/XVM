package net.wg.gui.prebattle.squads.event
{
    import net.wg.gui.prebattle.squads.simple.SimpleSquadSlotHelper;
    import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.prebattle.squads.simple.SimpleSquadSlotRenderer;
    import net.wg.gui.prebattle.squads.event.vo.EventSlotVO;
    import net.wg.gui.prebattle.squads.event.vo.GeneralVO;
    import flash.display.InteractiveObject;
    import net.wg.gui.cyberSport.controls.CSVehicleButton;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class EventSquadSlotHelper extends SimpleSquadSlotHelper
    {

        public function EventSquadSlotHelper()
        {
            super();
        }

        override public function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO) : void
        {
            super.updateComponents(param1,param2);
            var _loc3_:SimpleSquadSlotRenderer = SimpleSquadSlotRenderer(param1);
            var _loc4_:EventSlotVO = param2 as EventSlotVO;
            var _loc5_:EventVehicleButton = EventVehicleButton(_loc3_.vehicleBtn);
            var _loc6_:GeneralVO = null;
            if(_loc4_ != null)
            {
                _loc6_ = _loc4_.general;
            }
            _loc5_.setGeneral(_loc6_);
            _loc3_.premiumIcon.visible = false;
        }

        override public function onControlRollOver(param1:InteractiveObject, param2:IRallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null) : void
        {
            var _loc6_:SimpleSquadSlotRenderer = null;
            var _loc5_:EventSlotVO = param3 as EventSlotVO;
            if(_loc5_)
            {
                _loc6_ = param2 as SimpleSquadSlotRenderer;
                if(_loc6_ && param1 == _loc6_.vehicleBtn && _loc6_.vehicleBtn.currentState == CSVehicleButton.SELECTED_VEHICLE)
                {
                    App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.SQUAD_SLOT_VEHICLE_SELECTED,null,param2.index,_loc5_.rallyIdx);
                }
            }
            super.onControlRollOver(param1,param2,param3,param4);
        }
    }
}
