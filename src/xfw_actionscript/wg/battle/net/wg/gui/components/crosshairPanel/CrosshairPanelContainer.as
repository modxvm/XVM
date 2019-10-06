package net.wg.gui.components.crosshairPanel
{
    import net.wg.infrastructure.base.meta.impl.CrosshairPanelContainerMeta;
    import flash.display.DisplayObject;
    import flash.utils.getDefinitionByName;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.components.crosshairPanel.components.speedometer.Speedometer;
    import net.wg.gui.components.crosshairPanel.components.gunMarker.IGunMarker;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.BlendMode;
    import flash.utils.getTimer;
    import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;
    import flash.utils.setInterval;
    import net.wg.data.constants.Values;
    import net.wg.gui.components.crosshairPanel.VO.CrosshairSettingsVO;
    import flash.display.StageScaleMode;
    import flash.display.StageAlign;
    import flash.display.MovieClip;
    import flash.utils.clearInterval;

    public class CrosshairPanelContainer extends CrosshairPanelContainerMeta implements ICrosshairPanelContainer
    {

        private static const SPEEDOMETER_OFFSET:int = 134;

        private static const CROSSHAIRS_LINAKGES:Vector.<String> = new <String>[Linkages.CROSSHAIR_ARCADE_UI,Linkages.CROSSHAIR_SNIPER_UI,Linkages.CROSSHAIR_STRATEGIC_UI,Linkages.CROSSHAIR_POSTMORTEM_UI];

        protected var gunMarkers:Object = null;

        private var _currentCrosshair:ICrosshair = null;

        private var _viewId:int = -1;

        private var _visibleNet:int = 3;

        private var _settingId:int = -1;

        private var _settings:Array = null;

        private var _healthInPercents:Number = 0;

        private var _zoomStr:String = "";

        private var _distanceStr:String = "";

        private var _playerInfoStr:String = "";

        private var _isDistanceShown:Boolean = true;

        private var _scale:Number = 1;

        private var _reloadingInterval:Number = -1;

        private var _currReloadingPercent:Number = 0;

        private var _previousReloadingPercent:Number = 0;

        private var _autoloaderBaseTime:Number = 0;

        private var _reloadingProgress:Number = 0;

        private var _reloadingProgressSeconds:Number = 0;

        private var _autoloaderState:String = "reloadingEnd";

        private var _autoloaderTimer:Number = -1;

        private var _reloadingAutoloaderFinishTime:Number = 0;

        private var _isAutoloaderTimerOn:Boolean = false;

        private var _autoloaderAnimationBaseTime:Number = 0;

        private var _autoloaderAnimationProgress:Number = 0;

        private var _autoloaderAnimationFinishTime:Number = 0;

        private var _autoloaderAnimationTimer:Number = -1;

        private var _autoloaderAnimationState:String = "reloadingEnd";

        private var _remainingTimeInSec:Number = 0;

        private var _baseReloadingTimeInSec:Number = 0;

        private var _initReloadingTime:Number = 0;

        private var _baseReloadingTimeInMsec:Number = 0;

        private var _currReloadingState:String = "reloadingInit";

        private var _ammoQuantity:Number = 0;

        private var _ammoQuantityInClip:Number = 0;

        private var _isAmmoLow:Boolean = false;

        private var _isAutoloader:Boolean = false;

        private var _isAutoloaderCritical:Boolean = false;

        private var _ammoClipState:String = "";

        private var _ammoClipReloaded:Boolean = false;

        private var _ammoState:String = "";

        private var _clipCapacity:Number = -1;

        private var _burst:Number = -1;

        private var _isReloadingTimeFieldShown:Boolean = true;

        private var _crosshairs:Vector.<ICrosshair> = null;

        private var _netType:int = -1;

        private var _speedometer:Speedometer = null;

        private var _speed:int = 0;

        private var _burnout:Number = 0;

        private var _speedMode:Boolean = false;

        private var _isWarning:Boolean = false;

        private var _isEngineCrush:Boolean = false;

        private var _burnoutWarning:String = "";

        private var _engineCrush:String = "";

        public function CrosshairPanelContainer()
        {
            super();
            this._settings = [];
            this.gunMarkers = {};
        }

        private static function createComponent(param1:String) : DisplayObject
        {
            var _loc2_:Class = Class(getDefinitionByName(param1));
            return new _loc2_();
        }

        private static function cleanupObject(param1:Object) : Object
        {
            var _loc3_:String = null;
            var _loc2_:Array = [];
            for(_loc3_ in param1)
            {
                _loc2_.push(_loc3_);
            }
            for each(_loc3_ in _loc2_)
            {
                delete param1[_loc3_];
            }
            _loc2_.splice(0,_loc2_.length);
            return null;
        }

        override protected function onDispose() : void
        {
            var _loc1_:IGunMarker = null;
            var _loc2_:IDisposable = null;
            this.clearReloadingTimer();
            this.clearAutoloaderReloadTimer();
            this.clearAutoloaderAtimationTimer();
            if(this._speedometer)
            {
                this._speedometer.dispose();
                this._speedometer = null;
            }
            this._currentCrosshair = null;
            this._settings = null;
            for each(_loc1_ in this.gunMarkers)
            {
                _loc1_.dispose();
            }
            this.gunMarkers = cleanupObject(this.gunMarkers);
            for each(_loc2_ in this._crosshairs)
            {
                _loc2_.dispose();
            }
            this._crosshairs.length = 0;
            this._crosshairs = null;
            super.onDispose();
        }

        public function as_addSpeedometer(param1:int, param2:int) : void
        {
            if(this._speedometer == null)
            {
                this._speedometer = Speedometer(createComponent(Linkages.SPEEDOMETER_UI));
                this._speedometer.x = this._speedometer.y = SPEEDOMETER_OFFSET;
                this._speedometer.setMaxSpeedNormalMode(param1);
                this._speedometer.setMaxSpeedSpeedMode(param2);
                this._speedometer.blendMode = BlendMode.ADD;
            }
            this._speedometer.visible = true;
            this.attachSpeedometer();
        }

        public function as_autoloaderUpdate(param1:Number, param2:Number, param3:Boolean, param4:Boolean, param5:Boolean) : void
        {
            this.clearAutoloaderReloadTimer();
            this._isAutoloaderTimerOn = param5;
            this._autoloaderBaseTime = param2;
            this._reloadingAutoloaderFinishTime = getTimer() + param1 * CrosshairConsts.MS_IN_SECOND;
            if(param1 > 0)
            {
                this._autoloaderState = CrosshairConsts.RELOADING_PROGRESS;
                this._autoloaderTimer = setInterval(this.updateAutoloaderReloadingTimer,CrosshairConsts.ANIMATION_UPDATE_TICK);
            }
            else if(param1 == 0)
            {
                this._autoloaderState = CrosshairConsts.RELOADING_END;
                this._reloadingProgressSeconds = this._autoloaderBaseTime;
            }
            this._isAutoloaderCritical = param4;
            if(this._currentCrosshair != null)
            {
                this._currentCrosshair.updateCritical(this._isAutoloaderCritical);
            }
            this.applyAutoloaderState();
        }

        public function as_clearDistance(param1:Boolean) : void
        {
            this._distanceStr = Values.EMPTY_STR;
            this._isDistanceShown = false;
            if(this._currentCrosshair != null)
            {
                this._currentCrosshair.clearDistance(param1);
            }
        }

        public function as_createGunMarker(param1:Number, param2:String, param3:String) : Boolean
        {
            var gunMarker:IGunMarker = null;
            var settings:CrosshairSettingsVO = null;
            var viewID:Number = param1;
            var linkageName:String = param2;
            var sceneName:String = param3;
            try
            {
                gunMarker = IGunMarker(addChild(createComponent(linkageName)));
                gunMarker.name = sceneName;
                gunMarker.setScale(this._scale);
                this.gunMarkers[sceneName] = gunMarker;
                settings = this._settings[this._settingId];
                if(settings)
                {
                    gunMarker.setSettings(settings.gunTagType,settings.mixingType,settings.gunTagAlpha,settings.mixingAlpha);
                }
                gunMarker.setReloadingParams(this._currReloadingPercent,this._currReloadingState);
                return true;
            }
            catch(e:ReferenceError)
            {
            }
            return false;
        }

        public function as_destroyGunMarker(param1:String) : Boolean
        {
            var _loc2_:IGunMarker = this.gunMarkers[param1];
            if(_loc2_)
            {
                _loc2_.dispose();
                removeChild(DisplayObject(_loc2_));
                delete this.gunMarkers[param1];
                return true;
            }
            return false;
        }

        public function as_recreateDevice(param1:Number, param2:Number) : void
        {
            var _loc3_:ICrosshair = null;
            for each(_loc3_ in this._crosshairs)
            {
                _loc3_.x = param1;
                _loc3_.y = param2;
            }
        }

        public function as_removeSpeedometer() : void
        {
            if(this._speedometer)
            {
                this._speedometer.visible = false;
            }
        }

        public function as_setAmmoStock(param1:Number, param2:Number, param3:Boolean, param4:String, param5:Boolean) : void
        {
            this._ammoQuantity = param1;
            this._ammoQuantityInClip = param2;
            this._isAmmoLow = param3;
            this._ammoClipState = param4;
            this._ammoClipReloaded = param5;
            if(this._ammoQuantity == 0)
            {
                this._remainingTimeInSec = 0;
                this._currReloadingState = CrosshairConsts.RELOADING_IMPOSSIBLE_AMMO_ENDED;
            }
            if(this._currentCrosshair != null)
            {
                this._currentCrosshair.setAmmoStock(this._ammoQuantity,this._ammoQuantityInClip,this._isAmmoLow,this._ammoClipState,this._ammoClipReloaded);
            }
            this._ammoClipReloaded = false;
        }

        public function as_setAutoloaderPercent(param1:Number, param2:Number, param3:Boolean) : void
        {
            if(this._currentCrosshair != null)
            {
                this._currentCrosshair.autoloaderUpdate(param1,param2,param3);
            }
        }

        public function as_setAutoloaderReloadasPercent(param1:Number) : void
        {
            if(this._currentCrosshair != null)
            {
                this._currentCrosshair.setAutoloaderReloadingAsPercent(param1,false);
            }
        }

        public function as_setAutoloaderReloading(param1:Number, param2:Number) : void
        {
            this.clearAutoloaderAtimationTimer();
            this._autoloaderAnimationBaseTime = param2;
            this._autoloaderAnimationFinishTime = getTimer() + param1 * CrosshairConsts.MS_IN_SECOND;
            if(param1 > 0)
            {
                this._autoloaderAnimationState = CrosshairConsts.RELOADING_PROGRESS;
                this._autoloaderAnimationTimer = setInterval(this.updateAutoloaderAnimationTimer,CrosshairConsts.ANIMATION_UPDATE_TICK);
            }
            else if(param1 == 0)
            {
                this._autoloaderAnimationState = CrosshairConsts.RELOADING_END;
                this._autoloaderAnimationProgress = 0;
            }
            this.applyAutoloaderAnimationState();
        }

        public function as_setBurnoutWarning(param1:String) : void
        {
            this._burnoutWarning = param1;
            this._isWarning = true;
            if(this._speedometer)
            {
                this._speedometer.setWarning(param1);
            }
        }

        public function as_setClipParams(param1:Number, param2:Number, param3:Boolean) : void
        {
            this._isAutoloader = param3;
            this._clipCapacity = param1;
            this._burst = param2;
            if(this._currentCrosshair != null)
            {
                this._currentCrosshair.setClipsParam(this._clipCapacity,this._burst,param3);
            }
        }

        public function as_setDistance(param1:String) : void
        {
            this._distanceStr = param1;
            this._isDistanceShown = true;
            if(this._currentCrosshair != null)
            {
                this._currentCrosshair.setDistance(this._distanceStr);
            }
        }

        public function as_setEngineCrushError(param1:String) : void
        {
            this._engineCrush = param1;
            this._isEngineCrush = true;
            if(this._speedometer)
            {
                this._speedometer.setEngineCrushError(param1);
            }
        }

        public function as_setGunMarkerColor(param1:String, param2:String) : void
        {
            var _loc3_:IGunMarker = this.gunMarkers[param1];
            if(_loc3_)
            {
                _loc3_.setColor(param2);
            }
        }

        public function as_setHealth(param1:Number) : void
        {
            this._healthInPercents = param1;
            if(this._currentCrosshair != null)
            {
                this._currentCrosshair.setHealth(this._healthInPercents);
            }
        }

        public function as_setNetType(param1:int) : void
        {
            if(this._netType != param1)
            {
                this._netType = param1;
                this.applySettings();
            }
        }

        public function as_setNetVisible(param1:int) : void
        {
            if(this._visibleNet == param1)
            {
                return;
            }
            this._visibleNet = param1;
            if(this._currentCrosshair != null)
            {
                this._currentCrosshair.setVisibleNet(this._visibleNet);
            }
        }

        public function as_setReloading(param1:Number, param2:Number, param3:Number, param4:Boolean) : void
        {
            this.clearReloadingTimer();
            this._baseReloadingTimeInSec = param2;
            if(param1 == 0)
            {
                this._currReloadingPercent = 100;
                this._remainingTimeInSec = this._baseReloadingTimeInSec;
                if(param4)
                {
                    this._currReloadingState = CrosshairConsts.RELOADING_END;
                }
                else if(param2 == 0)
                {
                    this._currReloadingState = CrosshairConsts.RELOADING_INIT;
                }
                else
                {
                    this._currReloadingState = CrosshairConsts.RELOADING_ENDED;
                }
            }
            else if(param1 == -1)
            {
                this._currReloadingPercent = 0;
                if(this._ammoQuantity == 0)
                {
                    this._remainingTimeInSec = 0;
                    this._currReloadingState = CrosshairConsts.RELOADING_IMPOSSIBLE_AMMO_ENDED;
                }
                else
                {
                    this._remainingTimeInSec = this._baseReloadingTimeInSec;
                    this._currReloadingState = CrosshairConsts.RELOADING_INIT;
                }
            }
            else
            {
                if(this._currReloadingState == CrosshairConsts.RELOADING_PROGRESS)
                {
                    this._remainingTimeInSec = param1;
                    this._previousReloadingPercent = this._currReloadingPercent;
                }
                else
                {
                    this._remainingTimeInSec = param1;
                    this._previousReloadingPercent = this._currReloadingPercent = param3 / param2;
                }
                this._currReloadingState = CrosshairConsts.RELOADING_PROGRESS;
                this._initReloadingTime = getTimer();
                this._baseReloadingTimeInMsec = this._baseReloadingTimeInSec * 1000;
                this._reloadingInterval = setInterval(this.updateReloadingTimer,CrosshairConsts.COUNTER_UPDATE_TICK,false);
            }
            this.updateCurrentCrosshairReloadingParams();
        }

        public function as_setReloadingAsPercent(param1:Number, param2:Boolean) : void
        {
            if(param1 >= 100)
            {
                this._currReloadingPercent = 1;
                this._remainingTimeInSec = this._baseReloadingTimeInSec;
                if(param2)
                {
                    this._currReloadingState = CrosshairConsts.RELOADING_END;
                }
                else
                {
                    this._currReloadingState = CrosshairConsts.RELOADING_ENDED;
                }
            }
            else
            {
                this._currReloadingState = CrosshairConsts.RELOADING_PROGRESS;
                this._currReloadingPercent = param1 / 100;
            }
            this.applyData(true);
        }

        public function as_setReloadingCounterShown(param1:Boolean) : void
        {
            this._isReloadingTimeFieldShown = param1;
            if(this._currentCrosshair != null)
            {
                this._currentCrosshair.showReloadingTimeField(param1);
            }
        }

        public function as_setScale(param1:Number) : void
        {
            var _loc2_:ICrosshair = null;
            var _loc3_:IGunMarker = null;
            if(this._scale == param1)
            {
                return;
            }
            this._scale = param1;
            for each(_loc2_ in this._crosshairs)
            {
                _loc2_.scaleX = _loc2_.scaleY = this._scale;
            }
            if(this.gunMarkers)
            {
                for each(_loc3_ in this.gunMarkers)
                {
                    _loc3_.setScale(this._scale);
                }
            }
        }

        public function as_setSettings(param1:Object) : void
        {
            var _loc2_:String = null;
            var _loc3_:Object = null;
            for(_loc2_ in param1)
            {
                _loc3_ = param1[_loc2_];
                if(_loc3_)
                {
                    this._settings[int(_loc2_)] = new CrosshairSettingsVO(_loc3_);
                }
            }
            this.applySettings();
        }

        public function as_setSpeedMode(param1:Boolean) : void
        {
            this._speedMode = param1;
            if(this._speedometer)
            {
                this._speedometer.changeState(param1);
            }
        }

        public function as_setView(param1:int, param2:int) : void
        {
            if(this._viewId == param1 && this._settingId == param2)
            {
                return;
            }
            this._viewId = param1;
            this._settingId = param2;
            if(this._viewId <= 0)
            {
                this.hideAll();
            }
            else if(this._currentCrosshair != null)
            {
                if(this._currentCrosshair.visible)
                {
                    this._currentCrosshair.visible = false;
                }
                this._currentCrosshair = this._crosshairs[this._viewId - 1];
                this._currentCrosshair.visible = true;
                this._currentCrosshair.setVisibleNet(this._visibleNet);
            }
            this.applySettings();
            this.applyData();
        }

        public function as_setZoom(param1:String) : void
        {
            if(this._currentCrosshair != null)
            {
                this._zoomStr = param1;
                this._currentCrosshair.setZoom(this._zoomStr);
            }
        }

        public function as_showShot() : void
        {
            if(this._isAutoloader && this._currentCrosshair != null)
            {
                this._currentCrosshair.autoloaderShowShot();
            }
        }

        public function as_stopBurnoutWarning() : void
        {
            this._isWarning = false;
            if(this._speedometer)
            {
                this._speedometer.stopWarning();
            }
        }

        public function as_stopEngineCrushError() : void
        {
            this._isEngineCrush = false;
            if(this._speedometer)
            {
                this._speedometer.stopEngineCrushError();
            }
        }

        public function as_updateAmmoState(param1:String) : void
        {
            if(this._currentCrosshair != null)
            {
                this._ammoState = param1;
                this._currentCrosshair.updateAmmoState(this._ammoState);
            }
        }

        public function as_updateBurnout(param1:Number) : void
        {
            this._burnout = param1;
            if(this._speedometer)
            {
                this._speedometer.setBurnout(param1);
            }
        }

        public function as_updatePlayerInfo(param1:String) : void
        {
            if(this._currentCrosshair != null)
            {
                this._playerInfoStr = param1;
                this._currentCrosshair.updatePlayerInfo(this._playerInfoStr);
            }
        }

        public function as_updateSpeed(param1:int) : void
        {
            this._speed = param1;
            if(this._speedometer)
            {
                this._speedometer.setSpeed(param1);
            }
        }

        public function init() : void
        {
            var _loc1_:ICrosshair = null;
            var _loc2_:String = null;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            this._crosshairs = new Vector.<ICrosshair>(0);
            for each(_loc2_ in CROSSHAIRS_LINAKGES)
            {
                _loc1_ = ICrosshair(createComponent(_loc2_));
                this._crosshairs.push(_loc1_);
                addChild(DisplayObject(_loc1_));
            }
            this._currentCrosshair = this._crosshairs[0];
            this.hideAll();
        }

        private function attachSpeedometer() : void
        {
            if(this._currentCrosshair != null && this._speedometer != null)
            {
                if(this._speedometer.parent != null)
                {
                    this._speedometer.parent.removeChild(this._speedometer);
                }
                MovieClip(this._currentCrosshair).addChild(this._speedometer);
                MovieClip(this._currentCrosshair).blendMode = BlendMode.LAYER;
            }
        }

        private function updateAutoloaderAnimationTimer() : void
        {
            if(getTimer() >= this._autoloaderAnimationFinishTime)
            {
                this.clearAutoloaderAtimationTimer();
            }
            this.applyAutoloaderAnimationState();
        }

        private function applyAutoloaderAnimationState(param1:Boolean = false) : void
        {
            var _loc2_:* = NaN;
            if(this._autoloaderAnimationState != CrosshairConsts.RELOADING_END)
            {
                _loc2_ = (this._autoloaderAnimationFinishTime - getTimer()) / CrosshairConsts.MS_IN_SECOND;
                this._autoloaderAnimationProgress = _loc2_ / this._autoloaderAnimationBaseTime;
            }
            if(this._currentCrosshair != null)
            {
                this._currentCrosshair.setAutoloaderReloadingAsPercent(1 - this._autoloaderAnimationProgress,param1);
            }
        }

        private function clearAutoloaderReloadTimer() : void
        {
            if(this._autoloaderTimer != -1)
            {
                clearInterval(this._autoloaderTimer);
                this._autoloaderTimer = -1;
            }
        }

        private function clearAutoloaderAtimationTimer() : void
        {
            if(this._autoloaderAnimationTimer != -1)
            {
                clearInterval(this._autoloaderAnimationTimer);
                this._autoloaderAnimationTimer = -1;
            }
        }

        private function updateAutoloaderReloadingTimer() : void
        {
            if(getTimer() >= this._reloadingAutoloaderFinishTime)
            {
                this.clearAutoloaderReloadTimer();
            }
            this.applyAutoloaderState();
        }

        private function applyAutoloaderState() : void
        {
            if(this._autoloaderState != CrosshairConsts.RELOADING_END)
            {
                this._reloadingProgressSeconds = (this._reloadingAutoloaderFinishTime - getTimer()) / CrosshairConsts.MS_IN_SECOND;
                this._reloadingProgress = this._reloadingProgressSeconds / this._autoloaderBaseTime;
            }
            if(this._currentCrosshair != null)
            {
                this._currentCrosshair.autoloaderUpdate(this._reloadingProgress,this._reloadingProgressSeconds,this._isAutoloaderTimerOn);
            }
        }

        private function applyData(param1:Boolean = false) : void
        {
            if(this._currentCrosshair != null)
            {
                this._currentCrosshair.setInfo(this._healthInPercents,this._zoomStr,this._currReloadingState,this._isReloadingTimeFieldShown,this._isDistanceShown,this._distanceStr,this._playerInfoStr,this._clipCapacity,this._burst,this._ammoState,this._ammoQuantity,this._ammoQuantityInClip,this._isAmmoLow,this._ammoClipState,this._ammoClipReloaded,this._isAutoloader,this._isAutoloaderCritical);
                if(this._speedometer != null)
                {
                    this._speedometer.changeState(this._speedMode);
                    this._speedometer.setBurnout(this._burnout);
                    this._speedometer.setSpeed(this._speed);
                    if(this._speedometer.warning.visible != this._isWarning)
                    {
                        if(this._isWarning)
                        {
                            this._speedometer.setWarning(this._burnoutWarning);
                        }
                        else
                        {
                            this._speedometer.stopWarning();
                        }
                    }
                    if(this._speedometer.engineError.visible != this._isEngineCrush)
                    {
                        if(this._isEngineCrush)
                        {
                            this._speedometer.setEngineCrushError(this._engineCrush);
                        }
                        else
                        {
                            this._speedometer.stopEngineCrushError();
                        }
                    }
                }
            }
            if(this._isAutoloader && !param1)
            {
                this.applyAutoloaderState();
                this.applyAutoloaderAnimationState(true);
            }
            this.updateCurrentCrosshairReloadingParams();
        }

        private function applySettings() : void
        {
            var _loc2_:IGunMarker = null;
            var _loc1_:CrosshairSettingsVO = this._settings[this._settingId];
            if(_loc1_ && this._currentCrosshair != null)
            {
                this._currentCrosshair.setNetType(this._netType != -1?this._netType:_loc1_.netType);
                this._currentCrosshair.setComponentsAlpha(_loc1_.netAlphaValue,_loc1_.centerAlphaValue,_loc1_.reloaderAlphaValue,_loc1_.conditionAlphaValue,_loc1_.cassetteAlphaValue,_loc1_.reloaderTimerAlphaValue,_loc1_.zoomIndicatorAlphaValue);
                this._currentCrosshair.setCenterType(_loc1_.centerType);
                for each(_loc2_ in this.gunMarkers)
                {
                    _loc2_.setSettings(_loc1_.gunTagType,_loc1_.mixingType,_loc1_.gunTagAlpha,_loc1_.mixingAlpha);
                }
            }
        }

        private function updateReloadingTimer() : void
        {
            var _loc1_:Number = getTimer() - this._initReloadingTime;
            this._currReloadingPercent = _loc1_ / this._baseReloadingTimeInMsec + this._previousReloadingPercent;
            if(this._currReloadingPercent >= 1)
            {
                this.clearReloadingTimer();
                this._currReloadingState = CrosshairConsts.RELOADING_ENDED;
                this._remainingTimeInSec = this._baseReloadingTimeInSec;
            }
            else if(this._isReloadingTimeFieldShown)
            {
                this._remainingTimeInSec = int(this._baseReloadingTimeInMsec * (1 - this._currReloadingPercent) * 0.1) * 0.01;
            }
            this.updateCurrentCrosshairReloadingParams();
        }

        private function updateCurrentCrosshairReloadingParams() : void
        {
            var _loc1_:IGunMarker = null;
            if(this._currentCrosshair != null)
            {
                if(this._isReloadingTimeFieldShown)
                {
                    this._currentCrosshair.setReloadingTime(this._remainingTimeInSec);
                }
                this._currentCrosshair.setReloadingAsPercent(this._currReloadingPercent);
                this._currentCrosshair.setReloadingState(this._currReloadingState);
            }
            for each(_loc1_ in this.gunMarkers)
            {
                _loc1_.setReloadingParams(this._currReloadingPercent,this._currReloadingState);
            }
        }

        private function clearReloadingTimer() : void
        {
            if(this._reloadingInterval != -1)
            {
                clearInterval(this._reloadingInterval);
                this._reloadingInterval = -1;
            }
        }

        private function hideAll() : void
        {
            var _loc1_:ICrosshair = null;
            for each(_loc1_ in this._crosshairs)
            {
                _loc1_.visible = false;
            }
        }
    }
}
