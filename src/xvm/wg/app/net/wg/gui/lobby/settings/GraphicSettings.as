package net.wg.gui.lobby.settings
{
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.DropdownMenu;
   import flash.events.Event;
   import scaleform.clik.events.SliderEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.lobby.settings.evnts.SettingViewEvent;
   import net.wg.utils.ICommons;


   public class GraphicSettings extends GraphicSettingsBase
   {
          
      public function GraphicSettings() {
         this._extendAdvancedControlsIds = [SettingsConfig.COLOR_GRADING_TECHNIQUE];
         this._imaginaryIdList = [SettingsConfig.CUSTOM_AA,SettingsConfig.MULTISAMPLING,SettingsConfig.WINDOW_SIZE,SettingsConfig.RESOLUTION,SettingsConfig.PRESETS,SettingsConfig.QUALITY_ORDER];
         super();
      }

      private var _graphicsQualityDataProv:Object = null;

      private var _qualityOrderIdList:Array = null;

      private var _isCustomPreset:Boolean = false;

      private var _isAdvanced:Boolean = false;

      private var _presets:Object = null;

      private var _isFullScreen:Boolean = false;

      private var _isInited:Boolean = false;

      private var _allowCheckPreset:Boolean = true;

      private var _extendAdvancedControls:Object;

      private var _extendAdvancedControlsIds:Array;

      private const _imaginaryIdList:Array;

      private var _skipIdList:Array;

      private var skipDispatchPresetEvent:Boolean = false;

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

      override protected function onDispose() : void {
         var _loc1_:String = null;
         var _loc2_:CheckBox = null;
         var _loc3_:Slider = null;
         var _loc4_:DropdownMenu = null;
         var _loc5_:SettingsControlProp = null;
         if(_data)
         {
            _loc1_ = "";
            _loc2_ = null;
            _loc3_ = null;
            _loc4_ = null;
            _loc5_ = null;
            for (_loc1_ in _data)
            {
               if(this._skipIdList.indexOf(_loc1_) >= 0)
               {
                  continue;
               }
               _loc5_ = SettingsControlProp(_data[_loc1_]);
               switch(_loc5_.type)
               {
                  case SettingsConfig.TYPE_CHECKBOX:
                     _loc2_ = this[_loc1_ + _loc5_.type];
                     _loc2_.removeEventListener(Event.SELECT,this.onCheckBoxChange);
                     continue;
                  case SettingsConfig.TYPE_SLIDER:
                     _loc3_ = this[_loc1_ + _loc5_.type];
                     _loc3_.removeEventListener(SliderEvent.VALUE_CHANGE,this.onSliderChanged);
                     continue;
                  case SettingsConfig.TYPE_DROPDOWN:
                     _loc4_ = this[_loc1_ + _loc5_.type];
                     _loc4_.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
                     continue;
                  default:
                     continue;
               }
            }
         }
         _loc1_ = SettingsConfig.GRAPHIC_QUALITY;
         _loc5_ = SettingsControlProp(_data[_loc1_]);
         _loc4_ = this[_loc1_ + _loc5_.type];
         _loc4_.removeEventListener(ListEvent.INDEX_CHANGE,this.onGraphicsQualityChangePreset);
         _loc1_ = SettingsConfig.RENDER_PIPELINE;
         _loc5_ = SettingsControlProp(_data[_loc1_]);
         _loc4_ = this[_loc1_ + _loc5_.type];
         _loc4_.removeEventListener(ListEvent.INDEX_CHANGE,this.onGraphicsQualityChangeRenderPipeline);
         for (_loc1_ in this._graphicsQualityDataProv)
         {
            if(_loc1_ == SettingsConfig.RENDER_PIPELINE)
            {
               continue;
            }
            _loc5_ = SettingsControlProp(this._graphicsQualityDataProv[_loc1_]);
            switch(_loc5_.type)
            {
               case SettingsConfig.TYPE_CHECKBOX:
                  _loc2_ = this[_loc1_ + _loc5_.type];
                  _loc2_.removeEventListener(Event.SELECT,this.onCheckBoxOrderedChange);
                  continue;
               case SettingsConfig.TYPE_DROPDOWN:
                  _loc4_ = this[_loc1_ + _loc5_.type];
                  _loc4_.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownOrderedChange);
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
         autodetectQuality.removeEventListener(ButtonEvent.CLICK,this.onAutodetectPress);
         super.onDispose();
      }

      override public function toString() : String {
         return "[WG GraphicSettings " + name + "]";
      }

      override public function updateDependentData() : void {
         if((SettingsConfig.liveUpdateVideoSettingsData) && (this._isInited))
         {
            this.updateLiveVideoData();
         }
      }

      public function setPresetAfterAutoDetect(param1:Number) : void {
         var _loc2_:String = SettingsConfig.GRAPHIC_QUALITY;
         var _loc3_:SettingsControlProp = SettingsControlProp(_data[_loc2_]);
         var _loc4_:DropdownMenu = this[_loc2_ + _loc3_.type];
         this._presets.current = param1;
         _loc3_.changedVal = this._presets.current;
         _loc4_.dataProvider = new DataProvider(_loc3_.options);
         _loc4_.selectedIndex = _loc3_.changedVal;
         autodetectQuality.enabled = true;
      }

      override protected function configUI() : void {
         autodetectQuality.addEventListener(ButtonEvent.CLICK,this.onAutodetectPress);
         super.configUI();
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
         var _loc8_:DropdownMenu = null;
         this._skipIdList = [];
         this._extendAdvancedControls = {};
         var _loc2_:Array = [SettingsConfig.SMOOTHING,SettingsConfig.SIZE];
         this._skipIdList = this._qualityOrderIdList.slice(0);
         this._skipIdList = this._skipIdList.concat(this._imaginaryIdList);
         this._skipIdList = this._skipIdList.concat(_loc2_);
         this._skipIdList.push(SettingsConfig.GRAPHIC_QUALITY);
         for (_loc3_ in param1)
         {
            trySetLabel(_loc3_);
            if(this._skipIdList.indexOf(_loc3_) < 0)
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
                              this._isFullScreen = _loc6_.selected;
                           }
                           break;
                        case SettingsConfig.TYPE_SLIDER:
                           _loc7_ = this[_loc3_ + _loc4_.type];
                           _loc7_.value = _loc4_.current;
                           _loc7_.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderChanged);
                           _loc7_.enabled = _loc5_;
                           break;
                        case SettingsConfig.TYPE_DROPDOWN:
                           _loc8_ = this[_loc3_ + _loc4_.type];
                           _loc8_.dataProvider = new DataProvider(_loc4_.options);
                           _loc8_.selectedIndex = _loc4_.current;
                           _loc8_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
                           _loc8_.enabled = _loc5_;
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
         this.updateStateForAspectRatioControl();
         this.updateStateForForGammaControl();
         this.setSizeControl();
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
         _loc4_.prevVal = new Array();
         _loc5_.prevVal = new Array();
         var _loc6_:Number = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_.prevVal[_loc6_] = _loc6_ == _loc2_?_loc4_.changedVal:0;
            _loc5_.prevVal[_loc6_] = _loc6_ == _loc2_?_loc5_.changedVal:0;
            _loc6_++;
         }
      }

      private function updateStateForAspectRatioControl() : void {
         var _loc2_:SettingsControlProp = null;
         var _loc3_:DropdownMenu = null;
         var _loc4_:* = false;
         var _loc1_:String = SettingsConfig.ASPECTRATIO;
         if((_data[_loc1_]) && !(this[_loc1_ + _data[_loc1_].type] == undefined))
         {
            _loc2_ = SettingsControlProp(_data[_loc1_]);
            _loc3_ = this[_loc1_ + _loc2_.type];
            _loc4_ = (this._isFullScreen) && !(_loc2_.changedVal == null || (_loc2_.readOnly));
            _loc3_.enabled = _loc4_;
         }
      }

      private function updateStateForForGammaControl() : void {
         var _loc2_:SettingsControlProp = null;
         var _loc3_:Slider = null;
         var _loc4_:* = false;
         var _loc1_:String = SettingsConfig.GAMMA;
         if((_data[_loc1_]) && !(this[_loc1_ + _data[_loc1_].type] == undefined))
         {
            _loc2_ = SettingsControlProp(_data[_loc1_]);
            _loc3_ = this[_loc1_ + _loc2_.type];
            _loc4_ = (this._isFullScreen) && !(_loc2_.changedVal == null || (_loc2_.readOnly));
            _loc3_.enabled = _loc4_;
         }
      }

      private function setSizeControl() : void {
         var _loc1_:String = SettingsConfig.SIZE;
         var _loc2_:SettingsControlProp = SettingsControlProp(_data[_loc1_]);
         var _loc3_:DropdownMenu = this[_loc1_ + _loc2_.type];
         var _loc4_:String = this._isFullScreen?SettingsConfig.RESOLUTION:SettingsConfig.WINDOW_SIZE;
         var _loc5_:SettingsControlProp = SettingsControlProp(_data[_loc4_]);
         sizesLabel.text = SettingsConfig.LOCALIZATION + _loc4_;
         var _loc6_:SettingsControlProp = SettingsControlProp(_data[SettingsConfig.MONITOR]);
         var _loc7_:Number = Number(_loc6_.changedVal);
         _loc2_.options = _loc5_.options[_loc7_];
         var _loc8_:Number = _loc2_.options.length-1;
         if(_loc3_.selectedIndex >= 0 && _loc3_.selectedIndex <= _loc3_.dataProvider.length)
         {
            _loc8_ = this.trySearchSameSizeForAnotherMonitor(_loc3_.dataProvider.requestItemAt(_loc3_.selectedIndex).toString(),_loc2_.options);
         }
         var _loc9_:Boolean = _loc2_.options  is  Array && _loc2_.options.length > 0;
         _loc3_.dataProvider = new DataProvider(_loc2_.options);
         _loc3_.selectedIndex = _loc8_;
         _loc3_.enabled = _loc9_;
         if(!this._isInited)
         {
            _loc2_.current = _loc8_;
            _loc3_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
         }
      }

      private function setPresets() : void {
         var _loc1_:Array = [];
         var _loc2_:* = "";
         var _loc3_:String = SettingsConfig.GRAPHIC_QUALITY;
         var _loc4_:SettingsControlProp = SettingsControlProp(_data[_loc3_]);
         var _loc5_:DropdownMenu = this[_loc3_ + _loc4_.type];
         for (_loc2_ in this._presets.options)
         {
            _loc1_[this._presets.options[_loc2_].index] =
               {
                  "label":SETTINGS.graphicsquality(this._presets.options[_loc2_].key),
                  "settings":this._presets.options[_loc2_].settings,
                  "key":this._presets.options[_loc2_].key
               }
            ;
         }
         _loc4_.changedVal = this._presets.current;
         _loc4_.options = new DataProvider(_loc1_);
         _loc5_.dataProvider = new DataProvider(_loc4_.options);
         _loc5_.selectedIndex = _loc4_.changedVal;
         _loc5_.enabled = _loc1_.length > 0;
         _loc5_.addEventListener(ListEvent.INDEX_CHANGE,this.onGraphicsQualityChangePreset);
      }

      private function setRenderPipeline() : void {
         var _loc2_:SettingsControlProp = null;
         var _loc3_:DropdownMenu = null;
         var _loc4_:* = false;
         var _loc1_:String = SettingsConfig.RENDER_PIPELINE;
         if((_data[_loc1_]) && !(this[_loc1_ + _data[_loc1_].type] == undefined))
         {
            _loc2_ = SettingsControlProp(_data[_loc1_]);
            _loc3_ = this[_loc1_ + _loc2_.type];
            _loc4_ = !(_loc2_.changedVal == null || (_loc2_.readOnly));
            _loc3_.dataProvider = new DataProvider(_loc2_.options);
            _loc3_.selectedIndex = _loc2_.changedVal;
            _loc3_.enabled = _loc4_;
            this._isAdvanced = _loc3_.selectedIndex == 0;
            _loc3_.addEventListener(ListEvent.INDEX_CHANGE,this.onGraphicsQualityChangeRenderPipeline);
         }
      }

      private function updateAdvancedDependedControls() : void {
         this.updateDataProviderForQuality();
         this.updateQualityControls();
         this.updateExtendedAdvancedControls();
         this.updateSmoothingControl();
      }

      private function updateDataProviderForQuality() : void {
         var _loc2_:SettingsControlProp = null;
         var _loc3_:String = null;
         var _loc1_:* = "";
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
               case SettingsConfig.TYPE_DROPDOWN:
                  _loc2_.options = new Array();
                  for (_loc3_ in _data[_loc1_].options)
                  {
                     if((this._isAdvanced) || !_data[_loc1_].options[_loc3_].advanced)
                     {
                        _loc2_.options.push(SettingsControlProp(_data[_loc1_]).options[_loc3_]);
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
         var _loc3_:CheckBox = null;
         var _loc4_:* = false;
         var _loc5_:DropdownMenu = null;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:uint = 0;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:uint = 0;
         switch(param2.type)
         {
            case SettingsConfig.TYPE_CHECKBOX:
               _loc3_ = this[param1 + param2.type];
               _loc4_ = param2.changedVal;
               _loc3_.selected = (_loc4_) && ((this._isAdvanced) || !param2.advanced);
               _loc3_.enabled = Boolean((this._isAdvanced) || (!param2.advanced));
               if(_loc4_ != _loc3_.selected)
               {
                  param2.changedVal = _loc3_.selected;
                  dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,param1,_loc3_.selected));
               }
               if(!this._isInited)
               {
                  _loc3_.addEventListener(Event.SELECT,this.onCheckBoxOrderedChange);
               }
               break;
            case SettingsConfig.TYPE_DROPDOWN:
               _loc5_ = this[param1 + param2.type];
               _loc6_ = param2.changedVal;
               _loc7_ = -1;
               _loc8_ = param2.options.length;
               _loc11_ = 0;
               while(_loc11_ < _loc8_)
               {
                  if(param2.options[_loc11_].data == _loc6_)
                  {
                     _loc7_ = _loc11_;
                     break;
                  }
                  _loc11_++;
               }
               _loc5_.menuRowCount = param2.options.length <= 7?param2.options.length:7;
               _loc5_.dataProvider = new DataProvider(param2.options);
               _loc9_ = _loc5_.selectedIndex;
               _loc5_.selectedIndex = _loc7_ != -1?_loc7_:0;
               _loc10_ = param2.options[_loc5_.selectedIndex].data;
               if(_loc9_ == _loc5_.selectedIndex)
               {
                  if(param2.prevVal != _loc10_)
                  {
                     param2.prevVal = param2.changedVal;
                     dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,param1,_loc10_));
                  }
               }
               param2.changedVal = _loc10_;
               if(!this._isInited)
               {
                  _loc5_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownOrderedChange);
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
               _loc1_.options = new Array();
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

      private function updateLiveVideoData() : void {
         var _loc6_:String = null;
         var _loc7_:SettingsControlProp = null;
         var _loc8_:SettingsControlProp = null;
         var _loc9_:String = null;
         var _loc10_:SettingsControlProp = null;
         var _loc11_:* = NaN;
         var _loc1_:CheckBox = null;
         var _loc2_:DropdownMenu = null;
         var _loc3_:uint = 0;
         _loc3_ = SettingsConfig.liveUpdateVideoSettingsOrderData.length;
         var _loc4_:ICommons = App.utils.commons;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = SettingsConfig.liveUpdateVideoSettingsOrderData[_loc5_];
            _loc7_ = SettingsControlProp(_data[_loc6_]);
            if(SettingsConfig.liveUpdateVideoSettingsData[_loc6_])
            {
               _loc8_ = SettingsControlProp(SettingsConfig.liveUpdateVideoSettingsData[_loc6_]);
               _loc7_.options = _loc4_.cloneObject(_loc8_.options);
            }
            if((_loc7_) && (this[_loc6_ + _loc7_.type]))
            {
               switch(_loc7_.type)
               {
                  case SettingsConfig.TYPE_CHECKBOX:
                     _loc1_ = CheckBox(this[_loc6_ + _loc7_.type]);
                     _loc1_.selected = Boolean(_loc8_.changedVal);
                     break;
                  case SettingsConfig.TYPE_DROPDOWN:
                     _loc2_ = DropdownMenu(this[_loc6_ + _loc7_.type]);
                     if(_loc6_ == SettingsConfig.SIZE)
                     {
                        _loc9_ = this._isFullScreen?SettingsConfig.RESOLUTION:SettingsConfig.WINDOW_SIZE;
                        _loc10_ = SettingsControlProp(SettingsConfig.liveUpdateVideoSettingsData[_loc9_]);
                        if((_loc10_) && _loc10_.options  is  Array)
                        {
                           _loc11_ = monitorDropDown.selectedIndex;
                           SettingsControlProp(_data[_loc9_]).prevVal[_loc11_] = _loc10_.changedVal;
                           _loc2_.dataProvider = new DataProvider(_loc10_.options[_loc11_]);
                           _loc2_.selectedIndex = _loc10_.changedVal;
                        }
                     }
                     else
                     {
                        _loc2_.dataProvider = new DataProvider(_loc8_.options);
                        _loc2_.selectedIndex = _loc8_.changedVal;
                     }
                     break;
               }
            }
            _loc5_++;
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
               _loc11_ = _loc10_.selectedIndex;
               if(_loc11_ != _loc4_)
               {
                  this.skipDispatchPresetEvent = true;
                  _loc10_.selectedIndex = _loc4_;
               }
            }
         }
      }

      private function trySearchSameSizeForAnotherMonitor(param1:String, param2:Array) : Number {
         var _loc3_:RegExp = new RegExp("\\*","g");
         var param1:String = param1.replace(_loc3_,"");
         var _loc4_:Number = param2.indexOf(param1);
         return _loc4_ == -1?param2.length-1:_loc4_;
      }

      private function onGraphicsQualityChangePreset(param1:ListEvent) : void {
         var _loc5_:SettingsControlProp = null;
         var _loc6_:DropdownMenu = null;
         var _loc7_:* = NaN;
         this._allowCheckPreset = false;
         var _loc2_:Object = param1.itemData;
         var _loc3_:String = _loc2_.key;
         this._presets.current = _loc2_.index;
         this._isCustomPreset = _loc3_ == SettingsConfig.CUSTOM;
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
            _loc7_ = _loc6_.selectedIndex;
            if(_loc7_ != _loc2_.settings[SettingsConfig.RENDER_PIPELINE])
            {
               _loc6_.selectedIndex = _loc2_.settings[SettingsConfig.RENDER_PIPELINE];
            }
            else
            {
               this.updateAdvancedDependedControls();
            }
         }
         this._allowCheckPreset = true;
      }

      private function onGraphicsQualityChangeRenderPipeline(param1:ListEvent) : void {
         var _loc2_:Number = param1.index;
         var _loc3_:DropdownMenu = DropdownMenu(param1.target);
         var _loc4_:String = SettingsConfig.getControlId(_loc3_.name,SettingsConfig.TYPE_DROPDOWN);
         var _loc5_:SettingsControlProp = SettingsControlProp(this._graphicsQualityDataProv[_loc4_]);
         var _loc6_:Number = _loc5_.options[_loc2_].data;
         var _loc7_:Boolean = this._isAdvanced;
         this._isAdvanced = _loc3_.selectedIndex == 0;
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
               _loc4_ = this._isFullScreen?SettingsConfig.RESOLUTION:SettingsConfig.WINDOW_SIZE;
               _loc5_ = SettingsControlProp(_data[_loc4_]);
               _loc5_.changedVal = _loc3_;
               _loc8_ = monitorDropDown.selectedIndex;
               _loc5_.prevVal[_loc8_] = _loc3_;
            }
            else
            {
               _loc5_.prevVal = _loc3_;
            }
         }
         if(_loc5_.prevVal)
         {
            this.setSizeControl();
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc4_,_loc3_));
      }

      private function onSliderChanged(param1:SliderEvent) : void {
         var _loc2_:String = SettingsConfig.getControlId(Slider(param1.target).name,SettingsConfig.TYPE_SLIDER);
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc2_,Slider(param1.target).value));
      }

      private function onCheckBoxChange(param1:Event) : void {
         var _loc2_:CheckBox = CheckBox(param1.target);
         var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_CHECKBOX);
         if(_loc3_ == SettingsConfig.FULL_SCREEN)
         {
            this._isFullScreen = _loc2_.selected;
            this.updateStateForAspectRatioControl();
            this.updateStateForForGammaControl();
            this.setSizeControl();
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
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,_loc5_));
         this.tryFindPreset();
      }

      private function onAutodetectPress(param1:ButtonEvent) : void {
         autodetectQuality.enabled = false;
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_AUTO_DETECT_QUALITY,_viewId));
      }
   }

}