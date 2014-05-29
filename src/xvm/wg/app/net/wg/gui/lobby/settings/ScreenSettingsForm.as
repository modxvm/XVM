package net.wg.gui.lobby.settings
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.RangeSlider;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.display.MovieClip;


   public class ScreenSettingsForm extends UIComponent
   {
          
      public function ScreenSettingsForm() {
         super();
      }

      public var monitorLabel:LabelControl = null;

      public var monitorDropDown:DropdownMenu = null;

      public var fullScreenCheckbox:CheckBox = null;

      public var sizesLabel:LabelControl = null;

      public var sizesDropDown:DropdownMenu = null;

      public var refreshRateLabel:LabelControl = null;

      public var refreshRateDropDown:DropdownMenu = null;

      public var vertSyncCheckbox:CheckBox = null;

      public var aspectRatioLabel:LabelControl = null;

      public var aspectRatioDropDown:DropdownMenu = null;

      public var smoothingLabel:LabelControl = null;

      public var smoothingDropDown:DropdownMenu = null;

      public var gammaLabel:LabelControl = null;

      public var gammaSlider:Slider = null;

      public var colorFilterIntensityLabel:LabelControl = null;

      public var colorFilterIntensitySlider:Slider = null;

      public var colorFilterIntensityValue:LabelControl = null;

      public var isColorBlindCheckbox:CheckBox = null;

      public var fovLabel:LabelControl = null;

      public var fovRangeSlider:RangeSlider = null;

      public var dynamicFovCheckbox:CheckBox = null;

      public var colorFilterDefaultImg:UILoaderAlt = null;

      public var colorFilterOverlayImg:UILoaderAlt = null;

      public var COLOR_GRADING_TECHNIQUELabel:LabelControl = null;

      public var COLOR_GRADING_TECHNIQUEDropDown:DropdownMenu = null;

      public var topShadow:MovieClip;

      public var bottomShadow:MovieClip;

      private function initTexts() : void {
         this.monitorLabel.text = SETTINGS.MONITOR;
         this.fullScreenCheckbox.label = SETTINGS.FULLSCREEN;
         this.vertSyncCheckbox.label = SETTINGS.VERTSYNC;
         this.aspectRatioLabel.text = SETTINGS.ASPECTRATIO;
         this.smoothingLabel.text = SETTINGS.SMOOTHING;
         this.gammaLabel.text = SETTINGS.GAMMA;
         this.isColorBlindCheckbox.label = SETTINGS.ISCOLORBLIND;
         this.COLOR_GRADING_TECHNIQUELabel.text = SETTINGS.COLOR_GRADING_TECHNIQUE;
         this.refreshRateLabel.text = SETTINGS.REFRESHRATE;
         this.colorFilterIntensityLabel.text = SETTINGS.COLORFILTERINTENSITY;
         this.fovLabel.text = SETTINGS.FOV;
         this.dynamicFovCheckbox.label = SETTINGS.DYNAMICFOV;
      }

      override protected function configUI() : void {
         super.configUI();
         this.initTexts();
         this.colorFilterDefaultImg.source = RES_ICONS.MAPS_ICONS_SETTINGS_COLOR_GRADING_TECHNIQUE_NONE;
         this.refreshRateDropDown.labelField = null;
         this.topShadow.mouseChildren = this.topShadow.mouseEnabled = false;
         this.bottomShadow.mouseChildren = this.bottomShadow.mouseEnabled = false;
      }

      override protected function onDispose() : void {
         this.monitorLabel.dispose();
         this.monitorDropDown.dispose();
         this.fullScreenCheckbox.dispose();
         this.sizesLabel.dispose();
         this.sizesDropDown.dispose();
         this.refreshRateLabel.dispose();
         this.refreshRateDropDown.dispose();
         this.vertSyncCheckbox.dispose();
         this.aspectRatioLabel.dispose();
         this.aspectRatioDropDown.dispose();
         this.smoothingLabel.dispose();
         this.smoothingDropDown.dispose();
         this.gammaLabel.dispose();
         this.gammaSlider.dispose();
         this.colorFilterIntensityLabel.dispose();
         this.colorFilterIntensitySlider.dispose();
         this.colorFilterIntensityValue.dispose();
         this.isColorBlindCheckbox.dispose();
         this.colorFilterDefaultImg.dispose();
         this.colorFilterOverlayImg.dispose();
         this.COLOR_GRADING_TECHNIQUELabel.dispose();
         this.COLOR_GRADING_TECHNIQUEDropDown.dispose();
         this.fovLabel.dispose();
         this.fovRangeSlider.dispose();
         this.dynamicFovCheckbox.dispose();
         this.monitorLabel = null;
         this.monitorDropDown = null;
         this.fullScreenCheckbox = null;
         this.sizesLabel = null;
         this.sizesDropDown = null;
         this.refreshRateLabel = null;
         this.refreshRateDropDown = null;
         this.vertSyncCheckbox = null;
         this.aspectRatioLabel = null;
         this.aspectRatioDropDown = null;
         this.smoothingLabel = null;
         this.smoothingDropDown = null;
         this.gammaLabel = null;
         this.gammaSlider = null;
         this.colorFilterIntensityLabel = null;
         this.colorFilterIntensitySlider = null;
         this.colorFilterIntensityValue = null;
         this.isColorBlindCheckbox = null;
         this.colorFilterDefaultImg = null;
         this.colorFilterOverlayImg = null;
         this.COLOR_GRADING_TECHNIQUELabel = null;
         this.COLOR_GRADING_TECHNIQUEDropDown = null;
         this.fovLabel = null;
         this.fovRangeSlider = null;
         this.dynamicFovCheckbox = null;
         this.topShadow = null;
         this.bottomShadow = null;
         super.onDispose();
      }
   }

}