package net.wg.infrastructure.base.meta.impl
{
   import net.wg.gui.rally.views.intro.BaseRallyIntroView;
   import net.wg.data.constants.Errors;


   public class CyberSportIntroMeta extends BaseRallyIntroView
   {
          
      public function CyberSportIntroMeta() {
         super();
      }

      public var requestVehicleSelection:Function = null;

      public var startAutoMatching:Function = null;

      public var showSelectorPopup:Function = null;

      public function requestVehicleSelectionS() : void {
         App.utils.asserter.assertNotNull(this.requestVehicleSelection,"requestVehicleSelection" + Errors.CANT_NULL);
         this.requestVehicleSelection();
      }

      public function startAutoMatchingS() : void {
         App.utils.asserter.assertNotNull(this.startAutoMatching,"startAutoMatching" + Errors.CANT_NULL);
         this.startAutoMatching();
      }

      public function showSelectorPopupS() : void {
         App.utils.asserter.assertNotNull(this.showSelectorPopup,"showSelectorPopup" + Errors.CANT_NULL);
         this.showSelectorPopup();
      }
   }

}