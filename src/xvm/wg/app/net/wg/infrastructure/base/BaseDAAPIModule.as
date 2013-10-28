package net.wg.infrastructure.base
{
   import net.wg.infrastructure.base.meta.impl.BaseDAAPIModuleMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.data.constants.Errors;


   public class BaseDAAPIModule extends BaseDAAPIModuleMeta implements IDAAPIModule
   {
          
      public function BaseDAAPIModule() {
         super();
      }

      private var _disposed:Boolean = false;

      public function get disposed() : Boolean {
         return this._disposed;
      }

      protected function onPopulate() : void {
          
      }

      protected function onDispose() : void {
          
      }

      public final function as_populate() : void {
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_POPULATE));
         this.onPopulate();
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_POPULATE));
      }

      public final function as_dispose() : void {
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
         this.onDispose();
         this._disposed = true;
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
      }

      protected final function assert(param1:Boolean, param2:String="failed assert") : void {
         App.utils.asserter.assert(param1,param2);
      }

      protected final function assertNotNull(param1:Object, param2:String="object") : void {
         App.utils.asserter.assertNotNull(param1,param2 + Errors.CANT_NULL);
      }

      protected final function assertNull(param1:Object, param2:String="object") : void {
         App.utils.asserter.assertNull(param1,param2 + Errors.MUST_NULL);
      }
   }

}