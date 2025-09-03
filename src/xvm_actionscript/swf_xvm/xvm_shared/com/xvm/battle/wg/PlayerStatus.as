/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.wg
{
    public class PlayerStatus
    {
        public static const DEFAULT:uint = 0x00;
        public static const IS_TEAM_KILLER:uint = 0x01;
        public static const IS_SQUAD_MAN:uint = 0x02;
        public static const IS_SQUAD_PERSONAL:uint = 0x04; // don't work?
        public static const IS_PLAYER_SELECTED:uint = 0x08;
        public static const IS_VOIP_DISABLED:uint = 0x10;
        public static const IS_ACTION_DISABLED:uint = 0x20;

        [Inline]
        public static function isSquadMan(param1:uint) : Boolean
        {
            return (param1 & IS_SQUAD_MAN) > 0;
        }

        [Inline]
        public static function isTeamKiller(param1:uint) : Boolean
        {
            return (param1 & IS_TEAM_KILLER) > 0;
        }

        [Inline]
        public static function isVoipDisabled(param1:uint) : Boolean
        {
            return (param1 & IS_VOIP_DISABLED) > 0;
        }

        [Inline]
        public static function isSquadPersonal(param1:uint) : Boolean
        {
            return (param1 & IS_SQUAD_PERSONAL) > 0;
        }

        [Inline]
        public static function isActionDisabled(param1:uint) : Boolean
        {
            return (param1 & IS_ACTION_DISABLED) > 0;
        }

        [Inline]
        public static function isSelected(param1:uint) : Boolean
        {
            return (param1 & IS_PLAYER_SELECTED) > 0;
        }
    }
}
