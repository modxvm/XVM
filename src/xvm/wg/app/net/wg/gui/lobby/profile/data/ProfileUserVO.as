package net.wg.gui.lobby.profile.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class ProfileUserVO extends DAAPIDataClass
   {
          
      public function ProfileUserVO(param1:Object) {
         super(param1);
      }

      public var name:String = "";

      public var registrationDate:String = "";

      public var lastBattleDate:String = "";

      public var clanName:String = "";

      public var clanNameDescr:String = "";

      public var clanLabel:String = "";

      public var clanJoinTime:String = "";

      public var clanPosition:String = "";

      public var clanEmblem:* = null;
   }

}
