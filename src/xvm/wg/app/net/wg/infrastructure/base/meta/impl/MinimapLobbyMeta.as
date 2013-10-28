package net.wg.infrastructure.base.meta.impl
{
   import net.wg.gui.lobby.training.MinimapEntity;
   import net.wg.data.constants.Errors;


   public class MinimapLobbyMeta extends MinimapEntity
   {
          
      public function MinimapLobbyMeta() {
         super();
      }

      public var setMap:Function = null;

      public function setMapS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.setMap,"setMap" + Errors.CANT_NULL);
         this.setMap(param1);
      }
   }

}