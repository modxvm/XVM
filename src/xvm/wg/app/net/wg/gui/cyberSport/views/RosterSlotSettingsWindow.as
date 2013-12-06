package net.wg.gui.cyberSport.views
{
   import net.wg.infrastructure.base.meta.impl.RosterSlotSettingsWindowMeta;
   import net.wg.infrastructure.base.meta.IRosterSlotSettingsWindowMeta;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.text.TextField;
   import net.wg.gui.cyberSport.controls.CSVehicleButton;
   import net.wg.gui.cyberSport.controls.ButtonDnmIcon;
   import net.wg.gui.cyberSport.controls.SettingRosterVO;
   import net.wg.gui.cyberSport.controls.VehicleSelector;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.gui.components.windows.WindowEvent;
   import net.wg.gui.components.windows.Window;
   import net.wg.gui.cyberSport.vo.VehicleVO;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.events.ViewStackEvent;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.cyberSport.views.events.RosterSettingsEvent;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorEvent;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorFilterEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.gui.cyberSport.vo.VehicleSelectorFilterVO;


   public class RosterSlotSettingsWindow extends RosterSlotSettingsWindowMeta implements IRosterSlotSettingsWindowMeta
   {
          
      public function RosterSlotSettingsWindow() {
         this.viewStackData = [];
         super();
         isModal = true;
      }

      public var viewStack:ViewStack;

      public var buttonBar:ButtonBarEx;

      public var submitBtn:SoundButtonEx;

      public var cancelBtn:SoundButtonEx;

      public var selectedTxt:TextField;

      public var selectedResultBtn:CSVehicleButton;

      public var refreshBtn:ButtonDnmIcon;

      public var headerText:TextField;

      private var viewStackData:Array;

      private var rangeModel:SettingRosterVO;

      private var vehicleSelector:VehicleSelector;

      private var rangeRoster:RangeRosterSettingsView;

      private var listData:Array = null;

      private var defaultModel:Array;

      private var autoSelectTabIndex:int = 1;

      override public function set window(param1:IWindow) : void {
         if(window)
         {
            window.removeEventListener(WindowEvent.SCALE_X_CHANGED,this.onScaleChanged);
            window.removeEventListener(WindowEvent.SCALE_Y_CHANGED,this.onScaleChanged);
         }
         super.window = param1;
         if(window)
         {
            window.addEventListener(WindowEvent.SCALE_X_CHANGED,this.onScaleChanged);
            window.addEventListener(WindowEvent.SCALE_Y_CHANGED,this.onScaleChanged);
         }
      }

      private function onScaleChanged(param1:WindowEvent) : void {
         if(param1.type == WindowEvent.SCALE_X_CHANGED)
         {
            window.width = param1.prevValue;
         }
         else
         {
            window.height = param1.prevValue;
         }
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         Window(window).visible = false;
         showWindowBg = false;
         window.title = CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_TITLE;
      }

      public function as_setDefaultData(param1:Array) : void {
         this.defaultModel = param1;
         if((this.defaultModel[2]) && (this.defaultModel[2].hasOwnProperty("shortUserName")))
         {
            this.refreshBtnState(true);
            this.selectedResultBtn.setVehicle(new VehicleVO(this.defaultModel[2]));
            this.autoSelectTabIndex = 0;
         }
         else
         {
            if(this.defaultModel[2])
            {
               this.rangeModel = new SettingRosterVO(this.defaultModel[2]);
               this.autoSelectTabIndex = 1;
               if(this.rangeRoster)
               {
                  this.rangeRoster.setDefaultState(false);
                  this.rangeRoster.update(this.rangeModel);
               }
            }
            else
            {
               if(this.defaultModel[2] == null)
               {
                  this.selectedResultBtn.reset();
                  this.createDefaultRangeModel();
                  this.refreshBtnState(false);
                  if(this.rangeRoster)
                  {
                     this.rangeRoster.setDefaultState(false);
                  }
               }
            }
         }
         if((initialized) && !(this.defaultModel[2] == null))
         {
            this.buttonBar.selectedIndex = this.autoSelectTabIndex;
            this.viewStack.show(this.autoSelectTabIndex == 0?CYBER_SPORT_ALIASES.VEHICLE_SELECTOR_VIEW:CYBER_SPORT_ALIASES.RANGE_ROSTER_SETTINGS_VIEW);
         }
      }

      public function as_setListData(param1:Array) : void {
         var _loc2_:Object = null;
         var _loc3_:VehicleSelectorItemVO = null;
         if(param1)
         {
            this.listData = [];
            for each (_loc2_ in param1)
            {
               _loc3_ = new VehicleSelectorItemVO(_loc2_,true);
               this.listData.push(_loc3_);
            }
            if(initialized)
            {
               this.updateWindow(true);
            }
         }
         if(this.vehicleSelector)
         {
            this.vehicleSelector.setListItems(this.listData);
         }
      }

      override protected function configUI() : void {
         super.configUI();
         if(!this.rangeModel)
         {
            this.createDefaultRangeModel();
         }
         this.selectedResultBtn.mouseEnabled = false;
         this.selectedResultBtn.mouseChildren = false;
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.onClickSubmitBtnHandler);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.cancelBtn_buttonClickHandler);
         this.headerText.text = CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_VEHICLETAB_HEADERTEXT;
         this.selectedTxt.text = CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_BOTTOMRESULT;
         this.submitBtn.label = CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_VEHICLETAB_SUBMITBTN;
         this.cancelBtn.label = CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_VEHICLETAB_CANCELBTN;
         this.refreshBtn.addEventListener(ButtonEvent.CLICK,this.onClickrefreshBtnHandler);
         this.viewStack.addEventListener(ViewStackEvent.NEED_UPDATE,this.viewStackUpdateHandler);
         this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.viewStackChangedHandler);
         this.viewStack.targetGroup = "buttonBar";
         this.viewStack.cache = true;
         this.viewStackData = [
            {
               "label":CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_TABBTNLBL_VEHICLE,
               "linkage":CYBER_SPORT_ALIASES.VEHICLE_SELECTOR_VIEW
            }
         ,
            {
               "label":CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_TABBTNLBL_RANGE,
               "linkage":CYBER_SPORT_ALIASES.RANGE_ROSTER_SETTINGS_VIEW
            }
         ];
         this.buttonBar.dataProvider = new DataProvider(this.viewStackData);
         this.buttonBar.selectedIndex = this.autoSelectTabIndex;
         this.viewStack.show(this.autoSelectTabIndex == 0?CYBER_SPORT_ALIASES.VEHICLE_SELECTOR_VIEW:CYBER_SPORT_ALIASES.RANGE_ROSTER_SETTINGS_VIEW);
         this.selectedResultBtn.clickableAreaEnable = false;
         this.selectedTxt.mouseEnabled = false;
      }

      private function createDefaultRangeModel() : void {
         var _loc1_:Object = new Object();
         _loc1_.nationIDRange = [];
         _loc1_.vLevelRange = [];
         _loc1_.vTypeRange = [];
         this.rangeModel = new SettingRosterVO(_loc1_);
      }

      override protected function onDispose() : void {
         this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.onClickSubmitBtnHandler);
         this.submitBtn.dispose();
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.cancelBtn_buttonClickHandler);
         this.cancelBtn.dispose();
         this.refreshBtn.removeEventListener(ButtonEvent.CLICK,this.onClickrefreshBtnHandler);
         this.refreshBtn.dispose();
         this.viewStack.removeEventListener(ViewStackEvent.NEED_UPDATE,this.viewStackUpdateHandler);
         this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.viewStackChangedHandler);
         this.viewStack.dispose();
         if(this.rangeModel)
         {
            this.rangeModel.dispose();
            this.rangeModel = null;
         }
         if(this.selectedResultBtn)
         {
            this.selectedResultBtn.dispose();
            this.selectedResultBtn = null;
         }
         if(this.rangeRoster)
         {
            this.rangeRoster.removeEventListener(RosterSettingsEvent.RANGE_ROSTER_CHANGED,this.rangeChangedHandler);
            this.rangeRoster.dispose();
            this.rangeRoster = null;
         }
         if(this.vehicleSelector)
         {
            this.vehicleSelector.removeEventListener(VehicleSelectorEvent.SELECTION_CHANGED,this.vehicleSelectorHandler);
            this.vehicleSelector.removeEventListener(VehicleSelectorFilterEvent.CHANGE,this.onFiltersChanged);
            this.vehicleSelector.dispose();
            this.vehicleSelector = null;
         }
         if(this.listData)
         {
            while(this.listData.length > 0)
            {
               IDisposable(this.listData.shift()).dispose();
            }
            this.listData = null;
         }
         if(this.viewStackData)
         {
            this.viewStackData.splice(0,this.viewStackData.length);
            this.viewStackData = null;
         }
         if(this.buttonBar)
         {
            this.buttonBar.dispose();
            this.buttonBar = null;
         }
         super.onDispose();
      }

      private function viewStackUpdateHandler(param1:ViewStackEvent) : void {
         var _loc2_:Object = null;
         var _loc3_:VehicleSelectorFilterVO = null;
         if(param1.linkage == CYBER_SPORT_ALIASES.RANGE_ROSTER_SETTINGS_VIEW)
         {
            this.rangeRoster = param1.view as RangeRosterSettingsView;
            this.rangeRoster.update(this.rangeModel);
            this.rangeRoster.addEventListener(RosterSettingsEvent.RANGE_ROSTER_CHANGED,this.rangeChangedHandler);
         }
         else
         {
            if(param1.linkage == CYBER_SPORT_ALIASES.VEHICLE_SELECTOR_VIEW)
            {
               if(this.vehicleSelector)
               {
                  return;
               }
               this.vehicleSelector = param1.view as VehicleSelector;
               this.vehicleSelector.y = 90;
               this.vehicleSelector.x = 2;
               this.vehicleSelector.height = 205;
               this.vehicleSelector.invalidateSize();
               _loc2_ = getFilterDataS();
               _loc3_ = new VehicleSelectorFilterVO(_loc2_);
               this.vehicleSelector.setFiltersData(_loc3_);
               this.vehicleSelector.addEventListener(VehicleSelectorEvent.SELECTION_CHANGED,this.vehicleSelectorHandler);
               this.vehicleSelector.addEventListener(VehicleSelectorFilterEvent.CHANGE,this.onFiltersChanged);
               if(this.listData)
               {
                  this.vehicleSelector.setListItems(this.listData);
               }
            }
         }
      }

      private function onFiltersChanged(param1:VehicleSelectorFilterEvent) : void {
         onFiltersUpdateS(param1.nation,param1.vehicleType,param1.isMain,param1.level);
      }

      private function rangeChangedHandler(param1:RosterSettingsEvent) : void {
         this.rangeModel = param1.data as SettingRosterVO;
         this.refreshBtnState(!this.isDefaultRange());
         var _loc2_:Object = param1.data;
         this.selectedResultBtn.setRangeData(SettingRosterVO(_loc2_));
         this.updateWindow(true);
      }

      private function updateWindow(param1:Boolean) : void {
         if(Window(window).visible != param1)
         {
            Window(window).visible = param1;
         }
      }

      private function viewStackChangedHandler(param1:ViewStackEvent) : void {
          
      }

      private function onClickrefreshBtnHandler(param1:ButtonEvent) : void {
         if(this.selectedResultBtn.visible)
         {
            this.refreshBtnState(false);
         }
         this.setDefaultRange();
         this.selectedResultBtn.reset();
         if(this.rangeRoster)
         {
            this.rangeRoster.update(this.rangeModel);
         }
      }

      private function setDefaultRange() : void {
         this.rangeModel.vLevelRange = [];
         this.rangeModel.nationIDRange = [];
         this.rangeModel.vTypeRange = [];
      }

      private function isDefaultRange() : Boolean {
         if(this.rangeModel.nationIDRange.length == 0 && this.rangeModel.vTypeRange.length == 0)
         {
            if(this.rangeModel.vLevelRange.length == 0)
            {
               return true;
            }
         }
         return false;
      }

      private function refreshBtnState(param1:Boolean) : void {
         if(this.selectedResultBtn.visible != param1)
         {
            this.selectedResultBtn.visible = param1;
         }
      }

      private function vehicleSelectorHandler(param1:VehicleSelectorEvent) : void {
         if((param1.selectedDescriptors) && param1.selectedDescriptors.length > 0)
         {
            this.refreshBtnState(true);
            if(this.rangeRoster)
            {
               this.setDefaultRange();
               this.rangeRoster.setDefaultState(false);
            }
            this.selectedResultBtn.setVehicle(param1.selectedObjects[0]);
            if(param1.forceSelect)
            {
               this.onClickSubmitBtnHandler();
            }
         }
      }

      private function onClickSubmitBtnHandler(param1:ButtonEvent=null) : void {
         this.defaultModel[2] = this.selectedResultBtn.getModel();
         submitButtonHandlerS(this.defaultModel);
      }

      private function cancelBtn_buttonClickHandler(param1:ButtonEvent) : void {
         cancelButtonHandlerS();
      }
   }

}