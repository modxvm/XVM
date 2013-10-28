package net.wg.gui.lobby.profile.data
{
   import net.wg.data.VO.AchievementItemVO;


   public class ProfileAchievementVO extends AchievementItemVO
   {
          
      public function ProfileAchievementVO(param1:Object) {
         super(param1);
      }

      public var isInDossier:Boolean;

      public var id:Array;

      public var rareIconId:String = "";

      public var isRare:Boolean;

      public var lvlUpValue:uint;

      public var lvlUpTotalValue:uint;

      public var isDossierForCurrentUser:Boolean;

      public var arr:Array;
   }

}