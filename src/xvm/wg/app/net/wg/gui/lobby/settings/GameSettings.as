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

      private var missChangeEvent:Boolean = false;

      override protected function configUI() : void {
         super.configUI();
      }

      override public function update(param1:Object) : void {
         super.update(param1);
      }

      override protected function setData(param1:Object) : void {
         var _loc2_:String = null;
         var _loc3_:SettingsControlProp = null;
         var _loc4_:* = false;
         var _loc5_:CheckBox = null;
         var _loc6_:DropdownMenu = null;
         var _loc7_:Slider = null;
         var _loc8_:LabelControl = null;
         super.setData(param1);
         for (_loc2_ in _data)
         {
            _loc3_ = SettingsControlProp(_data[_loc2_]);
            if(this[_loc2_ + _loc3_.type])
            {
               _loc4_ = !(_loc3_.current == null || (_loc3_.readOnly));
               switch(_loc3_.type)
               {
                  case SettingsConfig.TYPE_CHECKBOX:
                     _loc5_ = CheckBox(this[_loc2_ + _loc3_.type]);
                     _loc5_.selected = _loc3_.current;
                     _loc5_.enabled = _loc4_;
                     _loc5_.addEventListener(Event.SELECT,this.onCheckBoxSelected);
                     break;
                  case SettingsConfig.TYPE_DROPDOWN:
                     _loc6_ = this[_loc2_ + _loc3_.type];
                     _loc6_.dataProvider = new DataProvider(_loc3_.options);
                     _loc6_.menuRowCount = _loc3_.options  is  Array?_loc3_.options.length:0;
                     _loc6_.selectedIndex = _loc3_.current;
                     _loc6_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
                     break;
                  case SettingsConfig.TYPE_SLIDER:
                     _loc7_ = Slider(this[_loc2_ + _loc3_.type]);
                     _loc7_.value = _loc3_.current;
                     _loc7_.enabled = _loc4_;
                     _loc7_.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChanged);
                     if((_loc3_.hasValue) && (this[_loc2_ + SettingsConfig.TYPE_VALUE]))
                     {
                        _loc8_ = this[_loc2_ + SettingsConfig.TYPE_VALUE];
                        _loc8_.text = _loc3_.current;
                     }
                     break;
               }
            }
            else
            {
               if(!_loc3_.readOnly)
               {
                  DebugUtils.LOG_WARNING("ERROR in" + this + " control " + (_loc2_ + _loc3_.type) + " can not find");
               }
            }
         }
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