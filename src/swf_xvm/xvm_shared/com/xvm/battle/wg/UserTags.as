/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.wg
{
    public class UserTags
    {
        public static const FRIEND:String = "friend";
        public static const IGNORED:String = "ignored";
        public static const MUTED:String = "muted";
        public static const CURRENT:String = "himself";
        public static const REFERRER:String = "referrer";
        public static const REFERRAL:String = "referral";
        public static const IGR_BASE:String = "igr/base";
        public static const IGR_PREMIUM:String = "igr/premium";
        public static const PRESENCE_DND:String = "presence/dnd";
        public static const SUB_TO:String = "sub/to";
        public static const SUB_PENDING_IN:String = "sub/pendingIn";
        public static const BAN_CHAT:String = "ban/chat";

        [Inline]
        public static function isFriend(param1:Array) : Boolean
        {
            return param1.indexOf(FRIEND) != -1;
        }

        [Inline]
        public static function isIgnored(param1:Array) : Boolean
        {
            return param1.indexOf(IGNORED) != -1;
        }

        [Inline]
        public static function isMuted(param1:Array) : Boolean
        {
            return param1.indexOf(MUTED) != -1;
        }

        [Inline]
        public static function isCurrentPlayer(param1:Array) : Boolean
        {
            return param1.indexOf(CURRENT) != -1;
        }

        [Inline]
        public static function isReferrer(param1:Array) : Boolean
        {
            return param1.indexOf(REFERRER) != -1;
        }

        [Inline]
        public static function isReferral(param1:Array) : Boolean
        {
            return param1.indexOf(REFERRAL) != -1;
        }

        [Inline]
        public static function isInRefSystem(param1:Array) : Boolean
        {
            return isReferrer(param1) || isReferral(param1);
        }

        [Inline]
        public static function isBusy(param1:Array) : Boolean
        {
            return param1.indexOf(PRESENCE_DND) != -1;
        }

        [Inline]
        public static function isBaseIGR(param1:Array) : Boolean
        {
            return param1.indexOf(IGR_BASE) != -1;
        }

        [Inline]
        public static function isPremiumIGR(param1:Array) : Boolean
        {
            return param1.indexOf(IGR_PREMIUM) != -1;
        }

        [Inline]
        public static function isInIGR(param1:Array) : Boolean
        {
            return isBaseIGR(param1) || isPremiumIGR(param1);
        }

        [Inline]
        public static function isChatBan(param1:Array) : Boolean
        {
            return param1.indexOf(BAN_CHAT) != -1;
        }
    }
}
