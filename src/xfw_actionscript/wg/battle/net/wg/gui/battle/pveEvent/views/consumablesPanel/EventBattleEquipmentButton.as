package net.wg.gui.battle.pveEvent.views.consumablesPanel
{
    import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButton;
    import flash.text.TextField;
    import net.wg.utils.IScheduler;
    import net.wg.data.constants.generated.CONSUMABLES_PANEL_SETTINGS;
    import net.wg.data.constants.generated.BATTLE_CONSUMABLES_PANEL_TAGS;
    import net.wg.data.constants.Time;
    import net.wg.data.constants.Values;
    import scaleform.gfx.TextFieldEx;

    public class EventBattleEquipmentButton extends BattleEquipmentButton
    {

        private static const EQUIPMENT_STAGES_ACTIVE:int = 5;

        public var activeGlow:EventBattleEquipmentActiveGlow = null;

        public var modifierTF:TextField = null;

        private var _currentTime:int = 0;

        private var _stage:int = 0;

        private var _scheduler:IScheduler = null;

        public function EventBattleEquipmentButton()
        {
            super();
            this._scheduler = App.utils.scheduler;
            TextFieldEx.setNoTranslate(this.modifierTF,true);
            this.modifierTF.visible = false;
        }

        override public function showGlow(param1:int) : void
        {
            if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_ORANGE)
            {
                (glow as EventBattleEquipmentButtonGlow).glowOrange();
            }
        }

        override public function setActivated() : void
        {
            super.setActivated();
            (glow as EventBattleEquipmentButtonGlow).hideText();
            this.activeGlow.glowYellow();
        }

        override public function clearCoolDownTime() : void
        {
            super.clearCoolDownTime();
            this.activeGlow.hideGlow();
            this._scheduler.cancelTask(this.updateCoolDown);
        }

        override public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:Boolean) : void
        {
            this._scheduler.cancelTask(this.updateCoolDown);
            this._scheduler.cancelTask(this.hideGlowOnTimeout);
            var _loc5_:String = consumablesVO.tag;
            if((_loc5_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_NITRO || _loc5_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_BUFF) && param1 > 0 && this._stage == EQUIPMENT_STAGES_ACTIVE)
            {
                this._currentTime = param1;
                super.setCoolDownTime(-1,param1,0,false);
                counterBg.gotoAndStop(BattleEquipmentButton.COOLDOWN_COUNTER_BG_GREEN);
                cooldownTimerTf.text = this._currentTime.toString();
                this._scheduler.scheduleRepeatableTask(this.updateCoolDown,Time.MILLISECOND_IN_SECOND,param1);
            }
            else
            {
                super.setCoolDownTime(param1,param2,param3,param4);
            }
            if(param1 > 0 && this._stage != EQUIPMENT_STAGES_ACTIVE)
            {
                this.activeGlow.hideGlow();
            }
            if(_loc5_ == BATTLE_CONSUMABLES_PANEL_TAGS.TRIGGER || _loc5_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_NITRO || _loc5_ == BATTLE_CONSUMABLES_PANEL_TAGS.SUPER_SHELL || _loc5_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_BUFF)
            {
                if(param1 <= 0)
                {
                    (glow as EventBattleEquipmentButtonGlow).glowYellow();
                    this.activeGlow.glowYellow();
                    clearCoolDownText();
                }
                else
                {
                    this.hideGlow();
                }
            }
            if(_loc5_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_PASSIVE_ABILITY || _loc5_ == BATTLE_CONSUMABLES_PANEL_TAGS.SUPER_SHELL)
            {
                this.modifierTF.visible = param1 <= 0 && param2 > 0;
                if(param1 == -1)
                {
                    (glow as EventBattleEquipmentButtonGlow).hideText();
                }
                if(this.modifierTF.visible)
                {
                    this.modifierTF.text = param2.toString();
                }
            }
        }

        override public function setStage(param1:int) : void
        {
            this._stage = param1;
        }

        override public function set empty(param1:Boolean) : void
        {
            super.empty = param1;
            if(param1)
            {
                this.hideGlow();
                glow.setBindKeyText(Values.EMPTY_STR);
            }
        }

        override public function hideGlow() : void
        {
            super.hideGlow();
            this._scheduler.cancelTask(this.hideGlowOnTimeout);
        }

        override protected function onDispose() : void
        {
            this._scheduler.cancelTask(this.updateCoolDown);
            this._scheduler.cancelTask(this.hideGlowOnTimeout);
            this._scheduler = null;
            this.modifierTF = null;
            this.activeGlow.dispose();
            this.activeGlow = null;
            super.onDispose();
        }

        private function hideGlowOnTimeout() : void
        {
            (glow as EventBattleEquipmentButtonGlow).hideOnTimeout();
        }

        private function updateCoolDown() : void
        {
            this._currentTime = this._currentTime - 1;
            cooldownTimerTf.text = this._currentTime.toString();
            if(this._currentTime <= 0)
            {
                this._scheduler.cancelTask(this.updateCoolDown);
            }
        }
    }
}
