/**
 * XVM Macro substitutions
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.vo.*;
    import com.xvm.vo.*;
    import org.idmedia.as3commons.util.*;

    internal class BattleMacros
    {
        internal static function RegisterGlobalMacrosData(m_globals:Object):void
        {
            _RegisterGlobalMacrosData(m_globals);
        }

        internal static function RegisterPlayersData(m_dict:Object):void
        {
            for each (var vehicleInfo:VOPlayerState in BattleState.vehiclesDataVO.vehicleInfos)
            {
                _RegisterPlayerData(m_dict, vehicleInfo);
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
            m_globals["cap"] = function(o:VOPlayerState):*
            {
                switch (o.getSubname())
                {
                    case "points": return isNaN(BattleState.vehiclesDataVO.capo.points) ? NaN : o.points;
                    case "tanks": return isNaN(o.vehiclesCount) ? NaN : o.vehiclesCount;
                    case "time":  return o.timeLeft;
                    case "time-sec": return isNaN(o.timeLeftSec) ? NaN : o.timeLeftSec;
                }
                return null;
            }

            // xmqp events macros

            if (Config.networkServicesSettings.xmqp)
            {
                // {{x-enabled}}
                m_globals["x-enabled"] = function(o:VOPlayerState):String { return o.x_enabled == true ? 'true' : null; }
                // {{x-sense-on}}
                m_globals["x-sense-on"] = function(o:VOPlayerState):String { return o.x_sense_on == true ? 'true' : null; }
                // {{x-fire}}
                m_globals["x-fire"] = function(o:VOPlayerState):String { return o.x_fire == true ? 'true' : null; }
                // {{x-overturned}}
                m_globals["x-overturned"] = function(o:VOPlayerState):String { return o.x_overturned == true ? 'true' : null; }
                // {{x-drowning}}
                m_globals["x-drowning"] = function(o:VOPlayerState):String { return o.x_drowning == true ? 'true' : null; }
                // {{x-spotted}}
                m_globals["x-spotted"] = function(o:VOPlayerState):String { return o.x_spotted == true ? 'true' : null; }
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

        private static function _RegisterPlayerData(m_dict:Object, vehicleInfo:VOPlayerState):void
        {
            if (!m_dict.hasOwnProperty(vehicleInfo.playerName))
                m_dict[vehicleInfo.playerName] = {};
            var pdata:Object = m_dict[vehicleInfo.playerName];

            Logger.addObject(vehicleInfo);
            Macros.RegisterMinimalMacrosData(vehicleInfo.accountDBID, vehicleInfo.playerFullName, vehicleInfo.vehicleID, vehicleInfo.isPlayerTeam);

            // stats

            // {{frags}}
            pdata["frags"] = function(o:VOPlayerState):Number
            {
                return isNaN(o.frags) || o.frags == 0 ? NaN : o.frags;
            }

            // {{marksOnGun}}
            pdata["marksOnGun"] = function(o:VOPlayerState):String
            {
                return isNaN(o.marksOnGun) || o.vehicleLevel < 5 ? null : Utils.getMarksOnGunText(o.marksOnGun);
            }

            // spotted

            var vdata:VOVehicleData = VehicleInfo.get(vehicleInfo.vehicleID);
            var isArty:Boolean = (vdata != null && vdata.vclass == "SPG");

            // {{spotted}}
            pdata["spotted"] = function(o:VOPlayerState):String
            {
                return Utils.getSpottedText(o.getSpottedStatus(), isArty);
            }

            // {{c:spotted}}
            pdata["c:spotted"] = function(o:VOPlayerState):String
            {
                return MacrosUtils.GetSpottedColorValue(o.getSpottedStatus(), isArty);
            }

            // {{a:spotted}}
            pdata["a:spotted"] = function(o:VOPlayerState):Number
            {
                return MacrosUtils.GetSpottedAlphaValue(o.getSpottedStatus(), isArty);
            }

            // hp

            var getMaxHealthFunc:Function = function(o:VOPlayerState):Number { return isNaN(o.maxHealth) ? vdata.hpTop : o.maxHealth; }
            var getHpRatioFunc:Function = function(o:VOPlayerState):Number { return o.getCurrentHealth() / getMaxHealthFunc(o) * 100; }

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
                return isNaN(o.getCurrentHealth()) ? null : MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, o.getCurrentHealth());
            }

            // {{c:hp-ratio}}
            pdata["c:hp-ratio"] = function(o:VOPlayerState):String
            {
                return isNaN(o.getCurrentHealth()) ? null : MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, getHpRatioFunc(o));
            }

            // {{a:hp}}
            pdata["a:hp"] = function(o:VOPlayerState):Number
            {
                return isNaN(o.getCurrentHealth()) ? NaN : MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP, o.getCurrentHealth());
            }

            // {{a:hp-ratio}}
            pdata["a:hp-ratio"] = function(o:VOPlayerState):Number
            {
                return isNaN(o.getCurrentHealth()) ? NaN : MacrosUtils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO, getHpRatioFunc(o));
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
                if (isNaN(o.damageInfo.damageDelta))
                    return null;
                switch (o.damageInfo.damageType)
                {
                    case "world_collision":
                    case "death_zone":
                    case "drowning":
                        return MacrosUtils.GetDmgKindValue(o.damageInfo.damageType);
                    default:
                        return MacrosUtils.GetDmgSrcColorValue(
                            MacrosUtils.damageFlagToDamageSource(o.damageInfo.damageFlag),
                            o.isTeamKiller ? ((vehicleInfo.isPlayerTeam ? "ally" : "enemy") + "tk") : o.entityName,
                            o.isDead,
                            o.isBlown);
                }
            }

            // {{c:dmg-kind}}
            pdata["c:dmg-kind"] = function(o:VOPlayerState):String
            {
                return o.damageInfo.damageType == null ? null : MacrosUtils.GetDmgKindValue(o.damageInfo.damageType);
            }

            // {{sys-color-key}}
            pdata["sys-color-key"] = function(o:VOPlayerState):String
            {
                return MacrosUtils.getSystemColorKey(o.entityName, o.isDead, o.isBlown);
            }

            // {{c:system}}
            pdata["c:system"] = function(o:VOPlayerState):String
            {
                return "#" + StringUtils.leftPad(MacrosUtils.getSystemColor(o.entityName, o.isDead, o.isBlown).toString(16), 6, "0");
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
                return BattleState.vehiclesDataVO.hitlogTotalHits;
            }

            // {{dmg-total}}
            pdata["dmg-total"] = function(o:VOPlayerState):Number
            {
                return BattleState.vehiclesDataVO.hitlogTotalDamage;
            }

            // {{c:dmg-total}}
            pdata["c:dmg-total"] = function(o:VOPlayerState):String
            {
                return MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, BattleGlobalData.curentXtdb, "#", false);
            }

            // {{dmg-avg}}
            pdata["dmg-avg"] = function(o:VOPlayerState):Number
            {
                return BattleState.vehiclesDataVO.hitlogTotalHits == 0 ? NaN : Math.round(BattleState.vehiclesDataVO.hitlogTotalDamage / BattleState.vehiclesDataVO.hitlogTotalHits);
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
    }
}
