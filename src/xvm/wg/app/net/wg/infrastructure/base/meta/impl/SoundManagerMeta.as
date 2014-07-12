package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIModule;
   import net.wg.data.constants.Errors;
   
   public class SoundManagerMeta extends BaseDAAPIModule
   {
      
      public function SoundManagerMeta() {
         super();
      }
      
      public var soundEventHandler:Function = null;
      
      public function soundEventHandlerS(param1:String, param2:String, param3:String, param4:String) : void {
         App.utils.asserter.assertNotNull(this.soundEventHandler,"soundEventHandler" + Errors.CANT_NULL);
         this.soundEventHandler(param1,param2,param3,param4);
      }
   }
}
