package net.wg.gui.components.common
{
   import net.wg.data.constants.Linkages;


   public class MainViewContainer extends ManagedContainer
   {
          
      public function MainViewContainer() {
         super();
      }

      override protected function getModalBgLinkage() : String {
         return Linkages.VIEW_LOAD_CURTAIN;
      }

      override protected function onDispose() : void {
         super.onDispose();
      }
   }

}