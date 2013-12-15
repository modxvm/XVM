package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIModule;
   import net.wg.data.constants.Errors;


   public class ContainerManagerMeta extends BaseDAAPIModule
   {
          
      public function ContainerManagerMeta() {
         super();
      }

      public var isModalViewsIsExists:Function = null;

      public var removeLoadingTokens:Function = null;

      public var canCancelPreviousLoading:Function = null;

      public function isModalViewsIsExistsS() : Boolean {
         App.utils.asserter.assertNotNull(this.isModalViewsIsExists,"isModalViewsIsExists" + Errors.CANT_NULL);
         return this.isModalViewsIsExists();
      }

      public function removeLoadingTokensS(param1:Array) : void {
         App.utils.asserter.assertNotNull(this.removeLoadingTokens,"removeLoadingTokens" + Errors.CANT_NULL);
         this.removeLoadingTokens(param1);
      }

      public function canCancelPreviousLoadingS(param1:String) : Boolean {
         App.utils.asserter.assertNotNull(this.canCancelPreviousLoading,"canCancelPreviousLoading" + Errors.CANT_NULL);
         return this.canCancelPreviousLoading(param1);
      }
   }

}