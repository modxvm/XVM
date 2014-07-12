package net.wg.gui.components.common
{
   import net.wg.data.constants.Linkages;
   import net.wg.infrastructure.interfaces.IManagedContent;
   import flash.display.DisplayObject;
   
   public class MainViewContainer extends ManagedContainer
   {
      
      public function MainViewContainer() {
         super();
      }
      
      override protected function getModalBgLinkage() : String {
         return Linkages.VIEW_LOAD_CURTAIN;
      }
      
      override public function tryToUpdateContent() : void {
         var _loc1_:IManagedContent = getTopmostView();
         if(_loc1_)
         {
            if(_loc1_.isModal)
            {
               updateOrCreateModalBg(_loc1_.modalAlpha);
            }
            setChildIndex(DisplayObject(_loc1_.containerContent),numChildren - 1);
         }
      }
   }
}
