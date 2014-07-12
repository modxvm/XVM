package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.gui.lobby.fortifications.data.FortClanListWindowVO;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class FortClanListWindowMeta extends AbstractWindowView
   {
      
      public function FortClanListWindowMeta() {
         super();
      }
      
      public function as_setData(param1:Object) : void {
         var _loc2_:FortClanListWindowVO = new FortClanListWindowVO(param1);
         this.setData(_loc2_);
      }
      
      protected function setData(param1:FortClanListWindowVO) : void {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
