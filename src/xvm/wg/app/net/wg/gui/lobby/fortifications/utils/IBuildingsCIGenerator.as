package net.wg.gui.lobby.fortifications.utils
{
   import net.wg.infrastructure.interfaces.IContextItem;
   
   public interface IBuildingsCIGenerator
   {
      
      function generateGeneralCtxItems(param1:Array) : Vector.<IContextItem>;
   }
}
