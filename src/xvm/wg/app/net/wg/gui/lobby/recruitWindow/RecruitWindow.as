package net.wg.gui.lobby.recruitWindow
{
   import net.wg.infrastructure.base.meta.impl.RecruitWindowMeta;
   import net.wg.infrastructure.base.meta.IRecruitWindowMeta;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TankmanTrainingButton;
   import scaleform.clik.controls.ButtonGroup;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.MouseEvent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.components.controls.IconText;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;
   import net.wg.utils.IFocusHandler;
   import flash.events.IEventDispatcher;
   import flash.events.Event;


   public class RecruitWindow extends RecruitWindowMeta implements IRecruitWindowMeta
   {
          
      public function RecruitWindow() {
         super();
         isModal = false;
         canResize = false;
         canMinimize = false;
         isCentered = true;
      }

      public var nationDropdown:DropdownMenu;

      public var roleDropdown:DropdownMenu;

      public var vehicleClassDropdown:DropdownMenu;

      public var vehicleTypeDropdown:DropdownMenu;

      public var btnRecruit:SoundButtonEx;

      public var btnCancel:SoundButtonEx;

      public var btnAcademy:TankmanTrainingButton;

      public var btnScool:TankmanTrainingButton;

      public var btnCourses:TankmanTrainingButton;

      protected var btnGroup:ButtonGroup;

      private var data:Object;

      private var studyType:Number = 0;

      private var menuEnabled:Boolean = false;

      override protected function configUI() : void {
         super.configUI();
         this.btnGroup = new ButtonGroup("group1",this);
         this.btnGroup.addButton(this.btnAcademy);
         this.btnGroup.addButton(this.btnScool);
         this.btnGroup.addButton(this.btnCourses);
         this.btnAcademy.doubleClickEnabled = true;
         this.btnAcademy.allowDeselect = false;
         this.btnAcademy.addEventListener(ButtonEvent.CLICK,this.onButtonStudyTypeClick);
         this.btnAcademy.addEventListener(MouseEvent.DOUBLE_CLICK,this.onButtonStudyTypeDoubleClick);
         this.btnScool.doubleClickEnabled = true;
         this.btnScool.allowDeselect = false;
         this.btnScool.addEventListener(ButtonEvent.CLICK,this.onButtonStudyTypeClick);
         this.btnScool.addEventListener(MouseEvent.DOUBLE_CLICK,this.onButtonStudyTypeDoubleClick);
         this.btnCourses.doubleClickEnabled = true;
         this.btnCourses.allowDeselect = false;
         this.btnCourses.addEventListener(ButtonEvent.CLICK,this.onButtonStudyTypeClick);
         this.btnCourses.addEventListener(MouseEvent.DOUBLE_CLICK,this.onButtonStudyTypeDoubleClick);
         this.btnCourses.selected = true;
         this.btnCancel.addEventListener(ButtonEvent.CLICK,this.onClose);
         this.btnRecruit.addEventListener(ButtonEvent.CLICK,this.onRecruitTankman);
         this.nationDropdown.dataProvider = new DataProvider([
            {
               "label":MENU.NATIONS_ALL,
               "data":null
            }
         ]);
         this.vehicleClassDropdown.dataProvider = new DataProvider([
            {
               "label":DIALOGS.RECRUITWINDOW_MENUEMPTYROW,
               "data":null
            }
         ]);
         this.vehicleTypeDropdown.dataProvider = new DataProvider([
            {
               "label":DIALOGS.RECRUITWINDOW_MENUEMPTYROW,
               "data":null
            }
         ]);
         this.roleDropdown.dataProvider = new DataProvider([
            {
               "label":DIALOGS.RECRUITWINDOW_MENUEMPTYROW,
               "data":null
            }
         ]);
         this.nationDropdown.selectedIndex = 0;
         this.vehicleClassDropdown.selectedIndex = 0;
         this.vehicleTypeDropdown.selectedIndex = 0;
         this.roleDropdown.selectedIndex = 0;
         this.nationDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.recruitButtonCheck);
         this.vehicleClassDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.recruitButtonCheck);
         this.vehicleTypeDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.recruitButtonCheck);
         this.roleDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.recruitButtonCheck);
         this.setDefaultSelection();
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this.data))
         {
            this.nationDropdown.validateNow();
            this.vehicleClassDropdown.validateNow();
            this.vehicleTypeDropdown.validateNow();
            this.roleDropdown.validateNow();
            this.btnAcademy.updatePrice(this.data.academyUpgradeActionPrc,this.data.academyUpgradePrice,this.data.academyUpgradeDefPrice,IconText.GOLD);
            if(this.data.gold < this.data.academyUpgradePrice)
            {
               this.btnAcademy.enabled = false;
            }
            this.btnScool.updatePrice(this.data.schoolUpgradeActionPrc,this.data.schoolUpgradePrice,this.data.schoolUpgradeDefPrice,IconText.CREDITS);
            this.btnCourses.updatePrice(0,0,0,"");
            if(this.data.credits < this.data.schoolUpgradePrice)
            {
               this.btnScool.enabled = false;
            }
            if(!this.menuEnabled)
            {
               this.btnAcademy.nation = this.data.data.nationID;
               this.btnScool.nation = this.data.data.nationID;
               this.btnCourses.nation = this.data.data.nationID;
               this.btnAcademy.validateNow();
               this.btnCourses.validateNow();
               this.btnScool.validateNow();
               updateAllDropdownsS(this.data.data.nationID,this.data.data.tankType,this.data.data.typeID,this.data.data.roleType);
            }
            else
            {
               this.nationDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onChangeNation);
               this.vehicleClassDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onChangeVehicleClass);
               this.vehicleTypeDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onChangeVehicleType);
               updateNationDropdownS();
               this.btnRecruit.enabled = false;
            }
         }
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         window.useBottomBtns = true;
         this.window.title = DIALOGS.RECRUITWINDOW_TITLE;
      }

      override protected function preInitialize() : void {
         constraints = new Constraints(this,ConstrainMode.COUNTER_SCALE);
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.btnAcademy.removeEventListener(ButtonEvent.CLICK,this.onButtonStudyTypeClick);
         this.btnAcademy.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onButtonStudyTypeDoubleClick);
         this.btnScool.removeEventListener(ButtonEvent.CLICK,this.onButtonStudyTypeClick);
         this.btnScool.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onButtonStudyTypeDoubleClick);
         this.btnCourses.removeEventListener(ButtonEvent.CLICK,this.onButtonStudyTypeClick);
         this.btnCourses.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onButtonStudyTypeDoubleClick);
         this.nationDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.recruitButtonCheck);
         this.vehicleClassDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.recruitButtonCheck);
         this.vehicleTypeDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.recruitButtonCheck);
         this.roleDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.recruitButtonCheck);
         if(this.vehicleTypeDropdown.hasEventListener(ListEvent.INDEX_CHANGE))
         {
            this.vehicleTypeDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onChangeVehicleType);
         }
         if(this.vehicleClassDropdown.hasEventListener(ListEvent.INDEX_CHANGE))
         {
            this.vehicleClassDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onChangeVehicleClass);
         }
         if(this.nationDropdown.hasEventListener(ListEvent.INDEX_CHANGE))
         {
            this.nationDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onChangeNation);
         }
         this.btnCancel.removeEventListener(ButtonEvent.CLICK,this.onClose);
         this.btnRecruit.removeEventListener(ButtonEvent.CLICK,this.onRecruitTankman);
      }

      public function as_setAllDropdowns(param1:Array, param2:Array, param3:Array, param4:Array) : void {
         this.as_setNations(param1);
         this.as_setVehicleClassDropdown(param2);
         this.as_setVehicleTypeDropdown(param3);
         this.as_setRoleDropdown(param4);
      }

      public function as_initData(param1:Object) : void {
         this.data = param1;
         this.menuEnabled = param1.menuEnabled;
         invalidateData();
      }

      public function as_setNations(param1:Array) : void {
         var _loc2_:String = null;
         this.nationDropdown.dataProvider = new DataProvider(param1);
         this.nationDropdown.selectedIndex = 0;
         if(!this.menuEnabled)
         {
            this.nationDropdown.enabled = false;
            for (_loc2_ in this.nationDropdown.dataProvider)
            {
               if(this.nationDropdown.dataProvider[_loc2_].id == this.data.data.nationID)
               {
                  this.nationDropdown.selectedIndex = Number(_loc2_);
                  break;
               }
            }
            App.utils.focusHandler.setFocus(this.btnRecruit);
         }
         else
         {
            this.vehicleClassDropdown.enabled = false;
            this.vehicleTypeDropdown.enabled = false;
            this.roleDropdown.enabled = false;
         }
      }

      public function as_setVehicleClassDropdown(param1:Array) : void {
         var _loc2_:String = null;
         this.vehicleClassDropdown.dataProvider = new DataProvider(param1);
         this.vehicleClassDropdown.selectedIndex = 0;
         if(this.vehicleClassDropdown.selectedIndex == 0)
         {
            this.vehicleTypeDropdown.selectedIndex = 0;
            this.roleDropdown.selectedIndex = 0;
         }
         this.vehicleTypeDropdown.enabled = !(this.vehicleClassDropdown.selectedIndex == 0);
         this.roleDropdown.enabled = !(this.vehicleClassDropdown.selectedIndex == 0);
         if(!this.menuEnabled)
         {
            for (_loc2_ in this.vehicleClassDropdown.dataProvider)
            {
               if(this.vehicleClassDropdown.dataProvider[_loc2_].id == this.data.data.tankType)
               {
                  this.vehicleClassDropdown.selectedIndex = Number(_loc2_);
                  break;
               }
            }
            this.vehicleClassDropdown.enabled = false;
         }
      }

      public function as_setVehicleTypeDropdown(param1:Array) : void {
         var _loc2_:String = null;
         this.vehicleTypeDropdown.dataProvider = new DataProvider(param1);
         this.vehicleTypeDropdown.selectedIndex = 0;
         if(this.vehicleTypeDropdown.selectedIndex == 0)
         {
            this.roleDropdown.selectedIndex = 0;
         }
         this.roleDropdown.enabled = !(this.vehicleTypeDropdown.selectedIndex == 0);
         if(!this.data.menuEnabled)
         {
            for (_loc2_ in this.vehicleTypeDropdown.dataProvider)
            {
               if(this.vehicleTypeDropdown.dataProvider[_loc2_].id == this.data.data.typeID)
               {
                  this.vehicleTypeDropdown.selectedIndex = Number(_loc2_);
                  break;
               }
            }
            this.vehicleTypeDropdown.enabled = false;
         }
      }

      public function as_setRoleDropdown(param1:Array) : void {
         var _loc2_:String = null;
         this.roleDropdown.dataProvider = new DataProvider(param1);
         this.roleDropdown.selectedIndex = 0;
         if(!this.menuEnabled)
         {
            for (_loc2_ in this.roleDropdown.dataProvider)
            {
               if(this.roleDropdown.dataProvider[_loc2_].id == this.data.data.roleType)
               {
                  this.roleDropdown.selectedIndex = Number(_loc2_);
                  break;
               }
            }
            this.roleDropdown.enabled = false;
         }
      }

      public function as_setCreditsChanged(param1:Number) : void {
         this.btnScool.enabled = param1 > this.data.schoolUpgradePrice;
      }

      public function as_setGoldChanged(param1:Number) : void {
         this.btnAcademy.enabled = param1 > this.data.academyUpgradePrice;
      }

      private function setDefaultSelection() : void {
         var _loc1_:IFocusHandler = App.utils.focusHandler;
         if((this.nationDropdown.enabled) && (this.nationDropdown.visible))
         {
            _loc1_.setFocus(this.nationDropdown);
         }
         else
         {
            if((this.vehicleClassDropdown.enabled) && (this.vehicleClassDropdown.visible))
            {
               _loc1_.setFocus(this.vehicleClassDropdown);
            }
            else
            {
               if((this.vehicleTypeDropdown.enabled) && (this.vehicleTypeDropdown.visible))
               {
                  _loc1_.setFocus(this.vehicleTypeDropdown);
               }
               else
               {
                  if((this.roleDropdown.enabled) && (this.roleDropdown.visible))
                  {
                     _loc1_.setFocus(this.roleDropdown);
                  }
                  else
                  {
                     _loc1_.setFocus(this.btnCourses);
                  }
               }
            }
         }
      }

      public function onButtonStudyTypeClick(param1:ButtonEvent) : void {
         switch(param1.target)
         {
            case this.btnAcademy:
               this.studyType = 2;
               break;
            case this.btnScool:
               this.studyType = 1;
               break;
            case this.btnCourses:
               this.studyType = 0;
               break;
            default:
               this.studyType = 0;
         }
      }

      public function onButtonStudyTypeDoubleClick(param1:MouseEvent) : void {
         (param1.target as IEventDispatcher).dispatchEvent(new ButtonEvent(ButtonEvent.CLICK));
         this.onRecruitTankman(param1);
      }

      private function onChangeNation(param1:ListEvent) : void {
         var _loc2_:Number = this.nationDropdown.dataProvider[this.nationDropdown.selectedIndex].id;
         this.vehicleClassDropdown.enabled = !((isNaN(_loc2_)) || !this.menuEnabled);
         this.btnAcademy.nation = this.btnScool.nation = this.btnCourses.nation = _loc2_;
         this.updateVehicleClassDropdownS(_loc2_);
      }

      private function onChangeVehicleClass(param1:ListEvent) : void {
         var _loc2_:Number = this.nationDropdown.dataProvider[this.nationDropdown.selectedIndex].id;
         var _loc3_:String = this.vehicleClassDropdown.dataProvider[this.vehicleClassDropdown.selectedIndex].id;
         this.vehicleTypeDropdown.enabled = !(!this.vehicleClassDropdown.enabled || _loc3_ == null || !_loc3_);
         if(!this.vehicleClassDropdown.enabled || _loc3_ == null || !_loc3_)
         {
            this.vehicleTypeDropdown.selectedIndex = 0;
         }
         this.updateVehicleTypeDropdownS(_loc2_,_loc3_);
      }

      private function onChangeVehicleType(param1:ListEvent) : void {
         var _loc2_:Number = this.nationDropdown.dataProvider[this.nationDropdown.selectedIndex].id;
         var _loc3_:String = this.vehicleClassDropdown.dataProvider[this.vehicleClassDropdown.selectedIndex].id;
         var _loc4_:Number = this.vehicleTypeDropdown.dataProvider[this.vehicleTypeDropdown.selectedIndex].id;
         this.roleDropdown.enabled = !(!this.vehicleTypeDropdown.enabled || (isNaN(_loc4_)));
         if(!this.vehicleTypeDropdown.enabled || (isNaN(_loc4_)) || !_loc4_)
         {
            this.roleDropdown.selectedIndex = 0;
         }
         this.updateRoleDropdownS(_loc2_,_loc3_,_loc4_);
      }

      private function onClose(param1:ButtonEvent) : void {
         onWindowCloseS();
      }

      private function onRecruitTankman(param1:Event) : void {
         var _loc2_:Number = this.nationDropdown.dataProvider[this.nationDropdown.selectedIndex].id;
         var _loc3_:Number = this.vehicleTypeDropdown.dataProvider[this.vehicleTypeDropdown.selectedIndex].id;
         var _loc4_:String = this.roleDropdown.dataProvider[this.roleDropdown.selectedIndex].id;
         var _loc5_:Number = this.data.data?this.data.data.slot:-1;
         if(!isNaN(_loc2_) && !isNaN(_loc3_) && !isNaN(_loc5_) && (_loc4_))
         {
            buyTankmanS(_loc2_,_loc3_,_loc4_,this.studyType,_loc5_);
         }
      }

      private function recruitButtonCheck(param1:ListEvent) : void {
         this.btnRecruit.enabled = !(this.nationDropdown.selectedIndex == 0 || this.vehicleClassDropdown.selectedIndex == 0 || this.vehicleTypeDropdown.selectedIndex == 0 || this.roleDropdown.selectedIndex == 0);
      }
   }

}