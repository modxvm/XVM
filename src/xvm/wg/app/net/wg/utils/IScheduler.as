package net.wg.utils
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IScheduler extends IDisposable
   {
      
      function scheduleTask(param1:Function, param2:Number, ... rest) : void;
      
      function scheduleNonCancelableTask(param1:Function, param2:Number, ... rest) : void;
      
      function envokeInNextFrame(param1:Function, ... rest) : void;
      
      function cancelTask(param1:Function) : void;
      
      function cancelAll() : void;
      
      function isEmpty() : Boolean;
   }
}
