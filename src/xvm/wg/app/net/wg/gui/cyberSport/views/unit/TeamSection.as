package net.wg.gui.cyberSport.views.unit
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IDropList;
   import flash.text.TextField;
   import net.wg.gui.cyberSport.controls.CSRosterToggleButton;
   import net.wg.gui.cyberSport.controls.ButtonDnmIcon;
   import net.wg.gui.cyberSport.controls.ReadyMsg;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.cyberSport.controls.SlotDropIndicator;
   import net.wg.gui.cyberSport.controls.SettingsIcons;
   import net.wg.gui.cyberSport.vo.UnitVO;
   import net.wg.gui.cyberSport.vo.ActionButtonVO;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.cyberSport.vo.VehicleVO;
   import net.wg.gui.cyberSport.vo.UnitSlotVO;
   import net.wg.gui.cyberSport.CSInvalidationType;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import __AS3__.vec.Vector;
   import net.wg.data.constants.Values;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import net.wg.gui.utils.ComplexTooltipHelper;


   public class TeamSection extends UIComponent implements IDropList
   {
          
      public function TeamSection() {
         super();
         this.btnFreeze.externalSource = true;
      }

      public var lblTeamHeader:TextField;

      public var lblTeamMembers:TextField;

      public var lblTeamVehicles:TextField;

      public var btnFreeze:CSRosterToggleButton;

      public var btnConfigure:ButtonDnmIcon;

      public var lblTeamPoints:TextField;

      public var lblStatus:ReadyMsg;

      public var btnFight:SoundButtonEx;

      public var slot0:SlotRenderer;

      public var slot1:SlotRenderer;

      public var slot2:SlotRenderer;

      public var slot3:SlotRenderer;

      public var slot4:SlotRenderer;

      public var slot5:SlotRenderer;

      public var slot6:SlotRenderer;

      public var dropTargerIndicator0:SlotDropIndicator;

      public var dropTargerIndicator1:SlotDropIndicator;

      public var dropTargerIndicator2:SlotDropIndicator;

      public var dropTargerIndicator3:SlotDropIndicator;

      public var dropTargerIndicator4:SlotDropIndicator;

      public var dropTargerIndicator5:SlotDropIndicator;

      public var dropTargerIndicator6:SlotDropIndicator;

      public var settingsIcons:SettingsIcons;

      private var _slotsUi:Array;

      private var _indicatorsUI:Array;

      private var _unitData:UnitVO;

      private var _actionButtonData:ActionButtonVO;

      private var _isFightBtnInCoolDown:Boolean = false;

      override public function dispose() : void {
         var _loc1_:SlotRenderer = null;
         var _loc2_:SlotDropIndicator = null;
         this.settingsIcons.dispose();
         this.btnFreeze.removeEventListener(ButtonEvent.CLICK,this.onStatusToggle);
         this.tooltipSubscribe([this.btnFreeze,this.btnConfigure,this.lblTeamPoints],false);
         this.btnFight.removeEventListener(ButtonEvent.CLICK,this.onReadyToggle);
         for each (_loc1_ in this._slotsUi)
         {
            _loc1_.dispose();
         }
         for each (_loc2_ in this._indicatorsUI)
         {
            _loc2_.dispose();
         }
         this._slotsUi.splice();
         this._slotsUi = null;
         this._indicatorsUI.splice();
         this._indicatorsUI = null;
         super.dispose();
      }

      public function setMemberVehicle(param1:uint, param2:uint, param3:VehicleVO) : void {
         var _loc4_:UnitSlotVO = this.getSlotModel(param1);
         _loc4_.selectedVehicle = param3;
         _loc4_.selectedVehicleLevel = param2;
         this.setSlotModel(param1,_loc4_);
      }

      public function setMemberStatus(param1:uint, param2:uint) : void {
         var _loc3_:UnitSlotVO = this.getSlotModel(param1);
         _loc3_.playerStatus = param2;
         this.setSlotModel(param1,_loc3_);
         this.updateIndicators(param1);
      }

      public function setOfflineStatus(param1:uint, param2:Boolean) : void {
         var _loc3_:UnitSlotVO = this.getSlotModel(param1);
         _loc3_.player.isOffline = param2;
         this.setSlotModel(param1,_loc3_);
      }

      public function updateMembers(param1:Boolean, param2:Array) : void {
         var _loc5_:UnitSlotVO = null;
         var _loc3_:int = param2.length;
         this._unitData.hasRestrictions = param1;
         this.updateSettingsIcon();
         this._unitData.slots.splice(0,this._unitData.slots.length);
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = new UnitSlotVO(param2[_loc4_]);
            this._unitData.slots.push(_loc5_);
            this.setSlotModel(_loc4_,this._unitData.slots[_loc4_] as UnitSlotVO);
            this.updateIndicators(_loc4_);
            _loc4_++;
         }
      }

      public function enableFreezeButton(param1:Boolean) : void {
         if(this.btnFreeze)
         {
            this.btnFreeze.enabled = param1;
         }
      }

      public function enableFightButton(param1:Boolean) : void {
         this._isFightBtnInCoolDown = !param1;
         if(this.btnFight)
         {
            this.btnFight.enabled = (param1) && (this._actionButtonData?this._actionButtonData.isEnabled:true);
         }
      }

      public function updateLockedUnit(param1:Boolean, param2:Array) : void {
         var _loc5_:UnitSlotVO = null;
         var _loc3_:int = this._unitData.slots.length;
         this._unitData.isFreezed = param1;
         this.updateSettingsIcon();
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.getSlotModel(_loc4_);
            _loc5_.isFreezed = param1;
            _loc5_.slotLabel = param2[_loc4_];
            this.setSlotModel(_loc4_,_loc5_);
            _loc4_++;
         }
      }

      public function closeSlot(param1:uint, param2:Boolean, param3:uint, param4:String, param5:Boolean, param6:int) : void {
         var _loc7_:UnitSlotVO = this.getSlotModel(param1);
         _loc7_.selectedVehicleLevel = param3;
         _loc7_.compatibleVehiclesCount = param6;
         _loc7_.isClosed = param5;
         _loc7_.slotLabel = param4;
         _loc7_.playerStatus = 0;
         _loc7_.canBeTaken = param2;
         this.setSlotModel(param1,_loc7_);
      }

      public function updateTotalLabel(param1:Boolean, param2:String) : void {
         this.updateLevelLabels(param2);
         this._unitData.sumLevelsError = param1;
      }

      private function updateLevelLabels(param1:String) : void {
         this.lblTeamPoints.htmlText = param1;
      }

      public function highlightSlots(param1:Array) : void {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:SlotDropIndicator = null;
         if((this._unitData) && (this._unitData.isCommander))
         {
            _loc3_ = this._indicatorsUI.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = this._indicatorsUI[_loc2_];
               this.highlightIndicator(_loc4_,_loc2_ > 0 && !(param1.indexOf(_loc2_) == -1));
               _loc2_++;
            }
         }
      }

      private function highlightIndicator(param1:SlotDropIndicator, param2:Boolean) : void {
         if((this._unitData) && (this._unitData.isCommander))
         {
            param1.setHighlightState(param2);
         }
      }

      public function highlightList() : void {
         var _loc1_:SlotDropIndicator = null;
         for each (_loc1_ in this._indicatorsUI)
         {
            this.highlightIndicator(_loc1_,true);
         }
      }

      public function hideHighLight() : void {
         var _loc1_:SlotDropIndicator = null;
         for each (_loc1_ in this._indicatorsUI)
         {
            this.highlightIndicator(_loc1_,false);
         }
      }

      public function get unitData() : UnitVO {
         return this._unitData;
      }

      public function set unitData(param1:UnitVO) : void {
         this._unitData = param1;
         this.updateComponents();
      }

      public function get actionButtonData() : ActionButtonVO {
         return this._actionButtonData;
      }

      public function set actionButtonData(param1:ActionButtonVO) : void {
         this._actionButtonData = param1;
         invalidate(CSInvalidationType.ACTION_BUTTON_DATA);
      }

      public function get selectable() : Boolean {
         return false;
      }

      public function set selectable(param1:Boolean) : void {
          
      }

      override protected function configUI() : void {
         super.configUI();
         this.btnConfigure.addEventListener(ButtonEvent.CLICK,this.onConfigureClick);
         this.lblTeamHeader.text = CYBERSPORT.WINDOW_UNIT_TEAM;
         this.lblTeamMembers.text = CYBERSPORT.WINDOW_UNIT_TEAMMEMBERS;
         this.lblTeamVehicles.text = CYBERSPORT.WINDOW_UNIT_TEAMVEHICLES;
         this.lblTeamPoints.text = CYBERSPORT.WINDOW_UNIT_TEAMPOINTS;
         this.btnFreeze.x = this.lblTeamMembers.x + this.lblTeamMembers.textWidth + 15;
         this.btnConfigure.x = this.lblTeamVehicles.x + this.lblTeamVehicles.textWidth + 15;
         this.settingsIcons.x = this.lblTeamHeader.x + this.lblTeamHeader.textWidth + 15;
         this._slotsUi = [this.slot0,this.slot1,this.slot2,this.slot3,this.slot4,this.slot5,this.slot6];
         this._indicatorsUI = [this.dropTargerIndicator0,this.dropTargerIndicator1,this.dropTargerIndicator2,this.dropTargerIndicator3,this.dropTargerIndicator4,this.dropTargerIndicator5,this.dropTargerIndicator6];
         this.btnFreeze.addEventListener(ButtonEvent.CLICK,this.onStatusToggle);
         this.tooltipSubscribe([this.btnFreeze,this.btnConfigure,this.lblTeamPoints]);
         this.btnFight.addEventListener(ButtonEvent.CLICK,this.onReadyToggle);
      }

      private function tooltipSubscribe(param1:Array, param2:Boolean=true) : void {
         var _loc3_:DisplayObject = null;
         for each (_loc3_ in param1)
         {
            if(param2)
            {
               _loc3_.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
               _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            }
            else
            {
               _loc3_.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
               _loc3_.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            }
         }
      }

      private function updateIndicators(param1:uint) : void {
         var _loc2_:UnitSlotVO = this.getSlotModel(param1);
         SlotDropIndicator(this._indicatorsUI[param1]).update(_loc2_.player);
         SlotDropIndicator(this._indicatorsUI[param1]).playerStatus = _loc2_.playerStatus;
      }

      private function updateComponents() : void {
         var _loc3_:SlotRenderer = null;
         var _loc4_:SlotDropIndicator = null;
         var _loc1_:Boolean = this._unitData?this._unitData.isCommander:false;
         var _loc2_:Vector.<UnitSlotVO> = this._unitData?this._unitData.slots:null;
         for each (_loc3_ in this._slotsUi)
         {
            _loc3_.slotData = _loc2_?_loc2_[this._slotsUi.indexOf(_loc3_)]:null;
         }
         for each (_loc4_ in this._indicatorsUI)
         {
            _loc4_.index = this._indicatorsUI.indexOf(_loc4_);
            _loc4_.isCurrentUserCommander = _loc1_;
            _loc4_.update(_loc2_?_loc2_[_loc4_.index].player:null);
            _loc4_.playerStatus = _loc2_?_loc2_[_loc4_.index].playerStatus:0;
         }
         this.btnConfigure.visible = this.btnFreeze.visible = _loc1_;
         this.btnFreeze.selected = this._unitData.isFreezed;
         this.updateSettingsIcon();
         this.updateLevelLabels(this._unitData.sumLevels);
      }

      private function updateSettingsIcon() : void {
         if((this._unitData) && !this._unitData.isCommander)
         {
            this.settingsIcons.visible = true;
            this.settingsIcons.flakeVisible = this._unitData?this._unitData.isFreezed:false;
            this.settingsIcons.gearVisible = this._unitData?this._unitData.hasRestrictions:false;
         }
         else
         {
            this.settingsIcons.visible = false;
         }
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(CSInvalidationType.UNIT_DATA)) && (this._unitData))
         {
            this.updateComponents();
         }
         if(isInvalid(CSInvalidationType.ACTION_BUTTON_DATA))
         {
            if(this._actionButtonData)
            {
               this.lblStatus.setMessage(this._actionButtonData.stateString,this._actionButtonData.stateColor);
               this.btnFight.enabled = (this._actionButtonData.isEnabled) && !this._isFightBtnInCoolDown;
               this.btnFight.label = this._actionButtonData.label;
            }
            else
            {
               this.lblStatus.setMessage(Values.EMPTY_STR,Values.EMPTY_STR);
               this.btnFight.enabled = false;
               this.btnFight.label = Values.EMPTY_STR;
            }
         }
      }

      private function onStatusToggle(param1:ButtonEvent) : void {
         dispatchEvent(new CSComponentEvent(CSComponentEvent.TOGGLE_FREEZE_REQUEST));
      }

      private function onConfigureClick(param1:ButtonEvent) : void {
         dispatchEvent(new CSComponentEvent(CSComponentEvent.CLICK_CONFIGURE_BUTTON));
      }

      private function onReadyToggle(param1:ButtonEvent) : void {
         dispatchEvent(new CSComponentEvent(CSComponentEvent.TOGGLE_READY_STATE_REQUEST));
      }

      private function showTooltip(param1:String, param2:String) : void {
         var _loc3_:String = new ComplexTooltipHelper().addHeader(param1,true).addBody(param2,true).make();
         if(_loc3_.length > 0)
         {
            App.toolTipMgr.showComplex(_loc3_);
         }
      }

      private function onControlRollOver(param1:MouseEvent) : void {
         var _loc2_:* = "";
         var _loc3_:* = "";
         switch(param1.currentTarget)
         {
            case this.btnFreeze:
               _loc2_ = TOOLTIPS.CYBERSPORT_UNIT_FREEZE_HEADER;
               _loc3_ = (this.unitData) && (this.unitData.isFreezed)?TOOLTIPS.CYBERSPORT_UNIT_FREEZE_BODYON:TOOLTIPS.CYBERSPORT_UNIT_FREEZE_BODYOFF;
               this.showTooltip(_loc2_,_loc3_);
               break;
            case this.btnConfigure:
               App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNIT_CONFIGURE);
               break;
            case this.lblTeamPoints:
               _loc2_ = TOOLTIPS.CYBERSPORT_UNIT_SUMLEVEL_HEADER;
               _loc3_ = (this.unitData) && (this.unitData.sumLevelsError)?TOOLTIPS.CYBERSPORT_UNIT_SUMLEVEL_BODYERROR:TOOLTIPS.CYBERSPORT_UNIT_SUMLEVEL_BODYNORMAL;
               this.showTooltip(_loc2_,_loc3_);
               break;
         }
      }

      private function onControlRollOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private function getSlotModel(param1:uint) : UnitSlotVO {
         return UnitSlotVO(this._unitData.slots[param1]);
      }

      private function setSlotModel(param1:uint, param2:UnitSlotVO) : void {
         SlotRenderer(this._slotsUi[param1]).slotData = param2;
      }
   }

}