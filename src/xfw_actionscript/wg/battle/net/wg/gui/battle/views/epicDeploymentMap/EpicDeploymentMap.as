package net.wg.gui.battle.views.epicDeploymentMap
{
    import net.wg.infrastructure.base.meta.impl.EpicDeploymentMapMeta;
    import net.wg.infrastructure.base.meta.IEpicDeploymentMapMeta;
    import net.wg.gui.battle.views.epicDeploymentMap.components.EpicMapContainer;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import net.wg.gui.battle.views.epicDeploymentMap.events.EpicDeploymentMapEvent;
    import net.wg.gui.battle.views.epicDeploymentMap.components.EpicDeploymentMapEntriesContainer;
    import net.wg.gui.battle.views.epicDeploymentMap.constants.DeploymentMapConstants;
    import net.wg.infrastructure.events.LifeCycleEvent;

    public class EpicDeploymentMap extends EpicDeploymentMapMeta implements IEpicDeploymentMapMeta
    {

        private static const HALF_RATIO_SCALE:Number = 0.5;

        private static const MAP_SCALE:Number = 0.6;

        private static const MAP_BACKGROUND_SCALE:Number = 1.33333333333333;

        private static const NORMAL_AVAILABLE_HEIGHT:int = 420;

        private static const LOADING_SCREEN_Y_OFFSET:int = 69;

        public var mapContainer:EpicMapContainer = null;

        public var bigBackground:UILoaderAlt = null;

        private var _inRespawnScreen:Boolean = false;

        private var _inLoadingScreen:Boolean = false;

        private var _entryContainer:Vector.<Sprite> = null;

        private var _mapWidth:int = 512;

        private var _mapHeight:int = 512;

        public function EpicDeploymentMap()
        {
            super();
            var _loc1_:EpicDeploymentMapEntriesContainer = this.mapContainer.entriesContainer;
            this._entryContainer = new <Sprite>[_loc1_.personal,_loc1_.hqs,_loc1_.points,_loc1_.aliveVehicles,_loc1_.deadVehicles,_loc1_.equipments,_loc1_.icons,_loc1_.flags,_loc1_.zones,_loc1_.landingZone];
        }

        override public function as_setBackground(param1:String) : void
        {
            var _loc2_:Sprite = null;
            this.bigBackground.setOriginalHeight(this._mapHeight * MAP_BACKGROUND_SCALE | 0);
            this.bigBackground.setOriginalWidth(this._mapWidth * MAP_BACKGROUND_SCALE >> 0);
            this.mapContainer.mapHit.width = this._mapWidth;
            this.mapContainer.mapHit.height = this._mapHeight;
            this.mapContainer.mapMask.width = this._mapWidth;
            this.mapContainer.mapMask.height = this._mapHeight;
            this.bigBackground.maintainAspectRatio = false;
            this.bigBackground.source = param1;
            for each(_loc2_ in this._entryContainer)
            {
                _loc2_.x = this._mapWidth * HALF_RATIO_SCALE;
                _loc2_.y = this._mapHeight * HALF_RATIO_SCALE;
            }
        }

        override public function getRectangles() : Vector.<Rectangle>
        {
            if(!visible)
            {
                return null;
            }
            return new <Rectangle>[this.mapContainer.mapHit.getBounds(App.stage)];
        }

        override protected function onDispose() : void
        {
            this.mapContainer.removeEventListener(EpicDeploymentMapEvent.MAP_CLICKED,this.onDeploymentMapClickedHandler);
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
            var _loc4_:EpicDeploymentMapEntriesContainer = this.mapContainer.entriesContainer;
            _loc4_.aliveVehicles.visible = _loc4_.personal.visible = _loc4_.landingZone.visible = _loc4_.zones.visible = !param1;
            this.updateStagePosition(param2,param3);
        }

        public function activeInRespawn(param1:Boolean, param2:int, param3:int) : void
        {
            this._inRespawnScreen = param1;
            this.updateMouseHandling();
            this.updateStagePosition(param2,param3);
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
                _loc3_ = (param2 - DeploymentMapConstants.RESPAWN_ELEMENTS_SIZE) * DeploymentMapConstants.RESPAWN_SCALE_FACTOR;
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
                this.y = DeploymentMapConstants.SCORE_PANEL_TOP_OFFSET + ((param2 - DeploymentMapConstants.RESPAWN_ELEMENTS_SIZE) * (1 - DeploymentMapConstants.RESPAWN_SCALE_FACTOR) >> 1);
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
        }

        private function updateMouseHandling() : void
        {
            mouseEnabled = mouseChildren = !this._inRespawnScreen;
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

        private function onDeploymentMapClickedHandler(param1:EpicDeploymentMapEvent) : void
        {
            setAttentionToCellS(param1.mouseX,param1.mouseY,param1.isMouseRightClick);
        }
    }
}
