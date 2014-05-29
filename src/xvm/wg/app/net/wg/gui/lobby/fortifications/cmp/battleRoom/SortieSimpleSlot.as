package net.wg.gui.lobby.fortifications.cmp.battleRoom
{
   import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
   import net.wg.gui.rally.controls.IGrayTransparentButton;
   import net.wg.gui.components.controls.SoundButtonEx;


   public class SortieSimpleSlot extends RallySimpleSlotRenderer
   {
          
      public function SortieSimpleSlot() {
         super();
      }

      public var showTakePlaceBtn:Boolean = false;

      public function get grayTakePlaceFirstButton() : IGrayTransparentButton {
         return takePlaceFirstTimeBtn as IGrayTransparentButton;
      }

      public function set grayTakePlaceFirstButton(param1:IGrayTransparentButton) : void {
         takePlaceFirstTimeBtn = param1 as SoundButtonEx;
      }

      override protected function configUI() : void {
         super.configUI();
         takePlaceBtn.label = FORTIFICATIONS.SORTIE_SLOT_TAKEPLACE;
         this.grayTakePlaceFirstButton.label = FORTIFICATIONS.SORTIE_SLOT_TAKEPLACE;
      }
   }

}