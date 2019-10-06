package net.wg.gui.battle.views.minimap.components.entries.vehicle
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import net.wg.gui.battle.views.minimap.components.entries.interfaces.IVehicleMinimapEntry;
    import net.wg.data.constants.InvalidationType;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.data.constants.Values;
    import net.wg.infrastructure.events.ColorSchemeEvent;
    import net.wg.gui.battle.views.minimap.MinimapEntryController;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.battle.views.minimap.components.entries.constants.VehicleMinimapEntryConst;
    import net.wg.gui.battle.views.minimap.components.entries.constants.AbsorptionFlagEntryConst;
    import flash.text.TextFormat;
    import net.wg.infrastructure.interfaces.IColorScheme;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersConstants;
    import scaleform.gfx.TextFieldEx;

    public class VehicleMinimapEntry extends BattleUIComponent implements IVehicleMinimapEntry
    {

        public static const INVALID_VEHICLE_LABEL:int = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

        public static const INVALID_VEHICLE_ACTION_ANIMATION:int = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

        public static const INVALID_CHANGE_VEHICLE_ANIMATION_TYPE:int = InvalidationType.SYSTEM_FLAGS_BORDER << 3;

        public static const INVALID_BEARER_STATE:int = InvalidationType.SYSTEM_FLAGS_BORDER << 4;

        private static const ENEMY_BEARER_LABEL:String = "enemyBearer";

        private static const ENEMY_BEARER_BLIND_LABEL:String = "enemyBearerBlind";

        private static const ALLY_BEARER_LABEL:String = "allyBearer";

        private static const ATLAS_NAME_DELIMITER:String = "_";

        public var mcTopAnimation:MarkerTopAnimation = null;

        private var _classTagName:String = "";

        private var _vehicleID:Number = -1;

        private var _guiLabel:String = "";

        private var _currentBearerLabel:String = "";

        private var _vehicleName:String = "";

        private var _actionAnimationType:String = "";

        private var _isSetVehicleInfo:Boolean = false;

        private var _aliasColor:String = "";

        private var _deadState:String = "";

        private var _isDeadPermanent:Boolean = false;

        private var _vehicleAnimationFrameLabel:String = "";

        public var enemyRedAnimation:VehicleAnimationMinimapEntry = null;

        public var enemyPurpleAnimation:VehicleAnimationMinimapEntry = null;

        public var deadAnimation:VehicleAnimationMinimapEntry = null;

        public var deadPermanentAnimation:VehicleAnimationMinimapEntry = null;

        public var squadmanYellowAnimation:VehicleAnimationMinimapEntry = null;

        public var squadmanGoldAnimation:VehicleAnimationMinimapEntry = null;

        public var teamKillerBlueAnimation:VehicleAnimationMinimapEntry = null;

        public var allyGreenAnimation:VehicleAnimationMinimapEntry = null;

        public function get xfw_currVehicleAnimation():VehicleAnimationMinimapEntry
        {
            return _currVehicleAnimation;
        }

        private var _currVehicleAnimation:VehicleAnimationMinimapEntry = null;

        private var _currentTextField:TextField = null;

        private var _vehicleAnimations:Object;

        public var vehicleNameTextFieldAlt:TextField = null;

        public var vehicleNameTextFieldClassic:TextField = null;

        public var mcBearerAnimation:MovieClip = null;

        public var mcBearerAnimationContainer:MovieClip = null;

        private var _isFlagBearer:Boolean = false;

        private var _isColorBlind:Boolean = false;

        private var _atlasItemName:String = "";

        private var _isVehicleLabelVisible:Boolean = false;

        private var _isInAoI:Boolean = false;

        public function VehicleMinimapEntry()
        {
            this._vehicleAnimations = {};
            super();
            this._vehicleAnimations[VehicleMinimapEntryConst.ALLY_GREEN_ANIMATION] = this.allyGreenAnimation;
            this._vehicleAnimations[VehicleMinimapEntryConst.ENEMY_RED_ANIMATION] = this.enemyRedAnimation;
            this._vehicleAnimations[VehicleMinimapEntryConst.ENEMY_PURPLE_ANIMATION] = this.enemyPurpleAnimation;
            this._vehicleAnimations[VehicleMinimapEntryConst.SQUADMAN_YELLOW_ANIMATION] = this.squadmanYellowAnimation;
            this._vehicleAnimations[VehicleMinimapEntryConst.SQUADMAN_GOLD_ANIMATION] = this.squadmanGoldAnimation;
            this._vehicleAnimations[VehicleMinimapEntryConst.TEAMKILLER_BLUE_ANIMATION] = this.teamKillerBlueAnimation;
            this.allyGreenAnimation.visible = this.enemyRedAnimation.visible = this.enemyPurpleAnimation.visible = this.squadmanYellowAnimation.visible = this.squadmanGoldAnimation.visible = this.teamKillerBlueAnimation.visible = this.mcBearerAnimationContainer.visible = this.deadAnimation.visible = this.deadPermanentAnimation.visible = false;
            this.vehicleNameTextFieldAlt.visible = false;
            this._currentTextField = this.vehicleNameTextFieldClassic;
            TextFieldEx.setNoTranslate(this.vehicleNameTextFieldAlt,true);
            TextFieldEx.setNoTranslate(this.vehicleNameTextFieldClassic,true);
            MinimapEntryController.instance.registerScalableEntry(this);
        }

        public function setVehicleInfo(param1:Number, param2:String, param3:String, param4:String, param5:String) : void
        {
            this._vehicleID = param1;
            var _loc6_:uint = 0;
            if(this._classTagName != param2)
            {
                this._classTagName = param2;
                _loc6_ = _loc6_ | INVALID_CHANGE_VEHICLE_ANIMATION_TYPE;
            }
            if(this._guiLabel != param4)
            {
                this._guiLabel = param4;
                _loc6_ = _loc6_ | INVALID_VEHICLE_LABEL | INVALID_CHANGE_VEHICLE_ANIMATION_TYPE;
            }
            if(this._vehicleName != param3)
            {
                this._vehicleName = param3;
                _loc6_ = _loc6_ | INVALID_VEHICLE_LABEL;
            }
            if(param5 != Values.EMPTY_STR)
            {
                this._actionAnimationType = param5;
                _loc6_ = _loc6_ | INVALID_VEHICLE_ACTION_ANIMATION;
            }
            if(!this._isSetVehicleInfo)
            {
                App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
                this._isSetVehicleInfo = true;
            }
            MinimapEntryController.instance.registerVehicleLabelEntry(this);
            if(_loc6_ != 0)
            {
                invalidate(_loc6_);
            }
        }

        private function updateBearer() : void
        {
            if(this._isFlagBearer)
            {
                this.mcBearerAnimation.visible = false;
            }
        }

        public function setGUILabel(param1:String) : void
        {
            if(this._guiLabel != param1)
            {
                this._guiLabel = param1;
                invalidate(INVALID_CHANGE_VEHICLE_ANIMATION_TYPE | INVALID_VEHICLE_LABEL);
            }
            else
            {
                invalidate(INVALID_CHANGE_VEHICLE_ANIMATION_TYPE);
            }
        }

        public function setFlagBearer(param1:Boolean) : void
        {
            if(this._isFlagBearer != param1)
            {
                this._isFlagBearer = param1;
                if(this._isFlagBearer)
                {
                    if(!this.mcBearerAnimation)
                    {
                        this.mcBearerAnimation = App.utils.classFactory.getComponent(Linkages.VEHICLE_MINIMAP_BEARER_ANIMATION,MovieClip);
                    }
                    invalidate(INVALID_BEARER_STATE);
                }
                this.mcBearerAnimationContainer.visible = this._isFlagBearer;
            }
        }

        public function setDead(param1:Boolean) : void
        {
            this._currentTextField.visible = false;
            this._deadState = VehicleMinimapEntryConst.DEAD;
            this._isDeadPermanent = param1;
            invalidate(INVALID_CHANGE_VEHICLE_ANIMATION_TYPE);
        }

        private function onDeadAnimationCompleteHandler() : void
        {
            this._currVehicleAnimation.stop();
        }

        public function setAlive() : void
        {
            this._currentTextField.visible = this._isVehicleLabelVisible;
            this._deadState = Values.EMPTY_STR;
            invalidate(INVALID_CHANGE_VEHICLE_ANIMATION_TYPE);
        }

        private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
        {
            var _loc2_:* = App.colorSchemeMgr.getScheme(AbsorptionFlagEntryConst.COLOR_SCHEME_NAME).aliasColor == AbsorptionFlagEntryConst.ENEMY_CAPTURE_BLIND;
            if(this._isColorBlind != _loc2_)
            {
                this._isColorBlind = _loc2_;
                if(this._isFlagBearer)
                {
                    invalidate(INVALID_BEARER_STATE);
                }
            }
            invalidate(INVALID_VEHICLE_LABEL | INVALID_CHANGE_VEHICLE_ANIMATION_TYPE);
        }

        public function highlight() : void
        {
            if(this._currVehicleAnimation.currentFrameLabel != VehicleMinimapEntryConst.HIGHLIGHTED_FRAME)
            {
                this._currVehicleAnimation.gotoAndPlay(VehicleMinimapEntryConst.HIGHLIGHT_ANIMATION_FRAME);
            }
        }

        public function unhighlight() : void
        {
            if(this._currVehicleAnimation.currentFrameLabel != VehicleMinimapEntryConst.UNHIGHLIGHTED_FRAME)
            {
                this._currVehicleAnimation.gotoAndPlay(VehicleMinimapEntryConst.UNHIGHLIGHT_ANIMATION_FRAME);
            }
        }

        public function setAnimation(param1:String) : void
        {
            this._actionAnimationType = param1;
            invalidate(INVALID_VEHICLE_ACTION_ANIMATION);
        }

        public function get vehicleID() : Number
        {
            return this._vehicleID;
        }

        public function hideVehicleName() : void
        {
            this._isVehicleLabelVisible = false;
            invalidate(INVALID_VEHICLE_LABEL);
        }

        public function showVehicleName() : void
        {
            this._isVehicleLabelVisible = true;
            invalidate(INVALID_VEHICLE_LABEL);
        }

        public function setInAoI(param1:Boolean) : void
        {
            this._currentTextField.visible = false;
            if(param1)
            {
                this._currentTextField = this.vehicleNameTextFieldClassic;
                MinimapEntryController.instance.registerVehicleEntry(this);
            }
            else
            {
                MinimapEntryController.instance.unregisterVehicleEntry(this);
                this._actionAnimationType = Values.EMPTY_STR;
                this._currentTextField = this.vehicleNameTextFieldAlt;
            }
            this._isInAoI = param1;
            invalidate(INVALID_VEHICLE_LABEL | INVALID_CHANGE_VEHICLE_ANIMATION_TYPE);
        }

        override protected function draw() : void
        {
            var _loc1_:TextFormat = null;
            var _loc2_:String = null;
            var _loc3_:IColorScheme = null;
            var _loc4_:String = null;
            if(isInvalid(INVALID_VEHICLE_LABEL))
            {
                if(this._isVehicleLabelVisible && App.colorSchemeMgr)
                {
                    this._currentTextField.htmlText = this._vehicleName;
                    this._currentTextField.autoSize = TextFieldAutoSize.LEFT;
                    _loc1_ = this._currentTextField.getTextFormat();
                    _loc1_.color = App.colorSchemeMgr.getRGB(VehicleMinimapEntryConst.TEXT_COLOR_SCHEME_PREFIX + this._guiLabel + VehicleMinimapEntryConst.TEXT_COLOR_SCHEME_POSTFIX);
                    this._currentTextField.setTextFormat(_loc1_);
                    this._currentTextField.height = this._currentTextField.textHeight;
                    this._currentTextField.visible = true;
                }
                else
                {
                    this._currentTextField.visible = false;
                }
                if(this._isFlagBearer)
                {
                    this.mcBearerAnimation.visible = false;
                }
            }
            if(isInvalid(INVALID_VEHICLE_ACTION_ANIMATION))
            {
                if(this._actionAnimationType != Values.EMPTY_STR)
                {
                    this.mcTopAnimation.playAnim(this._actionAnimationType);
                }
                else
                {
                    this.mcTopAnimation.gotoAndStop(1);
                }
            }
            if(isInvalid(INVALID_CHANGE_VEHICLE_ANIMATION_TYPE) && App.colorSchemeMgr)
            {
                if(this._guiLabel != Values.EMPTY_STR)
                {
                    _loc2_ = VehicleMinimapEntryConst.COLOR_SCHEME_PREFIX + this._deadState + this._guiLabel;
                    _loc3_ = App.colorSchemeMgr.getScheme(_loc2_);
                    this._aliasColor = _loc3_.aliasColor;
                    if(this._currVehicleAnimation)
                    {
                        _loc4_ = this._currVehicleAnimation.currentFrameLabel;
                        this._currVehicleAnimation.stop();
                        this._currVehicleAnimation.visible = false;
                    }
                    if(this._isInAoI)
                    {
                        this._atlasItemName = this._classTagName + ATLAS_NAME_DELIMITER + this._guiLabel + ATLAS_NAME_DELIMITER + this._deadState + this._aliasColor;
                    }
                    else
                    {
                        this._atlasItemName = VehicleMinimapEntryConst.LAST_LIT_ICON_NAME + ATLAS_NAME_DELIMITER + this._guiLabel + ATLAS_NAME_DELIMITER + this._deadState + this._aliasColor;
                    }
                    if(this._deadState == VehicleMinimapEntryConst.DEAD)
                    {
                        if(this._isDeadPermanent)
                        {
                            this._currVehicleAnimation = this.deadPermanentAnimation;
                        }
                        else
                        {
                            this._currVehicleAnimation = this.deadAnimation;
                        }
                        this._currVehicleAnimation.drawEntry(this._atlasItemName);
                        if(_loc4_ != VehicleMinimapEntryConst.DESTROYED_FRAME_LABEL)
                        {
                            this._vehicleAnimationFrameLabel = VehicleMinimapEntryConst.DESTROY_FRAME;
                        }
                        else
                        {
                            this._vehicleAnimationFrameLabel = VehicleMinimapEntryConst.DESTROYED_FRAME_LABEL;
                        }
                        this._currVehicleAnimation.visible = true;
                        this._currVehicleAnimation.gotoAndPlay(this._vehicleAnimationFrameLabel);
                    }
                    else
                    {
                        this._currVehicleAnimation = this._vehicleAnimations[this._guiLabel + ATLAS_NAME_DELIMITER + this._deadState + this._aliasColor];
                        this._currVehicleAnimation.drawEntry(this._atlasItemName);
                        if(_loc4_ == VehicleMinimapEntryConst.HIGHLIGHT_ANIMATION_FRAME || _loc4_ == VehicleMinimapEntryConst.HIGHLIGHTED_FRAME)
                        {
                            this._vehicleAnimationFrameLabel = VehicleMinimapEntryConst.HIGHLIGHTED_FRAME;
                        }
                        else
                        {
                            this._vehicleAnimationFrameLabel = VehicleMinimapEntryConst.UNHIGHLIGHTED_FRAME;
                        }
                        this._currVehicleAnimation.visible = true;
                        this._currVehicleAnimation.gotoAndStop(this._vehicleAnimationFrameLabel);
                    }
                }
            }
            if(isInvalid(INVALID_BEARER_STATE))
            {
                if(this.mcBearerAnimation)
                {
                    this._currentBearerLabel = this._guiLabel == VehicleMarkersConstants.ENTITY_NAME_ENEMY?this._isColorBlind?ENEMY_BEARER_BLIND_LABEL:ENEMY_BEARER_LABEL:ALLY_BEARER_LABEL;
                    this.mcBearerAnimation.gotoAndStop(this._currentBearerLabel);
                }
            }
        }

        override protected function onDispose() : void
        {
            MinimapEntryController.instance.unregisterScalableEntry(this);
            MinimapEntryController.instance.unregisterVehicleLabelEntry(this);
            MinimapEntryController.instance.unregisterVehicleEntry(this);
            this.mcTopAnimation.dispose();
            this.mcTopAnimation = null;
            App.utils.data.cleanupDynamicObject(this._vehicleAnimations);
            this._vehicleAnimations = null;
            this.enemyRedAnimation.dispose();
            this.enemyRedAnimation = null;
            this.enemyPurpleAnimation.dispose();
            this.enemyPurpleAnimation = null;
            this.deadAnimation.dispose();
            this.deadAnimation = null;
            this.deadPermanentAnimation.dispose();
            this.deadPermanentAnimation = null;
            this.squadmanYellowAnimation.dispose();
            this.squadmanYellowAnimation = null;
            this.squadmanGoldAnimation.dispose();
            this.squadmanGoldAnimation = null;
            this.teamKillerBlueAnimation.dispose();
            this.teamKillerBlueAnimation = null;
            this.allyGreenAnimation.dispose();
            this.allyGreenAnimation = null;
            this.mcBearerAnimation = null;
            this.mcBearerAnimationContainer = null;
            this._currVehicleAnimation = null;
            this._currentTextField = null;
            this.vehicleNameTextFieldAlt = null;
            this.vehicleNameTextFieldClassic = null;
            if(App.colorSchemeMgr)
            {
                App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
            }
            super.onDispose();
        }
    }
}
