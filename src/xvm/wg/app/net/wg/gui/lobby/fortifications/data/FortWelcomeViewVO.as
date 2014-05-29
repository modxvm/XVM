package net.wg.gui.lobby.fortifications.data
{
   import net.wg.gui.lobby.fortifications.data.base.BaseFortificationVO;


   public class FortWelcomeViewVO extends BaseFortificationVO
   {
          
      public function FortWelcomeViewVO(param1:Object) {
         super(param1);
      }

      private var _isOnClan:Boolean = false;

      public function canRoleCreateFort() : Boolean {
         return (isCommander) && (this._isOnClan);
      }

      public function canCreateFort() : Boolean {
         return (this.canRoleCreateFort()) && clanSize >= minClanSize;
      }

      public function get isOnClan() : Boolean {
         return this._isOnClan;
      }

      public function set isOnClan(param1:Boolean) : void {
         this._isOnClan = param1;
      }
   }

}