package net.wg.infrastructure.base.meta.impl
{
   import net.wg.gui.lobby.profile.pages.ProfileAchievementsSection;
   import net.wg.data.constants.Errors;


   public class ProfileAwardsMeta extends ProfileAchievementsSection
   {
          
      public function ProfileAwardsMeta() {
         super();
      }

      public var setFilter:Function = null;

      public function setFilterS(param1:Object) : void {
         App.utils.asserter.assertNotNull(this.setFilter,"setFilter" + Errors.CANT_NULL);
         this.setFilter(param1);
      }
   }

}