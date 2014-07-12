package net.wg.gui.lobby.GUIEditor.views
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import flash.display.InteractiveObject;
   
   public class EventsView extends UIComponent implements IViewStackContent
   {
      
      public function EventsView() {
         super();
      }
      
      public function update(param1:Object) : void {
      }
      
      public function getComponentForFocus() : InteractiveObject {
         return null;
      }
      
      public function canShowAutomatically() : Boolean {
         return true;
      }
   }
}
