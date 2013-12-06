package net.wg.gui.lobby.settings
{
   import net.wg.gui.components.advanced.ButtonBarEx;
   import flash.display.MovieClip;
   import net.wg.gui.components.common.VehicleMarkerEnemy;
   import net.wg.gui.components.common.VehicleMarkerAlly;
   import net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   import net.wg.gui.lobby.settings.evnts.SettingViewEvent;
   import net.wg.gui.components.common.markers.VehicleMarker;


   public class MarkerSettings extends SettingsBaseView
   {
          
      public function MarkerSettings() {
         this.markerAllyData =
            {
               "vClass":"heavyTank",
               "vIconSource":"../maps/icons/vehicle/contour/usa-T32.png",
               "vType":"T32",
               "vLevel":8,
               "pFullName":"Killer",
               "curHealth":1075,
               "maxHealth":1400,
               "entityName":"ally",
               "speaking":false,
               "hunt":false,
               "entityType":"ally"
            }
         ;
         this.markerEnemyData =
            {
               "vClass":"heavyTank",
               "vIconSource":"../maps/icons/vehicle/contour/germany-PzVI.png",
               "vType":"PzKpfw VI Tiger",
               "vLevel":7,
               "pFullName":"Killer",
               "curHealth":985,
               "maxHealth":1350,
               "entityName":"enemy",
               "speaking":false,
               "hunt":false,
               "entityType":"enemy"
            }
         ;
         this.markerDeadData =
            {
               "vClass":"heavyTank",
               "vIconSource":"../maps/icons/vehicle/contour/germany-E-75.png",
               "vType":"E-75",
               "vLevel":9,
               "pFullName":"Killer",
               "curHealth":0,
               "maxHealth":1920,
               "entityName":"ally",
               "speaking":false,
               "hunt":false,
               "entityType":"ally"
            }
         ;
         super();
      }

      public var tabs:ButtonBarEx = null;

      public var bg:MovieClip = null;

      public var enemyForm:SettingsMarkersForm = null;

      public var allyForm:SettingsMarkersForm = null;

      public var deadForm:SettingsMarkersForm = null;

      private const FORM:String = "Form";

      private var __currentTab:uint = 0;

      private var _dynamicMarkersData:Object = null;

      public var markerEnemy:VehicleMarkerEnemy = null;

      public var markerEnemyAlt:VehicleMarkerEnemy = null;

      public var markerAlly:VehicleMarkerAlly = null;

      public var markerAllyAlt:VehicleMarkerAlly = null;

      public var markerDead:VehicleMarkerAlly = null;

      public var markerDeadAlt:VehicleMarkerAlly = null;

      private var markerAllyData:Object;

      private var markerEnemyData:Object;

      private var markerDeadData:Object;

      override protected function configUI() : void {
         super.configUI();
         this.initMarkers();
      }

      private function initMarkers() : void {
         this.markerAlly.init(this.markerAllyData);
         this.markerAllyAlt.init(this.markerAllyData);
         this.markerEnemy.init(this.markerEnemyData);
         this.markerEnemyAlt.init(this.markerEnemyData);
         this.markerDead.init(this.markerDeadData);
         this.markerDeadAlt.init(this.markerDeadData);
         this.markerAlly.setMarkerState("normal");
         this.markerAllyAlt.setMarkerState("normal");
         this.markerEnemy.setMarkerState("normal");
         this.markerEnemyAlt.setMarkerState("normal");
         this.markerDead.setMarkerState("immediate_dead");
         this.markerDeadAlt.setMarkerState("immediate_dead");
         this.markerAllyAlt.exInfo = true;
         this.markerEnemyAlt.exInfo = true;
         this.markerDeadAlt.exInfo = true;
      }

      override public function update(param1:Object) : void {
         super.update(param1);
      }

      override protected function setData(param1:Object) : void {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:SettingsMarkersForm = null;
         super.setData(param1);
         this._dynamicMarkersData = {};
         for (_loc2_ in param1)
         {
            if(this[_loc2_ + this.FORM])
            {
               _loc4_ = SettingsMarkersForm(this[_loc2_ + this.FORM]);
               _loc4_.setData(_loc2_,param1[_loc2_]);
               _loc4_.addEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE,this.onControlChange);
            }
            for (_loc3_ in param1[_loc2_])
            {
               if(!this._dynamicMarkersData.hasOwnProperty(_loc2_))
               {
                  this._dynamicMarkersData[_loc2_] = {};
               }
               this._dynamicMarkersData[_loc2_][_loc3_] = SettingsControlProp(param1[_loc2_][_loc3_]).current;
            }
         }
         this.tabs.dataProvider = new DataProvider(SettingsConfig.markerTabsDataProvider);
         this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabChange);
         this.tabs.selectedIndex = this.__currentTab;
      }

      private function onControlChange(param1:SettingsSubVewEvent) : void {
         var _loc2_:String = param1.subViewId;
         var _loc3_:String = param1.controlId;
         var _loc4_:Object = {};
         _loc4_[_loc3_] = param1.controlValue;
         if(this._dynamicMarkersData != null)
         {
            this._dynamicMarkersData[_loc2_][param1.controlId] = param1.controlValue;
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc2_,_loc4_));
         this.updateShowContent();
      }

      override public function updateDependentData() : void {
         this.updateShowContent();
      }

      override public function dispose() : void {
         this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabChange);
         if(this.enemyForm.hasEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE))
         {
            this.enemyForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE,this.onControlChange);
         }
         if(this.allyForm.hasEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE))
         {
            this.allyForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE,this.onControlChange);
         }
         if(this.deadForm.hasEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE))
         {
            this.deadForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE,this.onControlChange);
         }
         this.enemyForm.dispose();
         this.allyForm.dispose();
         this.deadForm.dispose();
         this._dynamicMarkersData = null;
         super.dispose();
      }

      override public function toString() : String {
         return "[WG MarkerSettings " + name + "]";
      }

      private function onTabChange(param1:IndexEvent) : void {
         this.__currentTab = param1.index;
         this.updateShowContent();
      }

      private function updateShowContent() : void {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:* = NaN;
         var _loc6_:SettingsMarkersForm = null;
         var _loc7_:VehicleMarker = null;
         var _loc8_:VehicleMarker = null;
         var _loc1_:Number = 0;
         while(_loc1_ < SettingsConfig.markerTabsDataProvider.length)
         {
            _loc2_ = SettingsConfig.markerTabsDataProvider[_loc1_].formID;
            _loc3_ = SettingsConfig.markerTabsDataProvider[_loc1_].markerID;
            _loc4_ = SettingsConfig.markerTabsDataProvider[_loc1_].id;
            _loc5_ = SettingsConfig.markerTabsDataProvider[_loc1_].markerFlag;
            if(this[_loc2_])
            {
               _loc6_ = SettingsMarkersForm(this[_loc2_]);
               _loc6_.visible = this.__currentTab == _loc1_?true:false;
            }
            if(this[_loc3_])
            {
               _loc7_ = VehicleMarker(this[_loc3_]);
               _loc7_.visible = this.__currentTab == _loc1_?true:false;
               _loc7_.markerSettings = this._dynamicMarkersData[_loc4_];
               _loc7_.settingsUpdate(_loc5_);
            }
            if(this[_loc3_ + "Alt"])
            {
               _loc8_ = VehicleMarker(this[_loc3_ + "Alt"]);
               _loc8_.visible = this.__currentTab == _loc1_?true:false;
               _loc8_.markerSettings = this._dynamicMarkersData[_loc4_];
               _loc8_.settingsUpdate(_loc5_);
            }
            _loc1_++;
         }
         this.bg.gotoAndStop(SettingsConfig.markerTabsDataProvider[this.__currentTab].id);
      }
   }

}