package net.wg.gui.lobby.settings
{
   import flash.display.Sprite;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.LabelControl;
   import flash.events.Event;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.events.SliderEvent;
   import net.wg.gui.lobby.settings.evnts.SettingViewEvent;


   public class GameSettings extends GameSettingsBase
   {
          
      public function GameSettings() {
         super();
      }

      public var bgFrom:Sprite = null;

      private var vibroControlsList:Array = null;

      private var missChangeEvent:Boolean = false;

      override protected function configUI() : void {
         super.configUI();
      }

      override public function update(param1:Object) : void {
         super.update(param1);
      }

      override protected function setData(param1:Object) : void {
         var _loc2_:String = null;
         var _loc3_:* = false;
         var _loc4_:SettingsControlProp = null;
         var _loc5_:* = false;
         var _loc6_:CheckBox = null;
         var _loc7_:DropdownMenu = null;
         var _loc8_:Slider = null;
         var _loc9_:LabelControl = null;
         var _loc10_:* = false;
         super.setData(param1);
         this.vibroControlsList = [];
         for (_loc2_ in _data)
         {
            _loc4_ = SettingsControlProp(_data[_loc2_]);
            if(this[_loc2_ + _loc4_.type])
            {
               _loc5_ = !(_loc4_.current == null || (_loc4_.readOnly));
               switch(_loc4_.type)
               {
                  case SettingsConfig.TYPE_CHECKBOX:
                     _loc6_ = CheckBox(this[_loc2_ + _loc4_.type]);
                     _loc6_.selected = _loc4_.current;
                     _loc6_.enabled = _loc5_;
                     _loc6_.addEventListener(Event.SELECT,this.onCheckBoxSelected);
                     break;
                  case SettingsConfig.TYPE_DROPDOWN:
                     _loc7_ = this[_loc2_ + _loc4_.type];
                     _loc7_.dataProvider = new DataProvider(_loc4_.options);
                     _loc7_.menuRowCount = _loc4_.options  is  Array?_loc4_.options.length:0;
                     _loc7_.selectedIndex = _loc4_.current;
                     _loc7_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
                     break;
                  case SettingsConfig.TYPE_SLIDER:
                     _loc8_ = Slider(this[_loc2_ + _loc4_.type]);
                     _loc8_.value = _loc4_.current;
                     _loc8_.enabled = _loc5_;
                     _loc8_.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChanged);
                     if((_loc4_.hasValue) && (this[_loc2_ + SettingsConfig.TYPE_VALUE]))
                     {
                        _loc9_ = this[_loc2_ + SettingsConfig.TYPE_VALUE];
                        _loc9_.text = _loc4_.current;
                     }
                     break;
               }
               if(_loc4_.isDependOn)
               {
                  if(_loc4_.isDependOn == SettingsConfig.VIBRO_IS_CONNECTED)
                  {
                     this.vibroControlsList.push(_loc2_);
                  }
                  _loc10_ = SettingsControlProp(_data[_loc4_.isDependOn]).current;
                  this.showHideControl(_loc2_,_loc4_,_loc10_);
               }
            }
            else
            {
               if(!_loc4_.readOnly)
               {
                  DebugUtils.LOG_WARNING("ERROR in" + this + " control " + (_loc2_ + _loc4_.type) + " can not find");
               }
            }
         }
         _loc3_ = SettingsControlProp(_data.vibroIsConnected).current;
         vibroDeviceConnectionStateField.text = _loc3_?SETTINGS.VIBRO_DEVICE_STATE_CONNECTED:SETTINGS.VIBRO_DEVICE_STATE_NOTCONNECTED;
         vibroDeviceConnectionStateField.visible = _loc3_;
         fieldSetVibro.visible = _loc3_;
         if((horStabilizationSnpCheckbox) && (dynamicCameraCheckbox))
         {
            this.enableHorStabilizationSnp(dynamicCameraCheckbox.selected);
         }
         this.updatePostMortem();
      }

      override public function updateDependentData() : void {
         this.updatePostMortem();
      }

      private function updatePostMortem() : void {
         var _loc1_:SettingsControlProp = SettingsControlProp(SettingsConfig.settingsData[SettingsConfig.GRAPHIC_SETTINGS][SettingsConfig.POST_PROCESSING_QUALITY]);
         enablePostMortemEffectCheckbox.enabled = !(_loc1_.changedVal == _loc1_.options.length-1);
      }

      private function showHideControl(param1:String, param2:SettingsControlProp, param3:Boolean) : void {
         if(this[param1 + param2.type])
         {
            this[param1 + param2.type].visible = param3;
         }
         if((param2.hasLabel) && (this[param1 + SettingsConfig.TYPE_LABEL]))
         {
            this[param1 + SettingsConfig.TYPE_LABEL].visible = param3;
         }
         if((param2.hasValue) && (this[param1 + SettingsConfig.TYPE_VALUE]))
         {
            this[param1 + SettingsConfig.TYPE_VALUE].visible = param3;
         }
      }

      private function onSliderValueChanged(param1:SliderEvent) : void {
         var _loc5_:LabelControl = null;
         var _loc2_:Slider = Slider(param1.target);
         var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_SLIDER);
         var _loc4_:SettingsControlProp = SettingsControlProp(_data[_loc3_]);
         if((_loc4_.hasValue) && (this[_loc3_ + SettingsConfig.TYPE_VALUE]))
         {
            _loc5_ = LabelControl(this[_loc3_ + SettingsConfig.TYPE_VALUE]);
            _loc5_.text = _loc2_.value.toString();
         }
         if(!this.missChangeEvent)
         {
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,_loc2_.value));
         }
      }

      private function onCheckBoxSelected(param1:Event) : void {
         var _loc2_:String = SettingsConfig.getControlId(CheckBox(param1.target).name,SettingsConfig.TYPE_CHECKBOX);
         var _loc3_:Boolean = CheckBox(param1.target).selected;
         if(_loc2_ == SettingsConfig.DYNAMIC_CAMERA)
         {
            this.enableHorStabilizationSnp(_loc3_);
         }
         if(!this.missChangeEvent)
         {
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc2_,_loc3_));
         }
      }

      private function enableHorStabilizationSnp(param1:Boolean) : void {
         var _loc2_:String = null;
         var _loc3_:SettingsControlProp = null;
         if(SettingsControlProp(SettingsConfig.settingsData[SettingsConfig.GAME_SETTINGS][SettingsConfig.HOR_STABILIZATION_SNP]).current != null)
         {
            _loc2_ = SettingsConfig.HOR_STABILIZATION_SNP;
            _loc3_ = SettingsControlProp(SettingsConfig.settingsData[SettingsConfig.GAME_SETTINGS][_loc2_]);
            this.missChangeEvent = true;
            if(param1)
            {
               horStabilizationSnpCheckbox.selected = _loc3_.prevVal;
            }
            else
            {
               _loc3_.prevVal = horStabilizationSnpCheckbox.selected;
               horStabilizationSnpCheckbox.selected = false;
            }
            this.missChangeEvent = false;
            horStabilizationSnpCheckbox.enabled = param1;
         }
      }

      public function onVibroManagerConnect() : void {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:SettingsControlProp = null;
         var _loc1_:Boolean = SettingsControlProp(SettingsConfig.settingsData[SettingsConfig.GAME_SETTINGS].vibroIsConnected).current;
         if(this.vibroControlsList)
         {
            _loc2_ = this.vibroControlsList.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = this.vibroControlsList[_loc3_];
               _loc5_ = SettingsControlProp(_data[_loc4_]);
               this.showHideControl(_loc4_,_loc5_,_loc1_);
               _loc3_++;
            }
         }
         vibroDeviceConnectionStateField.text = _loc1_?SETTINGS.VIBRO_DEVICE_STATE_CONNECTED:SETTINGS.VIBRO_DEVICE_STATE_NOTCONNECTED;
         vibroDeviceConnectionStateField.visible = _loc1_;
         fieldSetVibro.visible = _loc1_;
      }

      private function onDropDownChange(param1:ListEvent) : void {
         var _loc2_:DropdownMenu = DropdownMenu(param1.target);
         var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_DROPDOWN);
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,_loc2_.selectedIndex));
      }

      override protected function onDispose() : void {
         var _loc1_:String = null;
         var _loc2_:SettingsControlProp = null;
         var _loc3_:CheckBox = null;
         var _loc4_:Slider = null;
         var _loc5_:DropdownMenu = null;
         if(_data)
         {
            for (_loc1_ in _data)
            {
               if(this[_loc1_ + _data[_loc1_].type])
               {
                  _loc2_ = _data[_loc1_];
                  switch(_loc2_.type)
                  {
                     case SettingsConfig.TYPE_CHECKBOX:
                        _loc3_ = this[_loc1_ + _loc2_.type];
                        _loc3_.removeEventListener(Event.SELECT,this.onCheckBoxSelected);
                        continue;
                     case SettingsConfig.TYPE_SLIDER:
                        _loc4_ = this[_loc1_ + _loc2_.type];
                        _loc4_.removeEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChanged);
                        continue;
                     case SettingsConfig.TYPE_DROPDOWN:
                        _loc5_ = this[_loc1_ + _loc2_.type];
                        _loc5_.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
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
         }
         while((this.vibroControlsList) && this.vibroControlsList.length > 0)
         {
            this.vibroControlsList.pop();
         }
         super.onDispose();
      }

      override protected function draw() : void {
         super.draw();
      }

      override public function toString() : String {
         return "[WG GameSettings " + name + "]";
      }
   }

}