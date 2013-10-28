package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIModule;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.data.constants.Errors;


   public class LoaderManagerMeta extends BaseDAAPIModule
   {
          
      public function LoaderManagerMeta() {
         super();
      }

      public var viewLoaded:Function = null;

      public var viewLoadError:Function = null;

      public var viewInitializationError:Function = null;

      public function viewLoadedS(param1:String, param2:IView) : void {
         App.utils.asserter.assertNotNull(this.viewLoaded,"viewLoaded" + Errors.CANT_NULL);
         this.viewLoaded(param1,param2);
      }

      public function viewLoadErrorS(param1:String, param2:String, param3:String) : void {
         App.utils.asserter.assertNotNull(this.viewLoadError,"viewLoadError" + Errors.CANT_NULL);
         this.viewLoadError(param1,param2,param3);
      }

      public function viewInitializationErrorS(param1:String, param2:Object, param3:String) : void {
         App.utils.asserter.assertNotNull(this.viewInitializationError,"viewInitializationError" + Errors.CANT_NULL);
         this.viewInitializationError(param1,param2,param3);
      }
   }

}