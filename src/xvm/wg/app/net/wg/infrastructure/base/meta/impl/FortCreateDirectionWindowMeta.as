package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;


   public class FortCreateDirectionWindowMeta extends AbstractWindowView
   {
          
      public function FortCreateDirectionWindowMeta() {
         super();
      }

      public var openNewDirection:Function = null;

      public var closeDirection:Function = null;

      public function openNewDirectionS() : void {
         App.utils.asserter.assertNotNull(this.openNewDirection,"openNewDirection" + Errors.CANT_NULL);
         this.openNewDirection();
      }

      public function closeDirectionS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.closeDirection,"closeDirection" + Errors.CANT_NULL);
         this.closeDirection(param1);
      }
   }

}