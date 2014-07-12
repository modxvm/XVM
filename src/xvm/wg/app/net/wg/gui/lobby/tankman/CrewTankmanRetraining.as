package net.wg.gui.lobby.tankman
{
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import scaleform.clik.controls.ButtonGroup;
   import net.wg.gui.components.controls.TankmanTrainingSmallButton;
   import net.wg.gui.components.controls.DropdownMenu;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import scaleform.clik.data.DataProvider;
   import net.wg.data.constants.VehicleTypes;
   import net.wg.gui.events.PersonalCaseEvent;
   import flash.display.InteractiveObject;
   
   public class CrewTankmanRetraining extends UIComponentEx implements IViewStackContent
   {
      
      public function CrewTankmanRetraining() {
         this.retrainingButtons = [];
         this.vehicleButtons = [];
         this.toolTipBindHash = {};
         super();
      }
      
      public var btnRetraining:SoundButtonEx;
      
      private var vehicleGroup:ButtonGroup = null;
      
      public var lightTankBtn:VehicleTypeButton = null;
      
      public var mediumTankBtn:VehicleTypeButton = null;
      
      public var heavyTankBtn:VehicleTypeButton = null;
      
      public var at_spgBtn:VehicleTypeButton = null;
      
      public var spgBtn:VehicleTypeButton = null;
      
      private var retrainingButtonGroup:ButtonGroup = null;
      
      public var btnAcademy:TankmanTrainingSmallButton = null;
      
      public var btnScool:TankmanTrainingSmallButton = null;
      
      public var btnCourses:TankmanTrainingSmallButton = null;
      
      public var vehiclesDropdown:DropdownMenu = null;
      
      public var btnReset:SoundButtonEx = null;
      
      private var currentSelectedVehicleType:String = null;
      
      private var currentSelectedInnationID:int = 0;
      
      private var currentSelectedCostIndex:int = -1;
      
      private var retrainingButtons:Array;
      
      private var vehicleButtons:Array;
      
      private var toolTipBindHash:Object;
      
      private var model:PersonalCaseRetrainingModel = null;
      
      private var needUpdateData:Boolean = false;
      
      private const UPDATE_DATA:String = "updateData";
      
      override protected function onDispose() : void {
         var _loc1_:* = 0;
         var _loc2_:VehicleTypeButton = null;
         var _loc3_:* = 0;
         var _loc4_:TankmanTrainingSmallButton = null;
         super.onDispose();
         this.model = null;
         if(this.vehicleButtons)
         {
            _loc1_ = 0;
            while(_loc1_ < this.vehicleButtons.length)
            {
               _loc2_ = this.vehicleButtons[_loc1_] as VehicleTypeButton;
               _loc2_.removeEventListener(ButtonEvent.PRESS,this.vehicleType_buttonPressHandler);
               _loc1_++;
            }
            this.vehicleButtons = null;
         }
         if(this.retrainingButtons)
         {
            _loc3_ = 0;
            while(_loc3_ < this.retrainingButtons.length)
            {
               _loc4_ = this.retrainingButtons[_loc3_] as TankmanTrainingSmallButton;
               _loc4_.dispose();
               _loc4_.removeEventListener(ButtonEvent.CLICK,this.retrainingTypeClick);
               _loc3_++;
            }
            this.retrainingButtons = null;
         }
         this.btnReset.removeEventListener(ButtonEvent.CLICK,this.btnReset_buttonClickHandler);
         this.vehiclesDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.vehiclesDropdown_listIndexChangeHandler);
         this.btnRetraining.removeEventListener(ButtonEvent.CLICK,this.applyRetrainingButtonClick);
         this.setToolTipListeners(this.vehiclesDropdown,false);
         this.setToolTipListeners(this.btnReset,false);
      }
      
      override protected function draw() : void {
         super.draw();
         if((isInvalid(this.UPDATE_DATA)) && (this.needUpdateData))
         {
            this.needUpdateData = false;
            this.updateViewElements();
         }
      }
      
      override protected function configUI() : void {
         this.vehiclesDropdown.buttonMode = true;
         this.setToolTipListeners(this.vehiclesDropdown);
         this.setToolTipListeners(this.btnReset);
         super.configUI();
         this.btnReset.addEventListener(ButtonEvent.CLICK,this.btnReset_buttonClickHandler);
         this.vehiclesDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.vehiclesDropdown_listIndexChangeHandler);
         this.btnRetraining.addEventListener(ButtonEvent.CLICK,this.applyRetrainingButtonClick);
         this.toolTipBindHash["lightTankBtn"] = "#tooltips:personal_case/training/light_tank_btn";
         this.toolTipBindHash["mediumTankBtn"] = "#tooltips:personal_case/training/medium_tank_btn";
         this.toolTipBindHash["heavyTankBtn"] = "#tooltips:personal_case/training/heavy_tank_btn";
         this.toolTipBindHash["at_spgBtn"] = "#tooltips:personal_case/training/at_spg_btn";
         this.toolTipBindHash["spgBtn"] = "#tooltips:personal_case/training/spg_btn";
         this.toolTipBindHash["vehiclesDropdown"] = "#tooltips:personal_case/training/tank";
         this.toolTipBindHash["btnReset"] = "#tooltips:personal_case/training/current_tank";
         this.vehicleButtons = [this.lightTankBtn,this.mediumTankBtn,this.heavyTankBtn,this.at_spgBtn,this.spgBtn];
         this.retrainingButtons = [this.btnCourses,this.btnScool,this.btnAcademy];
         this.initRetrainingButton();
         this.initVehicleTypes();
      }
      
      private function setToolTipListeners(param1:DisplayObject, param2:Boolean = true) : void {
         if(param2)
         {
            param1.addEventListener(MouseEvent.MOUSE_OVER,this.currentItem_mouseOverHandler);
            param1.addEventListener(MouseEvent.MOUSE_OUT,this.currnetItem_mouseOutHandler);
         }
         else
         {
            param1.removeEventListener(MouseEvent.MOUSE_OVER,this.currentItem_mouseOverHandler);
            param1.removeEventListener(MouseEvent.MOUSE_OUT,this.currnetItem_mouseOutHandler);
         }
      }
      
      private function updateViewElements() : void {
         this.enableVehicleTypeButton();
         if(this.currentSelectedVehicleType == null)
         {
            this.currentSelectedVehicleType = this.model.nativeVehicle.type;
         }
         this.currentSelectedInnationID = this.model.nativeVehicle.innationID;
         this.autoSelectVehicleType();
         this.autoSelectVehicle();
      }
      
      private function enableVehicleTypeButton() : void {
         this.lightTankBtn.enabled = this.model.lightTanks.length > 0;
         this.mediumTankBtn.enabled = this.model.mediumTanks.length > 0;
         this.heavyTankBtn.enabled = this.model.heavyTanks.length > 0;
         this.at_spgBtn.enabled = this.model.AT_SPG.length > 0;
         this.spgBtn.enabled = this.model.SPG.length > 0;
      }
      
      private function initRetrainingButton() : void {
         var _loc2_:TankmanTrainingSmallButton = null;
         this.retrainingButtonGroup = ButtonGroup.getGroup("retrainingButtonGroup",this);
         var _loc1_:* = 0;
         while(_loc1_ < this.retrainingButtons.length)
         {
            _loc2_ = this.retrainingButtons[_loc1_] as TankmanTrainingSmallButton;
            _loc2_.addEventListener(ButtonEvent.CLICK,this.retrainingTypeClick);
            _loc2_.groupName = "retrainingButtonGroup";
            _loc2_.retraining = true;
            _loc2_.allowDeselect = false;
            _loc1_++;
         }
      }
      
      private function updateRetrainingButtons() : void {
         var _loc1_:* = this.currentSelectedInnationID == this.model.nativeVehicle.innationID;
         var _loc2_:* = this.currentSelectedVehicleType == this.model.nativeVehicle.type;
         var _loc3_:* = 0;
         while(_loc3_ < this.retrainingButtons.length)
         {
            TankmanTrainingSmallButton(this.retrainingButtons[_loc3_]).setData(this.model.tankmanCost[_loc3_],this.model.gold,this.model.credits,this.model.specializationLevel,_loc1_,_loc2_,this.model.nationID,this.model.action[_loc3_]);
            _loc3_++;
         }
         this.autoSelectRetrainingButtons();
      }
      
      private function autoSelectRetrainingButtons() : void {
         var _loc2_:TankmanTrainingSmallButton = null;
         var _loc1_:* = 0;
         while(_loc1_ < this.retrainingButtons.length)
         {
            _loc2_ = this.retrainingButtons[_loc1_] as TankmanTrainingSmallButton;
            if(_loc2_.enabled == true)
            {
               _loc2_.selected = true;
               this.currentSelectedCostIndex = _loc1_;
               this.btnRetraining.enabled = true;
               return;
            }
            _loc1_++;
         }
         this.btnRetraining.enabled = false;
      }
      
      private function initVehicleTypes() : void {
         var _loc2_:VehicleTypeButton = null;
         this.vehicleGroup = ButtonGroup.getGroup("vehicleGroup",this);
         var _loc1_:* = 0;
         while(_loc1_ < this.vehicleButtons.length)
         {
            _loc2_ = this.vehicleButtons[_loc1_] as VehicleTypeButton;
            _loc2_.addEventListener(ButtonEvent.PRESS,this.vehicleType_buttonPressHandler);
            this.setToolTipListeners(_loc2_);
            _loc2_.groupName = "vehicleGroup";
            _loc2_.allowDeselect = false;
            _loc2_.validateNow();
            _loc1_++;
         }
      }
      
      private function currentItem_mouseOverHandler(param1:MouseEvent) : void {
         var _loc2_:String = null;
         if(this.toolTipBindHash[param1.currentTarget.name] != null)
         {
            _loc2_ = this.toolTipBindHash[param1.currentTarget.name];
         }
         App.toolTipMgr.showComplex(_loc2_);
      }
      
      private function currnetItem_mouseOutHandler(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }
      
      private function vehicleType_buttonPressHandler(param1:ButtonEvent) : void {
         var _loc2_:* = false;
         var _loc3_:* = false;
         if(this.currentSelectedVehicleType != VehicleTypeButton(param1.currentTarget).type)
         {
            this.currentSelectedVehicleType = VehicleTypeButton(param1.currentTarget).type;
            _loc2_ = false;
            if(this.model.currentVehicle)
            {
               _loc2_ = this.currentSelectedVehicleType == this.model.currentVehicle.type;
            }
            _loc3_ = this.currentSelectedVehicleType == this.model.nativeVehicle.type;
            this.currentSelectedInnationID = _loc2_?this.model.currentVehicle.innationID:this.model.nativeVehicle.innationID;
            this.autoSelectVehicle((_loc2_) || (_loc3_));
         }
      }
      
      private function autoSelectVehicleType() : void {
         var _loc1_:* = 0;
         while(_loc1_ < this.vehicleButtons.length)
         {
            if(this.currentSelectedVehicleType == this.vehicleButtons[_loc1_].type)
            {
               this.vehicleButtons[_loc1_].selected = true;
            }
            _loc1_++;
         }
      }
      
      private function autoSelectVehicle(param1:Boolean = true) : void {
         var _loc2_:DataProvider = null;
         var _loc3_:* = false;
         var _loc4_:* = 0;
         switch(this.currentSelectedVehicleType)
         {
            case VehicleTypes.LIGHT_TANK:
               _loc2_ = new DataProvider(this.model.lightTanks);
               break;
            case VehicleTypes.MEDIUM_TANK:
               _loc2_ = new DataProvider(this.model.mediumTanks);
               break;
            case VehicleTypes.HEAVY_TANK:
               _loc2_ = new DataProvider(this.model.heavyTanks);
               break;
            case VehicleTypes.AT_SPG:
               _loc2_ = new DataProvider(this.model.AT_SPG);
               break;
            case VehicleTypes.SPG:
               _loc2_ = new DataProvider(this.model.SPG);
               break;
            default:
               DebugUtils.LOG_DEBUG("ERROR unknown tank type");
         }
         this.vehiclesDropdown.labelField = "userName";
         this.vehiclesDropdown.dataProvider = _loc2_;
         if(param1)
         {
            _loc3_ = false;
            _loc4_ = 0;
            while(_loc4_ < this.vehiclesDropdown.dataProvider.length)
            {
               if(this.vehiclesDropdown.dataProvider[_loc4_].innationID == this.currentSelectedInnationID)
               {
                  this.vehiclesDropdown.selectedIndex = _loc4_;
                  _loc3_ = true;
                  break;
               }
               _loc4_++;
            }
            if(!_loc3_)
            {
               this.vehiclesDropdown.selectedIndex = 0;
            }
         }
         else
         {
            this.vehiclesDropdown.selectedIndex = 0;
         }
         this.checkEnabledResetBtn(this.vehiclesDropdown.dataProvider[this.vehiclesDropdown.selectedIndex].innationID);
         this.currentSelectedCostIndex = -1;
         this.autoSelectRetrainingButtons();
         this.vehiclesDropdown.validateNow();
      }
      
      public function update(param1:Object) : void {
         if(param1 == null)
         {
            return;
         }
         this.model = param1 as PersonalCaseRetrainingModel;
         this.btnReset.enabled = !(this.model.currentVehicle == null);
         this.needUpdateData = true;
         invalidate(this.UPDATE_DATA);
      }
      
      private function btnReset_buttonClickHandler(param1:ButtonEvent) : void {
         this.currentSelectedVehicleType = this.model.currentVehicle.type;
         this.currentSelectedInnationID = this.model.currentVehicle.innationID;
         this.autoSelectVehicleType();
         this.autoSelectVehicle();
      }
      
      private function vehiclesDropdown_listIndexChangeHandler(param1:ListEvent) : void {
         this.checkEnabledResetBtn(param1.itemData.innationID);
      }
      
      private function checkEnabledResetBtn(param1:int) : void {
         if(this.model.currentVehicle)
         {
            this.btnReset.enabled = !(param1 == this.model.currentVehicle.innationID);
         }
         this.currentSelectedInnationID = param1;
         this.updateRetrainingButtons();
      }
      
      private function retrainingTypeClick(param1:ButtonEvent) : void {
         this.currentSelectedCostIndex = this.retrainingButtonGroup.selectedIndex;
      }
      
      private function applyRetrainingButtonClick(param1:ButtonEvent) : void {
         var _loc2_:PersonalCaseEvent = new PersonalCaseEvent(PersonalCaseEvent.APPLY_RETRAINING);
         var _loc3_:Object = {};
         _loc3_.innaitonID = this.currentSelectedInnationID;
         _loc3_.inventoryID = this.model.tankmanID;
         _loc3_.tankmanCostTypeIndex = this.currentSelectedCostIndex;
         _loc2_.retrainingTankmanData = _loc3_;
         dispatchEvent(_loc2_);
      }
      
      public function getComponentForFocus() : InteractiveObject {
         return null;
      }
      
      public function canShowAutomatically() : Boolean {
         return true;
      }
   }
}
