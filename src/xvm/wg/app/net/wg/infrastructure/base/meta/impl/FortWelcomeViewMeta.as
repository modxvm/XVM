package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.fortifications.data.FortWelcomeViewVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class FortWelcomeViewMeta extends BaseDAAPIComponent
   {
      
      public function FortWelcomeViewMeta() {
         super();
      }
      
      public var onCreateBtnClick:Function = null;
      
      public var onNavigate:Function = null;
      
      public function onCreateBtnClickS() : void {
         App.utils.asserter.assertNotNull(this.onCreateBtnClick,"onCreateBtnClick" + Errors.CANT_NULL);
         this.onCreateBtnClick();
      }
      
      public function onNavigateS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.onNavigate,"onNavigate" + Errors.CANT_NULL);
         this.onNavigate(param1);
      }
      
      public function as_setCommonData(param1:Object) : void {
         var _loc2_:FortWelcomeViewVO = new FortWelcomeViewVO(param1);
         this.setCommonData(_loc2_);
      }
      
      protected function setCommonData(param1:FortWelcomeViewVO) : void {
         var _loc2_:String = "as_setCommonData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
