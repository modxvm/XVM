package net.wg.gui.battle.views.staticMarkers.epic.headquarter
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import net.wg.gui.battle.views.vehicleMarkers.HPFieldContainer;
    import net.wg.gui.battle.views.vehicleMarkers.HealthBarAnimatedLabel;
    import net.wg.gui.battle.views.vehicleMarkers.HealthBar;
    import flash.display.MovieClip;
    import scaleform.clik.motion.Tween;
    import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerFlags;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersConstants;

    public class HeadquarterMarker extends BattleUIComponent
    {

        private static const SEPARATOR:String = " / ";

        private static const FIRST_FRAME:int = 1;

        private static const HQ_DESTROYED_TWEEN_LENGTH:int = 500;

        private static const HQ_DESTROYED_TWEEN_DELAY_LENGTH:int = 1000;

        private static const HIT_LABEL_X_OFFSET:int = 41;

        private static const ACTIVE_ICON_SCALE:Number = 0.7;

        private static const INACTIVE_ICON_SCALE:Number = 0.6;

        private static const INACTIVE_ALPHA_VALUE:Number = 0.75;

        private static const ACTIVE_ALPHA_VALUE:Number = 1;

        private static const DAMAGE_FROM_ENEMY:int = 3;

        private static const ACTIVE_ACTIONS_Y_OFFSET:Number = -40;

        private static const ACTIVE_HIT_LABEL_Y_OFFSET:Number = 48;

        private static const ACTIVE_HP_FIELD_CONTAINER_Y_OFFSET:Number = 53;

        private static const ACTIVE_HEALTH_BAR_Y_OFFSET:Number = 56;

        private static const ACTIVE_HEALTH_BAR_SHADOW_Y_OFFSET:Number = 102;

        private static const INACTIVE_ACTIONS_Y_OFFSET:Number = -30;

        private static const INACTIVE_HIT_LABEL_Y_OFFSET:Number = 20;

        private static const INACTIVE_HP_FIELD_CONTAINER_Y_OFFSET:Number = 25;

        private static const INACTIVE_HEALTH_BAR_Y_OFFSET:Number = 28;

        private static const INACTIVE_HEALTH_BAR_SHADOW_Y_OFFSET:Number = 74;

        public var hpFieldContainer:HPFieldContainer = null;

        public var hitLabel:HealthBarAnimatedLabel = null;

        public var healthBar:HealthBar = null;

        public var healthBarShadow:MovieClip = null;

        public var actionMarker:HeadquarterActionMarker = null;

        public var marker:HeadquarterIcon = null;

        public var actions:MovieClip = null;

        private var _alphaVal:Number = 1;

        private var _headquarterDestroyed:Boolean = false;

        private var _currentHealth:Number = -1;

        private var _maxHealth:int = -1;

        private var _markerColor:String = "red";

        private var _isPlayerTeam:Boolean = false;

        public function HeadquarterMarker()
        {
            super();
            this.marker.visible = true;
            this.marker.targetHighlight.visible = false;
            this.actions.attack.visible = false;
            this.actions.defend.visible = false;
            this.actions.attack.stop();
            this.actions.defend.stop();
            this.hpFieldContainer.visible = true;
            this.hpFieldContainer.setWithBarType(true);
            this.healthBar.visible = true;
        }

        override protected function onDispose() : void
        {
            this.hpFieldContainer.dispose();
            this.hpFieldContainer = null;
            this.hitLabel.dispose();
            this.hitLabel = null;
            this.healthBar.dispose();
            this.healthBar = null;
            this.healthBarShadow = null;
            this.marker.dispose();
            this.marker = null;
            this.actions = null;
            super.onDispose();
        }

        public function setReplyCount(param1:int) : void
        {
            this.actionMarker.setReplyCount(param1);
        }

        public function setDead(param1:Boolean) : void
        {
            var _loc2_:Tween = null;
            if(this._headquarterDestroyed == param1)
            {
                return;
            }
            this._headquarterDestroyed = param1;
            if(this._headquarterDestroyed)
            {
                _loc2_ = new Tween(HQ_DESTROYED_TWEEN_LENGTH,this.healthBar,{"alpha":0},{
                    "delay":HQ_DESTROYED_TWEEN_DELAY_LENGTH,
                    "onComplete":this.hideHealthBar
                });
            }
            else
            {
                gotoAndStop(FIRST_FRAME);
                this.healthBar.visible = true;
                this.healthBar.alpha = ACTIVE_ALPHA_VALUE;
            }
            this.marker.setDead(this._headquarterDestroyed);
        }

        public function setHealth(param1:Number, param2:int = 3, param3:Boolean = true) : void
        {
            var _loc4_:* = 0;
            var _loc5_:String = null;
            if(!this._headquarterDestroyed)
            {
                _loc4_ = this._currentHealth - param1;
                this._currentHealth = param1;
                _loc5_ = VehicleMarkerFlags.DAMAGE_FROM[param2];
                this.healthBar.updateHealth(param1,VehicleMarkerFlags.DAMAGE_COLOR[_loc5_][this._markerColor]);
                this.hpFieldContainer.setText(int(param1) + SEPARATOR + this._maxHealth);
                if(_loc4_ > 0)
                {
                    this.marker.setHit(param3);
                    this.hitLabel.x = HIT_LABEL_X_OFFSET;
                    this.hitLabel.damage(_loc4_,VehicleMarkerFlags.DAMAGE_COLOR[_loc5_][this._markerColor]);
                    this.hitLabel.playShowTween();
                }
            }
        }

        public function setHighlight(param1:Boolean) : void
        {
            if(param1)
            {
                this.marker.targetHighlight.visible = true;
                this.marker.setInternalIconScale(ACTIVE_ICON_SCALE);
                this._alphaVal = ACTIVE_ALPHA_VALUE;
                this.actions.y = ACTIVE_ACTIONS_Y_OFFSET;
                this.hitLabel.y = ACTIVE_HIT_LABEL_Y_OFFSET;
                this.hpFieldContainer.y = ACTIVE_HP_FIELD_CONTAINER_Y_OFFSET;
                this.healthBar.y = ACTIVE_HEALTH_BAR_Y_OFFSET;
                this.healthBarShadow.y = ACTIVE_HEALTH_BAR_SHADOW_Y_OFFSET;
            }
            else
            {
                this.marker.targetHighlight.visible = false;
                this.marker.setInternalIconScale(INACTIVE_ICON_SCALE);
                this._alphaVal = INACTIVE_ALPHA_VALUE;
                this.actions.y = INACTIVE_ACTIONS_Y_OFFSET;
                this.hitLabel.y = INACTIVE_HIT_LABEL_Y_OFFSET;
                this.hpFieldContainer.y = INACTIVE_HP_FIELD_CONTAINER_Y_OFFSET;
                this.healthBar.y = INACTIVE_HEALTH_BAR_Y_OFFSET;
                this.healthBarShadow.y = INACTIVE_HEALTH_BAR_SHADOW_Y_OFFSET;
            }
            this.alpha = this._alphaVal;
            this.setHealthComponentVisibility(true);
        }

        public function setIdentifier(param1:int) : void
        {
            this.marker.setHeadquarterId(param1);
        }

        public function setMaxHealth(param1:Number) : void
        {
            if(!this._headquarterDestroyed)
            {
                this.healthBar.maxHealth = param1;
                this.healthBar.currHealth = param1;
                this._maxHealth = param1;
            }
        }

        public function setOwningTeam(param1:Boolean) : void
        {
            this._isPlayerTeam = param1;
            this.marker.setOwningTeam(param1);
            this._markerColor = param1?VehicleMarkersConstants.COLOR_GREEN:VehicleMarkersConstants.COLOR_RED;
            this.healthBar.color = this._markerColor;
        }

        public function setTarget() : void
        {
            if(!this.actions.visible)
            {
                this.actions.visible = true;
            }
            this.actions.attack.visible = !this._isPlayerTeam;
            this.actions.defend.visible = this._isPlayerTeam;
            if(!this._isPlayerTeam)
            {
                this.actions.attack.gotoAndPlay(FIRST_FRAME);
            }
            else
            {
                this.actions.defend.gotoAndPlay(FIRST_FRAME);
            }
        }

        private function hideHealthBar() : void
        {
            this.setHealthComponentVisibility(false);
        }

        private function setHealthComponentVisibility(param1:Boolean) : void
        {
            this.hitLabel.visible = param1;
            this.hpFieldContainer.visible = param1;
            this.healthBar.visible = param1;
            this.healthBarShadow.visible = param1;
        }
    }
}
