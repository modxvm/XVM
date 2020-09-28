package net.wg.gui.prebattle.squads.simple
{
    import net.wg.gui.rally.controls.BaseRallySlotHelper;
    import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
    import flash.display.InteractiveObject;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.infrastructure.managers.ITooltipFormatter;
    import net.wg.gui.rally.vo.VehicleVO;
    import net.wg.gui.rally.vo.RallySlotVO;
    import net.wg.data.constants.Errors;
    import net.wg.data.constants.Values;
    import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
    import net.wg.gui.cyberSport.controls.CSVehicleButton;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadRallySlotVO;
    import net.wg.gui.components.advanced.IndicationOfStatus;
    import net.wg.data.constants.UserTags;

    public class SimpleSquadSlotHelper extends BaseRallySlotHelper
    {

        public function SimpleSquadSlotHelper()
        {
            super();
            chooseVehicleText = Values.EMPTY_STR;
        }

        override public function initControlsState(param1:IRallySimpleSlotRenderer) : void
        {
            super.initControlsState(param1);
            var _loc2_:SimpleSquadSlotRenderer = SimpleSquadSlotRenderer(param1);
            _loc2_.inviteIndicator.visible = false;
        }

        override public function onControlRollOver(param1:InteractiveObject, param2:IRallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null) : void
        {
            var _loc6_:SimpleSquadSlotRenderer = null;
            var _loc7_:String = null;
            var _loc8_:ITooltipFormatter = null;
            var _loc9_:String = null;
            var _loc10_:* = false;
            var _loc11_:VehicleVO = null;
            var _loc5_:RallySlotVO = param3 as RallySlotVO;
            if(_loc5_)
            {
                _loc6_ = param2 as SimpleSquadSlotRenderer;
                App.utils.asserter.assertNotNull(_loc6_,"squadSlot" + Errors.CANT_NULL);
                _loc7_ = Values.EMPTY_STR;
                _loc8_ = null;
                _loc9_ = Values.EMPTY_STR;
                _loc10_ = false;
                switch(param1)
                {
                    case _loc6_.statusIndicator:
                        _loc9_ = TOOLTIPS.squadwindow_status(RallySimpleSlotRenderer.STATUSES[_loc5_.playerStatus]);
                        _loc8_ = App.toolTipMgr.getNewFormatter();
                        _loc8_.addBody(_loc9_,true);
                        break;
                    case _loc6_.commander:
                        _loc9_ = TOOLTIPS.SQUADWINDOW_STATUS_COMMANDER;
                        _loc8_ = App.toolTipMgr.getNewFormatter();
                        _loc8_.addBody(_loc9_,true);
                        break;
                    case _loc6_.vehicleBtn:
                        if(_loc6_.vehicleBtn.currentState == CSVehicleButton.SELECTED_VEHICLE)
                        {
                            _loc11_ = _loc5_.selectedVehicle;
                            if(_loc11_ != null)
                            {
                                if(_loc11_.enabled)
                                {
                                    if(_loc11_.isBattleRoyaleVehicle)
                                    {
                                        App.toolTipMgr.showSpecial(_loc11_.tooltip,null,_loc11_.intCD);
                                    }
                                    else
                                    {
                                        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.SQUAD_SLOT_VEHICLE_SELECTED,null,param2.index,_loc5_.rallyIdx);
                                    }
                                    _loc10_ = true;
                                }
                                else
                                {
                                    _loc7_ = _loc11_.tooltip;
                                }
                            }
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

        override public function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO) : void
        {
            var _loc3_:SimpleSquadSlotRenderer = null;
            var _loc4_:SimpleSquadRallySlotVO = null;
            _loc3_ = param1 as SimpleSquadSlotRenderer;
            App.utils.asserter.assertNotNull(_loc3_,"squadSlot" + Errors.CANT_NULL);
            _loc4_ = param2 as SimpleSquadRallySlotVO;
            App.utils.asserter.assertNotNull(_loc4_,"unitSlotData" + Errors.CANT_NULL);
            _loc3_.slotLabel.width = _loc4_.playerStatus && _loc4_.selectedVehicle || _loc4_.isVisibleAdtMsg?_loc3_.vehicleBtn.x - _loc3_.slotLabel.x:_loc3_.vehicleBtn.x + _loc3_.vehicleBtn.width - _loc3_.slotLabel.x;
            super.updateComponents(param1,param2);
            _loc3_.slotLabel.visible = true;
            if(_loc4_.player && _loc4_.player.isOffline)
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
                _loc3_.vehicleBtn.visible = _loc4_.playerStatus && _loc4_.selectedVehicle;
            }
            if(_loc3_.contextMenuArea)
            {
                _loc3_.contextMenuArea.visible = param2 && param2.player;
                _loc3_.contextMenuArea.buttonMode = _loc3_.contextMenuArea.useHandCursor = param2 && param2.player && !UserTags.isCurrentPlayer(param2.player.tags);
                _loc3_.contextMenuArea.width = _loc3_.vehicleBtn.visible?_loc3_.vehicleBtn.x - _loc3_.contextMenuArea.x:_loc3_.slotLabel.width;
            }
            if(_loc4_.player)
            {
                _loc3_.setSpeakers(_loc4_.player.isPlayerSpeaking,true);
                _loc3_.commander.visible = _loc4_.player.isCommander;
                _loc3_.selfBg.visible = UserTags.isCurrentPlayer(_loc4_.player.tags);
            }
            else
            {
                _loc3_.setSpeakers(false,true);
                _loc3_.commander.visible = false;
                _loc3_.selfBg.visible = false;
            }
            _loc3_.premiumIcon.visible = _loc4_.hasPremiumAccount;
            _loc3_.updateVoiceWave();
        }
    }
}
