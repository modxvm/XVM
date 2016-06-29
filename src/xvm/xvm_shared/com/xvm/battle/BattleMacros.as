/**
 * XVM Macro substitutions
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.*;
    import com.xvm.battle.vo.*;
    import com.xvm.vo.*;

    public class BattleMacros
    {
        public static function RegisterGlobalMacrosData(m_globals:Object):void
        {
            _RegisterGlobalMacrosData(m_globals);
        }

        public static function RegisterPlayersData(m_dict:Object):void
        {
            for each (var playerState:VOPlayerState in BattleState.playersDataVO.playerStates)
            {
                _RegisterPlayerData(m_dict, playerState);
            }
        }

        // PRIVATE

        private static function _RegisterGlobalMacrosData(m_globals:Object):void
        {
            // Capture bar

            // {{cap.points}}
            // {{cap.tanks}}
            // {{cap.time}}
            // {{cap.time-sec}}
            m_globals["cap"] = function(o:IVOMacrosOptions):*
            {
                switch (o.getSubname())
                {
                    case "points": return Number(BattleState.captureBarDataVO.points);
                    case "tanks": return Number(BattleState.captureBarDataVO.vehiclesCount);
                    case "time":  return BattleState.captureBarDataVO.timeLeft;
                    case "time-sec": return Number(BattleState.captureBarDataVO.timeLeftSec);
                }
                return null;
            }

            // {{my-frags}}
            m_globals["my-frags"] = function(o:IVOMacrosOptions):Number
            {
                return BattleState.playerFrags == 0 ? NaN : BattleState.playerFrags;
            }

            // {{zoom}}
            m_globals["zoom"] = function(o:IVOMacrosOptions):int
            {
                return BattleState.currentAimZoom;
            }

            // xmqp events macros

            if (Config.networkServicesSettings.xmqp)
            {
                // {{x-enabled}}
                m_globals["x-enabled"] = function(o:VOPlayerState):String
                {
                    return o.xmqpData && o.xmqpData.x_enabled == true ? 'true' : null;
                }

                // {{x-sense-on}}
                m_globals["x-sense-on"] = function(o:VOPlayerState):String
                {
                    return o.xmqpData && o.xmqpData.x_sense_on == true ? 'true' : null;
                }

                // {{x-fire}}
                m_globals["x-fire"] = function(o:VOPlayerState):String
                {
                    return o.xmqpData && o.xmqpData.x_fire == true ? 'true' : null;
                }

                // {{x-overturned}}
                m_globals["x-overturned"] = function(o:VOPlayerState):String
                {
                    return o.xmqpData && o.xmqpData.x_overturned == true ? 'true' : null;
                }

                // {{x-drowning}}
                m_globals["x-drowning"] = function(o:VOPlayerState):String
                {
                    return o.xmqpData && o.xmqpData.x_drowning == true ? 'true' : null;
                }

                // {{x-spotted}}
                m_globals["x-spotted"] = function(o:VOPlayerState):String
                {
                    return o.xmqpData && o.xmqpData.x_spotted == true ? 'true' : null;
                }
            }
            else
            {
                m_globals["x-enabled"] = null;
                m_globals["x-sense-on"] = null;
                m_globals["x-fire"] = null;
                m_globals["x-overturned"] = null;
                m_globals["x-drowning"] = null;
                m_globals["x-spotted"] = null;
            }
        }

        private static function _RegisterPlayerData(m_dict:Object, playerState:VOPlayerState):void
        {
            if (!m_dict.hasOwnProperty(playerState.playerName))
                m_dict[playerState.playerName] = {};
            var pdata:Object = m_dict[playerState.playerName];

            Macros.RegisterMinimalMacrosData(playerState.vehicleID, playerState.accountDBID, playerState.playerFullName, playerState.vehCD, playerState.isAlly);

            // stats

            // {{frags}}
            pdata["frags"] = function(o:VOPlayerState):Number
            {
                return o.frags == 0 ? NaN : o.frags;
            }

            // {{marksOnGun}}
            pdata["marksOnGun"] = function(o:VOPlayerState):String
            {
                return isNaN(o.marksOnGun) || o.vehicleLevel < 5 ? null : Utils.getMarksOnGunText(o.marksOnGun);
            }

            // spotted

            var vdata:VOVehicleData = playerState.vehicleData;
            var isArty:Boolean = (vdata != null && vdata.vclass == VehicleType.SPG);

            // {{spotted}}
            pdata["spotted"] = function(o:VOPlayerState):String
            {
                return Utils.getSpottedText(o.getSpottedStatus(), isArty);
            }

            // {{c:spotted}}
            pdata["c:spotted"] = function(o:VOPlayerState):String
            {
                return getSpottedColorValue(o.getSpottedStatus(), isArty);
            }

            // {{a:spotted}}
            pdata["a:spotted"] = function(o:VOPlayerState):Number
            {
                return getSpottedAlphaValue(o.getSpottedStatus(), isArty);
            }

            // hp

            var getMaxHealthFunc:Function = function(o:VOPlayerState):Number
            {
                return isNaN(o.maxHealth) ? vdata.hpTop : o.maxHealth;
            }

            var getHpRatioFunc:Function = function(o:VOPlayerState):Number
            {
                return o.getCurrentHealth() / getMaxHealthFunc(o) * 100;
            }

            // {{hp}}
            pdata["hp"] = function(o:VOPlayerState):Number
            {
                return o.getCurrentHealth();
            }

            // {{hp-max}}
            pdata["hp-max"] = getMaxHealthFunc;

            // {{hp-ratio}}
            pdata["hp-ratio"] = function(o:VOPlayerState):Number
            {
                return isNaN(o.getCurrentHealth()) ? NaN : Math.round(getHpRatioFunc(o));
            }

            // {{c:hp}}
            pdata["c:hp"] = function(o:VOPlayerState):String
            {
                return isNaN(o.getCurrentHealth()) ? null : MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_HP, o.getCurrentHealth());
            }

            // {{c:hp-ratio}}
            pdata["c:hp-ratio"] = function(o:VOPlayerState):String
            {
                return isNaN(o.getCurrentHealth()) ? null : MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, getHpRatioFunc(o));
            }

            // {{a:hp}}
            pdata["a:hp"] = function(o:VOPlayerState):Number
            {
                return isNaN(o.getCurrentHealth()) ? NaN : MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP, o.getCurrentHealth());
            }

            // {{a:hp-ratio}}
            pdata["a:hp-ratio"] = function(o:VOPlayerState):Number
            {
                return isNaN(o.getCurrentHealth()) ? NaN : MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO, getHpRatioFunc(o));
            }

            // dmg

            // {{dmg}}
            pdata["dmg"] = function(o:VOPlayerState):Number
            {
                return o.damageInfo.damageDelta;
            }

            // {{dmg-ratio}}
            pdata["dmg-ratio"] = function(o:VOPlayerState):Number
            {
                return isNaN(o.damageInfo.damageDelta) ? NaN : Math.round(o.damageInfo.damageDelta / getMaxHealthFunc(o) * 100);
            }

            // {{dmg-kind}}
            pdata["dmg-kind"] = function(o:VOPlayerState):String
            {
                return o.damageInfo.damageType == null ? null : Locale.get(o.damageInfo.damageType);
            }

            // {{c:dmg}}
            pdata["c:dmg"] = function(o:VOPlayerState):String
            {
                return XfwUtils.toHtmlColor(getDamageSystemColor(o));
            }

            // {{c:dmg-kind}}
            pdata["c:dmg-kind"] = function(o:VOPlayerState):String
            {
                return o.damageInfo.damageType == null ? null : XfwUtils.toHtmlColor(getDmgKindValue(o.damageInfo.damageType));
            }

            // {{sys-color-key}}
            pdata["sys-color-key"] = function(o:VOPlayerState):String
            {
                return getSystemColorKey(o);
            }

            // {{c:system}}
            pdata["c:system"] = function(o:VOPlayerState):String
            {
                return XfwUtils.toHtmlColor(getSystemColor(o));
            }

            // hitlog

            // {{dead}}
            pdata["dead"] = function(o:VOPlayerState):String
            {
                return o.isBlown ? Config.config.hitLog.blowupMarker : o.isDead ? Config.config.hitLog.deadMarker : null;
            }

            // {{n}}
            pdata["n"] = function(o:VOPlayerState):Number
            {
                return BattleState.hitlogTotalHits;
            }

            // {{dmg-total}}
            pdata["dmg-total"] = function(o:VOPlayerState):Number
            {
                return BattleState.hitlogTotalDamage;
            }

            // {{c:dmg-total}}
            pdata["c:dmg-total"] = function(o:VOPlayerState):String
            {
                return MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, BattleGlobalData.curentXtdb, "#", false);
            }

            // {{dmg-avg}}
            pdata["dmg-avg"] = function(o:VOPlayerState):Number
            {
                return BattleState.hitlogTotalHits == 0 ? NaN : Math.round(BattleState.hitlogTotalDamage / BattleState.hitlogTotalHits);
            }

            // {{n-player}}
            pdata["n-player"] = function(o:VOPlayerState):Number
            {
                return o.hitlogCount;
            }

            // {{dmg-player}}
            pdata["dmg-player"] = function(o:VOPlayerState):Number
            {
                return o.hitlogDamage;
            }
        }

        /*
        private function _RegisterGlobalMacrosDataDelayed(eventName:String):void
        {
            switch (eventName)
            {
                case "ON_STAT_LOADED":
                    m_globals["chancesStatic"] = Macros.formatWinChancesText(true, false);
                    m_globals["chancesLive"] = function(o:MacrosOptions):String { return Macros.formatWinChancesText(false, true); }
                    break;
            }
        }
        */

        /*
        private function _RegisterMarkerData(pname:String, data:Object):void
        {
            //Logger.addObject(data);

            if (!data)
                return;
            if (!m_dict.hasOwnProperty(pname))
                m_dict[pname] = new Object();
            var pdata:Object = m_dict[pname];

            // {{turret}}
            pdata["turret"] = data.turret || "";
        }
        */

        // helpers

        /**
         * Get system color key for current state
         */
        private static function getSystemColorKey(o:VOPlayerState):String
        {
            return getEntityName(o) + "_" + (/*isBase ? "base" :*/ o.isAlive ? "alive" : o.isBlown ? "blowedup" : "dead");
        }

        /**
         * Get system color value for current state
         */
        private static function getSystemColor(o:VOPlayerState):Number
        {
            return parseInt(Config.config.colors.system[getSystemColorKey(o/*, isBase*/)]);
        }

        public static function getDamageSystemColor(o:VOPlayerState):Number
        {
            if (isNaN(o.damageInfo.damageDelta))
                return NaN;
            switch (o.damageInfo.damageType)
            {
                case "world_collision":
                case "death_zone":
                case "drowning":
                    return getDmgKindValue(o.damageInfo.damageType);
                default:
                    return getDmgSrcColorValue(o);
            }
        }

        private static function getDmgSrcColorValue(o:VOPlayerState):Number
        {
            var damageSource:String = damageFlagToDamageSource(o.damageInfo.damageFlag);
            var damageDest:String = o.isTeamKiller ? (o.isAlly ? "ally" : "enemy") + "tk" : getEntityName(o);
            var key:String = damageSource + "_" + damageDest + "_" + (o.isAlive ? "hit" : o.isBlown ? "blowup" : "kill");
            if (Config.config.colors.damage[key] == null)
                return NaN;
            var value:int = XfwUtils.toInt(Config.config.colors.damage[key], -1);
            if (value < 0)
                return NaN;
            return value;
        }

        private static function getDmgKindValue(dmg_kind:String):Number
        {
            if (dmg_kind == null || !Config.config.colors.dmg_kind[dmg_kind])
                return NaN;
            var value:int = XfwUtils.toInt(Config.config.colors.dmg_kind[dmg_kind], -1);
            if (value < 0)
                return NaN;
            return value;
        }

        //   src: ally, squadman, enemy, unknown, player (allytk, enemytk - how to detect?)
        private static function damageFlagToDamageSource(damageFlag:Number):String
        {
            switch (damageFlag)
            {
                case Defines.FROM_ALLY:
                    return "ally";
                case Defines.FROM_ENEMY:
                    return "enemy";
                case Defines.FROM_PLAYER:
                    return "player";
                case Defines.FROM_SQUAD:
                    return "squadman";
                case Defines.FROM_UNKNOWN:
                default:
                    return "unknown";
            }
        }

        private static function getSpottedColorValue(value:String, isArty:Boolean):String
        {
            try
            {
                if (!value)
                    return "";
                if (isArty)
                    value += "_arty";
                if (!Config.config.colors.spotted[value])
                    return "";
                return XfwUtils.toHtmlColor(XfwUtils.toInt(Config.config.colors.spotted[value], 0xFFFFFE));
            }
            catch (ex:Error)
            {
                return null;
            }
            return null;
        }

        private static function getSpottedAlphaValue(value:String, isArty:Boolean):Number
        {
            try
            {
                if (!value)
                    return NaN;
                if (isArty)
                    value += "_arty";
                if (Config.config.alpha.spotted[value] == null)
                    return NaN;
                return Config.config.alpha.spotted[value];
            }
            catch (ex:Error)
            {
                return NaN;
            }
            return NaN;
        }

        private static function getEntityName(o:VOPlayerState):String
        {
            return !o.isAlly ? "enemy" : o.isSquadMan ? "squadman" : o.isTeamKiller ? "teamKiller" : "ally";
        }

        /**
         * Return vehicle marker frame name for current state
         *
         * VehicleMarkerAlly should contain 4 named frames:
         *   - green - normal ally
         *   - gold - squad mate
         *   - blue - teamkiller
         * VehicleMarkerEnemy should contain 2 named frames:
         *   - red - normal enemy
         * @param	entityName EntityName
         * @param	isColorBlindMode CB mode flag
         * @return	name of marker frame
         */
        /*
        public static function getMarkerColorAlias(entityName):String
        {
            //if (m_entityName != "ally" && m_entityName != "enemy" && m_entityName != "squadman" && m_entityName != "teamKiller")
            //  Logger.add("m_entityName=" + m_entityName);
            if (entityName == "ally")
                return "green";
            if (entityName == "squadman")
                return "gold";
            if (entityName == "teamKiller")
                return "blue";
            if (entityName == "enemy")
                return "red";

            // if not found (node is not implemented), return inverted enemy color (for debug only)
            // TODO: throw error may be better?
            return "purple";
        }
        */
    }
}
