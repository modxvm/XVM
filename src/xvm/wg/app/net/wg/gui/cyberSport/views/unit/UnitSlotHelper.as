package net.wg.gui.cyberSport.views.unit
{
    import net.wg.gui.rally.controls.BaseRallySlotHelper;
    import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
    import net.wg.gui.rally.vo.RallySlotVO;
    import flash.display.InteractiveObject;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import net.wg.data.constants.Tooltips;
    import net.wg.gui.cyberSport.controls.CSVehicleButton;
    import net.wg.gui.cyberSport.controls.GrayTransparentButton;
    
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

override public function initControlsState(param1:IRallySimpleSlotRenderer) : void
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

override public function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO) : void
{
super.updateComponents(param1,param2);
this.updateCommonControls(param1,param2);
var _loc3_:RallySimpleSlotRenderer = param1 as RallySimpleSlotRenderer;
var _loc4_:IRallySlotVO = param2 as IRallySlotVO;
var _loc5_:SlotRenderer = param1 as SlotRenderer;
if(_loc5_)
{
    if(_loc4_)
    {
        _loc5_.setStatus(_loc4_.playerStatus);
        _loc5_.levelLbl.text = String(_loc4_.selectedVehicleLevel);
        _loc5_.levelLbl.alpha = _loc4_.selectedVehicleLevel?1:0.33;
        if(_loc4_.player)
        {
            _loc5_.setSpeakers(_loc4_.player.isPlayerSpeaking,true);
            _loc5_.selfBg.visible = _loc4_.player.himself;
            _loc5_.commander.visible = _loc4_.player.isCommander;
        }
        else
        {
            _loc5_.commander.visible = false;
            _loc5_.selfBg.visible = false;
            _loc5_.setSpeakers(false,true);
        }
        _loc5_.orderNo.visible = !_loc5_.commander.visible;
    }
    _loc5_.updateVoiceWave();
}
}

private function updateCommonControls(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO) : void
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

override public function onControlRollOver(param1:InteractiveObject, param2:IRallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null) : void
{
var _loc8_:ComplexTooltipHelper = null;
var _loc9_:String = null;
super.onControlRollOver(param1,param2,param3,param4);
var _loc5_:RallySlotVO = param3 as RallySlotVO;
var _loc6_:RallySimpleSlotRenderer = param2 as RallySimpleSlotRenderer;
if(!_loc5_)
{
    return;
}
switch(param1)
{
    case _loc6_.slotLabel:
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
    case _loc6_.takePlaceBtn:
        App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_TAKEPLACEBTN);
        break;
    case _loc6_.takePlaceFirstTimeBtn:
        App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_TAKEPLACEFIRSTTIMEBTN);
        break;
    case _loc6_.vehicleBtn:
        if(_loc6_.vehicleBtn.currentState == CSVehicleButton.CHOOSE_VEHICLE)
        {
            App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_SELECTVEHICLE);
        }
        else if(_loc6_.vehicleBtn.currentState == CSVehicleButton.DEFAULT_STATE)
        {
            App.toolTipMgr.showComplex(TOOLTIPS.MEDALION_NOVEHICLE);
        }
        else if(_loc6_.vehicleBtn.currentState == CSVehicleButton.SELECTED_VEHICLE)
        {
            if((param4) && param4.type == "alert")
            {
                _loc8_ = new ComplexTooltipHelper();
                _loc8_.addHeader(param4.state);
                _loc8_.addBody(TOOLTIPS.CYBERSPORT_UNIT_SLOT_VEHICLE_NOTREADY_TEMPORALLY_BODY,true);
                App.toolTipMgr.showComplex(_loc8_.make());
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
var _loc7_:SlotRenderer = param2 as SlotRenderer;
if((_loc7_) && (param1 == _loc7_.removeBtn) && _loc7_.removeBtn.icon == GrayTransparentButton.ICON_LOCK)
{
    _loc9_ = new ComplexTooltipHelper().addHeader(MENU.contextmenu(_loc5_.isClosed?"unlockSlot":"lockSlot"),true).addBody("",true).make();
    if(_loc9_.length > 0)
    {
        App.toolTipMgr.showComplex(_loc9_);
    }
}
}
}
}
