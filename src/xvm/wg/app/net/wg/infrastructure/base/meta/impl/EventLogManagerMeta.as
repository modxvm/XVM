package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIModule;
   import net.wg.data.constants.Errors;
   
   public class EventLogManagerMeta extends BaseDAAPIModule
   {
      
      public function EventLogManagerMeta() {
         super();
      }
      
      public var logEvent:Function = null;
      
      public function logEventS(param1:int, param2:String, param3:int, param4:int) : void {
         App.utils.asserter.assertNotNull(this.logEvent,"logEvent" + Errors.CANT_NULL);
         this.logEvent(param1,param2,param3,param4);
      }
   }
}
