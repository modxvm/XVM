package net.wg.gui.lobby.settings
{
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.advanced.FieldSet;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.Event;
   import scaleform.clik.events.SliderEvent;
   import net.wg.utils.ICommons;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.lobby.settings.evnts.SettingViewEvent;


   public class GraphicSettings extends SettingsBaseView
   {
          
      public function GraphicSettings() {
         super();
      }

      public var monitorLabel:LabelControl = null;

      public var monitorDropDown:DropdownMenu = null;

      public var fullScreenCheckbox:CheckBox = null;

      public var sizesLabel:LabelControl = null;

      public var sizesDropDown:DropdownMenu = null;

      public var vertSyncCheckbox:CheckBox = null;

      public var aspectRatioLabel:LabelControl = null;

      public var aspectRatioDropDown:DropdownMenu = null;

      public var smoothingLabel:LabelControl = null;

      public var smoothingDropDown:DropdownMenu = null;

      public var tripleBufferedCheckbox:CheckBox = null;

      public var gammaLabel:LabelControl = null;

      public var gammaSlider:Slider = null;

      public var sl:Slider = null;

      public var isColorBlindCheckbox:CheckBox = null;

      public var graphicsQualityLabel:LabelControl = null;

      public var graphicsQualityDropDown:DropdownMenu = null;

      public var autodetectQuality:SoundButtonEx = null;

      public var graficsFieldSet:FieldSet = null;

      public var RENDER_PIPELINELabel:LabelControl = null;

      public var RENDER_PIPELINEDropDown:DropdownMenu = null;

      public var TEXTURE_QUALITYLabel:LabelControl = null;

      public var TEXTURE_QUALITYDropDown:DropdownMenu = null;

      public var DECALS_QUALITYLabel:LabelControl = null;

      public var DECALS_QUALITYDropDown:DropdownMenu = null;

      public var SHADOWS_QUALITYLabel:LabelControl = null;

      public var SHADOWS_QUALITYDropDown:DropdownMenu = null;

      public var TERRAIN_QUALITYLabel:LabelControl = null;

      public var TERRAIN_QUALITYDropDown:DropdownMenu = null;

      public var WATER_QUALITYLabel:LabelControl = null;

      public var WATER_QUALITYDropDown:DropdownMenu = null;

      public var LIGHTING_QUALITYLabel:LabelControl = null;

      public var LIGHTING_QUALITYDropDown:DropdownMenu = null;

      public var SPEEDTREE_QUALITYLabel:LabelControl = null;

      public var SPEEDTREE_QUALITYDropDown:DropdownMenu = null;

      public var FLORA_QUALITYLabel:LabelControl = null;

      public var FLORA_QUALITYDropDown:DropdownMenu = null;

      public var EFFECTS_QUALITYLabel:LabelControl = null;

      public var EFFECTS_QUALITYDropDown:DropdownMenu = null;

      public var POST_PROCESSING_QUALITYLabel:LabelControl = null;

      public var POST_PROCESSING_QUALITYDropDown:DropdownMenu = null;

      public var FAR_PLANELabel:LabelControl = null;

      public var FAR_PLANEDropDown:DropdownMenu = null;

      public var OBJECT_LODLabel:LabelControl = null;

      public var OBJECT_LODDropDown:DropdownMenu = null;

      public var SNIPER_MODE_EFFECTS_QUALITYLabel:LabelControl = null;

      public var SNIPER_MODE_EFFECTS_QUALITYDropDown:DropdownMenu = null;

      public var fpsPerfomancerCheckbox:CheckBox = null;

      public var SNIPER_MODE_GRASS_ENABLEDCheckbox:CheckBox = null;

      public var VEHICLE_DUST_ENABLEDCheckbox:CheckBox = null;

      public var VEHICLE_TRACES_ENABLEDCheckbox:CheckBox = null;

      private var _presets:Object = null;

      private var graphicsQualityDataProv:Object = null;

      private var qualityOrder:Array = null;

      private var useAdvancedGraphic:Boolean = false;

      private var allowCheckPresets:Boolean = true;

      override public function update(param1:Object) : void {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         this.graphicsQualityDataProv = {};
         var _loc2_:Object = param1.data;
         this.qualityOrder = _loc2_.qualityOrder;
         if(this.qualityOrder  is  Array)
         {
            _loc3_ = this.qualityOrder.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = this.qualityOrder[_loc4_];
               if(_loc2_[_loc5_] != undefined)
               {
                  this.graphicsQualityDataProv[_loc5_] = SettingsControlProp(_loc2_[_loc5_]).clone();
               }
               _loc4_++;
            }
         }
         super.update(param1);
      }

      override public function dispose() : void {
         if(this.graphicsQualityDropDown.hasEventListener(ListEvent.INDEX_CHANGE))
         {
            this.graphicsQualityDropDown.removeEventListener(ListEvent.INDEX_CHANGE,this.onGraphicsQualityChangePreset);
         }
         if(this.autodetectQuality.hasEventListener(ButtonEvent.CLICK))
         {
            this.autodetectQuality.removeEventListener(ButtonEvent.CLICK,this.onAutodetectPress);
         }
         var _loc1_:* = "";
         var _loc2_:CheckBox = null;
         var _loc3_:DropdownMenu = null;
         var _loc4_:Slider = null;
         var _loc5_:SettingsControlProp = null;
         while((this.qualityOrder) && this.qualityOrder.length > 0)
         {
            _loc1_ = this.qualityOrder.pop();
            if(!(_data[_loc1_] == undefined) && (this[_loc1_ + _data[_loc1_].type]))
            {
               _loc5_ = SettingsControlProp(_data[_loc1_]);
               switch(_loc5_.type)
               {
                  case SettingsConfig.TYPE_CHECKBOX:
                     _loc2_ = this[_loc1_ + _loc5_.type];
                     if(_loc2_.hasEventListener(Event.SELECT))
                     {
                        _loc2_.removeEventListener(Event.SELECT,this.onGraphicsCheckBoxChange);
                     }
                     break;
                  case SettingsConfig.TYPE_SLIDER:
                     break;
                  case SettingsConfig.TYPE_DROPDOWN:
                     _loc3_ = this[_loc1_ + _loc5_.type];
                     if(_loc3_.hasEventListener(ListEvent.INDEX_CHANGE))
                     {
                        _loc3_.removeEventListener(ListEvent.INDEX_CHANGE,this.onGraphicsDropDownChange);
                     }
                     break;
               }
               _loc5_.clear();
               _loc5_ = null;
            }
         }
         this.qualityOrder = null;
         this.graphicsQualityDataProv = null;
         for (_loc1_ in _data)
         {
            if((_data[_loc1_]) && (this[_loc1_ + _data[_loc1_].type]))
            {
               _loc5_ = SettingsControlProp(_data[_loc1_]);
               switch(_loc5_.type)
               {
                  case SettingsConfig.TYPE_CHECKBOX:
                     _loc2_ = this[_loc1_ + _loc5_.type];
                     if(_loc2_.hasEventListener(Event.SELECT))
                     {
                        _loc2_.removeEventListener(Event.SELECT,this.onCheckBoxChange);
                     }
                     break;
                  case SettingsConfig.TYPE_SLIDER:
                     _loc4_ = this[_loc1_ + _loc5_.type];
                     if(_loc4_.hasEventListener(SliderEvent.VALUE_CHANGE))
                     {
                        _loc4_.removeEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChanged);
                     }
                     break;
                  case SettingsConfig.TYPE_DROPDOWN:
                     _loc3_ = this[_loc1_ + _loc5_.type];
                     if(_loc3_.hasEventListener(ListEvent.INDEX_CHANGE))
                     {
                        _loc3_.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
                     }
                     break;
               }
               _loc5_.clear();
               _loc5_ = null;
            }
         }
         super.dispose();
      }

      override public function toString() : String {
         return "[WG GraphicSettings " + name + "]";
      }

      public function setPresetAfterAutoDetect(param1:Number) : void {
         this._presets.current = Math.min(this._presets.current,param1);
         this.setPresets();
         this.autodetectQuality.enabled = true;
      }

      public function updateLiveVideoData() : void {
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
            _loc7_ = SettingsControlProp(SettingsConfig.settingsData[SettingsConfig.GRAPHIC_SETTINGS][_loc6_]);
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
                     _loc1_.selected = Boolean(_loc8_.current);
                     break;
                  case SettingsConfig.TYPE_SLIDER:
                     break;
                  case SettingsConfig.TYPE_DROPDOWN:
                     _loc2_ = DropdownMenu(this[_loc6_ + _loc7_.type]);
                     if(_loc6_ == SettingsConfig.SIZE)
                     {
                        _loc9_ = this.fullScreenCheckbox.selected?SettingsConfig.RESOLUTION:SettingsConfig.WINDOW_SIZE;
                        _loc10_ = SettingsControlProp(SettingsConfig.liveUpdateVideoSettingsData[_loc9_]);
                        _loc11_ = this.monitorDropDown.selectedIndex;
                        SettingsControlProp(_data[_loc9_]).lastVal[_loc11_] = _loc10_.current;
                        if((_loc10_) && _loc10_.options  is  Array)
                        {
                           _loc2_.dataProvider = new DataProvider(_loc10_.options[_loc11_]);
                           _loc2_.selectedIndex = _loc10_.current;
                        }
                     }
                     else
                     {
                        _loc2_.dataProvider = new DataProvider(_loc8_.options);
                        _loc2_.selectedIndex = _loc8_.current;
                     }
                     break;
               }
            }
            if(_loc6_ != SettingsConfig.SIZE)
            {
               dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc6_,_loc8_.current));
            }
            _loc5_++;
         }
      }

      override protected function configUI() : void {
         this.monitorLabel.text = SETTINGS.MONITOR;
         this.fullScreenCheckbox.label = SETTINGS.FULLSCREENMODE;
         this.sizesLabel.text = SETTINGS.RESOLUTION;
         this.vertSyncCheckbox.label = SETTINGS.VERTICAL_SYNC;
         this.aspectRatioLabel.text = SETTINGS.ASPECTRATIO;
         this.smoothingLabel.text = SETTINGS.MULTISAMPLINGTYPE;
         this.tripleBufferedCheckbox.label = SETTINGS.TRIPLEBUFFERED;
         this.gammaLabel.text = SETTINGS.GAMMA;
         this.isColorBlindCheckbox.label = SETTINGS.ISCOLORBLIND;
         this.graphicsQualityLabel.text = SETTINGS.GRAPHICS_DETAILS;
         this.autodetectQuality.label = SETTINGS.AUTODETECTBUTTON;
         this.RENDER_PIPELINELabel.text = "";
         this.TEXTURE_QUALITYLabel.text = "";
         this.DECALS_QUALITYLabel.text = "";
         this.SHADOWS_QUALITYLabel.text = "";
         this.TERRAIN_QUALITYLabel.text = "";
         this.WATER_QUALITYLabel.text = "";
         this.LIGHTING_QUALITYLabel.text = "";
         this.SPEEDTREE_QUALITYLabel.text = "";
         this.FLORA_QUALITYLabel.text = "";
         this.EFFECTS_QUALITYLabel.text = "";
         this.POST_PROCESSING_QUALITYLabel.text = "";
         this.FAR_PLANELabel.text = "";
         this.OBJECT_LODLabel.text = "";
         this.SNIPER_MODE_EFFECTS_QUALITYLabel.text = "";
         this.fpsPerfomancerCheckbox.label = "";
         this.SNIPER_MODE_GRASS_ENABLEDCheckbox.label = "";
         this.VEHICLE_DUST_ENABLEDCheckbox.label = "";
         this.VEHICLE_TRACES_ENABLEDCheckbox.label = "";
         this.autodetectQuality.addEventListener(ButtonEvent.CLICK,this.onAutodetectPress);
         super.configUI();
      }

      override protected function setData(param1:Object) : void {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc2_:* = false;
         if(_data.presets.options)
         {
            _loc3_ = _data.presets.options.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(_data.presets.current == _data.presets.options[_loc4_].index)
               {
                  _loc2_ = _data.presets.options[_loc4_].key == SettingsConfig.CUSTOM?true:false;
                  break;
               }
               _loc4_++;
            }
         }
         this.setControlsData(param1,_loc2_);
         this.setPresets();
      }

      private function setControlsData(param1:Object, param2:Boolean) : void {
         var _loc3_:String = null;
         var _loc4_:* = false;
         var _loc5_:* = false;
         var _loc6_:* = false;
         var _loc7_:SettingsControlProp = null;
         var _loc8_:* = false;
         var _loc9_:CheckBox = null;
         var _loc10_:Slider = null;
         var _loc11_:DropdownMenu = null;
         var _loc12_:String = null;
         var _loc13_:SettingsControlProp = null;
         var _loc14_:SettingsControlProp = null;
         var _loc15_:SettingsControlProp = null;
         var _loc16_:SettingsControlProp = null;
         var _loc17_:* = NaN;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:String = null;
         var _loc21_:SettingsControlProp = null;
         var _loc22_:SettingsControlProp = null;
         var _loc23_:* = NaN;
         var _loc24_:String = null;
         for (_loc3_ in _data)
         {
            _loc4_ = (this.qualityOrder) && this.qualityOrder.indexOf(_loc3_,0) == -1?false:true;
            _loc5_ = false;
            _loc6_ = (param2) && (_loc4_);
            if((_data[_loc3_]) && !(this[_loc3_ + _data[_loc3_].type] == undefined))
            {
               _loc7_ = SettingsControlProp(_data[_loc3_]);
               _loc8_ = !(_loc7_.current == null || (_loc7_.readOnly));
               switch(_loc7_.type)
               {
                  case SettingsConfig.TYPE_CHECKBOX:
                     _loc9_ = this[_loc3_ + _loc7_.type];
                     if(_loc9_.label == "")
                     {
                        _loc9_.label = SettingsConfig.LOCALIZATION + _loc3_;
                     }
                     if((_loc6_) || !_loc4_)
                     {
                        _loc9_.selected = _loc7_.current;
                     }
                     if(!_loc4_)
                     {
                        _loc9_.addEventListener(Event.SELECT,this.onCheckBoxChange);
                     }
                     else
                     {
                        _loc9_.addEventListener(Event.SELECT,this.onGraphicsCheckBoxChange);
                     }
                     _loc9_.enabled = _loc8_;
                     break;
                  case SettingsConfig.TYPE_SLIDER:
                     _loc10_ = this[_loc3_ + _loc7_.type];
                     if((_loc6_) || !_loc4_)
                     {
                        _loc10_.value = _loc7_.current;
                     }
                     if(!_loc4_)
                     {
                        _loc10_.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChanged);
                     }
                     if(_loc3_ == SettingsConfig.GAMMA)
                     {
                        _loc5_ = SettingsControlProp(_data[SettingsConfig.FULL_SCREEN]).current;
                        _loc8_ = (_loc5_) && (_loc8_);
                     }
                     _loc10_.enabled = _loc8_;
                     break;
                  case SettingsConfig.TYPE_DROPDOWN:
                     _loc11_ = this[_loc3_ + _loc7_.type];
                     if(_loc3_ == SettingsConfig.SIZE)
                     {
                        _loc12_ = _data[SettingsConfig.FULL_SCREEN].current?SettingsConfig.RESOLUTION:SettingsConfig.WINDOW_SIZE;
                        this.sizesLabel.text = SettingsConfig.LOCALIZATION + _loc12_;
                        _loc13_ = SettingsControlProp(_data[_loc12_]);
                        _loc14_ = SettingsControlProp(_data[SettingsConfig.RESOLUTION]);
                        _loc15_ = SettingsControlProp(_data[SettingsConfig.WINDOW_SIZE]);
                        _loc16_ = SettingsControlProp(_data[SettingsConfig.MONITOR]);
                        _loc17_ = _loc16_.current;
                        if((_loc13_) && _loc13_.options  is  Array)
                        {
                           _loc7_.options = _loc13_.options[_loc17_];
                           _loc7_.current = _loc13_.current;
                        }
                        _loc8_ = _loc7_.options  is  Array && _loc7_.options.length > 0;
                        _loc18_ = 0;
                        _loc19_ = _loc16_.options  is  Array?_loc16_.options.length:0;
                        _loc14_.lastVal = null;
                        _loc15_.lastVal = null;
                        _loc14_.lastVal = new Array();
                        _loc15_.lastVal = new Array();
                        _loc18_ = 0;
                        while(_loc18_ < _loc19_)
                        {
                           _loc14_.lastVal[_loc18_] = _loc18_ == _loc16_.current?_loc14_.current:0;
                           _loc15_.lastVal[_loc18_] = _loc18_ == _loc16_.current?_loc15_.current:0;
                           _loc18_++;
                        }
                     }
                     if(_loc3_ == SettingsConfig.ASPECTRATIO)
                     {
                        _loc5_ = SettingsControlProp(_data[SettingsConfig.FULL_SCREEN]).current;
                        _loc8_ = (_loc5_) && (_loc8_);
                     }
                     if(_loc3_ == SettingsConfig.SMOOTHING)
                     {
                        _loc20_ = _data[SettingsConfig.RENDER_PIPELINE].current == 0?SettingsConfig.CUSTOM_AA:SettingsConfig.MULTISAMPLING;
                        _loc7_.options = SettingsControlProp(_data[_loc20_]).options;
                        _loc7_.current = SettingsControlProp(_data[_loc20_]).current;
                        _loc21_ = SettingsControlProp(_data[SettingsConfig.CUSTOM_AA]);
                        _loc22_ = SettingsControlProp(_data[SettingsConfig.MULTISAMPLING]);
                        _loc21_.lastVal = _loc21_.current;
                        _loc22_.lastVal = _loc22_.current;
                        _loc8_ = (_loc7_.options) && _loc7_.options  is  Array && _loc7_.options.length > 0;
                     }
                     if((_loc6_) || !_loc4_)
                     {
                        _loc11_.dataProvider = new DataProvider(_loc7_.options);
                        if(_loc6_)
                        {
                           _loc23_ = 0;
                           for (_loc24_ in _loc7_.options)
                           {
                              if((_loc7_.options[_loc24_].hasOwnProperty("data")) && _loc7_.current == _loc7_.options[_loc24_].data)
                              {
                                 break;
                              }
                              _loc23_++;
                           }
                           _loc11_.selectedIndex = _loc23_;
                        }
                        else
                        {
                           _loc11_.selectedIndex = _loc7_.current;
                        }
                     }
                     if(_loc3_ != SettingsConfig.GRAPHIC_QUALITY)
                     {
                        if(!_loc4_)
                        {
                           _loc11_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
                        }
                        else
                        {
                           _loc11_.addEventListener(ListEvent.INDEX_CHANGE,this.onGraphicsDropDownChange);
                        }
                     }
                     _loc11_.enabled = _loc8_;
                     break;
               }
            }
            else
            {
               if(_loc3_ == SettingsConfig.PRESETS && !this._presets)
               {
                  this._presets = _data[_loc3_];
               }
               else
               {
                  if(!_loc7_.readOnly && SettingsConfig.reservedImaginaryControls.indexOf(_loc3_) == -1)
                  {
                     DebugUtils.LOG_WARNING("ERROR in" + this + " control " + _loc3_ + " can not find");
                  }
               }
            }
            trySetLabel(_loc3_);
         }
      }

      private function setPresets() : void {
         var _loc1_:Array = [];
         var _loc2_:* = "";
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
         this.graphicsQualityDropDown.dataProvider = new DataProvider(_loc1_);
         this.graphicsQualityDropDown.selectedIndex = this._presets.current;
         this.graphicsQualityDropDown.addEventListener(ListEvent.INDEX_CHANGE,this.onGraphicsQualityChangePreset);
         this.graphicsQualityDropDown.enabled = true;
         if(SettingsConfig.settingsData.GraphicSettings.graphicsQuality != undefined)
         {
            SettingsConfig.settingsData.GraphicSettings.graphicsQuality.current = this._presets.current;
         }
         var _loc3_:Object = null;
         var _loc4_:uint = this._presets.options  is  Array?this._presets.options.length:0;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            if(this._presets.current == this._presets.options[_loc5_].index)
            {
               _loc3_ = this._presets.options[_loc5_];
               break;
            }
            _loc5_++;
         }
         if(_loc3_)
         {
            this.updateGraphicsQualityControlsForPreset(this._presets.current,_loc3_,true);
         }
         else
         {
            this.graphicsQualityDropDown.enabled = false;
            this.autodetectQuality.enabled = false;
         }
      }

      private function updateGraphicsQualityControlsForPreset(param1:Number, param2:Object, param3:Boolean) : void {
         var _loc5_:String = null;
         var _loc9_:DropdownMenu = null;
         var _loc10_:SettingsControlProp = null;
         var _loc11_:CheckBox = null;
         var _loc12_:DropdownMenu = null;
         var _loc13_:* = NaN;
         var _loc14_:* = NaN;
         var _loc15_:uint = 0;
         var _loc4_:String = param2.key;
         _loc5_ = "";
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         this.allowCheckPresets = false;
         var _loc8_:* = false;
         if(_loc4_ == SettingsConfig.CUSTOM)
         {
            _loc9_ = this[SettingsConfig.RENDER_PIPELINE + SettingsConfig.TYPE_DROPDOWN];
            _loc8_ = _loc9_.selectedIndex == 0;
         }
         else
         {
            _loc8_ = param2.settings[SettingsConfig.RENDER_PIPELINE] == 0;
         }
         this.updateGraphicsQualityDataForAdvanced(_loc8_,param3);
         if(_loc4_ != SettingsConfig.CUSTOM)
         {
            _loc7_ = 0;
            while(_loc7_ < this.qualityOrder.length)
            {
               _loc5_ = this.qualityOrder[_loc7_];
               if(!(this.graphicsQualityDataProv[_loc5_] == undefined) && !(this[_loc5_ + SettingsControlProp(this.graphicsQualityDataProv[_loc5_]).type] == undefined))
               {
                  _loc10_ = SettingsControlProp(this.graphicsQualityDataProv[_loc5_]);
                  switch(_loc10_.type)
                  {
                     case SettingsConfig.TYPE_CHECKBOX:
                        _loc11_ = this[_loc5_ + _loc10_.type];
                        _loc11_.selected = Boolean(param2.settings[_loc5_]);
                        _loc11_.enabled = Boolean((this.useAdvancedGraphic) || (!_loc10_.advanced));
                        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc5_,_loc11_.selected));
                        break;
                     case SettingsConfig.TYPE_SLIDER:
                        break;
                     case SettingsConfig.TYPE_DROPDOWN:
                        _loc12_ = this[_loc5_ + _loc10_.type];
                        _loc12_.menuRowCount = _loc10_.options.length;
                        _loc12_.dataProvider = new DataProvider(_loc10_.options);
                        _loc13_ = 0;
                        _loc14_ = 0;
                        _loc15_ = _loc10_.options.length;
                        _loc6_ = 0;
                        while(_loc6_ < _loc15_)
                        {
                           if(param2.settings[_loc5_] == _loc10_.options[_loc6_].data)
                           {
                              _loc13_ = _loc6_;
                              _loc14_ = _loc10_.options[_loc6_].data;
                              break;
                           }
                           _loc6_++;
                        }
                        _loc12_.selectedIndex = _loc13_;
                        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc5_,_loc14_));
                        break;
                  }
               }
               _loc7_++;
            }
         }
         else
         {
            if(param3)
            {
               this.updateGraphicsQualityIfChangeAdvanced();
               param3 = false;
            }
         }
         this.allowCheckPresets = true;
      }

      private function updateGraphicsQualityDataForAdvanced(param1:Boolean, param2:Boolean) : void {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:SettingsControlProp = null;
         var _loc6_:SettingsControlProp = null;
         var _loc7_:String = null;
         var _loc8_:DropdownMenu = null;
         var _loc9_:* = NaN;
         if(!(this.useAdvancedGraphic == param1) || (param2))
         {
            this.useAdvancedGraphic = param1;
            _loc3_ = "";
            for (_loc3_ in this.graphicsQualityDataProv)
            {
               _loc6_ = SettingsControlProp(this.graphicsQualityDataProv[_loc3_]);
               switch(_loc6_.type)
               {
                  case SettingsConfig.TYPE_CHECKBOX:
                     continue;
                  case SettingsConfig.TYPE_SLIDER:
                     continue;
                  case SettingsConfig.TYPE_DROPDOWN:
                     _loc6_.options = new Array();
                     for (_loc7_ in _data[_loc3_].options)
                     {
                        if((param1) || !_data[_loc3_].options[_loc7_].advanced)
                        {
                           _loc6_.options.push(SettingsControlProp(_data[_loc3_]).options[_loc7_]);
                        }
                     }
                     continue;
                  default:
                     continue;
               }
            }
            _loc4_ = this.useAdvancedGraphic?SettingsConfig.CUSTOM_AA:SettingsConfig.MULTISAMPLING;
            _loc5_ = SettingsControlProp(_data[SettingsConfig.SMOOTHING]);
            _loc5_.options = _data[_loc4_].options;
            if(this[SettingsConfig.SMOOTHING + _loc5_.type])
            {
               _loc8_ = this[SettingsConfig.SMOOTHING + _loc5_.type];
               _loc9_ = _loc8_.selectedIndex;
               _loc8_.enabled = (_loc5_.options) && _loc5_.options.length > 0;
               _loc8_.dataProvider = new DataProvider(_loc5_.options);
               if(_loc9_ != _data[_loc4_].lastVal)
               {
                  _loc8_.selectedIndex = _data[_loc4_].lastVal;
                  dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,SettingsConfig.SMOOTHING,_loc8_.selectedIndex));
               }
            }
         }
      }

      private function updateGraphicsQualityIfChangeAdvanced() : void {
         var _loc1_:String = null;
         var _loc2_:SettingsControlProp = null;
         var _loc3_:CheckBox = null;
         var _loc4_:* = false;
         var _loc5_:DropdownMenu = null;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:uint = 0;
         var _loc9_:* = NaN;
         var _loc10_:uint = 0;
         this.allowCheckPresets = false;
         for (_loc1_ in this.graphicsQualityDataProv)
         {
            if(this[_loc1_ + SettingsControlProp(this.graphicsQualityDataProv[_loc1_]).type])
            {
               _loc2_ = SettingsControlProp(this.graphicsQualityDataProv[_loc1_]);
               switch(_loc2_.type)
               {
                  case SettingsConfig.TYPE_CHECKBOX:
                     _loc3_ = this[_loc1_ + _loc2_.type];
                     _loc4_ = _loc3_.selected;
                     if(!this.useAdvancedGraphic && (_loc2_.advanced))
                     {
                        _loc3_.selected = Boolean((this.useAdvancedGraphic) || (!_loc2_.advanced));
                     }
                     _loc3_.enabled = Boolean((this.useAdvancedGraphic) || (!_loc2_.advanced));
                     if(_loc4_ != _loc3_.selected)
                     {
                        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc1_,_loc3_.selected));
                     }
                     continue;
                  case SettingsConfig.TYPE_SLIDER:
                     continue;
                  case SettingsConfig.TYPE_DROPDOWN:
                     _loc5_ = this[_loc1_ + _loc2_.type];
                     _loc6_ = _loc5_.dataProvider[_loc5_.selectedIndex].data;
                     _loc7_ = -1;
                     _loc8_ = _loc2_.options.length;
                     _loc10_ = 0;
                     while(_loc10_ < _loc8_)
                     {
                        if(_loc2_.options[_loc10_].data == _loc6_)
                        {
                           _loc7_ = _loc10_;
                           break;
                        }
                        _loc10_++;
                     }
                     _loc5_.menuRowCount = _loc2_.options.length;
                     _loc5_.dataProvider = new DataProvider(_loc2_.options);
                     _loc5_.selectedIndex = _loc7_ != -1?_loc7_:_loc2_.options.length-1;
                     _loc9_ = _loc2_.options[_loc5_.selectedIndex].data;
                     if(_loc6_ != _loc9_)
                     {
                        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc1_,_loc9_));
                     }
                     continue;
                  default:
                     continue;
               }
            }
            else
            {
               continue;
            }
         }
         this.allowCheckPresets = true;
      }

      private function checkForCustomsPreset() : void {
         var _loc2_:String = null;
         var _loc10_:SettingsControlProp = null;
         var _loc11_:CheckBox = null;
         var _loc12_:DropdownMenu = null;
         var _loc13_:String = null;
         if(!this.allowCheckPresets)
         {
            return;
         }
         var _loc1_:uint = 0;
         _loc2_ = "";
         var _loc3_:Object = {};
         var _loc4_:uint = this.qualityOrder.length;
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc2_ = this.qualityOrder[_loc1_];
            if(!(_data[_loc2_] == undefined) && (this[_loc2_ + _data[_loc2_].type]))
            {
               _loc10_ = SettingsControlProp(_data[_loc2_]);
               switch(_loc10_.type)
               {
                  case SettingsConfig.TYPE_CHECKBOX:
                     _loc11_ = this[_loc2_ + _loc10_.type];
                     _loc3_[_loc2_] = Number(_loc11_.selected);
                     break;
                  case SettingsConfig.TYPE_SLIDER:
                     break;
                  case SettingsConfig.TYPE_DROPDOWN:
                     _loc12_ = this[_loc2_ + _loc10_.type];
                     _loc3_[_loc2_] = SettingsControlProp(this.graphicsQualityDataProv[_loc2_]).options[_loc12_.selectedIndex].data;
                     break;
               }
            }
            _loc1_++;
         }
         var _loc5_:Number = -1;
         var _loc6_:* = "";
         var _loc7_:* = true;
         var _loc8_:uint = this._presets.options.length;
         var _loc9_:* = "";
         _loc1_ = 0;
         while(_loc1_ < _loc8_)
         {
            if(this._presets.options[_loc1_].key == SettingsConfig.CUSTOM)
            {
               _loc6_ = this._presets.options[_loc1_].key;
               _loc5_ = this._presets.options[_loc1_].index;
            }
            else
            {
               _loc7_ = true;
               for (_loc9_ in _loc3_)
               {
                  if(this._presets.options[_loc1_].settings[_loc9_] != _loc3_[_loc9_])
                  {
                     _loc7_ = false;
                     break;
                  }
               }
               if(_loc7_)
               {
                  _loc5_ = this._presets.options[_loc1_].index;
                  _loc6_ = this._presets.options[_loc1_].key;
                  break;
               }
            }
            _loc1_++;
         }
         _loc3_ = null;
         if(this.graphicsQualityDropDown.selectedIndex != _loc5_)
         {
            this.graphicsQualityDropDown.selectedIndex = _loc5_;
            _loc13_ = SettingsConfig.GRAPHIC_QUALITY;
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc13_,_loc5_));
         }
      }

      private function onAutodetectPress(param1:ButtonEvent) : void {
         this.autodetectQuality.enabled = false;
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_AUTO_DETECT_QUALITY,_viewId));
      }

      private function onDropDownChange(param1:ListEvent) : void {
         var _loc7_:SettingsControlProp = null;
         var _loc8_:* = false;
         var _loc9_:String = null;
         var _loc10_:* = false;
         var _loc11_:SettingsControlProp = null;
         var _loc12_:* = NaN;
         var _loc2_:DropdownMenu = DropdownMenu(param1.target);
         var _loc3_:Number = param1.index;
         var _loc4_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_DROPDOWN);
         var _loc5_:* = "";
         var _loc6_:Number = 0;
         if(_loc4_ == SettingsConfig.SMOOTHING)
         {
            _loc7_ = SettingsControlProp(_data[SettingsConfig.RENDER_PIPELINE]);
            _loc8_ = _loc7_.options[this.RENDER_PIPELINEDropDown.selectedIndex].data == 0?true:false;
            _loc9_ = SettingsConfig.MULTISAMPLING;
            SettingsControlProp(_data[_loc9_]).lastVal = _loc3_;
         }
         else
         {
            if(_loc4_ == SettingsConfig.SIZE)
            {
               _loc10_ = this.fullScreenCheckbox.selected;
               _loc4_ = _loc10_?SettingsConfig.RESOLUTION:SettingsConfig.WINDOW_SIZE;
               _loc6_ = this.monitorDropDown.selectedIndex;
               SettingsControlProp(_data[_loc4_]).lastVal[_loc6_] = _loc3_;
            }
            else
            {
               if(_loc4_ == SettingsConfig.MONITOR)
               {
                  _loc5_ = this.fullScreenCheckbox.selected?SettingsConfig.RESOLUTION:SettingsConfig.WINDOW_SIZE;
                  _loc6_ = _loc3_;
                  _loc11_ = SettingsControlProp(_data[SettingsConfig.SIZE]);
                  _loc11_.options = SettingsControlProp(_data[_loc5_]).options[_loc6_];
                  if(!this.fullScreenCheckbox.selected)
                  {
                     _loc12_ = this.trySearchSameSizeForAnotherMonitor(this.sizesDropDown.dataProvider.requestItemAt(this.sizesDropDown.selectedIndex).toString(),_loc11_.options);
                     SettingsControlProp(_data[_loc5_]).lastVal[_loc6_] = _loc12_;
                  }
                  this.sizesDropDown.dataProvider = new DataProvider(_loc11_.options);
                  this.sizesDropDown.selectedIndex = SettingsControlProp(_data[_loc5_]).lastVal[_loc6_];
                  dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc5_,this.sizesDropDown.selectedIndex));
               }
            }
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc4_,_loc3_));
      }

      private function trySearchSameSizeForAnotherMonitor(param1:String, param2:Array) : Number {
         var _loc3_:RegExp = new RegExp("\\*","g");
         var param1:String = param1.replace(_loc3_,"");
         var _loc4_:Number = param2.indexOf(param1);
         return _loc4_ == -1?param2.length-1:_loc4_;
      }

      private function onCheckBoxChange(param1:Event) : void {
         var _loc4_:SettingsControlProp = null;
         var _loc5_:String = null;
         var _loc6_:* = NaN;
         var _loc2_:CheckBox = CheckBox(param1.target);
         var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_CHECKBOX);
         if(_loc3_ == SettingsConfig.FULL_SCREEN)
         {
            _loc4_ = SettingsControlProp(_data[SettingsConfig.SIZE]);
            _loc5_ = _loc2_.selected?SettingsConfig.RESOLUTION:SettingsConfig.WINDOW_SIZE;
            _loc6_ = this.monitorDropDown.selectedIndex;
            this.sizesLabel.text = SettingsConfig.LOCALIZATION + _loc5_;
            _loc4_.options = SettingsControlProp(_data[_loc5_]).options[_loc6_];
            this.sizesDropDown.dataProvider = new DataProvider(_loc4_.options);
            this.sizesDropDown.selectedIndex = SettingsControlProp(_data[_loc5_]).lastVal[_loc6_];
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc5_,this.sizesDropDown.selectedIndex));
            this.aspectRatioDropDown.enabled = _loc2_.selected;
            this.gammaSlider.enabled = _loc2_.selected;
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,_loc2_.selected));
      }

      private function onSliderValueChanged(param1:SliderEvent) : void {
         var _loc2_:String = SettingsConfig.getControlId(Slider(param1.target).name,SettingsConfig.TYPE_SLIDER);
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc2_,Slider(param1.target).value));
      }

      private function onGraphicsQualityChangePreset(param1:ListEvent) : void {
         var _loc2_:Number = param1.index;
         var _loc3_:Object = param1.itemData;
         this.updateGraphicsQualityControlsForPreset(_loc2_,_loc3_,false);
      }

      private function onGraphicsDropDownChange(param1:ListEvent) : void {
         var _loc2_:Number = param1.index;
         var _loc3_:Object = param1.itemData;
         var _loc4_:DropdownMenu = DropdownMenu(param1.target);
         var _loc5_:String = SettingsConfig.getControlId(_loc4_.name,SettingsConfig.TYPE_DROPDOWN);
         var _loc6_:Number = SettingsControlProp(this.graphicsQualityDataProv[_loc5_]).options[_loc2_].data;
         if(_loc5_ == SettingsConfig.RENDER_PIPELINE)
         {
            if(!Boolean(_loc6_) != this.useAdvancedGraphic)
            {
               this.updateGraphicsQualityDataForAdvanced(!Boolean(_loc6_),false);
               this.updateGraphicsQualityIfChangeAdvanced();
            }
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc5_,_loc6_));
         this.checkForCustomsPreset();
      }

      private function onGraphicsCheckBoxChange(param1:Event) : void {
         var _loc2_:CheckBox = CheckBox(param1.target);
         var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_CHECKBOX);
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,_loc2_.selected));
         this.checkForCustomsPreset();
      }
   }

}