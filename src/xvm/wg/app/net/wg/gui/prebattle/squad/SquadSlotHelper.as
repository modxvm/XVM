package net.wg.gui.prebattle.squad
{
    import net.wg.gui.rally.controls.BaseRallySlotHelper;
    import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.rally.vo.RallySlotVO;
    import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
    import net.wg.gui.components.advanced.IndicationOfStatus;
    import flash.display.InteractiveObject;
    import net.wg.data.constants.Values;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import net.wg.gui.cyberSport.controls.CSVehicleButton;
    import net.wg.data.constants.Tooltips;
    
    public class SquadSlotHelper extends BaseRallySlotHelper
    {
        
        public function SquadSlotHelper()
        {
            super();
            chooseVehicleText = Values.EMPTY_STR;
        }
        
        override public function initControlsState(param1:IRallySimpleSlotRenderer) : void
        {
            super.initControlsState(param1);
            var _loc2_:SquadSlotRenderer = SquadSlotRenderer(param1);
            _loc2_.inviteIndicator.visible = false;
        }
        
        override public function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO) : void
        {
            var _loc3_:SquadSlotRenderer = null;
            _loc3_ = param1 as SquadSlotRenderer;
            var _loc4_:RallySlotVO = param2 as RallySlotVO;
            _loc3_.slotLabel.width = (_loc4_.playerStatus) && (_loc4_.selectedVehicle)?_loc3_.vehicleBtn.x - _loc3_.slotLabel.x:_loc3_.vehicleBtn.x + _loc3_.vehicleBtn.width - _loc3_.slotLabel.x;
            super.updateComponents(param1,param2);
            _loc3_.slotLabel.visible = true;
            if((_loc4_.player) && (_loc4_.player.isOffline))
            {
                _loc3_.setStatus(RallySimpleSlotRenderer.STATUSES.indexOf(IndicationOfStatus.STATUS_NORMAL));
            }
            else
            {
                _loc3_.setStatus(_loc4_.playerStatus);
            }
            if(_loc3_.vehicleBtn)
            {
                _loc3_.vehicleBtn.enabled = false;
                _loc3_.vehicleBtn.visible = (_loc4_.playerStatus) && (_loc4_.selectedVehicle);
            }
            if(_loc3_.contextMenuArea)
            {
                _loc3_.contextMenuArea.visible = (param2) && (param2.player);
                _loc3_.contextMenuArea.buttonMode = _loc3_.contextMenuArea.useHandCursor = (param2) && (param2.player) && !param2.player.himself;
                _loc3_.contextMenuArea.width = _loc3_.vehicleBtn.visible?_loc3_.vehicleBtn.x - _loc3_.contextMenuArea.x:_loc3_.slotLabel.width;
            }
            if(_loc4_.player)
            {
                _loc3_.setSpeakers(_loc4_.player.isPlayerSpeaking,true);
                _loc3_.commander.visible = _loc4_.player.isCommander;
                _loc3_.selfBg.visible = _loc4_.player.himself;
            }
            else
            {
                _loc3_.setSpeakers(false,true);
                _loc3_.commander.visible = false;
                _loc3_.selfBg.visible = false;
            }
            _loc3_.updateVoiceWave();
        }
        
        override public function onControlRollOver(param1:InteractiveObject, param2:IRallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null) : void
        {
            var _loc5_:RallySlotVO = param3 as RallySlotVO;
            var _loc6_:SquadSlotRenderer = param2 as SquadSlotRenderer;
            if(!_loc5_)
            {
                return;
            }
            var _loc7_:String = Values.EMPTY_STR;
            var _loc8_:ComplexTooltipHelper = null;
            var _loc9_:String = Values.EMPTY_STR;
            var _loc10_:* = false;
            switch(param1)
            {
                case _loc6_.statusIndicator:
                    _loc9_ = TOOLTIPS.squadwindow_status(RallySimpleSlotRenderer.STATUSES[_loc5_.playerStatus]);
                    _loc8_ = new ComplexTooltipHelper();
                    _loc8_.addBody(_loc9_,true);
                    break;
                case _loc6_.commander:
                    _loc9_ = TOOLTIPS.SQUADWINDOW_STATUS_COMMANDER;
                    _loc8_ = new ComplexTooltipHelper();
                    _loc8_.addBody(_loc9_,true);
                    break;
                case _loc6_.vehicleBtn:
                    if(_loc6_.vehicleBtn.currentState == CSVehicleButton.SELECTED_VEHICLE)
                    {
                        App.toolTipMgr.showSpecial(Tooltips.SQUAD_SLOT_VEHICLE_SELECTED,null,_loc5_.player.accID);
                        _loc10_ = true;
                    }
                    break;
            }
            if(!_loc10_)
            {
                if(_loc7_ != Values.EMPTY_STR)
                {
                    App.toolTipMgr.showComplex(_loc7_);
                }
                else if(_loc8_)
                {
                    App.toolTipMgr.showComplex(_loc8_.make());
                }
                else
                {
                    super.onControlRollOver(param1,param2,param3,param4);
                }
                
            }
        }
    }
}
