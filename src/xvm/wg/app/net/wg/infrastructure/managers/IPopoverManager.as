package net.wg.infrastructure.managers
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;


   public interface IPopoverManager extends IDisposable
   {
          
      function show(param1:Object, param2:String, param3:int, param4:int, param5:Object=null) : void;

      function hide() : void;
   }

}