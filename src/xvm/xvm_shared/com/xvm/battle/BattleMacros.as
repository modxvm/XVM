/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
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
        public static function RegisterGlobalMacrosData():void
        {
            _RegisterGlobalMacrosData(Macros.Globals);
        }

        // PRIVATE

        private static function _RegisterGlobalMacrosData(m_globals:Object):void
        {
            // {{battletype}}
            m_globals["battletype"] = Utils.getBattleTypeText(BattleGlobalData.battleType);
            // {{battletype-key}}
            m_globals["battletype-key"] = Utils.getBattleTypeKey(BattleGlobalData.battleType);
            // {{battletier}}
            m_globals["battletier"] = BattleGlobalData.battleLevel;

            // {{cellsize}}
            m_globals["cellsize"] = int(BattleGlobalData.mapSize / 10);

            var vdata:VOVehicleData = VehicleInfo.get(BattleGlobalData.playerVehCD);

            if (vdata == null)
                return;

            // {{my-veh-id}}
            m_globals["my-veh-id"] = vdata.vehCD;
            // {{my-vehicle}} - Chaffee
            m_globals["my-vehicle"] = vdata.localizedName;
            // {{my-vehiclename}} - usa-M24_Chaffee
            m_globals["my-vehiclename"] = VehicleInfo.getVIconName(vdata.key);
            // {{my-vehicle-short}} - Chaff
            m_globals["my-vehicle-short"] = vdata.shortName || vdata.localizedName;
            // {{my-vtype-key}} - MT
            m_globals["my-vtype-key"] = vdata.vtype;
            // {{my-vtype}}
            m_globals["my-vtype"] = VehicleInfo.getVTypeText(vdata.vtype);
            // {{my-vtype-l}} - Medium Tank
            m_globals["my-vtype-l"] = Locale.get(vdata.vtype);
            // {{c:my-vtype}}
            m_globals["c:my-vtype"] = MacrosUtils.getVTypeColorValue(vdata.vehCD);
            // {{my-battletier-min}}
            m_globals["my-battletier-min"] = vdata.tierLo;
            // {{my-battletier-max}}
            m_globals["my-battletier-max"] = vdata.tierHi;
            // {{my-nation}}
            m_globals["my-nation"] = vdata.nation;
            // {{my-level}}
            m_globals["my-level"] = vdata.level;
            // {{my-rlevel}}
            m_globals["my-rlevel"] = Defines.ROMAN_LEVEL[vdata.level - 1];
            // {{my-premium}}
            m_globals["my-premium"] = vdata.premium ? "premium" : null;

            // {{my-clan}}
            m_globals["my-clan"] = BattleGlobalData.playerClan;

            // {{my-alive}}
            m_globals["my-alive"] = function(o:IVOMacrosOptions):String
            {
                return BattleState.playerIsAlive ? "alive" : null;
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

            // Hitlog

            // {{hitlog.n}}
            // {{hitlog.dmg-total}}
            // {{hitlog.dmg-total-color}}
            // {{hitlog.dmg-avg}}
            // {{hitlog.dead}}
            // {{hitlog.n-player}}
            // {{hitlog.dmg-player}}
            m_globals["hitlog"] = function(o:VOPlayerState):*
            {
                switch (o.getSubname())
                {
                    case "n": return BattleState.hitlogHits.length;
                    case "dmg-total": return BattleState.hitlogTotalDamage;
                    case "dmg-total-color": return MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, BattleGlobalData.curentXtdb, "#", false);
                    case "dmg-avg": return BattleState.hitlogHits.length ? Math.round(BattleState.hitlogTotalDamage / BattleState.hitlogHits.length) : NaN;
                    case "dead": return o.isBlown ? Config.config.hitLog.blowupMarker : o.isDead ? Config.config.hitLog.deadMarker : null;
                    case "n-player": return o.hitlogHits.length;
                    case "dmg-player": return o.hitlogDamage;
                }
                return null;
            }

            // {{pp.mode}}
            // {{pp.widthLeft}}
            // {{pp.widthRight}}
            m_globals["pp"] = function(o:IVOMacrosOptions):*
            {
                switch (o.getSubname())
                {
                    case "mode": return BattleState.playersPanelMode;
                    case "widthLeft": return BattleState.playersPanelWidthLeft;
                    case "widthRight": return BattleState.playersPanelWidthRight;
                }
                return null;
            }

            // xmqp events macros

            if (Config.networkServicesSettings.xmqp)
            {
                // {{x-enabled}}
                m_globals["x-enabled"] = function(o:VOPlayerState):String
                {
                    return o && o.xmqpData && o.xmqpData.x_enabled == true ? "true" : null;
                }

                // {{x-sense-on}}
                m_globals["x-sense-on"] = function(o:VOPlayerState):String
                {
                    return o && o.xmqpData && o.xmqpData.x_sense_on == true ? "true" : null;
                }

                // {{x-fire}}
                m_globals["x-fire"] = function(o:VOPlayerState):String
                {
                    return o && o.xmqpData && o.xmqpData.x_fire == true ? "true" : null;
                }

                // {{x-overturned}}
                m_globals["x-overturned"] = function(o:VOPlayerState):String
                {
                    return o && o.xmqpData && o.xmqpData.x_overturned == true ? "true" : null;
                }

                // {{x-drowning}}
                m_globals["x-drowning"] = function(o:VOPlayerState):String
                {
                    return o && o.xmqpData && o.xmqpData.x_drowning == true ? "true" : null;
                }

                // {{x-spotted}}
                m_globals["x-spotted"] = function(o:VOPlayerState):String
                {
                    return o && o.xmqpData && o.xmqpData.x_spotted == true ? "true" : null;
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

            // Dynamic macros

            // {{ready}}
            m_globals["ready"] = function(o:IVOMacrosOptions):String
            {
                return o && o.isReady ? 'ready' : null;
            }
            // {{alive}}
            m_globals["alive"] = function(o:IVOMacrosOptions):String
            {
                return o && o.isAlive ? 'alive' : null;
            }
            // {{selected}}
            m_globals["selected"] = function(o:IVOMacrosOptions):String
            {
                return o && o.isSelected ? 'sel' : null;
            }
            // {{player}}
            m_globals["player"] = function(o:IVOMacrosOptions):String
            {
                return o && o.isCurrentPlayer ? 'pl' : null;
            }
            // {{tk}}
            m_globals["tk"] = function(o:IVOMacrosOptions):String
            {
                return o && o.isTeamKiller ? 'tk' : null;
            }
            // {{squad}}
            m_globals["squad"] = function(o:IVOMacrosOptions):String
            {
                return o && o.isSquadPersonal ? 'sq' : null;
            }
            // {{squad-num}}
            m_globals["squad-num"] = function(o:IVOMacrosOptions):Number
            {
                return o && o.squadIndex ? o.squadIndex : NaN;
            }
            // {{rank-level}}
            m_globals["rank-level"] = function(o:IVOMacrosOptions):Number
            {
                return o && o.rankLevel ? o.rankLevel : NaN;
            }
            // {{position}}
            m_globals["position"] = function(o:IVOMacrosOptions):Number
            {
                return o && !isNaN(o.position) ? o.position : NaN;
            }

            // stats

            // {{frags}}
            m_globals["frags"] = function(o:VOPlayerState):Number
            {
                return o && o.frags ? o.frags : NaN;
            }

            // {{marksOnGun}}
            m_globals["marksOnGun"] = function(o:VOPlayerState):String
            {
                return o && !isNaN(o.marksOnGun) && o.vehicleData && o.vehicleData.level > 4 ? Utils.getMarksOnGunText(o.marksOnGun) : null;
            }

            // spotted

            // {{spotted}}
            m_globals["spotted"] = function(o:VOPlayerState):String
            {
                return o ? Utils.getSpottedText(o.getSpottedStatus(), o.isSPG) : null;
            }

            // {{c:spotted}}
            m_globals["c:spotted"] = function(o:VOPlayerState):String
            {
                return o ? getSpottedColorValue(o.getSpottedStatus(), o.isSPG) : null;
            }

            // {{a:spotted}}
            m_globals["a:spotted"] = function(o:VOPlayerState):Number
            {
                return o ? getSpottedAlphaValue(o.getSpottedStatus(), o.isSPG) : NaN;
            }

            // hp

            var getHpRatioFunc:Function = function(o:VOPlayerState):Number
            {
                return o ? o.curHealth / o.maxHealth * 100 : NaN;
            }

            // {{hp}}
            m_globals["hp"] = function(o:VOPlayerState):Number
            {
                return o ? o.curHealth : NaN;
            }

            // {{hp-max}}
            m_globals["hp-max"] = function(o:VOPlayerState):Number
            {
                return o ? o.maxHealth : NaN;
            }

            // {{hp-ratio}}
            m_globals["hp-ratio"] = function(o:VOPlayerState):Number
            {
                return o && !isNaN(o.curHealth) ? Math.round(getHpRatioFunc(o)) : NaN;
            }

            // {{c:hp}}
            m_globals["c:hp"] = function(o:VOPlayerState):String
            {
                return o && !isNaN(o.curHealth) ? MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_HP, o.curHealth) : null;
            }

            // {{c:hp-ratio}}
            m_globals["c:hp-ratio"] = function(o:VOPlayerState):String
            {
                return o && !isNaN(o.curHealth) ? MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, getHpRatioFunc(o)) : null;
            }

            // {{a:hp}}
            m_globals["a:hp"] = function(o:VOPlayerState):Number
            {
                return o && !isNaN(o.curHealth) ? MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP, o.curHealth) : NaN;
            }

            // {{a:hp-ratio}}
            m_globals["a:hp-ratio"] = function(o:VOPlayerState):Number
            {
                return o && !isNaN(o.curHealth) ? MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO, getHpRatioFunc(o)) : NaN;
            }

            // dmg

            // {{dmg}}
            m_globals["dmg"] = function(o:VOPlayerState):Number
            {
                return o && o.damageInfo ? o.damageInfo.damageDelta : NaN;
            }

            // {{dmg-ratio}}
            m_globals["dmg-ratio"] = function(o:VOPlayerState):Number
            {
                return o && o.damageInfo && o.damageInfo.damageDelta ? Math.round(o.damageInfo.damageDelta / o.maxHealth * 100) : NaN;
            }

            // {{dmg-kind}}
            m_globals["dmg-kind"] = function(o:VOPlayerState):String
            {
                return o && o.damageInfo && o.damageInfo.damageType ? Locale.get(o.damageInfo.damageType) : null;
            }

            // {{c:dmg}}
            m_globals["c:dmg"] = function(o:VOPlayerState):String
            {
                return o ? XfwUtils.toHtmlColor(getDamageSystemColor(o)) : null;
            }

            // {{c:dmg-kind}}
            m_globals["c:dmg-kind"] = function(o:VOPlayerState):String
            {
                return o && o.damageInfo && o.damageInfo.damageType ? XfwUtils.toHtmlColor(getDmgKindValue(o.damageInfo.damageType)) : null;
            }

            // {{sys-color-key}}
            m_globals["sys-color-key"] = function(o:VOPlayerState):String
            {
                return o ? getSystemColorKey(o) : null;
            }

            // {{c:system}}
            m_globals["c:system"] = function(o:VOPlayerState):String
            {
                return o ? XfwUtils.toHtmlColor(getSystemColor(o)) : null;
            }
        }

        // helpers

        /**
         * Get system color key for current state
         */
        private static function getSystemColorKey(o:VOPlayerState):String
        {
            return o ? getEntityName(o) + "_" + (/*isBase ? "base" :*/ o.isAlive ? "alive" : o.isBlown ? "blowedup" : "dead") : null;
        }

        /**
         * Get system color value for current state
         */
        private static function getSystemColor(o:VOPlayerState):Number
        {
            return o ? parseInt(Config.config.colors.system[getSystemColorKey(o/*, isBase*/)]) : NaN;
        }

        public static function getDamageSystemColor(o:VOPlayerState):Number
        {
            if (o && o.damageInfo && o.damageInfo.damageDelta)
            {
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
            return NaN;
        }

        private static function getDmgSrcColorValue(o:VOPlayerState):Number
        {
            if (!o)
                return NaN;
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
            return !o ? null : !o.isAlly ? "enemy" : o.isSquadPersonal ? "squadman" : o.isTeamKiller ? "teamKiller" : "ally";
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
