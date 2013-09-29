package net.wg.gui.components.common.markers 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.common.markers.data.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.managers.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class VehicleMarker extends scaleform.clik.core.UIComponent
    {
        public function VehicleMarker()
        {
            super();
            return;
        }

        internal function updateIconColor():void
        {
            this.iconLoader.transform.colorTransform = this.colorsManager.getTransform(this.colorSchemeName);
            return;
        }

        internal function onIconLoaded(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            this.iconLoader.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onIconLoaded);
            this.iconLoader.x = -(this.iconLoader.width >> 1) + ICON_HORIZONTAL_OFFSET;
            return;
        }

        internal function layoutParts(arg1:Array):void
        {
            var loc4:*=null;
            var loc5:*=0;
            this.actionMarker.y = ACTION_Y;
            this.iconLoader.y = ICON_Y;
            this.levelIcon.y = LEVEL_Y;
            this.vehicleNameField.y = V_NAME_LBL_Y;
            this.playerNameField.y = P_NAME_LBL_Y;
            this.healthBar.y = HEALTH_BAR_Y;
            this.hpFieldContainer.y = HEALTH_BAR_Y + HP_FIELD_VERTICAL_OFFSET;
            var loc1:*=[];
            var loc2:*=[this.iconLoader, this.levelIcon, this.vehicleNameField, this.playerNameField, this.healthBar];
            var loc3:*=0;
            loc3 = 0;
            while (loc3 < loc2.length) 
            {
                loc1.push(arg1[loc3] ? 0 : OFFSETS[loc3]);
                ++loc3;
            }
            loc3 = 0;
            while (loc3 < loc2.length) 
            {
                loc4 = loc2[loc3];
                loc5 = loc3 + 1;
                while (loc5 < loc1.length) 
                {
                    loc4.y = loc4.y + loc1[loc5];
                    ++loc5;
                }
                ++loc3;
            }
            return;
        }

        internal function getIsPartVisible(arg1:String):Boolean
        {
            var loc1:*=false;
            var loc2:*="marker" + (this.exInfo ? "Alt" : "Base") + arg1;
            var loc3:*="marker" + (this.exInfo ? "Alt" : "Base") + "Dead";
            if (arg1 != HEALTH_LBL) 
            {
                loc1 = this.markerSettings[loc2];
            }
            else 
            {
                loc1 = !(this.markerSettings[loc2] == net.wg.gui.components.common.markers.data.HPDisplayMode.HIDDEN);
            }
            return loc1;
        }

        public function getMarkerState():String
        {
            return this._markerState;
        }

        public function setMarkerState(arg1:String):void
        {
            var loc1:*=NaN;
            this._markerState = arg1;
            if (initialized) 
            {
                if (this.model.speaking) 
                {
                    this.setVehicleClass();
                }
                loc1 = this.colorScheme.rgb;
                if (!isNaN(loc1)) 
                {
                    this.playerNameField.textColor = loc1;
                    this.vehicleNameField.textColor = loc1;
                }
                if (this._markerState) 
                {
                    if (this.vehicleDestroyed) 
                    {
                        this.actionMarker.stopAction();
                        this.updateIconColor();
                        this.setDestroyedColorForHP();
                        if (this._markerState == STATE_IMMEDIATE_DEAD) 
                        {
                            this.hitLabel.transform.colorTransform = this.colorsManager.getTransform(this.colorSchemeName);
                        }
                    }
                    this.updateMarkerSettings();
                    this.vehicleTypeMarker.gotoAndPlay(this._markerState);
                }
            }
            return;
        }

        public function updateState(arg1:String, arg2:Boolean):void
        {
            if (this.vehicleDestroyed) 
            {
                return;
            }
            if (arg2 && arg1 == STATE_DEAD) 
            {
                arg1 = STATE_IMMEDIATE_DEAD;
            }
            this.setMarkerState(arg1);
            return;
        }

        public function isSpeaking():Boolean
        {
            return this.model.speaking;
        }

        public function setSpeaking(arg1:Boolean):void
        {
            if (this.model.speaking == arg1) 
            {
                return;
            }
            this.model.speaking = arg1;
            if (initialized) 
            {
                this.setVehicleClass();
            }
            return;
        }

        internal function setVehicleClass():void
        {
            var loc1:*=this.model.speaking && !this.vehicleDestroyed ? "dynamic" : this.model.vClass;
            if (this.vehicleTypeMarker.marker.iconHunt == null) 
            {
                this.vehicleTypeMarker.marker.icon.gotoAndStop(loc1);
            }
            else 
            {
                this.vehicleTypeMarker.marker.icon.visible = !this.model.hunt;
                this.vehicleTypeMarker.marker.iconHunt.visible = this.model.hunt;
                if (this.model.hunt) 
                {
                    this.vehicleTypeMarker.marker.iconHunt.gotoAndStop(loc1);
                }
                else 
                {
                    this.vehicleTypeMarker.marker.icon.gotoAndStop(loc1);
                }
            }
            return;
        }

        public function set markerSettings(arg1:Object):void
        {
            this._markerSettingsOverride = arg1;
            return;
        }

        public function showActionMarker(arg1:String):void
        {
            this.actionMarker.showAction(arg1);
            return;
        }

        public function settingsUpdate(arg1:Number):void
        {
            var loc1:*=net.wg.gui.components.common.markers.data.VehicleMarkerFlags.DAMAGE_FROM[arg1];
            this.hitLabel.fakeDamage = this.model.maxHealth - this.model.curHealth;
            this.hitLabel.imitationFlag = net.wg.gui.components.common.markers.data.VehicleMarkerFlags.DAMAGE_COLOR[loc1][this._markerColor];
            this.hitLabel.imitation = this.getIsPartVisible(DAMAGE_PANEL);
            this.setupIconLoader();
            this.update();
            return;
        }

        public function update():void
        {
            this.updateMarkerColor();
            this.updateMarkerSettings();
            return;
        }

        public function updateMarkerSettings():void
        {
            var loc1:*=this.getIsPartVisible(ICON);
            var loc2:*=this.getIsPartVisible(LEVEL);
            var loc3:*=this.getIsPartVisible(P_NAME_LBL);
            var loc4:*=this.getIsPartVisible(V_NAME_LBL);
            var loc5:*=this.getIsPartVisible(HEALTH_BAR);
            var loc6:*=this.getIsPartVisible(HEALTH_LBL);
            var loc7:*=this.getIsPartVisible(DAMAGE_PANEL);
            this.playerNameField.visible = loc3;
            this.playerNameField.text = this.model.pFullName;
            this.vehicleNameField.visible = loc4;
            this.vehicleNameField.text = this.model.vType;
            if (loc5) 
            {
                this.healthBar.curHealth = this.model.curHealth;
            }
            this.healthBar.visible = loc5;
            this.hpFieldContainer.gotoAndStop(loc5 ? "withBar" : "withoutBar");
            this.hpFieldContainer.visible = loc6;
            if (this.vehicleDestroyed) 
            {
                this.setDestroyedColorForHP();
            }
            this.setHealthText();
            this.hitLabel.visible = loc7;
            this.hitExplosion.visible = loc7;
            this.levelIcon.visible = loc2;
            this.iconLoader.visible = loc1;
            this.backgroundShadow.visible = loc5 || loc6 || loc2 || loc1 || loc3 || loc4;
            var loc8:*=(loc5 || loc6 ? 1 : 0) + (loc2 || loc1 ? 1 : 0) + (loc3 ? 1 : 0) + (loc4 ? 1 : 0);
            var loc9:*="shadow_" + (loc5 ? "bar_" : "") + loc8.toString();
            this.backgroundShadow.gotoAndStop(loc9);
            this.layoutParts([loc1, loc2, loc4, loc3, loc5 || loc6]);
            return;
        }

        internal function onSplashHidden(arg1:flash.events.Event):void
        {
            if (this.vehicleDestroyed || this.model.curHealth <= 0) 
            {
                this.updateMarkerSettings();
            }
            return;
        }

        public function setEntityName(arg1:String):void
        {
            if (arg1 == this._entityName) 
            {
                return;
            }
            this._entityName = arg1;
            this.update();
            return;
        }

        public function showExInfo(arg1:Boolean):void
        {
            this.updateMarkerSettings();
            return;
        }

        public function get exInfo():Boolean
        {
            return this._exInfoOverride || s_showExInfo;
        }

        public function set exInfo(arg1:Boolean):void
        {
            this._exInfoOverride = arg1;
            return;
        }

        public function get markerSettings():Object
        {
            var loc1:*=null;
            if (this._markerSettingsOverride) 
            {
                loc1 = this._markerSettingsOverride;
            }
            else if (this.vehicleDestroyed) 
            {
                loc1 = s_markerSettings["dead"];
            }
            else 
            {
                loc1 = s_markerSettings[this.model.entityType];
            }
            return loc1;
        }

        
        {
            ICON = "Icon";
            LEVEL = "Level";
            HEALTH_LBL = "Hp";
            HEALTH_BAR = "HpIndicator";
            P_NAME_LBL = "PlayerName";
            V_NAME_LBL = "VehicleName";
            DAMAGE_PANEL = "Damage";
            ACTION_Y = -93;
            ICON_Y = -86;
            LEVEL_Y = -74;
            V_NAME_LBL_Y = -62;
            P_NAME_LBL_Y = -49;
            HEALTH_BAR_Y = -29;
            ICON_OFFSET = 15;
            LEVEL_OFFSET = 3;
            V_NAME_LBL_OFFSET = 13;
            P_NAME_LBL_OFFSET = 13;
            HEALTH_BAR_OFFSET = 13;
            OFFSETS = [ICON_OFFSET, LEVEL_OFFSET, V_NAME_LBL_OFFSET, P_NAME_LBL_OFFSET, HEALTH_BAR_OFFSET];
            s_showExInfo = false;
            s_markerSettings = {"ally":new net.wg.gui.components.common.markers.data.VehicleMarkerSettings(), "enemy":new net.wg.gui.components.common.markers.data.VehicleMarkerSettings(), "dead":new net.wg.gui.components.common.markers.data.VehicleMarkerSettings()};
        }

        public function get isEnabledExInfo():Boolean
        {
            var loc1:*="marker" + (this.exInfo ? "Alt" : "Base") + "Dead";
            return this.markerSettings[loc1];
        }

        public override function dispose():void
        {
            this.iconLoader.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onIconLoaded);
            this.healthBar.hitSplash.removeEventListener(net.wg.gui.components.common.markers.HealthBarAnimatedPart.HIDE, this.onSplashHidden);
            if (this.model) 
            {
                this.model.dispose();
                this.model = null;
            }
            if (this._markerSettingsOverride) 
            {
                this._markerSettingsOverride = null;
            }
            super.dispose();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.healthBar.hitSplash.addEventListener(net.wg.gui.components.common.markers.HealthBarAnimatedPart.HIDE, this.onSplashHidden);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && this.model && !this._isPopulated) 
            {
                this.initMarkerColor();
                this.setupHealthBar();
                this.setupIconLoader();
                this.levelIcon.gotoAndStop(this.model.vLevel);
                if (this.model.vClass) 
                {
                    this.setVehicleClass();
                }
                this.setMarkerState(this._markerState);
                this.updateMarkerSettings();
                this._isPopulated = true;
            }
            return;
        }

        public function init(arg1:Object):void
        {
            this.model = new net.wg.gui.components.common.markers.data.VehicleMarkerVO(arg1);
            if (this.model.entityName) 
            {
                this._entityName = this.model.entityName;
            }
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        internal function initMarkerColor():void
        {
            this._markerColor = this.colorsManager.getAliasColor(this.colorSchemeName);
            this.applyColor();
            return;
        }

        internal function updateMarkerColor():void
        {
            var loc1:*=this.colorsManager.getAliasColor(this.colorSchemeName);
            if (this._markerColor == loc1) 
            {
                return;
            }
            this._markerColor = loc1;
            this.applyColor();
            if (this.model.vClass) 
            {
                this.setVehicleClass();
            }
            this.setMarkerState(this._markerState);
            this.updateIconColor();
            return;
        }

        internal function applyColor():void
        {
            gotoAndStop(this._markerColor);
            this.healthBar.color = this._markerColor;
            return;
        }

        public function get colorsManager():net.wg.infrastructure.managers.IColorSchemeManager
        {
            return App.colorSchemeMgr;
        }

        public function get colorSchemeName():String
        {
            return (this.vehicleDestroyed ? "vm_dead_" : "vm_") + this._entityName;
        }

        public function get colorScheme():net.wg.infrastructure.interfaces.IColorScheme
        {
            return this.colorsManager.getScheme(this.colorSchemeName);
        }

        public function get vehicleDestroyed():Boolean
        {
            return this._markerState == STATE_DEAD || this._markerState == STATE_IMMEDIATE_DEAD;
        }

        internal function setupHealthBar():void
        {
            if (this.getHealthPercents() >= 0) 
            {
                this.healthBar.maxHealth = this.model.maxHealth;
                this.healthBar.curHealth = this.model.curHealth;
            }
            return;
        }

        public function updateHealth(arg1:Number, arg2:int, arg3:String):void
        {
            var loc1:*=net.wg.gui.components.common.markers.data.VehicleMarkerFlags.DAMAGE_FROM[arg2];
            arg3 = arg1 < 0 ? net.wg.gui.components.common.markers.data.VehicleMarkerFlags.DAMAGE_EXPLOSION : arg3;
            arg1 = Math.max(arg1, 0);
            var loc2:*=this.model.curHealth - arg1;
            this.model.curHealth = arg1;
            if (this._isPopulated) 
            {
                if (this.getIsPartVisible(HEALTH_BAR)) 
                {
                    this.healthBar.updateHealth(arg1, net.wg.gui.components.common.markers.data.VehicleMarkerFlags.DAMAGE_COLOR[loc1][this._markerColor]);
                }
                if (this.getIsPartVisible(DAMAGE_PANEL)) 
                {
                    this.hitLabel.damage(loc2, net.wg.gui.components.common.markers.data.VehicleMarkerFlags.DAMAGE_COLOR[loc1][this._markerColor]);
                    if (net.wg.gui.components.common.markers.data.VehicleMarkerFlags.checkAllowedDamages(arg3)) 
                    {
                        this.hitExplosion.setColorAndDamageType(net.wg.gui.components.common.markers.data.VehicleMarkerFlags.DAMAGE_COLOR[loc1][this._markerColor], arg3);
                        this.hitExplosion.x = Math.round(this.hitLabel.x + this.hitLabel.damageLabel.textWidth + EXPLOSION_HORIZONTAL_OFFSET);
                        this.hitExplosion.playShowTween();
                    }
                    this.hitLabel.playShowTween();
                }
                if (this.getIsPartVisible(HEALTH_LBL)) 
                {
                    if (this.vehicleDestroyed) 
                    {
                        this.setDestroyedColorForHP();
                    }
                    this.setHealthText();
                }
            }
            return;
        }

        internal function setDestroyedColorForHP():void
        {
            this.hpFieldContainer.hpField.textColor = VEHICLE_DESTROY_COLOR;
            return;
        }

        internal function setHealthText():void
        {
            var loc1:*=null;
            var loc2:*=this.markerSettings["marker" + (this.exInfo ? "Alt" : "Base") + "Hp"];
            var loc3:*=loc2;
            switch (loc3) 
            {
                case net.wg.gui.components.common.markers.data.HPDisplayMode.PERCENTS:
                {
                    loc1 = this.getHealthPercents() + "%";
                    break;
                }
                case net.wg.gui.components.common.markers.data.HPDisplayMode.CURRENT_AND_MAXIMUM:
                {
                    loc1 = this.model.curHealth + " / " + this.model.maxHealth;
                    break;
                }
                case net.wg.gui.components.common.markers.data.HPDisplayMode.CURRENT:
                {
                    loc1 = this.model.curHealth.toString();
                    break;
                }
                default:
                {
                    loc1 = "";
                    break;
                }
            }
            this.hpFieldContainer.hpField.text = loc1;
            return;
        }

        internal function getHealthPercents():Number
        {
            return Math.ceil(this.model.curHealth / this.model.maxHealth * 100);
        }

        internal function setupIconLoader():void
        {
            this.iconLoader.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onIconLoaded);
            this.iconLoader.source = this.model.vIconSource;
            this.updateIconColor();
            return;
        }

        public static const STATE_HIT:String="hit";

        public static const STATE_DEAD:String="dead";

        public static const STATE_IMMEDIATE_DEAD:String="immediate_dead";

        internal static const ICON_HORIZONTAL_OFFSET:Number=6;

        internal static const HP_FIELD_VERTICAL_OFFSET:Number=-3;

        public static const STATE_HIT_PIERCED:String="hit_pierced";

        internal static const EXPLOSION_HORIZONTAL_OFFSET:Number=15;

        public static const STATE_NORMAL:String="normal";

        internal static const VEHICLE_DESTROY_COLOR:Number=6710886;

        public var hpFieldContainer:flash.display.MovieClip;

        public var actionMarker:net.wg.gui.components.common.markers.VehicleActionMarker;

        public var vehicleTypeMarker:flash.display.MovieClip;

        public var hitLabel:net.wg.gui.components.common.markers.HealthBarAnimatedLabel;

        public var vehicleNameField:flash.text.TextField;

        public var playerNameField:flash.text.TextField;

        public var healthBar:net.wg.gui.components.common.markers.HealthBar;

        protected var model:net.wg.gui.components.common.markers.data.VehicleMarkerVO;

        protected var _entityName:String="enemy";

        protected var _markerColor:String="red";

        protected var _markerState:String;

        internal var _isPopulated:Boolean=false;

        internal var _exInfoOverride:Boolean=false;

        internal var _markerSettingsOverride:Object;

        public var backgroundShadow:flash.display.MovieClip;

        public var hitExplosion:net.wg.gui.components.common.markers.AnimateExplosion;

        public var levelIcon:flash.display.MovieClip;

        internal static var ICON:String="Icon";

        internal static var LEVEL:String="Level";

        internal static var HEALTH_LBL:String="Hp";

        internal static var HEALTH_BAR:String="HpIndicator";

        internal static var P_NAME_LBL:String="PlayerName";

        internal static var V_NAME_LBL:String="VehicleName";

        internal static var DAMAGE_PANEL:String="Damage";

        internal static var ACTION_Y:Number=-93;

        internal static var ICON_Y:Number=-86;

        internal static var LEVEL_Y:Number=-74;

        public var iconLoader:net.wg.gui.components.controls.UILoaderAlt;

        internal static var P_NAME_LBL_Y:Number=-49;

        internal static var HEALTH_BAR_Y:Number=-29;

        internal static var ICON_OFFSET:Number=15;

        internal static var LEVEL_OFFSET:Number=3;

        internal static var V_NAME_LBL_OFFSET:Number=13;

        internal static var P_NAME_LBL_OFFSET:Number=13;

        internal static var HEALTH_BAR_OFFSET:Number=13;

        internal static var OFFSETS:Array;

        public static var s_showExInfo:Boolean=false;

        public static var s_markerSettings:Object;

        internal static var V_NAME_LBL_Y:Number=-62;
    }
}
