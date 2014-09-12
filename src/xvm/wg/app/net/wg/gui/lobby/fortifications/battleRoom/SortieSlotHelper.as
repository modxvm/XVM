package net.wg.gui.lobby.fortifications.battleRoom
{
    import net.wg.gui.rally.controls.BaseRallySlotHelper;
    import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
    import net.wg.gui.rally.controls.RallySlotRenderer;
    import net.wg.gui.rally.controls.RallyLockableSlotRenderer;
    import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
    import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSimpleSlot;
    import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSlot;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.rally.vo.RallySlotVO;
    import net.wg.gui.cyberSport.controls.GrayTransparentButton;
    import net.wg.data.constants.Values;
    import flash.display.InteractiveObject;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import net.wg.gui.components.advanced.IndicationOfStatus;
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

override public function initControlsState(param1:IRallySimpleSlotRenderer) : void
{
var _loc6_:RallySlotRenderer = null;
var _loc7_:RallyLockableSlotRenderer = null;
var _loc8_:LegionariesSortieSlot = null;
super.initControlsState(param1);
var _loc2_:RallySimpleSlotRenderer = param1 as RallySimpleSlotRenderer;
var _loc3_:* = param1.index == 0;
_loc2_.orderNo.visible = !_loc3_;
_loc2_.commander.visible = false;
var _loc4_:SortieSimpleSlot = param1 as SortieSimpleSlot;
if(_loc4_)
{
    _loc4_.commander.visible = _loc3_;
    _loc4_.lockBackground.visible = true;
}
var _loc5_:SortieSlot = param1 as SortieSlot;
if(_loc5_)
{
    _loc5_.commander.visible = _loc3_;
}
if(param1 is RallySlotRenderer)
{
    _loc6_ = RallySlotRenderer(param1);
    _loc6_.removeBtn.visible = false;
    _loc6_.selfBg.visible = false;
}
if(param1 is RallyLockableSlotRenderer)
{
    _loc7_ = RallyLockableSlotRenderer(param1);
    _loc7_.lockBackground.visible = true;
}
if(param1 is LegionariesSortieSlot)
{
    _loc8_ = LegionariesSortieSlot(param1);
    _loc8_.legionariesIcon.visible = false;
}
}

override public function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO) : void
{
var _loc5_:SortieSlot = null;
var _loc6_:SortieSimpleSlot = null;
var _loc7_:RallyLockableSlotRenderer = null;
var _loc8_:* = false;
var _loc3_:RallySlotVO = param2 as RallySlotVO;
if(_loc3_.player)
{
    _loc3_.player.clanAbbrev = null;
}
super.updateComponents(param1,param2);
var _loc4_:RallySimpleSlotRenderer = param1 as RallySimpleSlotRenderer;
if(param1 is SortieSimpleSlot && (_loc3_))
{
    _loc6_ = SortieSimpleSlot(param1);
    _loc6_.lockBackground.visible = false;
}
_loc5_ = param1 as SortieSlot;
if((param1) && (_loc3_))
{
    if(param1 is RallyLockableSlotRenderer)
    {
        _loc7_ = RallyLockableSlotRenderer(param1);
        _loc7_.lockBackground.visible = false;
    }
    _loc4_.commander.visible = param1.index == 0;
}
if(_loc5_)
{
    if(_loc3_)
    {
        _loc5_.setStatus(_loc3_.playerStatus);
        if(!_loc3_.isClosed)
        {
            if(_loc3_.isCommanderState)
            {
                if(_loc3_.player)
                {
                    _loc5_.removeBtn.visible = _loc5_.index > 0;
                    _loc5_.removeBtn.icon = GrayTransparentButton.ICON_CROSS;
                    _loc5_.removeBtn.width = BTN_PROPS.remove.width;
                    _loc5_.removeBtn.x = BTN_PROPS.remove.x;
                    _loc5_.removeBtn.label = Values.EMPTY_STR;
                }
                else
                {
                    _loc5_.removeBtn.visible = false;
                }
            }
            else
            {
                _loc8_ = (_loc3_.player) && (_loc3_.player.himself);
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
            _loc5_.removeBtn.visible = _loc3_.isCommanderState;
            _loc5_.removeBtn.icon = GrayTransparentButton.ICON_NO_ICON;
            _loc5_.removeBtn.width = BTN_PROPS.lock.width;
            _loc5_.removeBtn.x = BTN_PROPS.lock.x;
            _loc5_.removeBtn.label = CYBERSPORT.WINDOW_UNIT_UNLOCKSLOT;
            _loc5_.statusIndicator.visible = false;
        }
        if(_loc3_.player)
        {
            _loc5_.setSpeakers(_loc3_.player.isPlayerSpeaking,true);
            _loc5_.selfBg.visible = _loc3_.player.himself;
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

override public function onControlRollOver(param1:InteractiveObject, param2:IRallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null) : void
{
var _loc7_:LegionariesSortieSlot = null;
var _loc8_:ComplexTooltipHelper = null;
if(param2 is LegionariesSortieSlot)
{
    _loc7_ = LegionariesSortieSlot(param2);
    switch(param1)
    {
        case _loc7_.legionariesIcon:
            App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_BATTLEROOMLEGIONARIES_TEAMSECTION);
            return;
    }
}
super.onControlRollOver(param1,param2,param3,param4);
var _loc5_:RallySimpleSlotRenderer = param2 as RallySimpleSlotRenderer;
switch(param1)
{
    case _loc5_.commander:
        App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_STATUS_COMMANDER);
        break;
    case _loc5_.statusIndicator:
        if(_loc5_.statusIndicator.currentFrameLabel == IndicationOfStatus.STATUS_READY)
        {
            App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_STATUS_ISREADY);
        }
        else if(_loc5_.statusIndicator.currentFrameLabel == IndicationOfStatus.STATUS_NORMAL)
        {
            App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_STATUS_NOTREADY);
        }
        
        break;
    case _loc5_.slotLabel:
        if(param3 != null)
        {
            if(param3.player)
            {
                App.toolTipMgr.show(param3.player.getToolTip());
            }
        }
        break;
    case _loc5_.takePlaceFirstTimeBtn:
        App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_TAKEPLACEFIRSTTIMEBTN);
        break;
    case _loc5_.takePlaceBtn:
        App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_TAKEPLACEFIRSTTIMEBTN);
        break;
    case _loc5_.vehicleBtn:
        if(_loc5_.vehicleBtn.currentState == CSVehicleButton.CHOOSE_VEHICLE)
        {
            App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_SELECTVEHICLE);
        }
        else if(_loc5_.vehicleBtn.currentState == CSVehicleButton.DEFAULT_STATE)
        {
            App.toolTipMgr.showComplex(TOOLTIPS.MEDALION_NOVEHICLE);
        }
        else if(_loc5_.vehicleBtn.currentState == CSVehicleButton.SELECTED_VEHICLE)
        {
            if((param4) && param4.type == "alert")
            {
                _loc8_ = new ComplexTooltipHelper();
                _loc8_.addHeader(param4.state);
                _loc8_.addBody(TOOLTIPS.FORTIFICATION_SORTIE_SLOT_VEHICLE_NOTREADY_TEMPORALLY_BODY,true);
                App.toolTipMgr.showComplex(_loc8_.make());
            }
            else if(param3.player)
            {
                if(!param3.player.himself)
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
var _loc6_:SortieSlot = param2 as SortieSlot;
if((_loc6_) && (param1 == _loc6_.removeBtn) && _loc6_.removeBtn.icon == GrayTransparentButton.ICON_CROSS)
{
    App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_REMOVEBTN);
}
}

override protected function isShowSlotRestrictions(param1:RallySimpleSlotRenderer, param2:IRallySlotVO) : Boolean
{
return false;
}
}
}
