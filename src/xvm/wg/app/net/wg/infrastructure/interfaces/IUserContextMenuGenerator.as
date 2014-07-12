package net.wg.infrastructure.interfaces
{
   import net.wg.data.daapi.PlayerInfo;
   
   public interface IUserContextMenuGenerator
   {
      
      function generateData(param1:PlayerInfo, param2:Number = NaN) : Vector.<IContextItem>;
   }
}
