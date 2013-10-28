package net.wg.gui.components.common
{
   import net.wg.data.constants.ContainerTypes;


   public class CursorManagedContainer extends ManagedContainer
   {
          
      public function CursorManagedContainer() {
         super();
         manageFocus = false;
         enabled = false;
         mouseEnabled = false;
         mouseChildren = false;
         type = ContainerTypes.CURSOR;
      }
   }

}