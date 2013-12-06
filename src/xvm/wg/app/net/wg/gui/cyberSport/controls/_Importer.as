package net.wg.gui.cyberSport.controls
{
   import net.wg.infrastructure.BaseImporter;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([CSComponentEvent,CSVehicleButton,CandidateItemRenderer,MedalVehicleVO,DynamicRangeVehicles,VehicleSelector,VehicleSelectorFilter,VehicleSelectorItemRenderer,SettingRosterVO,ManualSearchScrollingList,ManualSearchRenderer,ButtonDnmIcon,ButtonDnmIconSlim,RangeViewComponent,ReadyMsg,CSRosterToggleButton,DoubleSlider,RosterButtonGroup,CSCandidatesScrollingList,SlotDropIndicator,ButtonIconLoader,GrayButtonText,GrayTransparentButton,CSVehicleButtonLevels,RosterSettingsNumerationBlock]));
      }
   }

}