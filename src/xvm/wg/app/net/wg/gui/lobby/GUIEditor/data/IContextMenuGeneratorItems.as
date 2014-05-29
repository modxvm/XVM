package net.wg.gui.lobby.GUIEditor.data
{
   import __AS3__.vec.Vector;
   import net.wg.infrastructure.interfaces.IContextItem;


   public interface IContextMenuGeneratorItems
   {
          
      function generateItemsContextMenu(param1:String) : Vector.<IContextItem>;
   }

}