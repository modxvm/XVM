package net.wg.gui.lobby.fortifications.utils
{
   import __AS3__.vec.Vector;
   import net.wg.infrastructure.interfaces.IContextItem;


   public interface IBuildingsCIGenerator
   {
          
      function generateGeneralCtxItems(param1:Array) : Vector.<IContextItem>;
   }

}