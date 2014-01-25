package net.wg.gui.lobby.settings
{
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.advanced.FieldSet;


   public class GraphicSettingsBase extends SettingsBaseView
   {
          
      public function GraphicSettingsBase() {
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

      public var MOTION_BLUR_QUALITYLabel:LabelControl = null;

      public var MOTION_BLUR_QUALITYDropDown:DropdownMenu = null;

      public var FAR_PLANELabel:LabelControl = null;

      public var FAR_PLANEDropDown:DropdownMenu = null;

      public var OBJECT_LODLabel:LabelControl = null;

      public var OBJECT_LODDropDown:DropdownMenu = null;

      public var SNIPER_MODE_EFFECTS_QUALITYLabel:LabelControl = null;

      public var SNIPER_MODE_EFFECTS_QUALITYDropDown:DropdownMenu = null;

      public var COLOR_GRADING_TECHNIQUELabel:LabelControl = null;

      public var COLOR_GRADING_TECHNIQUEDropDown:DropdownMenu = null;

      public var fpsPerfomancerCheckbox:CheckBox = null;

      public var SNIPER_MODE_GRASS_ENABLEDCheckbox:CheckBox = null;

      public var VEHICLE_DUST_ENABLEDCheckbox:CheckBox = null;

      public var VEHICLE_TRACES_ENABLEDCheckbox:CheckBox = null;

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
         this.MOTION_BLUR_QUALITYLabel.text = "";
         this.FAR_PLANELabel.text = "";
         this.OBJECT_LODLabel.text = "";
         this.SNIPER_MODE_EFFECTS_QUALITYLabel.text = "";
         this.COLOR_GRADING_TECHNIQUELabel.text = "";
         this.fpsPerfomancerCheckbox.label = "";
         this.SNIPER_MODE_GRASS_ENABLEDCheckbox.label = "";
         this.VEHICLE_DUST_ENABLEDCheckbox.label = "";
         this.VEHICLE_TRACES_ENABLEDCheckbox.label = "";
         super.configUI();
      }
   }

}