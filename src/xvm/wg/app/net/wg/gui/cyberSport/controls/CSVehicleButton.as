package net.wg.gui.cyberSport.controls
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.geom.Rectangle;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.utils.IUtils;
   import net.wg.data.gui_items.Vehicle;
   import scaleform.clik.constants.InvalidationType;
   import flash.text.TextFormat;
   import flash.events.MouseEvent;
   import scaleform.gfx.MouseEventEx;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;


   public class CSVehicleButton extends SoundButtonEx
   {
          
      public function CSVehicleButton() {
         super();
      }

      private static const CUT_RECTANGLE:Rectangle;

      public static const SELECTED_VEHICLE:int = 0;

      public static const CHOOSE_VEHICLE:int = 1;

      public static const COUNT_VEHICLE:int = 2;

      public static const DEFAULT_STATE:int = 3;

      public static const RANGE_ROSTER:int = 4;

      public static const ROSTER_SETTINGS:int = 5;

      private static const UPDATE_INIT_DATA:String = "updateInitDFata";

      public var cutVehicleIcon:MovieClip;

      public var cutVehicleIconEff:MovieClip;

      public var vehicleNameEff:MovieClip;

      public var vehicleName:MovieClip;

      public var vehicleLevel:CSVehicleButtonLevels;

      public var vehicleType:MovieClip;

      public var vehicleTypeEff:MovieClip;

      public var nationTypeEff:MovieClip;

      public var nationType:MovieClip;

      public var vCountMsg:TextField;

      public var defaultMsg:TextField;

      public var bgAnimationSelectVehicle:MovieClip;

      public var bgAnimationSelectVehicleDef:MovieClip;

      public var chooseVhclAnimEffect:MovieClip;

      public var chooseVhclAnim:MovieClip;

      public var rangeView:RangeViewComponent;

      public var defaultBg:MovieClip;

      public var rangeBg:MovieClip;

      public var btnIconVCount:MovieClip;

      public var gearIcon:MovieClip;

      public var clickableArea:MovieClip;

      public var currentViewType:String = "autoSearch";

      private var rangeModel:SettingRosterVO;

      private var utils:IUtils;

      private var _currentState:int = 3;

      private var _vehicleCount:int = -1;

      private var currentCompDescriptor:int = -1;

      private var vehicleModel:Vehicle;

      private var _showRangeRosterBg:Boolean = true;

      private var _selectSate:Boolean = false;

      private var selectedStateText:String = "#cyberSport:button/medallion/chooseVehicle";

      private var _forceSoundEnable:Boolean = false;

      private var _showCommanderSettings:Boolean = false;

      public function set forceSoundEnable(param1:Boolean) : void {
         this._forceSoundEnable = param1;
      }

      public function get forceSoundEnable() : Boolean {
         return this._forceSoundEnable;
      }

      public function set showRangeRosterBg(param1:Boolean) : void {
         this._showRangeRosterBg = param1;
         this.rangeBg.visible = !param1;
      }

      public function get showRangeRosterBg() : Boolean {
         return this._showRangeRosterBg;
      }

      public function get vehicleCount() : int {
         return this._vehicleCount;
      }

      public function set vehicleCount(param1:int) : void {
         this.clearData();
         this._vehicleCount = param1;
         invalidate(UPDATE_INIT_DATA);
      }

      public function set showCommanderSettings(param1:Boolean) : void {
         this.clearData();
         this._showCommanderSettings = param1;
         invalidate(UPDATE_INIT_DATA);
      }

      public function setRangeData(param1:SettingRosterVO) : void {
         if(param1 == null)
         {
            return;
         }
         this.clearData();
         this.rangeModel = param1;
         invalidate(UPDATE_INIT_DATA);
      }

      public function getModel() : * {
         if(this.vehicleModel)
         {
            return this.currentCompDescriptor;
         }
         if(this.rangeModel)
         {
            return {
               "nationIDRange":this.getNationRange(),
               "vTypeRange":this.getVType(),
               "vLevelRange":this.getLevelsRange()
            }
         ;
         }
         return null;
      }

      public function setCompDescriptor(param1:int) : void {
         if(param1 != -1)
         {
            this.clearData();
            this.currentCompDescriptor = param1;
            this.vehicleModel = new Vehicle(param1);
            invalidate(UPDATE_INIT_DATA);
         }
      }

      public function get vehicleInventoryID() : Number {
         if(this.vehicleModel)
         {
            return this.currentCompDescriptor;
         }
         return NaN;
      }

      public function reset() : void {
         this.selectState(false);
         this.clearData();
         invalidate(UPDATE_INIT_DATA);
      }

      override protected function draw() : void {
         if(!(_newFrame == null) && (isInvalid(InvalidationType.STATE)) && (this.vehicleLevel))
         {
            this.vehicleLevel.setState(_newFrame);
         }
         super.draw();
         if((isInvalid(UPDATE_INIT_DATA)) && !this.updatedFlag)
         {
            if(this.vehicleModel)
            {
               this.initMedallion();
            }
            else
            {
               if(this.rangeModel)
               {
                  this.updateRange();
               }
               else
               {
                  this.initVehicleCount();
               }
            }
            this.changeViewState();
            this.updatedFlag = true;
         }
      }

      private var updatedFlag:Boolean = false;

      private function clearData() : void {
         this.updatedFlag = false;
         this.currentCompDescriptor = -1;
         this.vehicleModel = null;
         this.rangeModel = null;
         this._vehicleCount = -1;
         this._showCommanderSettings = false;
      }

      private function updateRange() : void {
         this.currentState = RANGE_ROSTER;
         this.rangeView.setData(this.rangeModel as SettingRosterVO);
      }

      private function initVehicleCount() : void {
         var _loc1_:TextFormat = null;
         if(this._showCommanderSettings)
         {
            this.currentState = ROSTER_SETTINGS;
         }
         else
         {
            if(this._selectSate)
            {
               this.initChooseVehicle();
            }
            else
            {
               this.currentState = this.vehicleCount != -1?COUNT_VEHICLE:DEFAULT_STATE;
               this.vCountMsg.htmlText = this.vehicleCount.toString();
               if(this._vehicleCount == 0)
               {
                  _loc1_ = this.vCountMsg.getTextFormat();
                  _loc1_.color = 16711680;
                  this.vCountMsg.setTextFormat(_loc1_);
               }
            }
         }
      }

      private function initMedallion() : void {
         this.currentState = SELECTED_VEHICLE;
         var _loc1_:String = this.utils.nations.getNationName(this.vehicleModel.nationID);
         this.nationType.gotoAndStop(_loc1_);
         this.nationTypeEff.gotoAndStop(_loc1_);
         this.cutVehicleIcon.vehicleIcon.cutRect = this.cutVehicleIconEff.vehicleIcon.cutRect = CUT_RECTANGLE;
         this.cutVehicleIcon.vehicleIcon.source = this.cutVehicleIconEff.vehicleIcon.source = this.vehicleModel.smallIconPath;
         App.utils.commons.formatPlayerName(this.vehicleName.textField,this.vehicleModel.shortUserName);
         this.vehicleNameEff.textField.text = this.vehicleName.textField.text;
         this.vehicleLevel.setData(this.vehicleModel.level);
         this.vehicleType.gotoAndStop(this.vehicleModel.type);
         this.vehicleTypeEff.gotoAndStop(this.vehicleModel.type);
      }

      private var _clickableAreaEnable:Boolean = true;

      public function set clickableAreaEnable(param1:Boolean) : void {
         this._clickableAreaEnable = param1;
      }

      override public function set enabled(param1:Boolean) : void {
         var _loc2_:* = false;
         if(enabled == false && param1 == true)
         {
            _loc2_ = true;
         }
         super.enabled = param1;
         if(param1 == false)
         {
            buttonMode = false;
            mouseChildren = true;
            this.clickableArea.buttonMode = false;
            this.clickableArea.removeEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler);
            this.clickableArea.removeEventListener(MouseEvent.ROLL_OVER,this.rollOverHandler);
            this.clickableArea.removeEventListener(MouseEvent.CLICK,this.areaOnClickHandler);
         }
         else
         {
            if(_loc2_)
            {
               mouseChildren = true;
               this.updateClickableArea();
            }
         }
      }

      override protected function configUI() : void {
         super.configUI();
         if(enabled)
         {
            buttonMode = false;
            mouseChildren = this._clickableAreaEnable;
            this.updateClickableArea();
         }
         this.cutVehicleIcon.mouseEnabled = false;
         this.cutVehicleIconEff.mouseEnabled = false;
         this.vehicleName.mouseEnabled = false;
         this.vehicleNameEff.mouseEnabled = false;
         this.vehicleLevel.mouseEnabled = false;
         this.vehicleType.mouseEnabled = false;
         this.vehicleTypeEff.mouseEnabled = false;
         this.nationType.mouseEnabled = false;
         this.nationTypeEff.mouseEnabled = false;
         this.vCountMsg.mouseEnabled = false;
         this.btnIconVCount.mouseEnabled = false;
         this.gearIcon.mouseEnabled = false;
         this.defaultMsg.mouseEnabled = false;
         this.bgAnimationSelectVehicle.mouseEnabled = false;
         this.bgAnimationSelectVehicleDef.mouseEnabled = false;
         this.chooseVhclAnimEffect.mouseEnabled = false;
         this.chooseVhclAnim.mouseEnabled = false;
         this.rangeView.mouseEnabled = false;
         this.defaultBg.mouseEnabled = false;
         this.rangeBg.mouseEnabled = false;
         this.bgAnimationSelectVehicle.visible = false;
         this.bgAnimationSelectVehicleDef.visible = false;
         this.vehicleLevel.visible = false;
         this.utils = App.utils;
         this.defaultMsg.text = CYBERSPORT.BUTTON_MEDALLION_AVAILABLEQUANTITY;
         App.soundMgr.removeSoundHdlrs(this);
      }

      private function updateClickableArea() : void {
         this.clickableArea.buttonMode = this._clickableAreaEnable;
         this.clickableArea.mouseEnabled = this._clickableAreaEnable;
         if(this._clickableAreaEnable)
         {
            this.clickableArea.addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler);
            this.clickableArea.addEventListener(MouseEvent.ROLL_OVER,this.rollOverHandler);
            this.clickableArea.addEventListener(MouseEvent.CLICK,this.areaOnClickHandler);
         }
      }

      private function rollOverHandler(param1:MouseEvent) : void {
         super.handleMouseRollOver(param1);
         this.playSounds(param1.type);
      }

      private function rollOutHandler(param1:MouseEvent) : void {
         super.handleMouseRollOut(param1);
         this.playSounds(param1.type);
      }

      private function areaOnClickHandler(param1:MouseEvent) : void {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null?0:_loc2_.buttonIdx;
         if(_loc3_ != MouseEventEx.LEFT_BUTTON)
         {
            return;
         }
         super.handleMousePress(param1);
         super.handleMouseRelease(param1);
         if(this.currentState == SELECTED_VEHICLE || this.currentState == CHOOSE_VEHICLE)
         {
            this.dispatchChooseVehicle();
         }
         if(!(this.currentState == COUNT_VEHICLE) && !(this.currentState == DEFAULT_STATE) && !(this.currentState == ROSTER_SETTINGS) || (this._forceSoundEnable))
         {
            App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,soundType,soundId);
         }
      }

      override protected function handleMousePress(param1:MouseEvent) : void {
          
      }

      override protected function handleMouseRelease(param1:MouseEvent) : void {
          
      }

      override protected function handleMouseRollOver(param1:MouseEvent) : void {
          
      }

      override protected function handleMouseRollOut(param1:MouseEvent) : void {
          
      }

      public function selectState(param1:Boolean, param2:String=null) : void {
         this.selectedStateText = param2 == null?CYBERSPORT.BUTTON_MEDALLION_CHOOSEVEHICLE:param2;
         this._selectSate = param1;
         invalidate(UPDATE_INIT_DATA);
      }

      private function initChooseVehicle() : void {
         this.currentState = CHOOSE_VEHICLE;
         this.chooseVhclAnim.chooseVehicle.text = this.selectedStateText;
         this.chooseVhclAnimEffect.chooseVehicle.text = this.selectedStateText;
         this.changeViewState();
      }

      private function changeViewState() : void {
         if(enabled)
         {
            if(this.currentState == COUNT_VEHICLE || this.currentState == DEFAULT_STATE || this.currentState == ROSTER_SETTINGS)
            {
               this.clickableArea.buttonMode = this._forceSoundEnable;
            }
            else
            {
               this.clickableArea.buttonMode = true;
            }
            if(this.currentState == ROSTER_SETTINGS)
            {
               this.clickableArea.hitArea = this.gearIcon;
            }
            else
            {
               this.clickableArea.hitArea = this.clickableArea;
            }
         }
         this.gearIcon.visible = this.currentState == ROSTER_SETTINGS;
         this.defaultBg.visible = !(this.currentState == COUNT_VEHICLE || this.currentState == ROSTER_SETTINGS);
         this.nationType.visible = this.nationTypeEff.visible = Boolean(this.currentState == SELECTED_VEHICLE);
         this.cutVehicleIcon.visible = this.cutVehicleIconEff.visible = Boolean(this.currentState == SELECTED_VEHICLE);
         this.vehicleName.visible = this.vehicleNameEff.visible = Boolean(this.currentState == SELECTED_VEHICLE);
         this.vehicleTypeEff.visible = this.vehicleType.visible = Boolean(this.currentState == SELECTED_VEHICLE);
         this.vehicleLevel.visible = Boolean(this.currentState == SELECTED_VEHICLE);
         this.btnIconVCount.visible = this.vCountMsg.visible = this.defaultMsg.visible = this.currentState == COUNT_VEHICLE;
         this.chooseVhclAnim.visible = this.chooseVhclAnimEffect.visible = this.currentState == CHOOSE_VEHICLE;
         this.bgAnimationSelectVehicleDef.visible = this.bgAnimationSelectVehicle.visible = this.currentState == CHOOSE_VEHICLE || this.currentState == RANGE_ROSTER;
         this.rangeView.visible = this.currentState == RANGE_ROSTER;
         this.rangeBg.visible = !this._showRangeRosterBg && this.currentState == RANGE_ROSTER;
         if(this.currentState == RANGE_ROSTER)
         {
            this.defaultBg.visible = this._showRangeRosterBg;
            this.bgAnimationSelectVehicle.visible = this._showRangeRosterBg;
            this.bgAnimationSelectVehicleDef.visible = this._showRangeRosterBg;
         }
      }

      private function playSounds(param1:String) : void {
         var param1:String = param1 == MouseEvent.ROLL_OVER?SoundManagerStates.SND_OVER:SoundManagerStates.SND_OUT;
         App.soundMgr.playControlsSnd(param1,soundType,soundId);
      }

      override public function dispose() : void {
         super.dispose();
         if(this.rangeModel)
         {
            this.rangeModel.dispose();
         }
         this.clearData();
         if(this.bgAnimationSelectVehicle)
         {
            this.bgAnimationSelectVehicle = null;
            this.bgAnimationSelectVehicleDef = null;
         }
         if(this.rangeView)
         {
            this.rangeView.dispose();
         }
         this.clickableArea.removeEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler);
         this.clickableArea.removeEventListener(MouseEvent.ROLL_OVER,this.rollOverHandler);
         this.clickableArea.removeEventListener(MouseEvent.CLICK,this.areaOnClickHandler);
      }

      private function dispatchChooseVehicle() : void {
         dispatchEvent(new CSComponentEvent(CSComponentEvent.CHOOSE_VEHICLE,this.getModel()));
      }

      private function getNationRange() : Array {
         if((this.rangeModel) && (this.rangeModel.nationIDRange))
         {
            return this.rangeModel.nationIDRange.slice();
         }
         return [];
      }

      private function getVType() : Array {
         if((this.rangeModel) && (this.rangeModel.vTypeRange))
         {
            return this.rangeModel.vTypeRange.slice();
         }
         return [];
      }

      private function getLevelsRange() : Array {
         if((this.rangeModel) && (this.rangeModel.vLevelRange))
         {
            return this.rangeModel.vLevelRange.slice();
         }
         return [];
      }

      public function get currentState() : int {
         return this._currentState;
      }

      public function set currentState(param1:int) : void {
         this._currentState = param1;
      }
   }

}