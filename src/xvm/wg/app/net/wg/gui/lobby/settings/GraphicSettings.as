package net.wg.gui.lobby.settings
{
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.components.controls.DropdownMenu;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.Slider;
   import flash.events.Event;
   import scaleform.clik.events.SliderEvent;
   import scaleform.clik.events.ListEvent;
   import net.wg.gui.lobby.settings.components.SettingsStepSlider;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.components.controls.RangeSlider;
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.lobby.settings.evnts.SettingViewEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import net.wg.utils.ICommons;
   import net.wg.gui.components.controls.LabelControl;


   public class GraphicSettings extends GraphicSettingsBase
   {
          
      public function GraphicSettings() {
         this._onlyPresetsDP = [];
         this._presetsWithCustomDP = [];
         this._extendAdvancedControlsIds = [SettingsConfig.COLOR_GRADING_TECHNIQUE];
         this._imaginaryIdList = [SettingsConfig.CUSTOM_AA,SettingsConfig.MULTISAMPLING,SettingsConfig.WINDOW_SIZE,SettingsConfig.RESOLUTION,SettingsConfig.PRESETS,SettingsConfig.QUALITY_ORDER];
         super();
      }

      private var _graphicsQualityDataProv:Object = null;

      private var _qualityOrderIdList:Array = null;

      private var _isCustomPreset:Boolean = false;

      private var _onlyPresetsDP:Array;

      private var _presetsWithCustomDP:Array;

      private var _isAdvanced:Boolean = false;

      private var _presets:Object = null;

      private var _colorFilterPreviews:Object = null;

      private var _isInited:Boolean = false;

      private var _allowCheckPreset:Boolean = true;

      private var _extendAdvancedControls:Object;

      private var _extendAdvancedControlsIds:Array;

      private var _skipIdList:Array;

      private var skipDispatchPresetEvent:Boolean = false;

      private const _imaginaryIdList:Array;

      private var _initialFOVValues:Array = null;

      override public function update(param1:Object) : void {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         this._graphicsQualityDataProv = {};
         var _loc2_:Object = param1.data;
         this._qualityOrderIdList = _loc2_.qualityOrder;
         if(this._qualityOrderIdList  is  Array)
         {
            _loc3_ = this._qualityOrderIdList.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = this._qualityOrderIdList[_loc4_];
               if(_loc2_[_loc5_] != undefined)
               {
                  this._graphicsQualityDataProv[_loc5_] = SettingsControlProp(_loc2_[_loc5_]).clone();
               }
               _loc4_++;
            }
         }
         this._presets = param1.data.presets;
         super.update(param1);
      }

      override public function toString() : String {
         return "[WG GraphicSettings " + name + "]";
      }

      override public function updateDependentData() : void {
         if((SettingsConfig.liveUpdateVideoSettingsData) && (this._isInited))
         {
            this.initMonitors();
            this.updateLiveVideoData();
         }
      }

      public function rewriteInitialValues() : void {
         var _loc1_:SettingsControlProp = SettingsControlProp(_data[SettingsConfig.FOV]);
         this._initialFOVValues = [fovRangeSlider.value,fovRangeSlider.leftValue,fovRangeSlider.rightValue];
         _loc1_.current = this._initialFOVValues;
      }

      public function setPresetAfterAutoDetect(param1:Number) : void {
         var _loc2_:String = null;
         _loc2_ = SettingsConfig.GRAPHIC_QUALITY;
         var _loc3_:SettingsControlProp = SettingsControlProp(_data[_loc2_]);
         var _loc4_:DropdownMenu = this[_loc2_ + _loc3_.type];
         this._presets.current = param1;
         _loc3_.changedVal = this._presets.current;
         _loc4_.dataProvider = new DataProvider(_loc3_.options);
         this.updateDropDownEnabled(_loc2_);
         _loc4_.selectedIndex = this.getDPItemIndex(_loc4_.dataProvider,_loc3_.changedVal);
         autodetectQuality.enabled = true;
      }

      override protected function onDispose() : void {
         var _loc3_:String = null;
         var _loc4_:CheckBox = null;
         var _loc5_:Slider = null;
         var _loc6_:Slider = null;
         var _loc7_:DropdownMenu = null;
         var _loc8_:SettingsControlProp = null;
         if(_data)
         {
            _loc3_ = "";
            _loc4_ = null;
            _loc5_ = null;
            _loc6_ = null;
            _loc7_ = null;
            _loc8_ = null;
            for (_loc3_ in _data)
            {
               if(this._skipIdList.indexOf(_loc3_) >= 0)
               {
                  continue;
               }
               _loc8_ = SettingsControlProp(_data[_loc3_]);
               switch(_loc8_.type)
               {
                  case SettingsConfig.TYPE_CHECKBOX:
                     _loc4_ = this[_loc3_ + _loc8_.type];
                     _loc4_.removeEventListener(Event.SELECT,this.onCheckBoxChange);
                     continue;
                  case SettingsConfig.TYPE_SLIDER:
                     _loc5_ = this[_loc3_ + _loc8_.type];
                     _loc5_.removeEventListener(SliderEvent.VALUE_CHANGE,this.onSliderChanged);
                     continue;
                  case SettingsConfig.TYPE_RANGE_SLIDER:
                     _loc6_ = this[_loc3_ + _loc8_.type];
                     _loc6_.removeEventListener(SliderEvent.VALUE_CHANGE,this.onRangeSliderChanged);
                     continue;
                  case SettingsConfig.TYPE_DROPDOWN:
                     _loc7_ = this[_loc3_ + _loc8_.type];
                     _loc7_.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
                     continue;
                  default:
                     continue;
               }
            }
         }
         var _loc1_:SettingsStepSlider = null;
         _loc3_ = SettingsConfig.GRAPHIC_QUALITY;
         _loc8_ = SettingsControlProp(_data[_loc3_]);
         _loc7_ = this[_loc3_ + _loc8_.type];
         _loc7_.removeEventListener(ListEvent.INDEX_CHANGE,this.onGraphicsQualityChangePreset);
         _loc3_ = SettingsConfig.RENDER_PIPELINE;
         _loc8_ = SettingsControlProp(_data[_loc3_]);
         var _loc2_:ButtonBarEx = this[_loc3_ + _loc8_.type];
         _loc2_.removeEventListener(IndexEvent.INDEX_CHANGE,this.onGraphicsQualityChangeRenderPipeline);
         for (_loc3_ in this._graphicsQualityDataProv)
         {
            if(_loc3_ == SettingsConfig.RENDER_PIPELINE)
            {
               continue;
            }
            _loc8_ = SettingsControlProp(this._graphicsQualityDataProv[_loc3_]);
            switch(_loc8_.type)
            {
               case SettingsConfig.TYPE_CHECKBOX:
                  _loc4_ = this[_loc3_ + _loc8_.type];
                  _loc4_.removeEventListener(Event.SELECT,this.onCheckBoxOrderedChange);
                  continue;
               case SettingsConfig.TYPE_STEP_SLIDER:
                  _loc1_ = this[_loc3_ + _loc8_.type];
                  _loc1_.removeEventListener(SliderEvent.VALUE_CHANGE,this.onSliderOrderedChange);
                  continue;
               case SettingsConfig.TYPE_DROPDOWN:
                  _loc7_ = this[_loc3_ + _loc8_.type];
                  _loc7_.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownOrderedChange);
                  continue;
               default:
                  continue;
            }
         }
         while(this._graphicsQualityDataProv.length)
         {
            this._graphicsQualityDataProv.pop();
         }
         this._graphicsQualityDataProv = null;
         while(this._extendAdvancedControls.length)
         {
            this._extendAdvancedControls.pop();
         }
         this._extendAdvancedControls = null;
         this._presets = null;
         this._colorFilterPreviews = null;
         if(this._onlyPresetsDP)
         {
            this._onlyPresetsDP.splice(0);
            this._onlyPresetsDP = null;
         }
         if(this._presetsWithCustomDP)
         {
            this._presetsWithCustomDP.splice(0);
            this._presetsWithCustomDP = null;
         }
         autodetectQuality.removeEventListener(ButtonEvent.CLICK,this.onAutodetectPress);
         tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabChange);
         refreshRateDropDown.removeEventListener(ListEvent.INDEX_CHANGE,this.onRefreshRateDDChange);
         super.onDispose();
      }

      override protected function configUI() : void {
         super.configUI();
         graphicsQualityLabel.text = SETTINGS.GRAPHICSQUALITY;
         autodetectQuality.label = SETTINGS.AUTODETECTBUTTON;
         dynamicRendererLabel.text = SETTINGS.DYNAMICRENDERER;
         tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabChange);
         tabs.dataProvider = new DataProvider([{"label":SETTINGS.GRAPHICS_TABSCREEN},{"label":SETTINGS.GRAPHICS_TABADVANCED}]);
         this.updateCurrentTab();
         autodetectQuality.addEventListener(ButtonEvent.CLICK,this.onAutodetectPress);
      }

      private function onTabChange(param1:IndexEvent) : void {
         if(initialized)
         {
            this.updateCurrentTab();
         }
      }

      private function updateCurrentTab() : void {
         screenForm.visible = tabs.selectedIndex == 0;
         advancedForm.visible = !screenForm.visible;
      }

      override protected function setData(param1:Object) : void {
         this.setControlsData(param1);
      }

      private function setControlsData(param1:Object) : void {
         var _loc3_:String = null;
         var _loc4_:SettingsControlProp = null;
         var _loc5_:* = false;
         var _loc6_:CheckBox = null;
         var _loc7_:Slider = null;
         var _loc8_:RangeSlider = null;
         var _loc9_:DropdownMenu = null;
         this._skipIdList = [];
         this._extendAdvancedControls = {};
         var _loc2_:Array = [SettingsConfig.SMOOTHING,SettingsConfig.SIZE];
         this._skipIdList = this._qualityOrderIdList.slice(0);
         this._skipIdList = this._skipIdList.concat(this._imaginaryIdList);
         this._skipIdList = this._skipIdList.concat(_loc2_);
         this._skipIdList.push(SettingsConfig.GRAPHIC_QUALITY);
         this._skipIdList.push(SettingsConfig.COLOR_FILTER_IMAGES);
         this._skipIdList.push(SettingsConfig.REFRESH_RATE);
         for (_loc3_ in param1)
         {
            trySetLabel(_loc3_);
            if(this._skipIdList.indexOf(_loc3_) >= 0)
            {
               if(_loc3_ == SettingsConfig.COLOR_FILTER_IMAGES)
               {
                  this._colorFilterPreviews = _data[_loc3_];
               }
            }
            else
            {
               if((param1[_loc3_]) && !(this[_loc3_ + param1[_loc3_].type] == undefined))
               {
                  _loc4_ = SettingsControlProp(param1[_loc3_]);
                  _loc5_ = !(_loc4_.current == null || (_loc4_.readOnly));
                  if(this._extendAdvancedControlsIds.indexOf(_loc3_) >= 0)
                  {
                     this._extendAdvancedControls[_loc3_] = _loc4_.clone();
                  }
                  else
                  {
                     switch(_loc4_.type)
                     {
                        case SettingsConfig.TYPE_CHECKBOX:
                           _loc6_ = this[_loc3_ + _loc4_.type];
                           if(_loc6_.label == "")
                           {
                              _loc6_.label = SettingsConfig.LOCALIZATION + _loc3_;
                           }
                           _loc6_.selected = _loc4_.current;
                           _loc6_.addEventListener(Event.SELECT,this.onCheckBoxChange);
                           _loc6_.enabled = _loc5_;
                           if(_loc3_ == SettingsConfig.FULL_SCREEN)
                           {
                              _isFullScreen = _loc6_.selected;
                           }
                           else
                           {
                              if(_loc3_ == SettingsConfig.DYNAMIC_FOV)
                              {
                                 fovRangeSlider.rangeMode = _loc6_.selected;
                              }
                           }
                           break;
                        case SettingsConfig.TYPE_SLIDER:
                           _loc7_ = this[_loc3_ + _loc4_.type];
                           _loc7_.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderChanged);
                           _loc7_.value = _loc4_.current;
                           _loc7_.enabled = _loc5_;
                           break;
                        case SettingsConfig.TYPE_RANGE_SLIDER:
                           _loc8_ = this[_loc3_ + _loc4_.type];
                           _loc8_.addEventListener(SliderEvent.VALUE_CHANGE,this.onRangeSliderChanged);
                           this._initialFOVValues = _loc4_.current;
                           this.setInitialFOVValues();
                           _loc8_.enabled = _loc5_;
                           break;
                        case SettingsConfig.TYPE_DROPDOWN:
                           _loc9_ = this[_loc3_ + _loc4_.type];
                           _loc9_.dataProvider = new DataProvider(_loc4_.options);
                           _loc9_.selectedIndex = _loc4_.current;
                           _loc9_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
                           this.updateDropDownEnabled(_loc3_);
                           break;
                     }
                  }
               }
               else
               {
                  if(!_loc4_.readOnly && SettingsConfig.reservedImaginaryControls.indexOf(_loc3_) == -1)
                  {
                     DebugUtils.LOG_WARNING("ERROR in" + this + " control " + _loc3_ + " can not find");
                  }
               }
            }
         }
         this.initMonitors();
         this.updateFullScreenDependentControls();
         this.setSizeControl(false);
         this.initRefreshRateControl();
         this.updateRefreshRate();
         this._allowCheckPreset = false;
         this.setPresets();
         this.setRenderPipeline();
         this.updateAdvancedDependedControls();
         this._allowCheckPreset = true;
         this._isInited = true;
      }

      private function initMonitors() : void {
         var _loc1_:SettingsControlProp = SettingsControlProp(_data[SettingsConfig.MONITOR]);
         var _loc2_:Number = Number(_loc1_.changedVal);
         var _loc3_:uint = _loc1_.options  is  Array?_loc1_.options.length:0;
         var _loc4_:SettingsControlProp = SettingsControlProp(_data[SettingsConfig.RESOLUTION]);
         var _loc5_:SettingsControlProp = SettingsControlProp(_data[SettingsConfig.WINDOW_SIZE]);
         _loc4_.prevVal = [];
         _loc5_.prevVal = [];
         var _loc6_:Number = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_.prevVal[_loc6_] = _loc6_ == _loc2_?_loc4_.changedVal:0;
            _loc5_.prevVal[_loc6_] = _loc6_ == _loc2_?_loc5_.changedVal:0;
            _loc6_++;
         }
      }

      private function updateFullScreenDependentControls() : void {
         var _loc2_:String = null;
         var _loc3_:SettingsControlProp = null;
         var _loc4_:UIComponent = null;
         var _loc1_:Array = [SettingsConfig.ASPECTRATIO,SettingsConfig.REFRESH_RATE,SettingsConfig.GAMMA];
         for each (_loc2_ in _loc1_)
         {
            _loc3_ = SettingsControlProp(_data[_loc2_]);
            _loc4_ = this[_loc2_ + _loc3_.type];
            _loc4_.enabled = (_isFullScreen) && !(_loc3_.changedVal == null || (_loc3_.readOnly));
         }
      }

      private function setSizeControl(param1:Boolean=true) : void {
         var _loc2_:String = SettingsConfig.SIZE;
         var _loc3_:SettingsControlProp = SettingsControlProp(_data[_loc2_]);
         var _loc4_:DropdownMenu = this[_loc2_ + _loc3_.type];
         var _loc5_:String = _isFullScreen?SettingsConfig.RESOLUTION:SettingsConfig.WINDOW_SIZE;
         var _loc6_:SettingsControlProp = SettingsControlProp(_data[_loc5_]);
         sizesLabel.text = SettingsConfig.LOCALIZATION + _loc5_;
         var _loc7_:SettingsControlProp = SettingsControlProp(_data[SettingsConfig.MONITOR]);
         var _loc8_:Number = Number(_loc7_.changedVal);
         _loc3_.options = _loc6_.options[_loc8_];
         var _loc9_:Number = _loc6_.changedVal;
         if(param1)
         {
            _loc9_ = _loc3_.options.length-1;
            if(_loc4_.selectedIndex >= 0 && _loc4_.selectedIndex <= _loc4_.dataProvider.length)
            {
               _loc9_ = this.trySearchSameSizeForAnotherMonitor(_loc4_.dataProvider.requestItemAt(_loc4_.selectedIndex).toString(),_loc3_.options);
            }
         }
         _loc4_.dataProvider = new DataProvider(_loc3_.options);
         _loc4_.selectedIndex = _loc9_;
         this.updateDropDownEnabled(_loc2_);
         if(!this._isInited)
         {
            _loc3_.current = _loc9_;
            _loc4_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
         }
      }

      private function updateDropDownEnabled(param1:String) : void {
         var _loc2_:SettingsControlProp = SettingsControlProp(_data[param1]);
         var _loc3_:DropdownMenu = this[param1 + _loc2_.type];
         _loc3_.enabled = _loc3_.dataProvider.length > 1 && !_loc2_.readOnly;
      }

      private function setInitialFOVValues() : void {
         fovRangeSlider.value = this._initialFOVValues[0];
         fovRangeSlider.rightValue = this._initialFOVValues[2];
         fovRangeSlider.leftValue = this._initialFOVValues[1];
      }

      private function initRefreshRateControl() : void {
         refreshRateDropDown.addEventListener(ListEvent.INDEX_CHANGE,this.onRefreshRateDDChange);
      }

      private function onRefreshRateDDChange(param1:ListEvent=null) : void {
         var _loc2_:String = null;
         var _loc3_:SettingsControlProp = null;
         var _loc4_:DropdownMenu = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         if(_isFullScreen)
         {
            _loc2_ = SettingsConfig.REFRESH_RATE;
            _loc3_ = SettingsControlProp(_data[_loc2_]);
            _loc4_ = this[_loc2_ + _loc3_.type];
            _loc5_ = _loc3_.changedVal;
            _loc6_ = int(_loc4_.dataProvider.requestItemAt(_loc4_.selectedIndex));
            if(_loc5_ != _loc6_)
            {
               _loc3_.prevVal = _loc5_;
               _loc3_.changedVal = _loc6_;
               dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc2_,_loc6_));
            }
         }
      }

      private function updateRefreshRate(param1:Boolean=false) : void {
         var _loc7_:SettingsControlProp = null;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:Array = null;
         var _loc11_:* = NaN;
         var _loc2_:String = SettingsConfig.REFRESH_RATE;
         var _loc3_:SettingsControlProp = SettingsControlProp(_data[_loc2_]);
         var _loc4_:DropdownMenu = this[_loc2_ + _loc3_.type];
         if((SettingsConfig.liveUpdateVideoSettingsData[_loc2_]) && (param1))
         {
            _loc7_ = SettingsControlProp(SettingsConfig.liveUpdateVideoSettingsData[_loc2_]);
            _loc3_.options = App.utils.commons.cloneObject(_loc7_.options);
            _loc3_.current = _loc7_.current;
         }
         var _loc5_:* = _loc3_.changedVal;
         if(_isFullScreen)
         {
            _loc8_ = monitorDropDown.selectedIndex;
            _loc9_ = sizesDropDown.selectedIndex;
            _loc10_ = _loc3_.options[_loc8_][_loc9_];
            _loc4_.dataProvider = new DataProvider(_loc10_);
         }
         else
         {
            _loc4_.dataProvider = new DataProvider([SETTINGS.REFRESHRATE_DEFAULT]);
         }
         this.updateDropDownEnabled(_loc2_);
         var _loc6_:int = _loc4_.dataProvider.indexOf(_loc5_);
         if(_loc6_ == -1)
         {
            _loc11_ = this.getClosestRefreshRate(_loc5_,_loc4_.dataProvider);
            if(isNaN(_loc11_))
            {
               _loc4_.selectedIndex = _loc4_.dataProvider.length-1;
            }
            else
            {
               _loc4_.selectedIndex = _loc4_.dataProvider.indexOf(_loc11_);
            }
         }
         else
         {
            _loc4_.selectedIndex = _loc6_;
         }
         this.onRefreshRateDDChange();
      }

      private function getClosestRefreshRate(param1:int, param2:IDataProvider) : Number {
         var _loc5_:* = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:* = 0;
         while(_loc4_ < param2.length)
         {
            _loc5_ = param2.requestItemAt(_loc4_) as Number;
            if(_loc5_ > param1 && (isNaN(_loc3_)?true:_loc5_ < _loc3_))
            {
               _loc3_ = _loc5_;
            }
            _loc4_++;
         }
         return _loc3_;
      }

      private function setPresets() : void {
         var _loc4_:* = 0;
         var _loc6_:String = null;
         var _loc7_:* = 0;
         var _loc8_:Object = null;
         var _loc9_:* = 0;
         var _loc1_:String = SettingsConfig.GRAPHIC_QUALITY;
         var _loc2_:SettingsControlProp = SettingsControlProp(_data[_loc1_]);
         var _loc3_:DropdownMenu = this[_loc1_ + _loc2_.type];
         this._onlyPresetsDP = [];
         this._presetsWithCustomDP = [];
         var _loc5_:* = "";
         for (_loc5_ in this._presets.options)
         {
            _loc7_ = this._presets.options[_loc5_].index;
            _loc6_ = this._presets.options[_loc5_].key;
            _loc8_ =
               {
                  "label":SETTINGS.graphicssettingsoptions(_loc6_),
                  "settings":this._presets.options[_loc5_].settings,
                  "key":_loc6_,
                  "data":_loc7_
               }
            ;
            this._presetsWithCustomDP.push(_loc8_);
            if(_loc6_ == SettingsConfig.CUSTOM)
            {
               this._isCustomPreset = _loc7_ == this._presets.current;
               _loc4_ = _loc7_;
            }
            else
            {
               this._onlyPresetsDP.push(_loc8_);
            }
         }
         _loc2_.changedVal = this._presets.current;
         _loc2_.options = new DataProvider(this._presetsWithCustomDP);
         _loc9_ = this.getDPItemIndex(_loc2_.options as IDataProvider,_loc2_.changedVal);
         if(_loc9_ == -1)
         {
            this._isCustomPreset = true;
            this.updatePresetsDP();
            _loc2_.current = _loc4_;
            _loc9_ = this.getDPItemIndex(_loc3_.dataProvider,_loc4_);
         }
         else
         {
            this.updatePresetsDP();
         }
         _loc3_.selectedIndex = _loc9_;
         _loc3_.addEventListener(ListEvent.INDEX_CHANGE,this.onGraphicsQualityChangePreset);
      }

      private function setRenderPipeline() : void {
         var _loc2_:SettingsControlProp = null;
         var _loc3_:* = false;
         var _loc4_:ButtonBarEx = null;
         var _loc1_:String = SettingsConfig.RENDER_PIPELINE;
         if((_data[_loc1_]) && !(this[_loc1_ + _data[_loc1_].type] == undefined))
         {
            _loc2_ = SettingsControlProp(_data[_loc1_]);
            _loc3_ = !(_loc2_.changedVal == null || (_loc2_.readOnly));
            _loc4_ = this[_loc1_ + _loc2_.type];
            _loc4_.dataProvider = new DataProvider(_loc2_.options);
            _loc4_.selectedIndex = this.getDPItemIndex(_loc4_.dataProvider,_loc2_.changedVal);
            _loc4_.enabled = _loc3_;
            this._isAdvanced = _loc4_.selectedItem["data"] == SettingsConfig.ADVANCED_GRAPHICS_DATA;
            _loc4_.addEventListener(IndexEvent.INDEX_CHANGE,this.onGraphicsQualityChangeRenderPipeline);
         }
      }

      private function getDPItemIndex(param1:IDataProvider, param2:*, param3:String="data") : int {
         var _loc5_:Object = null;
         var _loc4_:* = -1;
         for each (_loc5_ in param1)
         {
            if((_loc5_.hasOwnProperty(param3)) && _loc5_[param3] == param2)
            {
               _loc4_ = param1.indexOf(_loc5_);
               break;
            }
         }
         return _loc4_;
      }

      private function updateAdvancedDependedControls() : void {
         this.updateDataProviderForQuality();
         this.updateQualityControls();
         this.updateExtendedAdvancedControls();
         this.updateSmoothingControl();
      }

      private function updateDataProviderForQuality() : void {
         var _loc1_:String = null;
         var _loc2_:SettingsControlProp = null;
         var _loc3_:SettingsStepSlider = null;
         var _loc4_:String = null;
         _loc1_ = "";
         for (_loc1_ in this._graphicsQualityDataProv)
         {
            if(_loc1_ == SettingsConfig.RENDER_PIPELINE)
            {
               continue;
            }
            _loc2_ = SettingsControlProp(this._graphicsQualityDataProv[_loc1_]);
            switch(_loc2_.type)
            {
               case SettingsConfig.TYPE_CHECKBOX:
                  continue;
               case SettingsConfig.TYPE_SLIDER:
                  continue;
               case SettingsConfig.TYPE_STEP_SLIDER:
                  _loc3_ = this[_loc1_ + _loc2_.type];
                  _loc3_.inAdvancedMode = this._isAdvanced;
                  continue;
               case SettingsConfig.TYPE_DROPDOWN:
                  _loc2_.options = new Array();
                  for (_loc4_ in _data[_loc1_].options)
                  {
                     if((this._isAdvanced) || !_data[_loc1_].options[_loc4_].advanced)
                     {
                        _loc2_.options.push(SettingsControlProp(_data[_loc1_]).options[_loc4_]);
                     }
                  }
                  continue;
               default:
                  continue;
            }
         }
      }

      private function updateQualityControls() : void {
         var _loc1_:String = null;
         var _loc2_:SettingsControlProp = null;
         for (_loc1_ in this._graphicsQualityDataProv)
         {
            if(_loc1_ != SettingsConfig.RENDER_PIPELINE)
            {
               if(this[_loc1_ + SettingsControlProp(this._graphicsQualityDataProv[_loc1_]).type])
               {
                  _loc2_ = SettingsControlProp(this._graphicsQualityDataProv[_loc1_]);
                  this.updateAdvancedQualityControl(_loc1_,_loc2_);
               }
            }
         }
      }

      private function updateAdvancedQualityControl(param1:String, param2:SettingsControlProp) : void {
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:uint = 0;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc9_:CheckBox = null;
         var _loc10_:* = false;
         var _loc11_:SettingsStepSlider = null;
         var _loc12_:DropdownMenu = null;
         var _loc8_:uint = 0;
         switch(param2.type)
         {
            case SettingsConfig.TYPE_CHECKBOX:
               _loc9_ = this[param1 + param2.type];
               _loc10_ = param2.changedVal;
               _loc9_.selected = (_loc10_) && ((this._isAdvanced) || !param2.advanced);
               _loc9_.enabled = Boolean((this._isAdvanced) || (!param2.advanced));
               if(_loc10_ != _loc9_.selected)
               {
                  param2.changedVal = _loc9_.selected;
                  dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,param1,_loc9_.selected));
               }
               if(!this._isInited)
               {
                  _loc9_.addEventListener(Event.SELECT,this.onCheckBoxOrderedChange);
               }
               break;
            case SettingsConfig.TYPE_STEP_SLIDER:
               _loc11_ = this[param1 + param2.type];
               _loc3_ = param2.changedVal;
               _loc4_ = -1;
               _loc5_ = param2.options.length;
               _loc8_ = 0;
               while(_loc8_ < _loc5_)
               {
                  if(param2.options[_loc8_].data == _loc3_)
                  {
                     _loc4_ = _loc8_;
                     break;
                  }
                  _loc8_++;
               }
               _loc11_.dataProvider = new DataProvider(param2.options);
               _loc11_.inAdvancedMode = this._isAdvanced;
               _loc11_.validateNow();
               _loc6_ = _loc11_.value;
               _loc11_.value = _loc4_ != -1?_loc4_:0;
               _loc7_ = param2.options[_loc11_.value].data;
               if(_loc6_ == _loc11_.value)
               {
                  if(param2.prevVal != _loc7_)
                  {
                     param2.prevVal = param2.changedVal;
                     dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,param1,_loc7_));
                  }
               }
               param2.changedVal = _loc7_;
               if(!this._isInited)
               {
                  _loc11_.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderOrderedChange);
               }
               break;
            case SettingsConfig.TYPE_DROPDOWN:
               _loc12_ = this[param1 + param2.type];
               _loc3_ = param2.changedVal;
               _loc4_ = -1;
               _loc5_ = param2.options.length;
               _loc8_ = 0;
               while(_loc8_ < _loc5_)
               {
                  if(param2.options[_loc8_].data == _loc3_)
                  {
                     _loc4_ = _loc8_;
                     break;
                  }
                  _loc8_++;
               }
               _loc12_.menuRowCount = param2.options.length <= 7?param2.options.length:7;
               _loc12_.dataProvider = new DataProvider(param2.options);
               _loc6_ = _loc12_.selectedIndex;
               _loc12_.selectedIndex = _loc4_ != -1?_loc4_:0;
               _loc7_ = param2.options[_loc12_.selectedIndex].data;
               if(_loc6_ == _loc12_.selectedIndex)
               {
                  if(param2.prevVal != _loc7_)
                  {
                     param2.prevVal = param2.changedVal;
                     dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,param1,_loc7_));
                  }
               }
               param2.changedVal = _loc7_;
               this.updateDropDownEnabled(param1);
               if(!this._isInited)
               {
                  if(param1 == SettingsConfig.COLOR_GRADING_TECHNIQUE)
                  {
                     this.updateColorFilterPreview(_loc7_);
                  }
                  _loc12_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownOrderedChange);
               }
               break;
         }
      }

      private function updateExtendedAdvancedControls() : void {
         var _loc1_:SettingsControlProp = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(this._extendAdvancedControls)
         {
            for (_loc2_ in this._extendAdvancedControls)
            {
               _loc1_ = SettingsControlProp(this._extendAdvancedControls[_loc2_]);
               _loc1_.options = [];
               for (_loc3_ in SettingsControlProp(_data[_loc2_]).options)
               {
                  if((this._isAdvanced) || !_data[_loc2_].options[_loc3_].advanced)
                  {
                     _loc1_.options.push(SettingsControlProp(_data[_loc2_]).options[_loc3_]);
                  }
               }
               this.updateAdvancedQualityControl(_loc2_,_loc1_);
            }
         }
      }

      private function updateSmoothingControl() : void {
         var _loc4_:DropdownMenu = null;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc1_:String = this._isAdvanced?SettingsConfig.CUSTOM_AA:SettingsConfig.MULTISAMPLING;
         var _loc2_:SettingsControlProp = SettingsControlProp(_data[SettingsConfig.SMOOTHING]);
         var _loc3_:SettingsControlProp = SettingsControlProp(_data[_loc1_]);
         _loc2_.options = _loc3_.options;
         if(this[SettingsConfig.SMOOTHING + _loc2_.type])
         {
            _loc4_ = this[SettingsConfig.SMOOTHING + _loc2_.type];
            _loc5_ = _loc2_.changedVal;
            _loc4_.enabled = (_loc2_.options) && _loc2_.options.length > 0;
            _loc4_.dataProvider = new DataProvider(_loc2_.options);
            this.updateDropDownEnabled(SettingsConfig.SMOOTHING);
            _loc6_ = _loc3_.prevVal >= 0 && _loc3_.prevVal < _loc2_.options.length?_loc3_.prevVal:0;
            if(!this._isInited)
            {
               _loc2_.current = _loc6_;
            }
            if(!(_loc5_ == _loc6_) || !this._isInited)
            {
               _loc4_.selectedIndex = _loc6_;
            }
            if(!this._isInited)
            {
               _loc4_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
            }
         }
      }

      private function updateCurrentPropForGraphicsOrderInPreset(param1:Object) : void {
         var _loc2_:String = null;
         var _loc3_:SettingsControlProp = null;
         for (_loc2_ in param1)
         {
            if(_loc2_ != SettingsConfig.RENDER_PIPELINE)
            {
               if(this._qualityOrderIdList.indexOf(_loc2_) >= 0)
               {
                  _loc3_ = SettingsControlProp(this._graphicsQualityDataProv[_loc2_]);
                  _loc3_.changedVal = _loc3_.type == SettingsConfig.TYPE_CHECKBOX?Boolean(param1[_loc2_]):Number(param1[_loc2_]);
               }
               else
               {
                  DebugUtils.LOG_WARNING("TRY SET DATA USE PRESET FOR CONTROL:",_loc2_);
               }
            }
         }
      }

      private function updateLiveVideoData() : void {
         var _loc6_:String = null;
         var _loc7_:SettingsControlProp = null;
         var _loc9_:SettingsControlProp = null;
         var _loc10_:String = null;
         var _loc11_:SettingsControlProp = null;
         var _loc12_:* = NaN;
         var _loc1_:CheckBox = null;
         var _loc2_:DropdownMenu = null;
         var _loc3_:Slider = null;
         var _loc4_:uint = 0;
         _loc4_ = SettingsConfig.liveUpdateVideoSettingsOrderData.length;
         var _loc5_:ICommons = App.utils.commons;
         var _loc8_:uint = 0;
         while(_loc8_ < _loc4_)
         {
            _loc6_ = SettingsConfig.liveUpdateVideoSettingsOrderData[_loc8_];
            _loc7_ = SettingsControlProp(_data[_loc6_]);
            if(SettingsConfig.liveUpdateVideoSettingsData[_loc6_])
            {
               _loc9_ = SettingsControlProp(SettingsConfig.liveUpdateVideoSettingsData[_loc6_]);
               _loc7_.options = _loc5_.cloneObject(_loc9_.options);
               _loc7_.current = _loc9_.current;
            }
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc6_ = SettingsConfig.liveUpdateVideoSettingsOrderData[_loc8_];
            _loc7_ = SettingsControlProp(_data[_loc6_]);
            if((_loc7_) && (this[_loc6_ + _loc7_.type]))
            {
               switch(_loc7_.type)
               {
                  case SettingsConfig.TYPE_CHECKBOX:
                     _loc1_ = CheckBox(this[_loc6_ + _loc7_.type]);
                     _loc1_.selected = Boolean(_loc7_.changedVal);
                     break;
                  case SettingsConfig.TYPE_SLIDER:
                     if(SettingsConfig.liveUpdateVideoSettingsData[_loc6_])
                     {
                        _loc3_ = Slider(this[_loc6_ + _loc7_.type]);
                        _loc3_.value = _loc7_.changedVal;
                     }
                     break;
                  case SettingsConfig.TYPE_DROPDOWN:
                     _loc2_ = DropdownMenu(this[_loc6_ + _loc7_.type]);
                     if(_loc6_ == SettingsConfig.SIZE)
                     {
                        _loc10_ = _isFullScreen?SettingsConfig.RESOLUTION:SettingsConfig.WINDOW_SIZE;
                        _loc11_ = SettingsControlProp(SettingsConfig.liveUpdateVideoSettingsData[_loc10_]);
                        if((_loc11_) && _loc11_.options  is  Array)
                        {
                           _loc12_ = monitorDropDown.selectedIndex;
                           SettingsControlProp(_data[_loc10_]).prevVal[_loc12_] = _loc11_.changedVal;
                           _loc2_.dataProvider = new DataProvider(_loc11_.options[_loc12_]);
                           _loc2_.selectedIndex = _loc11_.changedVal;
                           _loc2_.enabled = _loc2_.dataProvider.length > 1;
                        }
                     }
                     else
                     {
                        if(_loc6_ == SettingsConfig.REFRESH_RATE)
                        {
                           this.updateRefreshRate(true);
                        }
                        else
                        {
                           _loc2_.dataProvider = new DataProvider(_loc7_.options);
                           _loc2_.selectedIndex = _loc7_.changedVal;
                           this.updateDropDownEnabled(_loc6_);
                        }
                     }
                     break;
               }
            }
            _loc8_++;
         }
      }

      private function tryFindPreset() : void {
         var _loc1_:Array = null;
         var _loc2_:* = NaN;
         var _loc3_:SettingsControlProp = null;
         var _loc4_:* = NaN;
         var _loc5_:String = null;
         var _loc6_:* = NaN;
         var _loc7_:* = false;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:DropdownMenu = null;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         if(this._allowCheckPreset)
         {
            _loc1_ = this._presets.options;
            _loc2_ = _loc1_.length;
            _loc3_ = null;
            _loc4_ = -1;
            _loc5_ = "";
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc7_ = true;
               for (_loc5_ in _loc1_[_loc6_].settings)
               {
                  _loc8_ = _loc1_[_loc6_].settings[_loc5_];
                  _loc3_ = SettingsControlProp(this._graphicsQualityDataProv[_loc5_]);
                  _loc9_ = Number(_loc3_.changedVal);
                  if(_loc8_ != _loc9_)
                  {
                     _loc7_ = false;
                     break;
                  }
               }
               if(_loc7_)
               {
                  this._isCustomPreset = _loc1_[_loc6_].key == SettingsConfig.CUSTOM;
                  _loc4_ = _loc1_[_loc6_].index;
                  break;
               }
               _loc6_++;
            }
            if(_loc4_ >= 0)
            {
               _loc5_ = SettingsConfig.GRAPHIC_QUALITY;
               _loc3_ = SettingsControlProp(_data[_loc5_]);
               _loc10_ = this[_loc5_ + _loc3_.type];
               this.updatePresetsDP();
               _loc11_ = _loc10_.selectedIndex;
               _loc12_ = this.getDPItemIndex(_loc10_.dataProvider,_loc4_);
               if(_loc11_ != _loc12_)
               {
                  this.skipDispatchPresetEvent = true;
                  _loc10_.selectedIndex = _loc12_;
               }
            }
         }
      }

      private function updatePresetsDP() : void {
         var _loc1_:String = SettingsConfig.GRAPHIC_QUALITY;
         var _loc2_:SettingsControlProp = SettingsControlProp(_data[_loc1_]);
         var _loc3_:DropdownMenu = this[_loc1_ + _loc2_.type];
         _loc3_.dataProvider = new DataProvider(this._isCustomPreset?this._presetsWithCustomDP:this._onlyPresetsDP);
         this.updateDropDownEnabled(_loc1_);
      }

      private function trySearchSameSizeForAnotherMonitor(param1:String, param2:Array) : Number {
         var _loc3_:RegExp = new RegExp("\\*","g");
         var param1:String = param1.replace(_loc3_,"");
         var _loc4_:Number = param2.indexOf(param1);
         return _loc4_ == -1?param2.length-1:_loc4_;
      }

      private function onGraphicsQualityChangePreset(param1:ListEvent) : void {
         var _loc5_:SettingsControlProp = null;
         var _loc6_:ButtonBarEx = null;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = 0;
         var _loc10_:Object = null;
         var _loc11_:* = false;
         this._allowCheckPreset = false;
         var _loc2_:Object = param1.itemData;
         var _loc3_:String = _loc2_.key;
         this._presets.current = _loc2_.index;
         this._isCustomPreset = _loc3_ == SettingsConfig.CUSTOM;
         this.updatePresetsDP();
         if((this.skipDispatchPresetEvent) || (this._isCustomPreset))
         {
            this.skipDispatchPresetEvent = false;
            this._allowCheckPreset = true;
            return;
         }
         this.updateCurrentPropForGraphicsOrderInPreset(_loc2_.settings);
         var _loc4_:String = SettingsConfig.RENDER_PIPELINE;
         if((_data[_loc4_]) && !(this[_loc4_ + _data[_loc4_].type] == undefined))
         {
            _loc5_ = SettingsControlProp(_data[_loc4_]);
            _loc6_ = this[_loc4_ + _loc5_.type];
            _loc7_ = _loc6_.selectedItem["data"];
            _loc8_ = _loc2_.settings[SettingsConfig.RENDER_PIPELINE];
            if(_loc7_ != _loc8_)
            {
               _loc9_ = this.getDPItemIndex(_loc6_.dataProvider,_loc8_);
               if(_loc9_ != -1)
               {
                  _loc10_ = _loc6_.dataProvider.requestItemAt(_loc9_);
                  _loc11_ = _loc10_.hasOwnProperty("supported")?_loc10_["supported"]:true;
                  _loc6_.selectedIndex = _loc9_;
               }
            }
            else
            {
               this.updateAdvancedDependedControls();
            }
         }
         this._allowCheckPreset = true;
      }

      private function onGraphicsQualityChangeRenderPipeline(param1:IndexEvent) : void {
         var _loc2_:Number = param1.index;
         var _loc3_:ButtonBarEx = ButtonBarEx(param1.target);
         var _loc4_:String = SettingsConfig.getControlId(_loc3_.name,SettingsConfig.TYPE_BUTTON_BAR);
         var _loc5_:SettingsControlProp = SettingsControlProp(this._graphicsQualityDataProv[_loc4_]);
         var _loc6_:Number = _loc5_.options[_loc2_].data;
         var _loc7_:Boolean = this._isAdvanced;
         this._isAdvanced = _loc3_.selectedItem["data"] == SettingsConfig.ADVANCED_GRAPHICS_DATA;
         var _loc8_:Number = _loc5_.changedVal;
         _loc5_.prevVal = _loc8_;
         _loc5_.changedVal = _loc6_;
         if(this._isAdvanced != _loc7_)
         {
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc4_,_loc6_));
            this.updateAdvancedDependedControls();
         }
         this.tryFindPreset();
      }

      private function onDropDownChange(param1:ListEvent) : void {
         var _loc7_:String = null;
         var _loc8_:* = NaN;
         var _loc2_:DropdownMenu = DropdownMenu(param1.target);
         var _loc3_:Number = param1.index;
         var _loc4_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_DROPDOWN);
         var _loc5_:SettingsControlProp = SettingsControlProp(_data[_loc4_]);
         var _loc6_:Number = _loc5_.changedVal;
         _loc5_.changedVal = _loc3_;
         if(_loc4_ == SettingsConfig.SMOOTHING)
         {
            _loc7_ = this._isAdvanced?SettingsConfig.CUSTOM_AA:SettingsConfig.MULTISAMPLING;
            _loc5_ = SettingsControlProp(_data[_loc7_]);
            _loc5_.changedVal = _loc3_;
            _loc5_.prevVal = _loc3_;
         }
         else
         {
            if(_loc4_ == SettingsConfig.SIZE)
            {
               _loc4_ = _isFullScreen?SettingsConfig.RESOLUTION:SettingsConfig.WINDOW_SIZE;
               _loc5_ = SettingsControlProp(_data[_loc4_]);
               _loc5_.changedVal = _loc3_;
               _loc8_ = monitorDropDown.selectedIndex;
               _loc5_.prevVal[_loc8_] = _loc3_;
               this.updateRefreshRate();
            }
            else
            {
               _loc5_.prevVal = _loc3_;
            }
         }
         if(_loc4_ == SettingsConfig.MONITOR)
         {
            this.setSizeControl();
            this.updateRefreshRate();
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc4_,_loc3_));
      }

      private function onRangeSliderChanged(param1:SliderEvent) : void {
         var _loc2_:RangeSlider = RangeSlider(param1.target);
         var _loc3_:String = SettingsConfig.getControlId(RangeSlider(param1.target).name,SettingsConfig.TYPE_RANGE_SLIDER);
         var _loc4_:SettingsControlProp = SettingsControlProp(_data[_loc3_]);
         var _loc5_:Array = [_loc2_.value,_loc2_.leftValue,_loc2_.rightValue];
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,_loc5_));
      }

      private function onSliderChanged(param1:SliderEvent) : void {
         var _loc5_:LabelControl = null;
         var _loc6_:String = null;
         var _loc2_:Slider = Slider(param1.target);
         var _loc3_:String = SettingsConfig.getControlId(Slider(param1.target).name,SettingsConfig.TYPE_SLIDER);
         var _loc4_:SettingsControlProp = SettingsControlProp(_data[_loc3_]);
         if((_loc4_.hasValue) && (this[_loc3_ + SettingsConfig.TYPE_VALUE]))
         {
            _loc5_ = this[_loc3_ + SettingsConfig.TYPE_VALUE];
            _loc6_ = "";
            if(_loc3_ == SettingsConfig.DYNAMIC_RENDERER || _loc3_ == SettingsConfig.COLOR_FILTER_INTENSITY)
            {
               _loc6_ = "%";
            }
            _loc5_.text = _loc2_.value.toString() + _loc6_;
         }
         if(_loc3_ == SettingsConfig.COLOR_FILTER_INTENSITY)
         {
            colorFilterOverlayImg.alpha = _loc2_.value / 100;
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,Slider(param1.target).value));
      }

      private function onCheckBoxChange(param1:Event) : void {
         var _loc2_:CheckBox = CheckBox(param1.target);
         var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_CHECKBOX);
         if(_loc3_ == SettingsConfig.FULL_SCREEN)
         {
            _isFullScreen = _loc2_.selected;
            this.updateFullScreenDependentControls();
            this.setSizeControl(false);
            this.updateRefreshRate();
         }
         else
         {
            if(_loc3_ == SettingsConfig.DYNAMIC_FOV)
            {
               fovRangeSlider.rangeMode = _loc2_.selected;
               this.setInitialFOVValues();
            }
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,_loc2_.selected));
      }

      private function onCheckBoxOrderedChange(param1:Event) : void {
         var _loc2_:CheckBox = CheckBox(param1.target);
         var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_CHECKBOX);
         var _loc4_:SettingsControlProp = SettingsControlProp(this._graphicsQualityDataProv[_loc3_]);
         _loc4_.changedVal = _loc2_.selected;
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,_loc2_.selected));
         this.tryFindPreset();
      }

      private function onDropDownOrderedChange(param1:ListEvent) : void {
         var _loc2_:DropdownMenu = DropdownMenu(param1.target);
         var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_DROPDOWN);
         var _loc4_:SettingsControlProp = null;
         if(this._extendAdvancedControlsIds.indexOf(_loc3_) >= 0)
         {
            _loc4_ = SettingsControlProp(this._extendAdvancedControls[_loc3_]);
         }
         else
         {
            _loc4_ = SettingsControlProp(this._graphicsQualityDataProv[_loc3_]);
         }
         var _loc5_:Number = _loc4_.options[param1.index].data;
         var _loc6_:Number = _loc4_.changedVal;
         _loc4_.prevVal = _loc6_;
         _loc4_.changedVal = _loc5_;
         if(_loc3_ == SettingsConfig.COLOR_GRADING_TECHNIQUE)
         {
            this.updateColorFilterPreview(_loc5_);
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,_loc5_));
         this.tryFindPreset();
      }

      private function updateColorFilterPreview(param1:int) : void {
         colorFilterOverlayImg.source = this._colorFilterPreviews[param1];
         colorFilterIntensitySlider.enabled = !(param1 == SettingsConfig.NO_COLOR_FILTER_DATA);
         colorFilterIntensityValue.visible = !(param1 == SettingsConfig.NO_COLOR_FILTER_DATA);
      }

      private function onSliderOrderedChange(param1:SliderEvent) : void {
         var _loc2_:SettingsStepSlider = SettingsStepSlider(param1.target);
         var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_STEP_SLIDER);
         var _loc4_:SettingsControlProp = null;
         if(this._extendAdvancedControlsIds.indexOf(_loc3_) >= 0)
         {
            _loc4_ = SettingsControlProp(this._extendAdvancedControls[_loc3_]);
         }
         else
         {
            _loc4_ = SettingsControlProp(this._graphicsQualityDataProv[_loc3_]);
         }
         var _loc5_:Number = _loc4_.options[_loc2_.value].data;
         var _loc6_:Number = _loc4_.changedVal;
         _loc4_.prevVal = _loc6_;
         _loc4_.changedVal = _loc5_;
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,_loc5_));
         this.tryFindPreset();
      }

      private function onAutodetectPress(param1:ButtonEvent) : void {
         autodetectQuality.enabled = false;
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_AUTO_DETECT_QUALITY,_viewId));
      }
   }

}