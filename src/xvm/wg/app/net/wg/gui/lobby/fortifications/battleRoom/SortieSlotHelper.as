package net.wg.gui.lobby.fortifications.battleRoom
{
    import net.wg.gui.rally.controls.BaseRallySlotHelper;
    import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
    import net.wg.gui.rally.controls.RallySlotRenderer;
    import net.wg.gui.rally.controls.RallyLockableSlotRenderer;
    import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSimpleSlot;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSlot;
    import net.wg.gui.rally.vo.RallySlotVO;
    import net.wg.infrastructure.interfaces.IUserProps;
    import net.wg.gui.cyberSport.controls.GrayTransparentButton;
    import net.wg.data.constants.Values;
    import flash.display.InteractiveObject;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import net.wg.gui.cyberSport.controls.CSVehicleButton;
    import net.wg.data.constants.Tooltips;
    
    public class SortieSlotHelper extends BaseRallySlotHelper
    {
        
        public function SortieSlotHelper()
        {
            super();
        }
        
        private static var REMOVE_BTN_PROPS:Object = {"x":237,
        "width":21,
        "height":17
    };
    
    private static var LOCK_BTN_PROPS:Object = {"x":273,
    "width":147
};

private static var BTN_PROPS:Object = {"lock":LOCK_BTN_PROPS,
"remove":REMOVE_BTN_PROPS
};

private static var HIMSELF_COLOR:int = 13224374;

override public function initControlsState(param1:RallySimpleSlotRenderer) : void
{
var _loc4_:RallySlotRenderer = null;
var _loc5_:RallyLockableSlotRenderer = null;
super.initControlsState(param1);
var _loc2_:* = param1.index == 0;
param1.orderNo.visible = !_loc2_;
param1.vehicleBtn.visible = false;
param1.takePlaceBtn.visible = false;
param1.slotLabel.htmlText = FORTIFICATIONS.SORTIE_LISTVIEW_SLOT_CLOSED;
param1.slotLabel.visible = true;
param1.takePlaceFirstTimeBtn.visible = false;
param1.commander.visible = false;
var _loc3_:SortieSimpleSlot = param1 as SortieSimpleSlot;
if(_loc3_)
{
    _loc3_.commander.visible = _loc2_;
}
if(param1 is RallySlotRenderer)
{
    _loc4_ = RallySlotRenderer(param1);
    _loc4_.removeBtn.visible = false;
    _loc4_.selfBg.visible = false;
}
if(param1 is RallyLockableSlotRenderer)
{
    _loc5_ = RallyLockableSlotRenderer(param1);
    _loc5_.lockBackground.visible = true;
}
}

override public function updateComponents(param1:RallySimpleSlotRenderer, param2:IRallySlotVO) : void
{
var _loc4_:SortieSlot = null;
var _loc5_:RallySlotVO = null;
var _loc7_:* = false;
var _loc8_:RallyLockableSlotRenderer = null;
var _loc9_:IUserProps = null;
var _loc10_:* = false;
super.updateComponents(param1,_loc5_);
if(param1.takePlaceBtn)
{
    param1.takePlaceBtn.visible = false;
}
var _loc3_:SortieSimpleSlot = param1 as SortieSimpleSlot;
_loc4_ = param1 as SortieSlot;
_loc5_ = param2 as RallySlotVO;
var _loc6_:Boolean = (_loc3_) && (_loc3_.showTakePlaceBtn) || (_loc4_) && (_loc4_.showTakePlaceBtn);
if((param1) && (_loc5_))
{
    _loc7_ = param1.index > 0 && (_loc5_.canBeTaken) && !_loc5_.isCommanderState;
    param1.commander.visible = param1.index == 0;
    if(param1.takePlaceFirstTimeBtn)
    {
        param1.takePlaceFirstTimeBtn.visible = (_loc6_) && (_loc7_) && !_loc5_.isCurrentUserInSlot;
    }
    if(param1.takePlaceBtn)
    {
        param1.takePlaceBtn.visible = (_loc6_) && (_loc7_) && (_loc5_.isCurrentUserInSlot);
    }
    param1.slotLabel.visible = !((_loc6_) && (_loc7_));
    if(param1 is RallyLockableSlotRenderer)
    {
        _loc8_ = RallyLockableSlotRenderer(param1);
        _loc8_.lockBackground.visible = false;
    }
    param1.vehicleBtn.visible = true;
    param1.vehicleBtn.selectState(!_loc5_.selectedVehicle && (_loc5_.playerObj) && (_loc5_.playerObj.himself));
    if(_loc5_.playerObj)
    {
        _loc9_ = App.utils.commons.getUserProps(_loc5_.playerObj.userName,null,_loc5_.playerObj.region,_loc5_.playerObj.igrType);
        if(!_loc5_.playerObj.himself)
        {
            _loc9_.rgb = _loc5_.playerObj.color;
        }
        else
        {
            _loc9_.rgb = HIMSELF_COLOR;
        }
        if(_loc5_.selectedVehicle)
        {
            param1.vehicleBtn.setVehicle(_loc5_.selectedVehicle);
        }
        App.utils.commons.formatPlayerName(param1.slotLabel,_loc9_);
        param1.vehicleBtn.enabled = (_loc5_.playerObj.himself) && !(_loc5_.playerStatus == IS_READY);
        param1.vehicleBtn.showAlertIcon = _loc5_.playerObj.himself;
        param1.vehicleBtn.alpha = (_loc5_.playerObj.isCommander) || (_loc5_.playerObj.himself) || _loc5_.playerStatus == IS_READY?1:0.5;
    }
    else
    {
        param1.slotLabel.htmlText = _loc5_.slotLabel;
        param1.vehicleBtn.visible = false;
    }
}
if(_loc4_)
{
    if(_loc5_)
    {
        _loc4_.setStatus(_loc5_.playerStatus);
        if(!_loc5_.isClosed)
        {
            if(_loc5_.isCommanderState)
            {
                if(_loc5_.player)
                {
                    _loc4_.removeBtn.visible = _loc4_.index > 0;
                    _loc4_.removeBtn.icon = GrayTransparentButton.ICON_CROSS;
                    _loc4_.removeBtn.width = BTN_PROPS.remove.width;
                    _loc4_.removeBtn.x = BTN_PROPS.remove.x;
                    _loc4_.removeBtn.label = Values.EMPTY_STR;
                }
                else
                {
                    _loc4_.removeBtn.visible = false;
                }
            }
            else
            {
                _loc10_ = (_loc5_.player) && (_loc5_.player.himself);
                _loc4_.removeBtn.visible = _loc10_;
                if(_loc10_)
                {
                    _loc4_.removeBtn.icon = GrayTransparentButton.ICON_CROSS;
                    _loc4_.removeBtn.width = BTN_PROPS.remove.width;
                    _loc4_.removeBtn.x = BTN_PROPS.remove.x;
                    _loc4_.removeBtn.label = Values.EMPTY_STR;
                }
            }
            _loc4_.statusIndicator.visible = true;
        }
        else
        {
            _loc4_.removeBtn.visible = _loc5_.isCommanderState;
            _loc4_.removeBtn.icon = GrayTransparentButton.ICON_NO_ICON;
            _loc4_.removeBtn.width = BTN_PROPS.lock.width;
            _loc4_.removeBtn.x = BTN_PROPS.lock.x;
            _loc4_.removeBtn.label = CYBERSPORT.WINDOW_UNIT_UNLOCKSLOT;
            _loc4_.statusIndicator.visible = false;
        }
        if(_loc5_.player)
        {
            _loc4_.setSpeakers(_loc5_.player.isPlayerSpeaking,true);
            _loc4_.selfBg.visible = _loc5_.player.himself;
        }
        else
        {
            _loc4_.selfBg.visible = false;
            _loc4_.setSpeakers(false,true);
        }
    }
    _loc4_.updateVoiceWave();
}
}

override public function onControlRollOver(param1:InteractiveObject, param2:RallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null) : void
{
var _loc6_:ComplexTooltipHelper = null;
super.onControlRollOver(param1,param2,param3,param4);
switch(param1)
{
    case param2.commander:
        App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_STATUS_COMMANDER);
        break;
    case param2.statusIndicator:
        if(param2.statusIndicator.currentFrameLabel == RallySlotRenderer.STATUS_READY)
        {
            App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_STATUS_ISREADY);
        }
        else if(param2.statusIndicator.currentFrameLabel == RallySlotRenderer.STATUS_NORMAL)
        {
            App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_STATUS_NOTREADY);
        }
        
        break;
    case param2.slotLabel:
        if(param3 != null)
        {
            if(param3.playerObj)
            {
                App.toolTipMgr.show(param3.playerObj.getToolTip());
            }
        }
        break;
    case param2.takePlaceFirstTimeBtn:
        App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_TAKEPLACEFIRSTTIMEBTN);
        break;
    case param2.takePlaceBtn:
        App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_TAKEPLACEFIRSTTIMEBTN);
        break;
    case param2.vehicleBtn:
        if(param2.vehicleBtn.currentState == CSVehicleButton.CHOOSE_VEHICLE)
        {
            App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_SELECTVEHICLE);
        }
        else if(param2.vehicleBtn.currentState == CSVehicleButton.DEFAULT_STATE)
        {
            App.toolTipMgr.showComplex(TOOLTIPS.MEDALION_NOVEHICLE);
        }
        else if(param2.vehicleBtn.currentState == CSVehicleButton.SELECTED_VEHICLE)
        {
            if((param4) && param4.type == "alert")
            {
                _loc6_ = new ComplexTooltipHelper();
                _loc6_.addHeader(param4.state);
                _loc6_.addBody(TOOLTIPS.FORTIFICATION_SORTIE_SLOT_VEHICLE_NOTREADY_TEMPORALLY_BODY,true);
                App.toolTipMgr.showComplex(_loc6_.make());
            }
            else if(param3.playerObj)
            {
                if(!param3.playerObj.himself)
                {
                    App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_PLAYER_VEHICLE);
                }
                else if(param3.playerStatus != IS_READY)
                {
                    App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_PLAYER_CHANGEVEHICLE);
                }
                else
                {
                    App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_PLAYER_CANCELREADY);
                }
                
            }
            
        }
        else
        {
            App.toolTipMgr.showSpecial(Tooltips.CYBER_SPORT_SLOT,null,param2.index,param3.rallyIdx);
        }
        
        
        break;
}
var _loc5_:SortieSlot = param2 as SortieSlot;
if((_loc5_) && (param1 == _loc5_.removeBtn) && _loc5_.removeBtn.icon == GrayTransparentButton.ICON_CROSS)
{
    App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_REMOVEBTN);
}
}
}
}
