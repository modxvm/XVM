package net.wg.gui.battle.views.epicDeploymentMap
{
    import net.wg.infrastructure.base.meta.impl.EpicDeploymentMapMeta;
    import net.wg.infrastructure.base.meta.IEpicDeploymentMapMeta;
    import net.wg.gui.battle.views.epicDeploymentMap.components.EpicMapContainer;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.geom.Point;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.geom.Rectangle;
    import net.wg.gui.battle.views.epicDeploymentMap.events.EpicDeploymentMapEvent;
    import net.wg.gui.battle.views.epicDeploymentMap.components.EpicDeploymentMapEntriesContainer;
    import net.wg.gui.battle.views.epicDeploymentMap.constants.DeploymentMapConstants;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import net.wg.gui.battle.views.epicRespawnView.events.EpicRespawnEvent;
    import net.wg.data.constants.Values;

    public class EpicDeploymentMap extends EpicDeploymentMapMeta implements IEpicDeploymentMapMeta
    {

        private static const SCORE_PANEL_TOP_OFFSET:int = 108;

        private static const HALF_RATIO_SCALE:Number = 0.5;

        private static const MAP_SCALE:Number = 0.6;

        private static const LANE_HIGHLIGHT_BORDER:int = 10;

        private static const DOUBLE_LANE_HIGHLIGHT_BORDER:int = 20;

        private static const MAP_BACKGROUND_SCALE:Number = 1.33333333333333;

        private static const NORMAL_AVAILABLE_HEIGHT:int = 420;

        private static const LOADING_SCREEN_Y_OFFSET:int = 69;

        public var mapContainer:EpicMapContainer = null;

        public var bigBackground:UILoaderAlt = null;

        private var _playerRespawnLane:int = 1;

        private var _currentLaneOver:int = -1;

        private var _inRespawnScreen:Boolean = false;

        private var _inLoadingScreen:Boolean = false;

        private var _respawnPosInited:Boolean = false;

        private var _respawnPositions:Vector.<Point> = null;

        private var _blockedLaneStates:Vector.<Boolean> = null;

        private var _blockedLaneStatesTexts:Vector.<String> = null;

        private var _entryContainer:Vector.<Sprite> = null;

        private var _mapWidth:int = 512;

        private var _mapHeight:int = 512;

        public function EpicDeploymentMap()
        {
            super();
            this._blockedLaneStates = new <Boolean>[false,false,false];
            this._blockedLaneStatesTexts = new <String>[Values.EMPTY_STR,Values.EMPTY_STR,Values.EMPTY_STR];
            this._respawnPositions = new <Point>[new Point()];
            var _loc1_:EpicDeploymentMapEntriesContainer = this.mapContainer.entriesContainer;
            this._entryContainer = new <Sprite>[_loc1_.personal,_loc1_.hqs,_loc1_.points,_loc1_.aliveVehicles,_loc1_.deadVehicles,_loc1_.equipments,_loc1_.icons,_loc1_.flags,this.mapContainer.laneHighlight1,this.mapContainer.laneHighlight2,this.mapContainer.laneHighlight3,_loc1_.zones,_loc1_.landingZone];
        }

        override public function as_setBackground(param1:String) : void
        {
            var _loc5_:MovieClip = null;
            var _loc7_:Sprite = null;
            var _loc8_:* = 0;
            var _loc9_:* = 0;
            this.bigBackground.setOriginalHeight(this._mapHeight * MAP_BACKGROUND_SCALE | 0);
            this.bigBackground.setOriginalWidth(this._mapWidth * MAP_BACKGROUND_SCALE >> 0);
            this.mapContainer.mapHit.width = this._mapWidth;
            this.mapContainer.mapHit.height = this._mapHeight;
            this.mapContainer.mapMask.width = this._mapWidth;
            this.mapContainer.mapMask.height = this._mapHeight;
            var _loc2_:Number = this._mapWidth / 3 + DOUBLE_LANE_HIGHLIGHT_BORDER;
            var _loc3_:Number = this._mapHeight + DOUBLE_LANE_HIGHLIGHT_BORDER;
            var _loc4_:MovieClip = this.mapContainer.laneHighlight1;
            _loc4_.width = _loc2_;
            _loc4_.height = _loc3_;
            _loc5_ = this.mapContainer.laneHighlight2;
            _loc5_.width = _loc2_;
            _loc5_.height = _loc3_;
            var _loc6_:MovieClip = this.mapContainer.laneHighlight3;
            _loc6_.width = _loc2_;
            _loc6_.height = _loc3_;
            this.bigBackground.maintainAspectRatio = false;
            this.bigBackground.source = param1;
            for each(_loc7_ in this._entryContainer)
            {
                _loc7_.x = this._mapWidth * HALF_RATIO_SCALE;
                _loc7_.y = this._mapHeight * HALF_RATIO_SCALE;
            }
            _loc4_.x = -LANE_HIGHLIGHT_BORDER;
            _loc4_.y = -LANE_HIGHLIGHT_BORDER;
            _loc5_.x = this._mapWidth / 3 - LANE_HIGHLIGHT_BORDER | 0;
            _loc5_.y = -LANE_HIGHLIGHT_BORDER;
            _loc6_.x = this._mapWidth * 2 / 3 - LANE_HIGHLIGHT_BORDER | 0;
            _loc6_.y = -LANE_HIGHLIGHT_BORDER;
            _loc8_ = _loc4_.width - 2 * LANE_HIGHLIGHT_BORDER;
            _loc9_ = (this._mapHeight >> 1) - LANE_HIGHLIGHT_BORDER;
            this.mapContainer.laneLocked1Mc.x = _loc8_ >> 1;
            this.mapContainer.laneLocked1Mc.y = _loc9_;
            this.mapContainer.laneLocked2Mc.x = _loc8_ + (_loc8_ >> 1);
            this.mapContainer.laneLocked2Mc.y = _loc9_;
            this.mapContainer.laneLocked3Mc.x = 2 * _loc8_ + (_loc8_ >> 1);
            this.mapContainer.laneLocked3Mc.y = _loc9_;
        }

        override public function getRectangles() : Vector.<Rectangle>
        {
            if(!visible)
            {
                return null;
            }
            return new <Rectangle>[this.mapContainer.mapHit.getBounds(App.stage)];
        }

        override public function setCompVisible(param1:Boolean) : void
        {
            super.setCompVisible(param1);
            if(param1)
            {
                this.setLaneStates();
                this.updateRespawnLocations();
            }
        }

        override protected function onDispose() : void
        {
            this.mapContainer.removeEventListener(EpicDeploymentMapEvent.MAP_CLICKED,this.onDeploymentMapClickedHandler);
            this._respawnPositions.splice(0,this._respawnPositions.length);
            this._respawnPositions = null;
            this._blockedLaneStates.splice(0,this._blockedLaneStates.length);
            this._blockedLaneStates = null;
            this._blockedLaneStatesTexts.splice(0,this._blockedLaneStatesTexts.length);
            this._blockedLaneStatesTexts = null;
            this._entryContainer.splice(0,this._entryContainer.length);
            this._entryContainer = null;
            this.bigBackground.dispose();
            this.bigBackground = null;
            this.mapContainer.dispose();
            this.mapContainer = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.mapContainer.initializeMouseHandler();
            this.mapContainer.addEventListener(EpicDeploymentMapEvent.MAP_CLICKED,this.onDeploymentMapClickedHandler);
        }

        public function activeInLoadingScreen(param1:Boolean, param2:int, param3:int) : void
        {
            this._inLoadingScreen = param1;
            this.mapContainer.updateVisiblity(false);
            var _loc4_:EpicDeploymentMapEntriesContainer = this.mapContainer.entriesContainer;
            _loc4_.aliveVehicles.visible = _loc4_.personal.visible = _loc4_.landingZone.visible = _loc4_.zones.visible = !param1;
            this.updateStagePosition(param2,param3);
        }

        public function activeInRespawn(param1:Boolean, param2:int, param3:int) : void
        {
            this._inRespawnScreen = param1;
            this.updateMouseHandling();
            this.updateStagePosition(param2,param3);
            this.mapContainer.updateVisiblity(param1);
            this.setLaneStates();
        }

        public function as_setMapDimensions(param1:int, param2:int) : void
        {
            this._mapWidth = param1;
            this._mapHeight = param2;
        }

        public function updateStagePosition(param1:int, param2:int) : void
        {
            var _loc4_:* = NaN;
            var _loc5_:* = NaN;
            var _loc6_:* = NaN;
            var _loc3_:int = param2 * MAP_SCALE;
            if(this._inRespawnScreen)
            {
                _loc3_ = (param2 - DeploymentMapConstants.RESPAWN_ELEMENTS_SIZE) * DeploymentMapConstants.BORDERMAP_TO_MAP_RATIO;
            }
            else if(this._inLoadingScreen)
            {
                _loc3_ = NORMAL_AVAILABLE_HEIGHT;
            }
            _loc4_ = _loc3_ / this._mapHeight;
            _loc5_ = _loc4_ * this._mapWidth;
            _loc6_ = _loc4_ * this._mapHeight;
            this.mapContainer.scaleX = _loc4_;
            this.mapContainer.scaleY = _loc4_;
            var _loc7_:int = _loc5_ * MAP_BACKGROUND_SCALE;
            var _loc8_:int = _loc6_ * MAP_BACKGROUND_SCALE;
            this.bigBackground.x = -(_loc7_ * DeploymentMapConstants.BORDER_WIDTH_PERCENTAGE) >> 0;
            this.bigBackground.y = -(_loc8_ * DeploymentMapConstants.BORDER_WIDTH_PERCENTAGE) >> 0;
            this.bigBackground.width = _loc7_;
            this.bigBackground.height = _loc8_;
            if(this._inRespawnScreen)
            {
                this.y = SCORE_PANEL_TOP_OFFSET + _loc8_ * DeploymentMapConstants.BORDER_WIDTH_PERCENTAGE;
            }
            else if(this._inLoadingScreen)
            {
                this.y = (param2 - _loc6_ >> 1) - LOADING_SCREEN_Y_OFFSET;
            }
            else
            {
                this.y = param2 - _loc6_ >> 1;
            }
            this.x = param1 - _loc5_ >> 1;
            if(_isCompVisible)
            {
                this.setLaneStates();
                this.updateRespawnLocations();
            }
        }

        private function updateMouseHandling() : void
        {
            mouseEnabled = mouseChildren = !this._inRespawnScreen;
        }

        private function updateRespawnLocations() : void
        {
            var _loc1_:* = 0;
            var _loc2_:Point = null;
            var _loc3_:String = null;
            var _loc4_:* = 0;
            if(!this._inRespawnScreen)
            {
                return;
            }
            if(this._respawnPosInited)
            {
                _loc1_ = this._respawnPositions.length;
                _loc4_ = 0;
                while(_loc4_ < _loc1_)
                {
                    _loc2_ = this._respawnPositions[_loc4_];
                    _loc3_ = EpicMapContainer.AVAILABLE_DEPLOY_STATE;
                    if(this._blockedLaneStates[_loc4_])
                    {
                        _loc3_ = EpicMapContainer.DISABLED_DEPLOY_STATE;
                    }
                    else if(_loc4_ == this._playerRespawnLane)
                    {
                        _loc3_ = EpicMapContainer.SELECTED_DEPLOY_STATE;
                    }
                    else
                    {
                        _loc3_ = EpicMapContainer.AVAILABLE_DEPLOY_STATE;
                        if(_loc4_ == this._currentLaneOver)
                        {
                            _loc3_ = EpicMapContainer.AVAILABLE_DEPLOY_HOVER_STATE;
                        }
                    }
                    this.displayRespawnPoint(_loc4_,_loc2_,_loc3_);
                    _loc4_++;
                }
            }
        }

        private function displayRespawnPoint(param1:int, param2:Point, param3:String) : void
        {
            this.mapContainer.updateRespawnPointPosition(param1,param2,this._mapWidth,this._mapHeight);
            this.mapContainer.setRespawnPointState(param1,param3,this._inRespawnScreen);
        }

        private function updateLaneHighlightOver(param1:int) : void
        {
            if(param1 != -1)
            {
                if(!this._blockedLaneStates[param1])
                {
                    this.mapContainer.setLaneHighlightState(param1,param1 != this._playerRespawnLane?EpicMapContainer.HIGHLIGHT_DEPLOY_STATE:EpicMapContainer.SELECTED_DEPLOY_STATE);
                }
            }
            else
            {
                this.mapContainer.setLaneHighlightState(this._playerRespawnLane,EpicMapContainer.SELECTED_DEPLOY_STATE);
            }
            this.updateRespawnLocations();
        }

        private function setLaneStates() : void
        {
            var _loc2_:String = null;
            var _loc1_:int = this._blockedLaneStates.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc1_)
            {
                _loc2_ = this._blockedLaneStatesTexts[_loc3_];
                this.mapContainer.setLockedLaneVisibility(_loc3_,false,_loc2_);
                if(this._blockedLaneStates[_loc3_])
                {
                    this.mapContainer.setLockedLaneVisibility(_loc3_,this._inRespawnScreen,_loc2_);
                    this.mapContainer.setLaneHighlightState(_loc3_,EpicMapContainer.DISABLED_DEPLOY_STATE);
                }
                else if(_loc3_ == this._playerRespawnLane)
                {
                    this.mapContainer.setLaneHighlightState(_loc3_,EpicMapContainer.SELECTED_DEPLOY_STATE);
                }
                else
                {
                    this.mapContainer.setLaneHighlightState(_loc3_,EpicMapContainer.NORMAL_DEPLOY_STATE);
                }
                _loc3_++;
            }
        }

        override public function set visible(param1:Boolean) : void
        {
            if(super.visible == param1)
            {
                return;
            }
            super.visible = param1;
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
        }

        public function setCurrentLaneOver(param1:EpicRespawnEvent) : void
        {
            this._currentLaneOver = param1.lane;
            this.updateLaneHighlightOver(param1.lane);
        }

        public function updateRespawnPositions(param1:EpicRespawnEvent) : void
        {
            this._respawnPositions = param1.respawnLocations;
            this._respawnPosInited = true;
            if(_isCompVisible)
            {
                this.updateRespawnLocations();
            }
        }

        public function updateBlockedLaneStates(param1:EpicRespawnEvent) : void
        {
            this._blockedLaneStates[param1.lane] = param1.laneBlocked;
            this._blockedLaneStatesTexts[param1.lane] = param1.additionalInfo;
            if(_isCompVisible)
            {
                this.setLaneStates();
                this.updateRespawnLocations();
            }
        }

        public function updateRespawnLane(param1:EpicRespawnEvent) : void
        {
            if(this._playerRespawnLane != param1.lane)
            {
                this._playerRespawnLane = param1.lane;
                if(_isCompVisible)
                {
                    this.mapContainer.setLaneHighlightState(param1.lane,EpicMapContainer.SELECTED_DEPLOY_STATE);
                    this.setLaneStates();
                    this.updateRespawnLocations();
                }
            }
        }

        private function onDeploymentMapClickedHandler(param1:EpicDeploymentMapEvent) : void
        {
            setAttentionToCellS(param1.mouseX,param1.mouseY,param1.isMouseRightClick);
        }
    }
}
