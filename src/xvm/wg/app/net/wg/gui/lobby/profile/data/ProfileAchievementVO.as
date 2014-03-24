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

      public var showProgress:Boolean;

      public var minValueForRecord:int = -1;

      public var arr:Array;

      public var hasCounter:Boolean;

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         if(param1 == "isDossierForCurrentUser")
         {
            this.showProgress = param2;
            this.isDossierForCurrentUser = param2;
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }

}