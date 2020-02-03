/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.vo.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vehiclemarkers.ui.*;
    import flash.display.*;
    import flash.text.*;
    import flash.utils.Dictionary;
    import flash.utils.getTimer;
    import scaleform.gfx.*;
    import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerFlags;

    public final class DamageTextComponent extends VehicleMarkerComponentBase implements IVehicleMarkerComponent
    {
        private var damage:MovieClip;
        private var attackers:Dictionary = new Dictionary();
        private const DELTA_TIME:int = 400;

        public final function DamageTextComponent(marker:XvmVehicleMarker)
        {
            super(marker);
            marker.addEventListener(XvmVehicleMarkerEvent.UPDATE_HEALTH, showDamage, false, 0, true);
        }

        override protected function onDispose():void
        {
            if (damage)
            {
                marker.removeChild(damage);
                damage = null;
            }
            super.onDispose();
        }

        public final function init(e:XvmVehicleMarkerEvent):void
        {
            if (!this.initialized)
            {
                this.initialized = true;
                damage = new MovieClip();
                marker.addChild(damage);
            }
        }

        [Inline]
        public final function onExInfo(e:XvmVehicleMarkerEvent):void
        {
            // stub
        }

        [Inline]
        public final function update(e:XvmVehicleMarkerEvent):void
        {
            // stub
        }

        // PRIVATE

        /**
         * Show floating damage indicator
         */

        private function updateAttackers(damageInfo:VODamageInfo, index:int):void
        {
            var attacker:Dictionary;

            if (damageInfo.attackerID in attackers)
            {
                attacker = attackers[damageInfo.attackerID];
                if (damageInfo.damageType in attacker && attacker[damageInfo.damageType] is PrevMC)
                {
                    var prevMC:PrevMC = attacker[damageInfo.damageType];
                    if ((getTimer() - prevMC.time) > DELTA_TIME)
                    {
                        prevMC.index = index;
                    }
                    prevMC.time = getTimer();
                    prevMC.damage = damageInfo.damageDelta;
                }
                else
                {
                    attacker[damageInfo.damageType] = new PrevMC(index, damageInfo.damageDelta);
                }
            }
            else
            {
                attacker = new Dictionary();
                attacker[damageInfo.damageType] = new PrevMC(index, damageInfo.damageDelta);
                attackers[damageInfo.attackerID] = attacker;
            }
        }

        private function getIndexPrevMC(damageInfo:VODamageInfo):int
        {
            if (damageInfo.attackerID in attackers && damageInfo.damageType != VehicleMarkerFlags.DAMAGE_FIRE)
            {
                var attacker:Dictionary = attackers[damageInfo.attackerID];
                if (damageInfo.damageType in attacker)
                {
                    var prevMC:PrevMC = attacker[damageInfo.damageType];
                    if (prevMC && (getTimer() - prevMC.time) < DELTA_TIME)
                    {
                        return prevMC.index;
                    }
                }
            }
            return -1;
        }

        private function getDamagePrevMC(damageInfo:VODamageInfo):int
        {
            if (damageInfo.attackerID in attackers)
            {
                var attacker:Dictionary = attackers[damageInfo.attackerID];
                if (damageInfo.damageType in attacker && attacker[damageInfo.damageType] is PrevMC)
                {
                    return attacker[damageInfo.damageType].damage;
                }
            }
            return 0;
        }

        private function showDamage(e:XvmVehicleMarkerEvent):void
        {
            function settingTextField(tf:TextField):void
            {
                tf.x = Macros.FormatNumber(cfg.x, playerState, 0);
                tf.alpha = alpha;
                if (!cfg.textFormat)
                {
                    cfg.textFormat = CTextFormat.GetDefaultConfigForMarkers();
                    cfg.textFormat.color = "{{c:dmg}}";
                }
                if (cfg.textFormat.color == null)
                {
                    cfg.textFormat.color = "{{c:dmg}}";
                }
                if (cfg.textFormat.leading == null)
                {
                    cfg.textFormat.leading = -2;
                }
                tf.defaultTextFormat = Utils.createTextFormatFromConfig(cfg.textFormat, playerState);
                tf.filters = Utils.createShadowFiltersFromConfig(cfg.shadow, playerState);
                tf.x -= (textField.width / 2.0);
            }
            var e_cfg:CMarkers4 = e.cfg;
            var playerState:VOPlayerState = e.playerState;
            var damageInfo:VODamageInfo = playerState.damageInfo;
            if (damageInfo && damageInfo.damageDelta > 0 && (playerState.isCrewActive || playerState.isBlown))
            {
                var damageFlag:Number = damageInfo.damageFlag;
                var cfg:CMarkersDamageText = damageFlag == Defines.FROM_PLAYER ? e_cfg.damageTextPlayer
                    : damageFlag == Defines.FROM_SQUAD ? e_cfg.damageTextSquadman
                    : e_cfg.damageText;
                var visible:Boolean = Macros.FormatBoolean(cfg.enabled, playerState, true);
                damage.visible = visible;
                if (visible)
                {
                    var text:String;
                    var alpha:Number = Macros.FormatNumber(cfg.alpha, playerState, 1) / 100.0;
                    var mc:MovieClip;
                    var textField:TextField;
                    var indexPrevMC:int = getIndexPrevMC(damageInfo);
                    if (0 <= indexPrevMC && indexPrevMC < damage.numChildren)
                    {
                        mc = damage.getChildAt(indexPrevMC) as MovieClip;
                        textField = mc.getChildAt(0) as TextField;
                        damageInfo.damageDelta += getDamagePrevMC(damageInfo);
                        text = Macros.FormatString(playerState.isBlown ? Locale.get(cfg.blowupMessage) : Locale.get(cfg.damageMessage), playerState);
                        settingTextField(textField);
                        textField.htmlText = text;
                    }
                    else // create text field
                    {
                        text = Macros.FormatString(playerState.isBlown ? Locale.get(cfg.blowupMessage) : Locale.get(cfg.damageMessage), playerState);
                        mc = new MovieClip();
                        damage.addChild(mc);
                        mc.y = Macros.FormatNumber(cfg.y, playerState, -67);
                        textField = new TextField();
                        mc.addChild(textField);
                        textField.mouseEnabled = false;
                        textField.selectable = false;
                        TextFieldEx.setNoTranslate(textField, true);
                        textField.antiAliasType = AntiAliasType.ADVANCED;
                        textField.y = 0;
                        textField.width = 200;
                        textField.height = 100;
                        textField.multiline = true;
                        textField.wordWrap = false;
                        settingTextField(textField);
                        textField.htmlText = text;

                        var maxRange:Number = Macros.FormatNumber(cfg.maxRange, playerState, 40);
                        new DamageTextAnimation(cfg, mc, maxRange); // defines and starts
                    }
                    updateAttackers(damageInfo, damage.getChildIndex(mc));
                }
            }
        }
    }
}

import flash.utils.getTimer;

class PrevMC
{
    public var damage:Number;
    public var index:int;
    public var time:int;

    public function PrevMC(ind:int, dmg:Number):void
    {
         index = ind;
         time = getTimer();
         damage = dmg;
    }
}
