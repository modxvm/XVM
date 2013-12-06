package net.wg.gui.cyberSport
{
   import net.wg.infrastructure.BaseImporter;
   import net.wg.gui.cyberSport.views.events.CyberSportEvent;
   import net.wg.gui.cyberSport.views.IntroView;
   import net.wg.gui.cyberSport.views.UnitsListView;
   import net.wg.gui.cyberSport.views.UnitView;
   import net.wg.gui.cyberSport.popups.VehicleSelectorPopup;
   import net.wg.gui.cyberSport.views.RosterSlotSettingsWindow;
   import net.wg.gui.cyberSport.views.RangeRosterSettingsView;
   import net.wg.gui.cyberSport.views.unit.ChatSection;
   import net.wg.gui.cyberSport.views.unit.SlotRenderer;
   import net.wg.gui.cyberSport.views.unit.TeamSection;
   import net.wg.gui.cyberSport.views.unit.WaitListSection;
   import net.wg.gui.cyberSport.views.AnimatedRosterSettingsView;
   import net.wg.gui.cyberSport.views.RosterSettingsView;
   import net.wg.gui.cyberSport.helpers.CSDragDropDelegate;
   import net.wg.gui.cyberSport.helpers.CSDragDropListDelegateController;
   import net.wg.gui.cyberSport.controls.SlotDropIndicator;
   import net.wg.gui.cyberSport.views.autoSearch.CSAutoSearchMainView;
   import net.wg.gui.cyberSport.views.autoSearch.ConfirmationReadinessStatus;
   import net.wg.gui.cyberSport.views.autoSearch.ErrorState;
   import net.wg.gui.cyberSport.views.autoSearch.SearchCommands;
   import net.wg.gui.cyberSport.views.autoSearch.SearchEnemy;
   import net.wg.gui.cyberSport.views.autoSearch.WaitingPlayers;
   import net.wg.gui.cyberSport.views.autoSearch.StateViewBase;
   import net.wg.gui.cyberSport.views.unit.SimpleSlotRenderer;
   import net.wg.gui.cyberSport.data.CandidatesDataProvider;
   import net.wg.gui.cyberSport.data.ManualSearchDataProvider;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([CyberSportEvent,CyberSportMainWindow,IntroView,UnitsListView,UnitView,VehicleSelectorPopup,RosterSlotSettingsWindow,RangeRosterSettingsView,ChatSection,SlotRenderer,TeamSection,WaitListSection,AnimatedRosterSettingsView,RosterSettingsView,CSDragDropDelegate,CSDragDropListDelegateController,SlotDropIndicator,CSAutoSearchMainView,ConfirmationReadinessStatus,ErrorState,SearchCommands,SearchEnemy,WaitingPlayers,StateViewBase,SimpleSlotRenderer,CandidatesDataProvider,ManualSearchDataProvider]));
      }
   }

}