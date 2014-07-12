package net.wg.infrastructure.managers
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.interfaces.IClosePopoverCallback;
   import net.wg.infrastructure.interfaces.IOpenPopoverCallback;
   
   public interface IPopoverManager extends IDisposable
   {
      
      function show(param1:IPopOverCaller, param2:String, param3:int, param4:int, param5:Object = null, param6:IClosePopoverCallback = null, param7:IOpenPopoverCallback = null) : void;
      
      function hide() : void;
      
      function get popoverCaller() : IPopOverCaller;
   }
}
