package net.wg.gui.components.common
{
   import flash.display.DisplayObject;
   import net.wg.data.constants.ContainerTypes;


   public class WaitingManagedContainer extends ManagedContainer
   {
          
      public function WaitingManagedContainer() {
         super();
         manageFocus = false;
         enabled = false;
         focusable = false;
         type = ContainerTypes.WAITING;
      }

      override public function setFocusedView(param1:DisplayObject) : void {
          
      }
   }

}