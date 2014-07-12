package net.wg.infrastructure.base.meta.impl
{
   import net.wg.gui.lobby.profile.pages.ProfileSection;
   import net.wg.data.constants.Errors;
   
   public class ProfileStatisticsMeta extends ProfileSection
   {
      
      public function ProfileStatisticsMeta() {
         super();
      }
      
      public var getData:Function = null;
      
      public function getDataS(param1:Object) : void {
         App.utils.asserter.assertNotNull(this.getData,"getData" + Errors.CANT_NULL);
         this.getData(param1);
      }
   }
}
