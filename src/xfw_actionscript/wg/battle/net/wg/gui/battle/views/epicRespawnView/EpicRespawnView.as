package net.wg.gui.battle.views.epicRespawnView
{
    import net.wg.infrastructure.base.meta.impl.EpicRespawnViewMeta;
    import net.wg.infrastructure.base.meta.IEpicRespawnViewMeta;
    import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IEpicBattleStatisticDataController;
    import net.wg.gui.battle.views.epicRespawnView.components.EpicRespawnDeployButtonGroup;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.battle.views.battleTankCarousel.BattleTankCarousel;
    import flash.display.Sprite;
    import flash.geom.Point;
    import net.wg.gui.battle.views.epicRespawnView.events.EpicRespawnEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import net.wg.data.constants.InvalidationType;
    import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
    import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehiclesStatsVO;
    import net.wg.gui.battle.epicBattle.VO.daapi.EpicPlayerStatsVO;
    import net.wg.gui.battle.views.epicDeploymentMap.constants.DeploymentMapConstants;
    import scaleform.gfx.MouseEventEx;

    public class EpicRespawnView extends EpicRespawnViewMeta implements IEpicRespawnViewMeta, IEpicBattleStatisticDataController
    {

        private static const DEPLOY_BUTTON_GROUP_CAROUSEL_OFFSET:int = 83;

        public var deployButtonGroup:EpicRespawnDeployButtonGroup = null;

        public var deploymentMapContainer:MovieClip = null;

        public var topBarBG:MovieClip = null;

        public var topBarTF:TextField = null;

        public var carousel:BattleTankCarousel = null;

        private var _mapClickArea:Sprite = null;

        private var _selectedLane:int = -1;

        private var _currentOverLane:int = -1;

        private var _deploymentMapWidth:int = 0;

        private var _deploymentMapHeight:int = 0;

        private var _blockedLaneStates:Vector.<Boolean> = null;

        private var _respawnPointsCache:Vector.<Point> = null;

        private var _originalHeight:int;

        public function EpicRespawnView()
        {
            super();
            this._blockedLaneStates = new <Boolean>[false,false,false];
            this._respawnPointsCache = new <Point>[new Point(),new Point(),new Point()];
        }

        override public function setCompVisible(param1:Boolean) : void
        {
            super.setCompVisible(param1);
            this.carousel.visible = param1;
            dispatchEvent(new EpicRespawnEvent(EpicRespawnEvent.VIEW_CHANGED));
            if(!param1)
            {
                App.popoverMgr.hide();
            }
        }

        override protected function initialize() : void
        {
            super.initialize();
            this.deployButtonGroup.deployButton.label = EPIC_BATTLE.RESPAWN_DEPLOY_BUTTON;
            this.deployButtonGroup.deployButton.addEventListener(ButtonEvent.CLICK,this.onBattleBtnClickHandler);
            this.deployButtonGroup.addEventListener(EpicRespawnEvent.DEPLOYMENT_BUTTON_READY,this.onDeploymentButtonReadyHandler);
            this._mapClickArea = new Sprite();
            addChildAt(this._mapClickArea,getChildIndex(this.deploymentMapContainer));
            this.deploymentMapContainer.visible = false;
            this.topBarBG.visible = false;
            this._mapClickArea.hitArea = this.deploymentMapContainer;
            this._mapClickArea.addEventListener(MouseEvent.CLICK,this.onMapMouseClickHandler);
            this._mapClickArea.addEventListener(MouseEvent.MOUSE_MOVE,this.onMapMouseMoveHandler);
            this._mapClickArea.addEventListener(MouseEvent.MOUSE_OUT,this.onMapMouseOutHandler);
            this.topBarTF.text = EPIC_BATTLE.RESPAWNSCREEN_HEADERTITLE;
        }

        override protected function onDispose() : void
        {
            this._mapClickArea.removeEventListener(MouseEvent.CLICK,this.onMapMouseClickHandler);
            this._mapClickArea.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMapMouseMoveHandler);
            this._mapClickArea.removeEventListener(MouseEvent.MOUSE_OUT,this.onMapMouseOutHandler);
            this._mapClickArea = null;
            this.carousel.removeEventListener(Event.RESIZE,this.onCarouselResizeHandler);
            this.deployButtonGroup.deployButton.removeEventListener(ButtonEvent.CLICK,this.onBattleBtnClickHandler);
            this.deployButtonGroup.removeEventListener(EpicRespawnEvent.DEPLOYMENT_BUTTON_READY,this.onDeploymentButtonReadyHandler);
            this.deployButtonGroup.dispose();
            this.deployButtonGroup = null;
            this.deploymentMapContainer = null;
            this.topBarBG = null;
            this.topBarTF = null;
            this.carousel = null;
            this._blockedLaneStates = null;
            this._respawnPointsCache.splice(0,this._respawnPointsCache.length);
            this._respawnPointsCache = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.STATE))
            {
                this.updateCarouselElementsPositions();
                if(hasEventListener(Event.RESIZE))
                {
                    dispatchEvent(new Event(Event.RESIZE));
                }
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.carousel.addEventListener(Event.RESIZE,this.onCarouselResizeHandler);
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            registerFlashComponentS(this.carousel,BATTLE_VIEW_ALIASES.BATTLE_TANK_CAROUSEL);
        }

        public function as_resetRespawnState() : void
        {
            this.deployButtonGroup.reset();
        }

        public function as_setLaneState(param1:int, param2:Boolean, param3:String) : void
        {
            this._blockedLaneStates[param1 - 1] = !param2;
            var _loc4_:EpicRespawnEvent = new EpicRespawnEvent(EpicRespawnEvent.LANE_STATE_CHANGED,param1 - 1,!param2);
            if(!param2)
            {
                _loc4_.additionalInfo = param3;
            }
            dispatchEvent(_loc4_);
        }

        public function as_setMapDimensions(param1:int, param2:int) : void
        {
            this._deploymentMapWidth = param1;
            this._deploymentMapHeight = param2;
        }

        public function as_setRespawnLocations(param1:Object) : void
        {
            var _loc2_:int = this._respawnPointsCache.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                this._respawnPointsCache[_loc3_].x = param1[_loc3_ + 1][0];
                this._respawnPointsCache[_loc3_].y = param1[_loc3_ + 1][1];
                _loc3_++;
            }
            dispatchEvent(new EpicRespawnEvent(EpicRespawnEvent.RESPAWN_LOCATION_UPDATE,-1,false,this._respawnPointsCache));
        }

        public function as_setSelectedLane(param1:int) : void
        {
            if(this._selectedLane != param1 - 1)
            {
                this._selectedLane = param1 - 1;
            }
            dispatchEvent(new EpicRespawnEvent(EpicRespawnEvent.SELECTED_LANE_CHANGED,this._selectedLane));
        }

        public function as_updateAutoTimer(param1:Boolean, param2:String) : void
        {
            this.deployButtonGroup.updateAutoTimer(param1,param2);
        }

        public function as_updateTimer(param1:Boolean, param2:String) : void
        {
            this.deployButtonGroup.updateTimer(param1,param2);
        }

        public function setEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
        {
        }

        public function updateEpicPlayerStats(param1:EpicPlayerStatsVO) : void
        {
        }

        public function updateEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
        {
        }

        public function updateStage(param1:Number, param2:Number) : void
        {
            this._originalHeight = param2;
            var _loc3_:* = param1 >> 1;
            this.topBarBG.x = -_loc3_;
            this.topBarBG.y = 0;
            this.topBarBG.width = param1;
            var _loc4_:Number = (param2 - DeploymentMapConstants.RESPAWN_ELEMENTS_SIZE) / this._deploymentMapHeight;
            var _loc5_:Number = _loc4_ * this._deploymentMapWidth;
            var _loc6_:Number = _loc4_ * this._deploymentMapHeight;
            this.deploymentMapContainer.x = -_loc5_ * (0.5 - DeploymentMapConstants.BORDER_WIDTH_PERCENTAGE);
            this.deploymentMapContainer.y = DeploymentMapConstants.SCORE_PANEL_TOP_OFFSET + _loc6_ * DeploymentMapConstants.BORDER_WIDTH_PERCENTAGE;
            this.deploymentMapContainer.width = _loc5_ * DeploymentMapConstants.BORDERMAP_TO_MAP_RATIO;
            this.deploymentMapContainer.height = _loc6_ * DeploymentMapConstants.BORDERMAP_TO_MAP_RATIO;
            this.deployButtonGroup.x = _loc3_;
            this.topBarTF.x = -this.topBarTF.width >> 1;
            this.topBarTF.y = this.deploymentMapContainer.y >> 1;
            if(this.carousel != null)
            {
                this.carousel.x = -_loc3_;
                this.carousel.updateStage(param1,param2);
                this.updateCarouselElementsPositions();
            }
        }

        private function updateCarouselElementsPositions() : void
        {
            var _loc1_:* = this._originalHeight - this.carousel.getBottom() ^ 0;
            this.carousel.y = _loc1_;
            this.deployButtonGroup.y = _loc1_ - DEPLOY_BUTTON_GROUP_CAROUSEL_OFFSET;
        }

        private function onCarouselResizeHandler(param1:Event) : void
        {
            invalidateState();
        }

        private function onMapMouseClickHandler(param1:MouseEvent) : void
        {
            var _loc2_:* = 0;
            if(param1 is MouseEventEx && param1.target == this._mapClickArea)
            {
                _loc2_ = Math.min((this._mapClickArea.mouseX + (this.deploymentMapContainer.width >> 1)) / (this.deploymentMapContainer.width / 3),this._blockedLaneStates.length - 1);
                if(_loc2_ != this._selectedLane && !this._blockedLaneStates[_loc2_])
                {
                    onLaneSelectedS(_loc2_ + 1);
                }
            }
        }

        private function onMapMouseMoveHandler(param1:MouseEvent) : void
        {
            var _loc2_:* = 0;
            if(param1 is MouseEventEx && param1.target == this._mapClickArea)
            {
                _loc2_ = Math.min((this._mapClickArea.mouseX + (this.deploymentMapContainer.width >> 1)) / (this.deploymentMapContainer.width / 3),this._blockedLaneStates.length - 1);
                if(_loc2_ != this._currentOverLane)
                {
                    this._currentOverLane = _loc2_;
                    dispatchEvent(new EpicRespawnEvent(EpicRespawnEvent.RESPAWN_MAP_MOUSE_OVER,_loc2_,this._blockedLaneStates[_loc2_]));
                }
            }
        }

        private function onMapMouseOutHandler(param1:MouseEvent) : void
        {
            this._currentOverLane = -1;
            dispatchEvent(new EpicRespawnEvent(EpicRespawnEvent.RESPAWN_MAP_MOUSE_OVER,this._currentOverLane));
        }

        private function onBattleBtnClickHandler(param1:ButtonEvent) : void
        {
            onRespawnBtnClickS();
        }

        private function onDeploymentButtonReadyHandler(param1:EpicRespawnEvent) : void
        {
            onDeploymentReadyS();
        }
    }
}
