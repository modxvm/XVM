package net.wg.gui.lobby.settings
{
   import net.wg.gui.components.advanced.FieldSet;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import scaleform.clik.events.SliderEvent;
   import net.wg.gui.lobby.settings.evnts.SettingViewEvent;
   
   public class OtherSettings extends SettingsBaseView
   {
      
      public function OtherSettings() {
         super();
      }
      
      private var vibroControlsList:Array = null;
      
      public var fieldSetVibro:FieldSet = null;
      
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
      
      override protected function configUI() : void {
         super.configUI();
         this.vibroDeviceConnectionStateField.text = SETTINGS.VIBRO_DEVICE_STATE_NOTCONNECTED;
         this.vibroGainLabel.text = SETTINGS.VIBRO_LABELS_GAIN;
         this.vibroEngineLabel.text = SETTINGS.VIBRO_LABELS_ENGINE;
         this.vibroAccelerationLabel.text = SETTINGS.VIBRO_LABELS_ACCELERATION;
         this.vibroShotsLabel.text = SETTINGS.VIBRO_LABELS_SHOTS;
         this.vibroHitsLabel.text = SETTINGS.VIBRO_LABELS_HITS;
         this.vibroCollisionsLabel.text = SETTINGS.VIBRO_LABELS_COLLISIONS;
         this.vibroDamageLabel.text = SETTINGS.VIBRO_LABELS_DAMAGE;
         this.vibroGUILabel.text = SETTINGS.VIBRO_LABELS_GUI;
         this.fieldSetVibro.label = SETTINGS.VIBRO_FIELDSET_HEADER;
      }
      
      override protected function setData(param1:Object) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
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
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,_loc2_.value));
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
      
      override protected function onDispose() : void {
         while((this.vibroControlsList) && this.vibroControlsList.length > 0)
         {
            this.vibroControlsList.pop();
         }
         super.onDispose();
      }
   }
}
