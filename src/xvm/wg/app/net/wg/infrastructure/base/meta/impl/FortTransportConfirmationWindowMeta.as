package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.fortifications.data.TransportingVO;
   import net.wg.infrastructure.exceptions.AbstractException;


   public class FortTransportConfirmationWindowMeta extends AbstractWindowView
   {
          
      public function FortTransportConfirmationWindowMeta() {
         super();
      }

      public var onCancel:Function = null;

      public var onTransporting:Function = null;

      public var onTransportingLimit:Function = null;

      public function onCancelS() : void {
         App.utils.asserter.assertNotNull(this.onCancel,"onCancel" + Errors.CANT_NULL);
         this.onCancel();
      }

      public function onTransportingS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.onTransporting,"onTransporting" + Errors.CANT_NULL);
         this.onTransporting(param1);
      }

      public function onTransportingLimitS() : void {
         App.utils.asserter.assertNotNull(this.onTransportingLimit,"onTransportingLimit" + Errors.CANT_NULL);
         this.onTransportingLimit();
      }

      public function as_setData(param1:Object) : void {
         var _loc2_:TransportingVO = new TransportingVO(param1);
         this.setData(_loc2_);
      }

      protected function setData(param1:TransportingVO) : void {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }

}