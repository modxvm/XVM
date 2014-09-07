package net.wg.gui.rally.controls
{
    import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
    import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
    import net.wg.data.constants.Values;
    import net.wg.gui.interfaces.IResettable;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.infrastructure.interfaces.IUserProps;
    import flash.display.InteractiveObject;
    
    public class BaseRallySlotHelper extends Object implements ISlotRendererHelper
    {
        
        public function BaseRallySlotHelper()
        {
            super();
        }
        
        public static var IS_READY:int = 2;
        
        protected var chooseVehicleText:String = "#cyberSport:button/medallion/chooseVehicle";
        
        public function initControlsState(param1:IRallySimpleSlotRenderer) : void
        {
            var _loc2_:RallySimpleSlotRenderer = param1 as RallySimpleSlotRenderer;
            _loc2_.slotLabel.text = Values.EMPTY_STR;
            if(_loc2_.takePlaceBtn)
            {
                _loc2_.takePlaceBtn.visible = false;
            }
            if(_loc2_.takePlaceFirstTimeBtn)
            {
                _loc2_.takePlaceFirstTimeBtn.visible = false;
            }
            _loc2_.vehicleBtn.visible = false;
            IResettable(_loc2_.vehicleBtn).reset();
        }
        
        public function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO) : void
        {
            var _loc5_:IUserProps = null;
            var _loc3_:RallySimpleSlotRenderer = param1 as RallySimpleSlotRenderer;
            var _loc4_:* = false;
            if(param2)
            {
                _loc4_ = _loc3_.index > 0 && (param2.canBeTaken) && !param2.isClosed && !param2.isFreezed && !param2.isCommanderState;
                if(_loc3_.takePlaceFirstTimeBtn)
                {
                    _loc3_.takePlaceFirstTimeBtn.visible = (_loc4_) && !param2.isCurrentUserInSlot;
                }
                if(_loc3_.takePlaceBtn)
                {
                    _loc3_.takePlaceBtn.visible = (_loc4_) && (param2.isCurrentUserInSlot);
                }
                if(_loc3_.contextMenuArea)
                {
                    _loc3_.contextMenuArea.visible = (param2) && (param2.player) && !param2.player.himself;
                }
                if(!param2.isClosed)
                {
                    _loc3_.vehicleBtn.visible = true;
                    if(param2.selectedVehicle)
                    {
                        _loc3_.vehicleBtn.setVehicle(param2.selectedVehicle);
                    }
                    else if(param2.isCommanderState)
                    {
                        _loc3_.vehicleBtn.vehicleCount = -1;
                        _loc3_.vehicleBtn.showCommanderSettings = !(_loc3_.index == 0) && (param2.hasRestrictions);
                        _loc3_.vehicleBtn.visible = (Boolean(param2.player)) || (_loc3_.vehicleBtn.showCommanderSettings);
                    }
                    else if(!param2.isCommanderState && !param2.player)
                    {
                        _loc3_.vehicleBtn.vehicleCount = _loc3_.index == 0 || !param2.hasRestrictions?-1:param2.compatibleVehiclesCount;
                        _loc3_.vehicleBtn.visible = (Boolean(param2.player)) || _loc3_.vehicleBtn.vehicleCount > -1;
                    }
                    else
                    {
                        _loc3_.vehicleBtn.vehicleCount = -1;
                        _loc3_.vehicleBtn.visible = Boolean(param2.player);
                    }
                    
                    
                    _loc3_.vehicleBtn.selectState(!param2.selectedVehicle && (param2.player) && (param2.player.himself),this.chooseVehicleText);
                    if(param2.player)
                    {
                        _loc3_.vehicleBtn.enabled = (param2.player.himself) && !(param2.playerStatus == 2);
                        _loc3_.vehicleBtn.showAlertIcon = param2.player.himself;
                    }
                }
                else
                {
                    _loc4_ = false;
                    _loc3_.vehicleBtn.visible = false;
                }
                _loc3_.slotLabel.visible = !_loc4_;
                if(param2.player)
                {
                    _loc5_ = App.utils.commons.getUserProps(param2.player.userName,param2.player.clanAbbrev,param2.player.region,param2.player.igrType);
                    if(!param2.player.himself)
                    {
                        _loc5_.rgb = param2.player.color;
                    }
                    else
                    {
                        _loc5_.rgb = 13224374;
                    }
                    App.utils.commons.formatPlayerName(_loc3_.slotLabel,_loc5_);
                    if(_loc3_.contextMenuArea)
                    {
                        _loc3_.contextMenuArea.width = _loc3_.slotLabel.width;
                    }
                }
                else
                {
                    _loc3_.slotLabel.htmlText = param2.slotLabel;
                }
            }
        }
        
        public function onControlRollOver(param1:InteractiveObject, param2:IRallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null) : void
        {
            var _loc5_:RallySimpleSlotRenderer = param2 as RallySimpleSlotRenderer;
            if((param1 == _loc5_.contextMenuArea) && (param3) && (param3.player))
            {
                App.toolTipMgr.show(param3.player.getToolTip());
            }
        }
    }
}
