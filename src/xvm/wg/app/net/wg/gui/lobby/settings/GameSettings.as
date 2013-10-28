package net.wg.gui.lobby.settings
{
   import flash.display.Sprite;
   import net.wg.gui.components.advanced.FieldSet;
   import net.wg.gui.components.controls.CheckBox;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import flash.events.Event;
   import scaleform.clik.events.SliderEvent;
   import net.wg.gui.lobby.settings.evnts.SettingViewEvent;


   public class GameSettings extends SettingsBaseView
   {
          
      public function GameSettings() {
         super();
      }

      public var bgFrom:Sprite = null;

      public var fieldSetChat:FieldSet = null;

      public var fieldSetInstructionPanel:FieldSet = null;

      public var fieldSetBattleTypes:FieldSet = null;

      public var fieldSetVibro:FieldSet = null;

      public var enableOlFilterCheckbox:CheckBox = null;

      public var enableSpamFilterCheckbox:CheckBox = null;

      public var showDateMessageCheckbox:CheckBox = null;

      public var showTimeMessageCheckbox:CheckBox = null;

      public var invitesFromFriendsOnlyCheckbox:CheckBox = null;

      public var enableStoreCwsCheckbox:CheckBox = null;

      public var enableStoreMwsCheckbox:CheckBox = null;

      public var storeReceiverInBattleCheckbox:CheckBox = null;

      public var ppShowLevelsCheckbox:CheckBox = null;

      public var gameplay_ctfCheckbox:CheckBox = null;

      public var gameplay_dominationCheckbox:CheckBox = null;

      public var gameplay_assaultCheckbox:CheckBox = null;

      public var vibroDeviceConnectionStateField:TextField = null;

      public var vibroGainLabel:TextField = null;

      public var vibroGainSlider:Slider = null;

      public var vibroGainValue:LabelControl = null;

      public var vibroEngineLabel:TextField = null;

      public var vibroEngineSlider:Slider = null;

      public var vibroEngineValue:LabelControl = null;

      public var vibroAccelerationLabel:TextField = null;

      public var vibroAccelerationSlider:Slider = null;

      public var vibroAccelerationValue:LabelControl = null;

      public var vibroShotsLabel:TextField = null;

      public var vibroShotsSlider:Slider = null;

      public var vibroShotsValue:LabelControl = null;

      public var vibroHitsLabel:TextField = null;

      public var vibroHitsSlider:Slider = null;

      public var vibroHitsValue:LabelControl = null;

      public var vibroCollisionsLabel:TextField = null;

      public var vibroCollisionsSlider:Slider = null;

      public var vibroCollisionsValue:LabelControl = null;

      public var vibroDamageLabel:TextField = null;

      public var vibroDamageSlider:Slider = null;

      public var vibroDamageValue:LabelControl = null;

      public var vibroGUILabel:TextField = null;

      public var vibroGUISlider:Slider = null;

      public var vibroGUIValue:LabelControl = null;

      public var minimapAlphaSliderLabel:TextField = null;

      public var minimapAlphaSlider:Slider = null;

      public var enablePostMortemEffectCheckbox:CheckBox = null;

      public var dynamicCameraCheckbox:CheckBox = null;

      public var horStabilizationSnpCheckbox:CheckBox = null;

      public var replayEnabledCheckbox:CheckBox = null;

      public var useServerAimCheckbox:CheckBox = null;

      public var showVehiclesCounterCheckbox:CheckBox = null;

      private var vibroControlsList:Array = null;

      private var missChangeEvent:Boolean = false;

      override protected function configUI() : void {
         super.configUI();
         this.fieldSetChat.label = SETTINGS.GAME_FIELDSET_HEADERCHAT;
         this.fieldSetInstructionPanel.label = SETTINGS.GAME_PLAYERPANELSETTINGS;
         this.fieldSetBattleTypes.label = SETTINGS.GAME_FIELDSET_HEADERGAMEPLAY;
         this.fieldSetVibro.label = SETTINGS.VIBRO_FIELDSET_HEADER;
         this.enableOlFilterCheckbox.label = SETTINGS.CHAT_CENSORSHIPMESSAGES;
         this.enableSpamFilterCheckbox.label = SETTINGS.CHAT_REMOVESPAM;
         this.showDateMessageCheckbox.label = SETTINGS.CHAT_SHOWDATEMESSAGE;
         this.showTimeMessageCheckbox.label = SETTINGS.CHAT_SHOWTIMEMESSAGE;
         this.invitesFromFriendsOnlyCheckbox.label = SETTINGS.CHAT_INVITESFROMFRIENDSONLY;
         this.enableStoreCwsCheckbox.label = SETTINGS.CHAT_ENABLESTORECHANNELSWINDOWS;
         this.enableStoreMwsCheckbox.label = SETTINGS.CHAT_ENABLESTOREMANAGEMENTWINDOWS;
         this.storeReceiverInBattleCheckbox.label = SETTINGS.CHAT_STORERECEIVERINBATTLE;
         this.ppShowLevelsCheckbox.label = SETTINGS.GAME_PPSHOWLEVELS;
         this.gameplay_ctfCheckbox.label = SETTINGS.GAMEPLAY_CTF;
         this.gameplay_dominationCheckbox.label = SETTINGS.GAMEPLAY_DOMINATION;
         this.gameplay_assaultCheckbox.label = SETTINGS.GAMEPLAY_ASSAULT;
         this.vibroDeviceConnectionStateField.text = SETTINGS.VIBRO_DEVICE_STATE_NOTCONNECTED;
         this.vibroGainLabel.text = SETTINGS.VIBRO_LABELS_GAIN;
         this.vibroEngineLabel.text = SETTINGS.VIBRO_LABELS_ENGINE;
         this.vibroAccelerationLabel.text = SETTINGS.VIBRO_LABELS_ACCELERATION;
         this.vibroShotsLabel.text = SETTINGS.VIBRO_LABELS_SHOTS;
         this.vibroHitsLabel.text = SETTINGS.VIBRO_LABELS_HITS;
         this.vibroCollisionsLabel.text = SETTINGS.VIBRO_LABELS_COLLISIONS;
         this.vibroDamageLabel.text = SETTINGS.VIBRO_LABELS_DAMAGE;
         this.vibroGUILabel.text = SETTINGS.VIBRO_LABELS_GUI;
         this.minimapAlphaSliderLabel.text = SETTINGS.MINIMAP_LABELS_ALPHA;
         this.enablePostMortemEffectCheckbox.label = SETTINGS.GAME_ENABLEMORTALPOSTEFFECT;
         this.dynamicCameraCheckbox.label = SETTINGS.GAME_DYNAMICCAMERA;
         this.horStabilizationSnpCheckbox.label = SETTINGS.GAME_HORSTABILIZATIONSNP;
         this.replayEnabledCheckbox.label = SETTINGS.GAME_REPLAYENABLED;
         this.useServerAimCheckbox.label = SETTINGS.CURSOR_SERVERAIM;
         this.showVehiclesCounterCheckbox.label = SETTINGS.GAME_SHOWVEHICLESCOUNTER;
         super.configUI();
      }

      override public function update(param1:Object) : void {
         super.update(param1);
      }

      override protected function setData(param1:Object) : void {
         var _loc2_:String = null;
         var _loc3_:* = false;
         var _loc5_:SettingsControlProp = null;
         var _loc6_:* = false;
         var _loc7_:CheckBox = null;
         var _loc8_:Slider = null;
         var _loc9_:LabelControl = null;
         var _loc10_:* = false;
         this.vibroControlsList = [];
         for (_loc2_ in _data)
         {
            _loc5_ = SettingsControlProp(_data[_loc2_]);
            if(this[_loc2_ + _loc5_.type])
            {
               _loc6_ = !(_loc5_.current == null || (_loc5_.readOnly));
               switch(_loc5_.type)
               {
                  case SettingsConfig.TYPE_CHECKBOX:
                     _loc7_ = CheckBox(this[_loc2_ + _loc5_.type]);
                     _loc7_.selected = _loc5_.current;
                     _loc7_.enabled = _loc6_;
                     _loc7_.addEventListener(Event.SELECT,this.onCheckBoxSelected);
                     break;
                  case SettingsConfig.TYPE_SLIDER:
                     _loc8_ = Slider(this[_loc2_ + _loc5_.type]);
                     _loc8_.value = _loc5_.current;
                     _loc8_.enabled = _loc6_;
                     _loc8_.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChanged);
                     if((_loc5_.hasValue) && (this[_loc2_ + SettingsConfig.TYPE_VALUE]))
                     {
                        _loc9_ = this[_loc2_ + SettingsConfig.TYPE_VALUE];
                        _loc9_.text = _loc5_.current;
                     }
                     break;
               }
               if(_loc5_.isDependOn)
               {
                  if(_loc5_.isDependOn == SettingsConfig.VIBRO_IS_CONNECTED)
                  {
                     this.vibroControlsList.push(_loc2_);
                  }
                  _loc10_ = SettingsControlProp(_data[_loc5_.isDependOn]).current;
                  this.showHideControl(_loc2_,_loc5_,_loc10_);
               }
            }
            else
            {
               if(!_loc5_.readOnly)
               {
                  DebugUtils.LOG_WARNING("ERROR in" + this + " control " + (_loc2_ + _loc5_.type) + " can not find");
               }
            }
         }
         _loc3_ = SettingsControlProp(_data.vibroIsConnected).current;
         this.vibroDeviceConnectionStateField.text = _loc3_?SETTINGS.VIBRO_DEVICE_STATE_CONNECTED:SETTINGS.VIBRO_DEVICE_STATE_NOTCONNECTED;
         this.vibroDeviceConnectionStateField.visible = _loc3_;
         this.fieldSetVibro.visible = _loc3_;
         if((this.horStabilizationSnpCheckbox) && (this.dynamicCameraCheckbox))
         {
            this.enableHorStabilizationSnp(this.dynamicCameraCheckbox.selected);
         }
         var _loc4_:int = SettingsControlProp(SettingsConfig.settingsData[SettingsConfig.GRAPHIC_SETTINGS].POST_PROCESSING_QUALITY).current;
         this.enablePostMortemEffectCheckbox.enabled = !(_loc4_ == 4);
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
               this.horStabilizationSnpCheckbox.selected = _loc3_.lastVal;
            }
            else
            {
               _loc3_.lastVal = this.horStabilizationSnpCheckbox.selected;
               this.horStabilizationSnpCheckbox.selected = false;
            }
            this.missChangeEvent = false;
            this.horStabilizationSnpCheckbox.enabled = param1;
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
         this.vibroDeviceConnectionStateField.text = _loc1_?SETTINGS.VIBRO_DEVICE_STATE_CONNECTED:SETTINGS.VIBRO_DEVICE_STATE_NOTCONNECTED;
         this.vibroDeviceConnectionStateField.visible = _loc1_;
         this.fieldSetVibro.visible = _loc1_;
      }

      override public function dispose() : void {
         var _loc1_:String = null;
         var _loc2_:SettingsControlProp = null;
         var _loc3_:CheckBox = null;
         var _loc4_:Slider = null;
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
         super.dispose();
      }

      override protected function draw() : void {
          
      }

      override public function toString() : String {
         return "[WG GameSettings " + name + "]";
      }
   }

}