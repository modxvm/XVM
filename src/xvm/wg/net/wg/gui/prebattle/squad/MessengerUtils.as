package net.wg.gui.prebattle.squad 
{
    public class MessengerUtils extends Object
    {
        public function MessengerUtils()
        {
            super();
            return;
        }

        public static function getFullChannelName(arg1:Object):String
        {
            return arg1.isSystem ? arg1.channelName : arg1.channelName + "(" + arg1.ownerName + ")";
        }

        public static function getUserInfoObject(arg1:Array):Object
        {
            var loc1:*=arg1[7];
            var loc2:*=arg1[8];
            var loc3:*=arg1.slice(9, 9 + loc2);
            var loc4:*=arg1[9 + loc2];
            var loc5:*=arg1.slice(10 + loc2, 10 + loc2 + loc4);
            var loc6:*=arg1[10 + loc2 + loc4];
            var loc7:*=arg1.slice(11 + loc2 + loc4, 11 + loc2 + loc4 + loc6);
            var loc8:*=arg1.slice(11 + loc2 + loc4 + loc6, 11 + loc2 + loc4 + loc6 + 8);
            return {"uid":arg1[0], "name":arg1[1], "chatRoster":arg1[2], "status":arg1[3], "displayName":arg1[5], "list":loc3, "achievements":loc5, "stats":loc7, "commonInfo":loc8, "creationTime":App.utils.locale.longDate(arg1[6]), "lastBattleTime":loc1 != 0 ? App.utils.locale.longDate(loc1) + " " + App.utils.locale.longTime(loc1) : ""};
        }

        public static function getUserStatusString(arg1:Boolean):String
        {
            return "#messenger:status/notAvaible";
        }

        public static function isFriend(arg1:Object):Boolean
        {
            return arg1.hasOwnProperty("chatRoster") && Boolean(arg1.chatRoster & net.wg.gui.prebattle.squad.UserDataFlags.ROSTER_FRIEND);
        }

        public static function isIgnored(arg1:Object):Boolean
        {
            return arg1.hasOwnProperty("chatRoster") && Boolean(arg1.chatRoster & net.wg.gui.prebattle.squad.UserDataFlags.ROSTER_IGNORED);
        }

        public static function isMuted(arg1:Object):Boolean
        {
            return arg1.hasOwnProperty("chatRoster") && Boolean(arg1.chatRoster & net.wg.gui.prebattle.squad.UserDataFlags.ROSTER_VOICE_MUTED);
        }
    }
}
