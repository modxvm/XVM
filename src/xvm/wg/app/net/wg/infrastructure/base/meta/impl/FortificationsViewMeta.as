package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.fortifications.data.FortificationVO;
   import net.wg.infrastructure.exceptions.AbstractException;


   public class FortificationsViewMeta extends AbstractView
   {
          
      public function FortificationsViewMeta() {
         super();
      }

      public var onFortCreateClick:Function = null;

      public var onDirectionCreateClick:Function = null;

      public var onEscapePress:Function = null;

      public function onFortCreateClickS() : void {
         App.utils.asserter.assertNotNull(this.onFortCreateClick,"onFortCreateClick" + Errors.CANT_NULL);
         this.onFortCreateClick();
      }

      public function onDirectionCreateClickS() : void {
         App.utils.asserter.assertNotNull(this.onDirectionCreateClick,"onDirectionCreateClick" + Errors.CANT_NULL);
         this.onDirectionCreateClick();
      }

      public function onEscapePressS() : void {
         App.utils.asserter.assertNotNull(this.onEscapePress,"onEscapePress" + Errors.CANT_NULL);
         this.onEscapePress();
      }

      public function as_setCommonData(param1:Object) : void {
         var _loc2_:FortificationVO = new FortificationVO(param1);
         this.setCommonData(_loc2_);
      }

      protected function setCommonData(param1:FortificationVO) : void {
         var _loc2_:String = "as_setCommonData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }

}