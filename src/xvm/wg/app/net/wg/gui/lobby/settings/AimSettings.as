package net.wg.gui.lobby.settings
{
   import net.wg.gui.components.advanced.ButtonBarEx;
   import flash.display.MovieClip;
   import net.wg.gui.components.common.crosshair.ClipQuantityBar;
   import net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   import net.wg.gui.lobby.settings.evnts.SettingViewEvent;
   import net.wg.gui.components.common.crosshair.ReloadingTimer;
   
   public class AimSettings extends SettingsBaseView
   {
      
      public function AimSettings() {
         super();
      }
      
      public var tabs:ButtonBarEx = null;
      
      public var arcadeForm:SettingsAimForm = null;
      
      public var sniperForm:SettingsAimForm = null;
      
      public var crosshairMC:MovieClip = null;
      
      public var arcadeCursor:MovieClip = null;
      
      public var snipperCursor:MovieClip = null;
      
      private var __currentTab:uint = 0;
      
      private const FORM:String = "Form";
      
      private const GUN_TAG_TYPE:String = "gunTagType";
      
      private const GUN_TAG:String = "gunTag";
      
      private const MIXING_TYPE:String = "mixingType";
      
      private const MIXING:String = "mixing";
      
      private var cassete:ClipQuantityBar = null;
      
      private var snpCassete:ClipQuantityBar = null;
      
      private var _dynamicCursorsData:Object = null;
      
      private var _setDataInProgress:Boolean = false;
      
      override protected function configUI() : void {
         super.configUI();
         this.cassete = ClipQuantityBar.create(7,1);
         this.cassete.quantityInClip = 7;
         this.cassete.clipState = "normal";
         this.snpCassete = ClipQuantityBar.create(7,1);
         this.snpCassete.quantityInClip = 7;
         this.snpCassete.clipState = "normal";
         MovieClip(this.arcadeCursor.cassette).addChild(this.cassete);
         MovieClip(this.snipperCursor.cassette).addChild(this.snpCassete);
      }
      
      override public function update(param1:Object) : void {
         super.update(param1);
      }
      
      override protected function setData(param1:Object) : void {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:SettingsAimForm = null;
         super.setData(param1);
         this._dynamicCursorsData = {};
         this._setDataInProgress = true;
         for(_loc2_ in param1)
         {
            if(this[_loc2_ + this.FORM])
            {
               _loc4_ = SettingsAimForm(this[_loc2_ + this.FORM]);
               _loc4_.setData(_loc2_,param1[_loc2_]);
               _loc4_.addEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE,this.onControlChange);
            }
            for(_loc3_ in param1[_loc2_])
            {
               if(!this._dynamicCursorsData.hasOwnProperty(_loc2_))
               {
                  this._dynamicCursorsData[_loc2_] = {};
               }
               this._dynamicCursorsData[_loc2_][_loc3_] = SettingsControlProp(param1[_loc2_][_loc3_]).current?SettingsControlProp(param1[_loc2_][_loc3_]).current:0;
            }
         }
         this._setDataInProgress = false;
         this.tabs.dataProvider = new DataProvider(SettingsConfig.cursorTabsDataProvider);
         this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabChange);
         this.tabs.selectedIndex = this.__currentTab;
      }
      
      private function onControlChange(param1:SettingsSubVewEvent) : void {
         if(this._setDataInProgress)
         {
            return;
         }
         var _loc2_:String = param1.subViewId;
         var _loc3_:String = param1.controlId;
         var _loc4_:Object = {};
         _loc4_[_loc3_] = param1.controlValue;
         if(this._dynamicCursorsData != null)
         {
            this._dynamicCursorsData[_loc2_][param1.controlId] = param1.controlValue;
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc2_,_loc4_));
         this.updateCrosshairs(this.__currentTab);
      }
      
      private function onTabChange(param1:IndexEvent) : void {
         this.__currentTab = param1.index;
         this.updateShowContent();
      }
      
      private function updateShowContent() : void {
         var _loc3_:SettingsAimForm = null;
         var _loc4_:MovieClip = null;
         var _loc1_:uint = SettingsConfig.cursorTabsDataProvider.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = SettingsAimForm(this[SettingsConfig.cursorTabsDataProvider[_loc2_].formID]);
            _loc3_.visible = _loc3_.id == SettingsConfig.cursorTabsDataProvider[this.__currentTab].id?true:false;
            _loc4_ = MovieClip(this[SettingsConfig.cursorTabsDataProvider[_loc2_].crosshairID]);
            _loc4_.visible = _loc3_.visible;
            _loc2_++;
         }
         this.updateCrosshairs(this.__currentTab);
      }
      
      private function updateCrosshairs(param1:Number) : void {
         var _loc14_:ReloadingTimer = null;
         var _loc2_:String = SettingsConfig.cursorTabsDataProvider[param1].id;
         var _loc3_:Object = this._dynamicCursorsData[_loc2_];
         var _loc4_:Number = 0;
         var _loc5_:String = _loc3_["centralTagType"]?"type" + _loc3_["centralTagType"]:"type0";
         var _loc6_:Number = _loc3_["centralTag"]?_loc3_["centralTag"] / 100:0;
         var _loc7_:String = _loc3_["netType"]?"type" + _loc3_["netType"]:"type0";
         var _loc8_:Number = _loc3_["net"]?_loc3_["net"] / 100:0;
         var _loc9_:Number = _loc3_["reloader"]?_loc3_["reloader"] / 100:0;
         var _loc10_:Number = _loc3_["condition"]?_loc3_["condition"] / 100:0;
         var _loc11_:Number = _loc3_["cassette"]?_loc3_["cassette"] / 100:0;
         var _loc12_:Number = _loc3_["reloaderTimer"]?_loc3_["reloaderTimer"] / 100:0.0;
         var _loc13_:MovieClip = null;
         switch(param1)
         {
            case 0:
               _loc13_ = this.arcadeCursor;
               break;
            case 1:
               _loc13_ = this.snipperCursor;
               break;
         }
         if(_loc13_)
         {
            _loc13_.center.gotoAndStop(_loc5_);
            _loc13_.center.alpha = _loc6_;
            _loc13_.gotoAndStop(_loc7_);
            _loc13_.grid1.alpha = _loc8_;
            _loc13_.reloadingBarMC.alpha = _loc9_;
            _loc13_.universalBarMC.alpha = _loc10_;
            _loc13_.reloaderTimer.setup(_loc12_);
            _loc13_.cassette.alpha = _loc11_;
            switch(_loc13_.currentFrame)
            {
               case 1:
                  _loc4_ = -1;
                  break;
               case 2:
                  _loc4_ = 13;
                  break;
               case 3:
                  _loc4_ = -11;
                  break;
               default:
                  _loc4_ = 0;
            }
            _loc13_.cassette.y = _loc4_;
            _loc13_.targetMC.gotoAndStop(60);
            _loc13_.universalBarMC.gotoAndStop(60);
            _loc13_.reloadingBarMC.gotoAndStop(60);
            _loc14_ = _loc13_.reloaderTimer as ReloadingTimer;
            if(_loc14_)
            {
               _loc14_.updateTime(4.2,false);
            }
         }
         this.setCrossHair(this._dynamicCursorsData[_loc2_][this.GUN_TAG_TYPE],this._dynamicCursorsData[_loc2_][this.GUN_TAG],this._dynamicCursorsData[_loc2_][this.MIXING_TYPE],this._dynamicCursorsData[_loc2_][this.MIXING]);
      }
      
      private function setCrossHair(param1:String, param2:Number, param3:String, param4:Number) : void {
         this.crosshairMC.gotoAndStop(50);
         this.crosshairMC.markerMC.gotoAndStop("type" + param1);
         this.crosshairMC.markerMC.alpha = param2 / 100;
         this.crosshairMC.radiusMC.gotoAndStop("type" + param3);
         this.crosshairMC.radiusMC.mixingMC.gotoAndStop(37);
         this.crosshairMC.radiusMC.mixingMC.alpha = param4 / 100;
         this.crosshairMC.markerMC.tag.gotoAndStop("normal");
      }
      
      override protected function onDispose() : void {
         this._dynamicCursorsData = null;
         if((this.cassete) && (this.arcadeCursor))
         {
            MovieClip(this.arcadeCursor.cassette).removeChild(this.cassete);
         }
         if((this.snpCassete) && (this.snipperCursor))
         {
            MovieClip(this.snipperCursor.cassette).removeChild(this.snpCassete);
         }
         this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabChange);
         if(this.arcadeForm.hasEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE))
         {
            this.arcadeForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE,this.onControlChange);
         }
         if(this.sniperForm.hasEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE))
         {
            this.sniperForm.removeEventListener(SettingsSubVewEvent.ON_CONTROL_CHANGE,this.onControlChange);
         }
         super.onDispose();
      }
      
      override public function toString() : String {
         return "[WG AimSettings " + name + "]";
      }
   }
}
