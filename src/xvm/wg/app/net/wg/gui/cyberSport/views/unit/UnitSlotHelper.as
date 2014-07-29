package net.wg.gui.cyberSport.views.unit
{
    import net.wg.gui.rally.controls.BaseRallySlotHelper;
    import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.infrastructure.interfaces.IUserProps;
    import net.wg.gui.cyberSport.controls.GrayTransparentButton;
    import net.wg.data.constants.Values;
    import net.wg.gui.rally.vo.RallySlotVO;
    import flash.display.InteractiveObject;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import net.wg.data.constants.Tooltips;
    import net.wg.gui.cyberSport.controls.CSVehicleButton;
    
    public class UnitSlotHelper extends BaseRallySlotHelper
    {
        
        public function UnitSlotHelper()
        {
            super();
        }
        
        private static var REMOVE_BTN_PROPS:Object = {"x":237,
        "width":23
    };
    
    private static var LOCK_BTN_PROPS:Object = {"x":273,
    "width":147
};

private static var BTN_PROPS:Object = {"lock":LOCK_BTN_PROPS,
"remove":REMOVE_BTN_PROPS
};

override public function initControlsState(param1:RallySimpleSlotRenderer) : void
{
var _loc3_:SlotRenderer = null;
super.initControlsState(param1);
var _loc2_:SimpleSlotRenderer = param1 as SimpleSlotRenderer;
if(_loc2_)
{
    _loc2_.ratingTF.text = "";
    _loc2_.ratingTF.visible = false;
    _loc2_.lockBackground.visible = false;
}
_loc3_ = param1 as SlotRenderer;
if(_loc3_)
{
    _loc3_.setStatus(0);
    _loc3_.ratingTF.text = "";
    _loc3_.ratingTF.visible = false;
    _loc3_.levelLbl.mouseEnabled = false;
    _loc3_.removeBtn.visible = false;
    _loc3_.levelLbl.visible = true;
    _loc3_.levelLbl.text = "0";
    _loc3_.levelLbl.alpha = 0.33;
    _loc3_.lockBackground.visible = false;
}
}

override public function updateComponents(param1:RallySimpleSlotRenderer, param2:IRallySlotVO) : void
{
var _loc6_:* = false;
var _loc7_:IUserProps = null;
var _loc8_:* = false;
super.updateComponents(param1,param2);
this.updateCommonControls(param1,param2);
var _loc3_:RallySimpleSlotRenderer = param1 as RallySimpleSlotRenderer;
var _loc4_:IRallySlotVO = param2 as IRallySlotVO;
if((_loc4_) && (_loc3_))
{
    if(!_loc4_.isClosed)
    {
        _loc3_.vehicleBtn.visible = true;
        _loc6_ = _loc3_.index > 0 && (_loc4_.canBeTaken) && !_loc4_.isClosed && !_loc4_.isFreezed && !_loc4_.isCommanderState;
        if(_loc4_.selectedVehicle)
        {
            _loc3_.vehicleBtn.setVehicle(_loc4_.selectedVehicle);
        }
        else if(_loc4_.isCommanderState)
        {
            _loc3_.vehicleBtn.vehicleCount = -1;
            _loc3_.vehicleBtn.showCommanderSettings = !(_loc3_.index == 0) && (_loc4_.hasRestrictions);
            _loc3_.vehicleBtn.visible = (Boolean(_loc4_.player)) || (_loc3_.vehicleBtn.showCommanderSettings);
        }
        else if(!_loc4_.isCommanderState && !_loc4_.player)
        {
            _loc3_.vehicleBtn.vehicleCount = _loc3_.index == 0 || !_loc4_.hasRestrictions?-1:_loc4_.compatibleVehiclesCount;
            _loc3_.vehicleBtn.visible = (Boolean(_loc4_.player)) || _loc3_.vehicleBtn.vehicleCount > -1;
        }
        else
        {
            _loc3_.vehicleBtn.vehicleCount = -1;
            _loc3_.vehicleBtn.visible = Boolean(_loc4_.player);
        }
        
        
        _loc3_.vehicleBtn.selectState(!_loc4_.selectedVehicle && (_loc4_.player) && (_loc4_.player.himself));
        if(_loc4_.player)
        {
            _loc3_.vehicleBtn.enabled = (_loc4_.player.himself) && !(_loc4_.playerStatus == 2);
            _loc3_.vehicleBtn.showAlertIcon = _loc4_.player.himself;
            _loc3_.vehicleBtn.alpha = (_loc4_.player.isCommander) || (_loc4_.player.himself) || _loc4_.playerStatus == 2?1:0.5;
        }
    }
    else
    {
        _loc6_ = false;
        _loc3_.vehicleBtn.visible = false;
    }
    _loc3_.slotLabel.visible = !_loc6_;
    if(_loc4_.player)
    {
        if(_loc3_.contextMenuArea)
        {
            _loc3_.contextMenuArea.width = _loc3_.slotLabel.width;
        }
        _loc7_ = App.utils.commons.getUserProps(_loc4_.player.userName,_loc4_.player.clanAbbrev,_loc4_.player.region,_loc4_.player.igrType);
        if(!_loc4_.player.himself)
        {
            _loc7_.rgb = _loc4_.player.color;
        }
        App.utils.commons.formatPlayerName(_loc3_.slotLabel,_loc7_);
    }
    else
    {
        _loc3_.slotLabel.htmlText = _loc4_.slotLabel;
    }
    if(_loc3_.takePlaceFirstTimeBtn)
    {
        _loc3_.takePlaceFirstTimeBtn.visible = (_loc6_) && !_loc4_.isCurrentUserInSlot;
    }
    if(_loc3_.takePlaceBtn)
    {
        _loc3_.takePlaceBtn.visible = (_loc6_) && (_loc4_.isCurrentUserInSlot);
    }
}
var _loc5_:SlotRenderer = param1 as SlotRenderer;
if(_loc5_)
{
    if(_loc4_)
    {
        _loc5_.setStatus(_loc4_.playerStatus);
        _loc5_.levelLbl.text = String(_loc4_.selectedVehicleLevel);
        _loc5_.levelLbl.alpha = _loc4_.selectedVehicleLevel?1:0.33;
        if(!_loc4_.isClosed)
        {
            if(_loc4_.isCommanderState)
            {
                if(_loc4_.player)
                {
                    _loc5_.removeBtn.visible = _loc5_.index > 0;
                    _loc5_.removeBtn.icon = GrayTransparentButton.ICON_CROSS;
                    _loc5_.removeBtn.width = BTN_PROPS.remove.width;
                    _loc5_.removeBtn.x = BTN_PROPS.remove.x;
                    _loc5_.removeBtn.label = Values.EMPTY_STR;
                }
                else
                {
                    _loc5_.removeBtn.visible = _loc5_.index > 4;
                    _loc5_.removeBtn.icon = GrayTransparentButton.ICON_NO_ICON;
                    _loc5_.removeBtn.width = BTN_PROPS.lock.width;
                    _loc5_.removeBtn.x = BTN_PROPS.lock.x;
                    _loc5_.removeBtn.label = CYBERSPORT.WINDOW_UNIT_LOCKSLOT;
                }
            }
            else
            {
                _loc8_ = (_loc4_.player) && (_loc4_.player.himself);
                _loc5_.removeBtn.visible = _loc8_;
                if(_loc8_)
                {
                    _loc5_.removeBtn.icon = GrayTransparentButton.ICON_CROSS;
                    _loc5_.removeBtn.width = BTN_PROPS.remove.width;
                    _loc5_.removeBtn.x = BTN_PROPS.remove.x;
                    _loc5_.removeBtn.label = Values.EMPTY_STR;
                }
            }
            _loc5_.statusIndicator.visible = true;
        }
        else
        {
            _loc5_.removeBtn.visible = _loc4_.isCommanderState;
            _loc5_.removeBtn.icon = GrayTransparentButton.ICON_NO_ICON;
            _loc5_.removeBtn.width = BTN_PROPS.lock.width;
            _loc5_.removeBtn.x = BTN_PROPS.lock.x;
            _loc5_.removeBtn.label = CYBERSPORT.WINDOW_UNIT_UNLOCKSLOT;
            _loc5_.statusIndicator.visible = false;
        }
        if(_loc4_.player)
        {
            _loc5_.setSpeakers(_loc4_.player.isPlayerSpeaking,true);
            _loc5_.selfBg.visible = _loc4_.player.himself;
        }
        else
        {
            _loc5_.selfBg.visible = false;
            _loc5_.setSpeakers(false,true);
        }
    }
    _loc5_.updateVoiceWave();
}
}

private function updateCommonControls(param1:RallySimpleSlotRenderer, param2:IRallySlotVO) : void
{
var _loc3_:RallySlotVO = param2 as RallySlotVO;
var _loc4_:Object = param1;
if(_loc3_)
{
    if(!_loc3_.isClosed)
    {
        if(_loc3_.player)
        {
            _loc4_.ratingTF.text = _loc3_.player.rating;
            _loc4_.ratingTF.visible = true;
            _loc4_.slotLabel.width = _loc4_.ratingTF.x + _loc4_.ratingTF.width - _loc4_.slotLabel.x - _loc4_.ratingTF.textWidth - 10;
        }
        else
        {
            _loc4_.ratingTF.visible = false;
        }
    }
    else
    {
        _loc4_.lockBackground.visible = true;
    }
}
}

override public function onControlRollOver(param1:InteractiveObject, param2:RallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null) : void
{
var _loc7_:ComplexTooltipHelper = null;
var _loc8_:String = null;
super.onControlRollOver(param1,param2,param3,param4);
var _loc5_:RallySlotVO = param3 as RallySlotVO;
if(!_loc5_)
{
    return;
}
switch(param1)
{
    case param2.slotLabel:
        if(_loc5_.isClosed)
        {
            App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_SLOTLABELCLOSED);
        }
        else if(_loc5_.compatibleVehiclesCount == 0 && !_loc5_.player)
        {
            if(_loc5_.isCommanderState)
            {
                if((_loc5_.restrictions) && ((_loc5_.restrictions[0]) || (_loc5_.restrictions[1])))
                {
                    App.toolTipMgr.showSpecial(Tooltips.CYBER_SPORT_SLOT,null,param2.index,_loc5_.rallyIdx);
                }
            }
            else
            {
                App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_SLOTLABELUNAVAILABLE);
            }
        }
        else if(_loc5_.player)
        {
            App.toolTipMgr.show(_loc5_.player.getToolTip());
        }
        
        
        break;
    case param2.takePlaceBtn:
        App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_TAKEPLACEBTN);
        break;
    case param2.takePlaceFirstTimeBtn:
        App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_TAKEPLACEFIRSTTIMEBTN);
        break;
    case param2.vehicleBtn:
        if(param2.vehicleBtn.currentState == CSVehicleButton.CHOOSE_VEHICLE)
        {
            App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_SELECTVEHICLE);
        }
        else if(param2.vehicleBtn.currentState == CSVehicleButton.DEFAULT_STATE)
        {
            App.toolTipMgr.showComplex(TOOLTIPS.MEDALION_NOVEHICLE);
        }
        else if(param2.vehicleBtn.currentState == CSVehicleButton.SELECTED_VEHICLE)
        {
            if((param4) && param4.type == "alert")
            {
                _loc7_ = new ComplexTooltipHelper();
                _loc7_.addHeader(param4.state);
                _loc7_.addBody(TOOLTIPS.CYBERSPORT_UNIT_SLOT_VEHICLE_NOTREADY_TEMPORALLY_BODY,true);
                App.toolTipMgr.showComplex(_loc7_.make());
            }
            else
            {
                App.toolTipMgr.showSpecial(Tooltips.CYBER_SPORT_SLOT_SELECTED,null,param2.index,_loc5_.rallyIdx);
            }
        }
        else
        {
            App.toolTipMgr.showSpecial(Tooltips.CYBER_SPORT_SLOT,null,param2.index,_loc5_.rallyIdx);
        }
        
        
        break;
}
var _loc6_:SlotRenderer = param2 as SlotRenderer;
if((_loc6_) && (param1 == _loc6_.removeBtn) && _loc6_.removeBtn.icon == GrayTransparentButton.ICON_LOCK)
{
    _loc8_ = new ComplexTooltipHelper().addHeader(MENU.contextmenu(_loc5_.isClosed?"unlockSlot":"lockSlot"),true).addBody("",true).make();
    if(_loc8_.length > 0)
    {
        App.toolTipMgr.showComplex(_loc8_);
    }
}
}
}
}
