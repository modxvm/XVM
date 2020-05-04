package net.wg.gui.battle.views.vehicleMarkers
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import flash.geom.Point;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerVO;
    import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerPart;
    import flash.events.Event;
    import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
    import net.wg.data.constants.InvalidationType;
    import net.wg.data.constants.Values;
    import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerFlags;
    import net.wg.utils.TextFieldUtils;
    import net.wg.gui.battle.views.vehicleMarkers.VO.CrossOffset;
    import net.wg.gui.battle.views.vehicleMarkers.VO.HPDisplayMode;
    import scaleform.gfx.TextFieldEx;

    public class VehicleMarker extends BattleUIComponent implements IMarkerManagerHandler
    {

        private static const SHADOW_POSITIONS:Array = [null,new Point(-94,-59),new Point(-94,-85),new Point(-94,-42),new Point(-94,-72),new Point(-94,-77)];

        private static const ICON:String = "Icon";

        private static const LEVEL:String = "Level";

        private static const HEALTH_LBL:String = "Hp";

        private static const HEALTH_BAR:String = "HpIndicator";

        private static const P_NAME_LBL:String = "PlayerName";

        private static const V_NAME_LBL:String = "VehicleName";

        private static const DAMAGE_PANEL:String = "Damage";

        private static const MARKER:String = "marker";

        private static const ALT:String = "Alt";

        private static const BASE:String = "Base";

        private static const DEAD:String = "Dead";

        private static const START_HORIZONTAL_OFFSET:int = 15;

        private static const EXPLOSION_HORIZONTAL_OFFSET:int = 15;

        private static const BLOCK_HORIZONTAL_OFFSET:int = 25;

        private static const V_TYPE_ICON_Y:int = -7;

        private static const EXPLOSION_SIZE:int = 18;

        private static const STATE_DEAD:String = "dead";

        private static const STATE_IMMEDIATE_DEAD:String = "immediate_dead";

        private static const STATE_RICOCHET:String = "hit_ricochet";

        private static const STATE_BLOCKED:String = "hit_blocked";

        private static const STATE_CRITICAL_BLOCKED:String = "hit_critical";

        private static const STATE_CRITICAL_CHASSIS:String = "hit_critical_chassis";

        private static const PERCENT_STRING:String = "%";

        private static const SLASH_STRING:String = " / ";

        private static const SHADOW_TYPE_HBAR_OFFSET:int = 2;

        private static const VM_PREFIX:String = "vm_";

        private static const VM_DEAD_PREFIX:String = "vm_dead_";

        private static const VM_STUN_PREFIX:String = "vm_stun_";

        private static const VM_STUN_POSTFIX:String = "_schema";

        private static const MAX_HEALTH_PERCENT:int = 100;

        private static const VEHICLE_DESTROY_COLOR:Number = 6710886;

        public static const INVALIDATE_MANAGER_READY:uint = 1 << 17;

        private static const SLASH:String = "/";

        private static const PNG_EXT:String = ".png";

        private static const HEALTH_BAR_Y:int = -29;

        private static const HP_FIELD_VERTICAL_OFFSET:int = -2;

        private static const PARTS_START_Y:int = -15;

        private static const STATE_HIT:String = "hit";

        private static const WHITE_COLOR:String = "white";

        public var vehicleIcon:MovieClip = null;

        public var actionMarker:VehicleActionMarker = null;

        public var statusContainer:VehicleStatusContainerMarker = null;

        public var marker:VehicleIconAnimation = null;

        public var hitLabel:HealthBarAnimatedLabel = null;

        public var criticalHitLabel:HealthBarAnimatedLabel = null;

        public var hitExplosion:AnimateExplosion = null;

        public var vehicleNameField:TextField = null;

        public var playerNameField:TextField = null;

        public var hpField:TextField = null;

        public var healthBar:HealthBar = null;

        public var bgShadow:MovieClip = null;

        public var marker2:FlagContainer = null;

        public var levelIcon:MovieClip = null;

        public var squadIcon:MovieClip = null;

        private var _model:VehicleMarkerVO = null;

        private var _entityType:String = "enemy";

        private var _entityName:String = "enemy";

        private var _markerColor:String = "red";

        private var _markerState:String = "";

        private var _vehicleDestroyed:Boolean = false;

        private var _vehicleDestroyedAlready:Boolean = false;

        private var _isPopulated:Boolean = false;

        private var _exInfoOverride:Boolean = false;

        private var _markerSettingsOverride:Object = null;

        private var _vmManager:VehicleMarkersManager = null;

        private var _maxHealthMult:Number = NaN;

        private var _markerSchemeName:String = "";

        private var _stunSchemeName:String = "";

        private var _isFlagShown:Boolean = false;

        private var _isManagerReady:Boolean = false;

        private var _canUseCachedVisibility:Boolean = false;

        private var _hitIconOffset:int = -1;

        private var _markerParts:Vector.<VehicleMarkerPart> = null;

        private var _lastPlayerName:String = "";

        public function VehicleMarker()
        {
            super();
            this._vmManager = VehicleMarkersManager.getInstance();
            this._isManagerReady = this._vmManager.isAtlasInited;
            if(!this._isManagerReady)
            {
                this._vmManager.addReadyHandler(this);
            }
            TextFieldEx.setNoTranslate(this.vehicleNameField,true);
            TextFieldEx.setNoTranslate(this.playerNameField,true);
            TextFieldEx.setNoTranslate(this.hpField,true);
            this.prepareLayout();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.statusContainer.addEventListener(Event.COMPLETE,this.onStatusAnimationHiddenCompleteHandler);
            this.healthBar.hitSplash.addEventListener(HealthBarAnimatedPart.HIDE,this.onSplashHideHandler);
            this._vmManager.addEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO,this.onShowExInfoHandler);
            this._vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_SETTINGS,this.onUpdateSettingsHandler);
            this._vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
        }

        override protected function draw() : void
        {
            var _loc1_:String = null;
            super.draw();
            if(this._isManagerReady && isInvalid(InvalidationType.DATA) && this._model != null && !this._isPopulated)
            {
                this._markerColor = this._vmManager.getAliasColor(this._markerSchemeName);
                this.applyColor();
                if(this.getHealthPercents() >= 0)
                {
                    this.healthBar.maxHealth = this._model.maxHealth;
                    this.healthBar.currHealth = this._model.currHealth;
                }
                this.setupVehicleIcon();
                _loc1_ = VMAtlasItemName.getLevelIconName(this._model.vLevel);
                this._vmManager.drawWithCenterAlign(_loc1_,this.levelIcon.graphics,true,false);
                this.setupSquadIcon();
                if(this._model.vClass)
                {
                    this.setVehicleType();
                }
                this.setMarkerState(this._markerState);
                this._canUseCachedVisibility = false;
                this.updateMarkerSettings();
                this._isPopulated = true;
            }
        }

        override protected function onDispose() : void
        {
            var _loc1_:VehicleMarkerPart = null;
            this.statusContainer.removeEventListener(Event.COMPLETE,this.onStatusAnimationHiddenCompleteHandler);
            this.healthBar.hitSplash.removeEventListener(HealthBarAnimatedPart.HIDE,this.onSplashHideHandler);
            this._vmManager.removeEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO,this.onShowExInfoHandler);
            this._vmManager.removeEventListener(VehicleMarkersManagerEvent.UPDATE_SETTINGS,this.onUpdateSettingsHandler);
            this._vmManager.removeEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
            this.vehicleIcon = null;
            this.hpField = null;
            if(this.actionMarker != null)
            {
                this.actionMarker.dispose();
            }
            this.actionMarker = null;
            if(this.marker != null)
            {
                this.marker.dispose();
            }
            this.marker = null;
            if(this.marker2 != null)
            {
                this.marker2.dispose();
            }
            this.marker2 = null;
            if(this.hitLabel != null)
            {
                this.hitLabel.dispose();
            }
            this.hitLabel = null;
            if(this.hitExplosion != null)
            {
                this.hitExplosion.dispose();
            }
            this.hitExplosion = null;
            this.vehicleNameField = null;
            this.playerNameField = null;
            if(this.healthBar != null)
            {
                this.healthBar.dispose();
            }
            this.healthBar = null;
            this.bgShadow = null;
            this.levelIcon = null;
            this.squadIcon = null;
            if(this.criticalHitLabel != null)
            {
                this.criticalHitLabel.dispose();
            }
            this.criticalHitLabel = null;
            if(this.statusContainer != null)
            {
                this.statusContainer.dispose();
            }
            this.statusContainer = null;
            this._model = null;
            this._markerSettingsOverride = null;
            this._vmManager = null;
            if(this._markerParts)
            {
                for each(_loc1_ in this._markerParts)
                {
                    _loc1_.dispose();
                }
                this._markerParts.splice(0,this._markerParts.length);
                this._markerParts = null;
            }
            super.onDispose();
        }

        public function hideArtyMarker() : void
        {
        }

        public function hideStatusMarker(param1:int, param2:int, param3:Boolean = false) : void
        {
            this.statusContainer.hideMarker(param1,param2,param3);
            this.updateMarkerSettings();
        }

        public function isSpeaking() : Boolean
        {
            return this._model.speaking;
        }

        public function managerReadyHandler() : void
        {
            this._isManagerReady = true;
            if(!this._isPopulated)
            {
                invalidate(INVALIDATE_MANAGER_READY);
            }
        }

        public function setEntityName(param1:String) : void
        {
            if(param1 == this._entityName)
            {
                return;
            }
            this.entityName = param1;
            this.update();
        }

        public function setHealth(param1:int) : void
        {
            if(param1 < 0)
            {
                var param1:* = 0;
            }
            this._model.currHealth = param1;
            if(this._isPopulated)
            {
                if(this.getIsPartVisible(HEALTH_BAR))
                {
                    this.healthBar.currHealth = param1;
                }
                if(this.getIsPartVisible(HEALTH_LBL))
                {
                    if(this._vehicleDestroyed)
                    {
                        this.setDestroyedColorForHP();
                    }
                    this.setHealthText();
                }
            }
        }

        public function setSpeaking(param1:Boolean) : void
        {
            if(this._model.speaking == param1)
            {
                return;
            }
            this._model.speaking = param1;
            if(initialized)
            {
                this.setVehicleType();
            }
        }

        public function setStatusTimerSnapshot(param1:int) : void
        {
            this.statusContainer.updateEffectTimer(0,param1);
            this.updateMarkerSettings();
        }

        public function setVehicleInfo(param1:String, param2:String, param3:String, param4:int, param5:String, param6:String, param7:String, param8:String, param9:int, param10:String, param11:Boolean, param12:int, param13:String) : void
        {
            var _loc14_:* = 0;
            if(this._model)
            {
                _loc14_ = this._model.currHealth;
            }
            this._model = new VehicleMarkerVO();
            this._model.vClass = param1;
            this._model.vIconSource = param2;
            this._model.vType = param3;
            this._model.vLevel = param4;
            this._model.pFullName = param5;
            this._model.pName = param6;
            this._model.pClan = param7;
            this._model.pRegion = param8;
            this._model.maxHealth = param9;
            this._model.entityName = param10;
            this._model.hunt = param11;
            this._model.squadIndex = param12;
            this._model.currHealth = _loc14_;
            this._model.locSecString = param13;
            this._maxHealthMult = MAX_HEALTH_PERCENT / this._model.maxHealth;
            this.statusContainer.setSecondString(this._model.locSecString);
            if(this._model.entityName != Values.EMPTY_STR)
            {
                this._entityName = this._model.entityName;
                this.actionMarker.entityName = this._entityName;
                this.makeColorSchemeName();
                this.statusContainer.setEffectColor(this._vmManager.getAliasColor(this._stunSchemeName),this._vmManager.getRGB(this._stunSchemeName));
                if(this._entityName == VehicleMarkersConstants.ENTITY_NAME_ENEMY)
                {
                    this._entityType = VehicleMarkersConstants.ENTITY_TYPE_ENEMY;
                }
                else
                {
                    this._entityType = VehicleMarkersConstants.ENTITY_TYPE_ALLY;
                }
            }
            this._isPopulated = false;
            invalidateData();
        }

        public function settingsUpdate(param1:int) : void
        {
            var _loc2_:String = VehicleMarkerFlags.DAMAGE_FROM[param1];
            this.setupVehicleIcon();
            this.update();
            this.hitLabel.fakeDamage = this._model.maxHealth - this._model.currHealth;
            this.hitLabel.imitationFlag = VehicleMarkerFlags.DAMAGE_COLOR[_loc2_][this._markerColor];
            this.hitLabel.imitation = this.getIsPartVisible(DAMAGE_PANEL);
        }

        public function showActionMarker(param1:String) : void
        {
            this.actionMarker.showAction(param1);
            if(param1 != Values.EMPTY_STR)
            {
                this.updateMarkerSettings();
            }
        }

        public function showExInfo() : void
        {
            this.updateMarkerSettings();
        }

        public function showStatusMarker(param1:int, param2:Boolean, param3:Number, param4:int, param5:Boolean = true) : void
        {
            this.statusContainer.showMarker(param1,param2,param3,param4,param5);
            this.updateMarkerSettings();
        }

        public function update() : void
        {
            this.updateMarkerColor();
            this.updateMarkerSettings();
        }

        public function updateFlagBearerState(param1:Boolean) : void
        {
            this._isFlagShown = param1;
            this.updateFlag();
        }

        public function updateHealth(param1:int, param2:int, param3:String) : void
        {
            var _loc4_:String = VehicleMarkerFlags.DAMAGE_FROM[param2];
            if(param1 < 0)
            {
                var param3:String = VehicleMarkerFlags.DAMAGE_EXPLOSION;
                var param1:* = 0;
            }
            var _loc5_:int = this._model.currHealth - param1;
            this._model.currHealth = param1;
            if(this._isPopulated)
            {
                if(this.getIsPartVisible(HEALTH_BAR))
                {
                    this.healthBar.updateHealth(param1,VehicleMarkerFlags.DAMAGE_COLOR[_loc4_][this._markerColor]);
                }
                if(this.getIsPartVisible(DAMAGE_PANEL))
                {
                    this.hitLabel.damage(_loc5_,VehicleMarkerFlags.DAMAGE_COLOR[_loc4_][this._markerColor]);
                    if(VehicleMarkerFlags.checkAllowedDamages(param3))
                    {
                        this.hitExplosion.setColorAndDamageType(VehicleMarkerFlags.DAMAGE_COLOR[_loc4_][this._markerColor],param3);
                        this.hitExplosion.playShowTween();
                        this._hitIconOffset = EXPLOSION_HORIZONTAL_OFFSET;
                    }
                    this.hitLabel.playShowTween();
                    this.updateHitLayout();
                }
                if(this.getIsPartVisible(HEALTH_LBL))
                {
                    if(this._vehicleDestroyed)
                    {
                        this.setDestroyedColorForHP();
                    }
                    this.setHealthText();
                }
            }
        }

        public function updateState(param1:String, param2:Boolean, param3:String = "", param4:String = "") : void
        {
            if(this._vehicleDestroyed)
            {
                return;
            }
            if(param2 && param1 == STATE_DEAD)
            {
                var param1:String = STATE_IMMEDIATE_DEAD;
            }
            if(param4 != Values.EMPTY_STR || param3 != Values.EMPTY_STR)
            {
                if(this.getIsPartVisible(DAMAGE_PANEL))
                {
                    this.hitExplosion.playShowTween();
                    this.criticalHitLabel.setLabel(param3,WHITE_COLOR);
                    this.hitExplosion.setAnimationType(param4);
                    this._hitIconOffset = BLOCK_HORIZONTAL_OFFSET;
                    this.updateHitLayout();
                    this.criticalHitLabel.playShowTween();
                }
            }
            this.setMarkerState(param1);
        }

        public function updateStatusEffectTimer(param1:int, param2:Number, param3:Boolean = false) : void
        {
            this.statusContainer.updateEffectTimer(param1,param2,param3);
            this.updateMarkerSettings();
        }

        public function updateTimer(param1:String) : void
        {
        }

        protected function layoutExtended(param1:int) : void
        {
        }

        private function updateHitLayout() : void
        {
            var _loc1_:Boolean = this.hitLabel.visible && this.hitLabel.isActive();
            var _loc2_:int = _loc1_?this.hitLabel.damageLabel.textWidth:0;
            var _loc3_:int = _loc1_?this._hitIconOffset:START_HORIZONTAL_OFFSET;
            this.hitExplosion.x = Math.round(this.hitLabel.x + _loc2_ + _loc3_);
            this.criticalHitLabel.x = Math.round(this.hitExplosion.x + EXPLOSION_SIZE);
        }

        private function makeColorSchemeName() : void
        {
            this._markerSchemeName = (this._vehicleDestroyed?VM_DEAD_PREFIX:VM_PREFIX) + this._entityName;
            this._stunSchemeName = VM_STUN_PREFIX + this._entityName + VM_STUN_POSTFIX;
        }

        protected function getVNameVisible() : Boolean
        {
            return this.getIsPartVisible(V_NAME_LBL);
        }

        private function updateMarkerSettings() : void
        {
            var _loc9_:Point = null;
            var _loc1_:Boolean = this.getIsPartVisible(ICON);
            var _loc2_:Boolean = this.getIsPartVisible(LEVEL);
            var _loc3_:Boolean = this.getIsPartVisible(P_NAME_LBL);
            var _loc4_:Boolean = this.getVNameVisible();
            var _loc5_:Boolean = this.getIsPartVisible(HEALTH_BAR);
            var _loc6_:Boolean = this.getIsPartVisible(HEALTH_LBL);
            var _loc7_:Boolean = this.getIsPartVisible(DAMAGE_PANEL);
            if(_loc3_ && this._lastPlayerName != this._model.pName)
            {
                this._lastPlayerName = this._model.pName;
                TextFieldUtils.instance.truncateTextFieldText(this.playerNameField,this._lastPlayerName);
            }
            this.playerNameField.visible = _loc3_;
            if(_loc4_)
            {
                this.vehicleNameField.text = this._model.vType;
            }
            this.vehicleNameField.visible = _loc4_;
            if(_loc5_)
            {
                this.healthBar.currHealth = this._model.currHealth;
            }
            this.healthBar.visible = _loc5_;
            this.hpField.visible = _loc6_;
            if(this._vehicleDestroyed)
            {
                this.setDestroyedColorForHP();
            }
            this.setHealthText();
            this.hitLabel.visible = _loc7_;
            this.hitExplosion.visible = _loc7_;
            this.levelIcon.visible = _loc2_;
            this.vehicleIcon.visible = _loc1_;
            var _loc8_:int = (_loc3_?1:0) + (_loc4_?1:0);
            if(!_loc5_)
            {
                _loc8_ = _loc8_ + (_loc6_?1:0);
                if(_loc8_ > 0)
                {
                    _loc8_ = _loc8_ + SHADOW_TYPE_HBAR_OFFSET;
                }
            }
            if(_loc8_ > 0)
            {
                _loc9_ = SHADOW_POSITIONS[_loc8_];
                this._vmManager.drawGraphics(VMAtlasItemName.getShadowName(_loc8_),this.bgShadow.graphics,_loc9_);
                this.bgShadow.visible = true;
            }
            else
            {
                this.bgShadow.visible = false;
            }
            this.layoutParts(new <Boolean>[_loc5_ || _loc6_,_loc3_,_loc4_,_loc2_,_loc1_,this._model.squadIndex != 0,this._isFlagShown,this.statusContainer.isVisible(),this.actionMarker.isVisible()]);
        }

        private function updateMarkerColor() : void
        {
            var _loc1_:String = this._vmManager.getAliasColor(this._markerSchemeName);
            if(this._markerColor == _loc1_)
            {
                return;
            }
            this._markerColor = _loc1_;
            this.applyColor();
            if(this._model.vClass)
            {
                this.setVehicleType();
            }
            this.setMarkerState(this._markerState);
            this.updateIconColor();
        }

        private function applyColor() : void
        {
            this.healthBar.color = this._markerColor;
        }

        private function layoutParts(param1:Vector.<Boolean>) : void
        {
            var _loc4_:VehicleMarkerPart = null;
            var _loc6_:* = 0;
            var _loc2_:int = PARTS_START_Y;
            var _loc3_:int = this._markerParts.length;
            var _loc5_:VehicleMarkerPart = null;
            var _loc7_:Boolean = this._canUseCachedVisibility;
            var _loc8_:* = false;
            var _loc9_:* = 0;
            while(_loc9_ < _loc3_)
            {
                _loc4_ = this._markerParts[_loc9_];
                _loc8_ = param1[_loc9_];
                if(_loc7_ && _loc8_ && _loc4_.cachedVisibility == _loc8_)
                {
                    _loc2_ = _loc4_.y;
                    _loc5_ = _loc4_;
                }
                else
                {
                    _loc7_ = false;
                    if(_loc8_)
                    {
                        _loc6_ = _loc4_.offsetFromPart(_loc5_);
                        _loc4_.y = _loc2_ - _loc6_ - _loc4_.height;
                        _loc5_ = _loc4_;
                        _loc2_ = _loc4_.y;
                    }
                }
                _loc4_.cachedVisibility = _loc8_;
                _loc9_++;
            }
            this.healthBar.y = HEALTH_BAR_Y;
            this.hpField.y = this.healthBar.y + HP_FIELD_VERTICAL_OFFSET;
            this._canUseCachedVisibility = true;
            this.layoutExtended(_loc2_ - _loc6_);
        }

        private function prepareLayout() : void
        {
            var _loc4_:VehicleMarkerPart = null;
            this._markerParts = new Vector.<VehicleMarkerPart>();
            var _loc1_:Array = [this.hpField,this.playerNameField,this.vehicleNameField,this.levelIcon,this.vehicleIcon,this.squadIcon,this.marker2,this.statusContainer,this.actionMarker];
            var _loc2_:Array = [-2,-2,1,1,1,1,1,0];
            var _loc3_:Array = [null,new CrossOffset(this.hpField,-3),new CrossOffset(this.playerNameField,-7,this.hpField,-3),new CrossOffset(this.vehicleNameField,-4,this.playerNameField,-4),new CrossOffset(this.levelIcon,-12,this.vehicleNameField,-3,this.playerNameField,-3),null,null,null,new CrossOffset(this.statusContainer,-25)];
            var _loc5_:int = _loc1_.length;
            var _loc6_:* = 0;
            while(_loc6_ < _loc5_)
            {
                _loc4_ = new VehicleMarkerPart(_loc1_[_loc6_],_loc2_[_loc6_],_loc3_[_loc6_]);
                this._markerParts.push(_loc4_);
                _loc6_++;
            }
        }

        private function setMarkerState(param1:String) : void
        {
            var _loc2_:uint = 0;
            this._markerState = param1;
            this._vehicleDestroyed = this._markerState == STATE_DEAD || this._markerState == STATE_IMMEDIATE_DEAD;
            this.makeColorSchemeName();
            if(initialized)
            {
                if(this._model.speaking)
                {
                    this.setVehicleType();
                }
                _loc2_ = this._vmManager.getRGB(this._markerSchemeName);
                if(!isNaN(_loc2_))
                {
                    this.playerNameField.textColor = _loc2_;
                    this.vehicleNameField.textColor = _loc2_;
                }
                if(this._markerState != Values.EMPTY_STR)
                {
                    this._canUseCachedVisibility = false;
                    if(this._vehicleDestroyed)
                    {
                        this.actionMarker.stopAction();
                        this.updateIconColor();
                        this.setDestroyedColorForHP();
                        if(this._markerState == STATE_IMMEDIATE_DEAD)
                        {
                            this.hitLabel.transform.colorTransform = this._vmManager.getTransform(this._markerSchemeName);
                        }
                    }
                    this.updateMarkerSettings();
                    if(!this._vehicleDestroyedAlready)
                    {
                        this.marker.gotoAndPlay(this._markerState);
                    }
                }
                if(!this._vehicleDestroyed)
                {
                    this.statusContainer.setEffectColor(this._vmManager.getAliasColor(this._stunSchemeName),this._vmManager.getRGB(this._stunSchemeName));
                }
                this._vehicleDestroyedAlready = this._vehicleDestroyedAlready || this._vehicleDestroyed;
            }
        }

        private function getIsPartVisible(param1:String) : Boolean
        {
            var _loc2_:* = false;
            var _loc3_:String = MARKER + (this.exInfo?ALT:BASE) + param1;
            if(param1 == HEALTH_LBL)
            {
                _loc2_ = this.markerSettings[_loc3_] != HPDisplayMode.HIDDEN;
            }
            else
            {
                _loc2_ = this.markerSettings[_loc3_];
            }
            return _loc2_;
        }

        private function setDestroyedColorForHP() : void
        {
            this.hpField.textColor = VEHICLE_DESTROY_COLOR;
        }

        private function setHealthText() : void
        {
            var _loc1_:String = Values.EMPTY_STR;
            var _loc2_:int = this.markerSettings[MARKER + (this.exInfo?ALT:BASE) + HEALTH_LBL];
            switch(_loc2_)
            {
                case HPDisplayMode.PERCENTS:
                    _loc1_ = this.getHealthPercents() + PERCENT_STRING;
                    break;
                case HPDisplayMode.CURRENT_AND_MAXIMUM:
                    _loc1_ = this._model.currHealth + SLASH_STRING + this._model.maxHealth;
                    break;
                case HPDisplayMode.CURRENT:
                    _loc1_ = this._model.currHealth.toString();
                    break;
                default:
                    _loc1_ = Values.EMPTY_STR;
            }
            this.hpField.text = _loc1_;
            var _loc3_:Boolean = this.getIsPartVisible(HEALTH_BAR);
            var _loc4_:Boolean = this.getIsPartVisible(HEALTH_LBL);
            if(_loc4_ && !_loc3_)
            {
                this.hpField.x = -(this.hpField.width >> 1);
            }
        }

        private function setVehicleType() : void
        {
            var _loc1_:String = null;
            if(this._vehicleDestroyedAlready)
            {
                return;
            }
            if(this._model.speaking && !this._vehicleDestroyed)
            {
                _loc1_ = VMAtlasItemName.SPEAKING_ICON;
            }
            else
            {
                _loc1_ = VMAtlasItemName.getVehicleTypeIconName(this._markerColor,this._model.vClass,this._model.hunt);
            }
            this._vmManager.drawWithCenterAlign(_loc1_,this.marker.vehicleTypeIcon.graphics,true,false,0,V_TYPE_ICON_Y);
        }

        private function updateIconColor() : void
        {
            this.vehicleIcon.transform.colorTransform = this._vmManager.getTransform(this._markerSchemeName);
        }

        private function setupSquadIcon() : void
        {
            var _loc1_:String = null;
            var _loc2_:String = null;
            if(this._model.squadIndex)
            {
                _loc1_ = this._vmManager.getAliasColor(this._markerSchemeName);
                _loc2_ = VMAtlasItemName.getSquadIconName(_loc1_,this._model.squadIndex);
                this._vmManager.drawWithCenterAlign(_loc2_,this.squadIcon.graphics,true,false);
            }
        }

        private function getHealthPercents() : int
        {
            var _loc1_:int = Math.ceil(this._model.currHealth * this._maxHealthMult);
            return _loc1_ <= MAX_HEALTH_PERCENT?_loc1_:MAX_HEALTH_PERCENT;
        }

        private function setupVehicleIcon() : void
        {
            var _loc1_:Array = this._model.vIconSource.split(SLASH);
            var _loc2_:String = _loc1_[_loc1_.length - 1].replace(PNG_EXT,Values.EMPTY_STR);
            this._vmManager.drawWithCenterAlign(_loc2_,this.vehicleIcon.graphics,true,false);
            this.updateIconColor();
        }

        private function updateFlag() : void
        {
            if(this._isFlagShown)
            {
                if(this._entityType == VehicleMarkersConstants.ENTITY_TYPE_ALLY)
                {
                    this.marker2.showGreen();
                }
                else if(this._entityType == VehicleMarkersConstants.ENTITY_TYPE_ENEMY)
                {
                    if(this._vmManager.isColorBlind)
                    {
                        this.marker2.showPurple();
                    }
                    else
                    {
                        this.marker2.showRed();
                    }
                }
            }
            else
            {
                this.marker2.hide();
            }
        }

        public function get markerSettings() : Object
        {
            var _loc1_:Object = null;
            if(this._markerSettingsOverride)
            {
                _loc1_ = this._markerSettingsOverride;
            }
            else if(this._vehicleDestroyed)
            {
                _loc1_ = this._vmManager.markerSettings[STATE_DEAD];
            }
            else
            {
                _loc1_ = this._vmManager.markerSettings[this.entityType];
            }
            return _loc1_;
        }

        public function set markerSettings(param1:Object) : void
        {
            this._markerSettingsOverride = param1;
        }

        public function get isEnabledExInfo() : Boolean
        {
            var _loc1_:String = MARKER + (this.exInfo?ALT:BASE) + DEAD;
            return this.markerSettings[_loc1_];
        }

        public function get exInfo() : Boolean
        {
            return this._exInfoOverride || this._vmManager.showExInfo;
        }

        public function set exInfo(param1:Boolean) : void
        {
            this._exInfoOverride = param1;
        }

        public function get entityName() : String
        {
            return this._entityName;
        }

        public function set entityName(param1:String) : void
        {
            this._entityName = param1;
            this._model.entityName = this._entityName;
            this.actionMarker.entityName = this._entityName;
            this.makeColorSchemeName();
        }

        public function get entityType() : String
        {
            return this._entityType;
        }

        public function set entityType(param1:String) : void
        {
            this._entityType = param1;
        }

        protected function get model() : VehicleMarkerVO
        {
            return this._model;
        }

        protected function get vmManager() : VehicleMarkersManager
        {
            return this._vmManager;
        }

        private function onShowExInfoHandler(param1:VehicleMarkersManagerEvent) : void
        {
            this.updateMarkerSettings();
        }

        private function onUpdateSettingsHandler(param1:VehicleMarkersManagerEvent) : void
        {
            this.updateMarkerSettings();
        }

        private function onUpdateColorsHandler(param1:VehicleMarkersManagerEvent) : void
        {
            this.updateMarkerColor();
            this.setupSquadIcon();
            this.updateMarkerSettings();
        }

        private function onSplashHideHandler(param1:Event) : void
        {
            if(this._vehicleDestroyed || this._model.currHealth <= 0)
            {
                this.updateMarkerSettings();
            }
        }

        private function onStatusAnimationHiddenCompleteHandler(param1:Event) : void
        {
            if(this.actionMarker.isVisible() || this.statusContainer.isVisible())
            {
                this.updateMarkerSettings();
            }
        }
    }
}
