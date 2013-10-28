package net.wg.gui.prebattle.squad
{


   public class MessengerUtils extends Object
   {
          
      public function MessengerUtils() {
         super();
      }

      public static function getFullChannelName(param1:Object) : String {
         return param1.isSystem?param1.channelName:param1.channelName + "(" + param1.ownerName + ")";
      }

      public static function getUserInfoObject(param1:Array) : Object {
         var _loc2_:Number = param1[7];
         var _loc3_:Number = param1[8];
         var _loc4_:Array = param1.slice(9,9 + _loc3_);
         var _loc5_:Number = param1[9 + _loc3_];
         var _loc6_:Array = param1.slice(10 + _loc3_,10 + _loc3_ + _loc5_);
         var _loc7_:Number = param1[10 + _loc3_ + _loc5_];
         var _loc8_:Array = param1.slice(11 + _loc3_ + _loc5_,11 + _loc3_ + _loc5_ + _loc7_);
         var _loc9_:Array = param1.slice(11 + _loc3_ + _loc5_ + _loc7_,11 + _loc3_ + _loc5_ + _loc7_ + 8);
         return {
            "uid":param1[0],
            "name":param1[1],
            "chatRoster":param1[2],
            "status":param1[3],
            "displayName":param1[5],
            "list":_loc4_,
            "achievements":_loc6_,
            "stats":_loc8_,
            "commonInfo":_loc9_,
            "creationTime":App.utils.locale.longDate(param1[6]),
            "lastBattleTime":(_loc2_ == 0?"":App.utils.locale.longDate(_loc2_) + " " + App.utils.locale.longTime(_loc2_))
         }
         ;
      }

      public static function getUserStatusString(param1:Boolean) : String {
         return "#messenger:status/notAvaible";
      }

      public static function isFriend(param1:Object) : Boolean {
         return (param1.hasOwnProperty("chatRoster")) && (Boolean(param1.chatRoster & UserDataFlags.ROSTER_FRIEND));
      }

      public static function isIgnored(param1:Object) : Boolean {
         return (param1.hasOwnProperty("chatRoster")) && (Boolean(param1.chatRoster & UserDataFlags.ROSTER_IGNORED));
      }

      public static function isMuted(param1:Object) : Boolean {
         return (param1.hasOwnProperty("chatRoster")) && (Boolean(param1.chatRoster & UserDataFlags.ROSTER_VOICE_MUTED));
      }
   }

}