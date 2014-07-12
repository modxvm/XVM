package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.data.constants.Errors;
   
   public class LobbyPageMeta extends AbstractView
   {
      
      public function LobbyPageMeta() {
         super();
      }
      
      public var moveSpace:Function = null;
      
      public function moveSpaceS(param1:Number, param2:Number, param3:Number) : void {
         App.utils.asserter.assertNotNull(this.moveSpace,"moveSpace" + Errors.CANT_NULL);
         this.moveSpace(param1,param2,param3);
      }
   }
}
