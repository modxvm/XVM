package net.wg.gui.lobby.techtree.controls
{
   import net.wg.data.constants.SoundTypes;


   public class ReturnToTTButton extends NationButton
   {
          
      public function ReturnToTTButton() {
         super();
      }

      override protected function defineSoundProps() : void {
         soundType = SoundTypes.CLOSE_WINDOW;
      }
   }

}