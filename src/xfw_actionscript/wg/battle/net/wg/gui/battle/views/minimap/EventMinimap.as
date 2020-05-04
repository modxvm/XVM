package net.wg.gui.battle.views.minimap
{
    import net.wg.infrastructure.base.meta.impl.EventMinimapMeta;
    import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IEpicBattleStatisticDataController;
    import net.wg.infrastructure.base.meta.IEventMinimapMeta;
    import flash.geom.Point;
    import flash.display.MovieClip;
    import net.wg.gui.battle.views.minimap.containers.EpicMinimapEntriesContainer;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
    import net.wg.gui.battle.views.minimap.events.MinimapEvent;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehiclesStatsVO;
    import net.wg.gui.battle.epicBattle.VO.daapi.EpicPlayerStatsVO;
    import scaleform.gfx.MouseEventEx;

    public class EventMinimap extends EventMinimapMeta implements IEpicBattleStatisticDataController, IEventMinimapMeta
    {

        private static const MAP_OFFSET:Number = 0;

        private static const BORDER_OFFSET:int = 14;

        private static const TOPLEFT_OFFSET:Point = new Point(0,-60);

        private static const SCALE_SIZES:Vector.<Number> = new <Number>[1,1.21,1.48,1.86,2.33,2.9];

        private static const MINIMAP_SCALE_SIZES:Vector.<Number> = new <Number>[216,260,320,400,502,624];

        private static const FRAME_WIDTH_MULTIPLIER:int = 2;

        private static const FRAME_IMG_OFFSET:int = 24;

        private static const MMAP_BASE_SIZE:int = 210;

        public var mapHit:MovieClip = null;

        public var mapShortcutLabel:MovieClip = null;

        public var mapZoomMode:MovieClip = null;

        public var entriesContainer:EpicMinimapEntriesContainer = null;

        public var bgFrame:MovieClip = null;

        public var fgFrame:MovieClip = null;

        public var background:UILoaderAlt = null;

        private var _clickAreaSpr:Sprite = null;

        private var _updateSizeIndexForce:Boolean = false;

        private var _currentSizeIndex:int = 0;

        private var _mapWidth:int = 210;

        private var _mapHeight:int = 210;

        public function EventMinimap()
        {
            super();
            this.background = this.entriesContainer.background;
            this._clickAreaSpr = new Sprite();
            addChildAt(this._clickAreaSpr,getChildIndex(this.mapHit));
            this.mapHit.visible = true;
            this._clickAreaSpr.hitArea = this.mapHit;
            this.mapZoomMode.visible = true;
        }

        override public function as_setBackground(param1:String) : void
        {
            this.background.setOriginalHeight(this._mapHeight);
            this.background.setOriginalWidth(this._mapWidth);
            this.background.maintainAspectRatio = false;
            this.background.source = param1;
        }

        override public function as_setSize(param1:int) : void
        {
            if(!initialized)
            {
                this._currentSizeIndex = param1;
            }
            else
            {
                this.checkNewSize(param1);
            }
        }

        override public function getMessageCoordinate() : Number
        {
            return this.currentHeight - this.currentTopLeftPoint.y;
        }

        override public function getMinimapRectBySizeIndex(param1:int) : Rectangle
        {
            var _loc2_:int = this._currentSizeIndex;
            if(param1 >= 0 && param1 < MinimapSizeConst.MAP_SIZE.length)
            {
                _loc2_ = param1;
            }
            return new Rectangle(0,0,MINIMAP_SCALE_SIZES[_loc2_],MINIMAP_SCALE_SIZES[_loc2_]);
        }

        override public function getMinmapHeightBySizeIndex(param1:int) : Number
        {
            return MAP_OFFSET;
        }

        override public function getRectangles() : Vector.<Rectangle>
        {
            if(!visible)
            {
                return null;
            }
            return new <Rectangle>[this.mapHit.getBounds(App.stage)];
        }

        override public function setAllowedSizeIndex(param1:Number) : void
        {
            if((this._currentSizeIndex != param1 || this._updateSizeIndexForce) && initialized)
            {
                this._currentSizeIndex = param1;
                dispatchEvent(new MinimapEvent(MinimapEvent.SIZE_CHANGED));
                this.updateContainersSize();
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
                applyNewSizeS(param1);
            }
            else
            {
                this._currentSizeIndex = param1;
            }
            this._updateSizeIndexForce = false;
        }

        override public function updateSizeIndex(param1:Boolean) : void
        {
            this._updateSizeIndexForce = param1;
            this.checkNewSize(this._currentSizeIndex);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.updateContainersSize();
            this._clickAreaSpr.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
            this._clickAreaSpr.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
            this.mapShortcutLabel.mapBtnTF.text = READABLE_KEY_NAMES.KEY_M;
        }

        override protected function onDispose() : void
        {
            this._clickAreaSpr.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
            this._clickAreaSpr.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
            this._clickAreaSpr = null;
            this.mapHit = null;
            this.mapShortcutLabel = null;
            this.mapZoomMode.stop();
            this.mapZoomMode = null;
            this.entriesContainer.dispose();
            this.entriesContainer = null;
            this.bgFrame = null;
            this.fgFrame = null;
            this.background.dispose();
            this.background = null;
            super.onDispose();
        }

        public function as_setMapDimensions(param1:int, param2:int) : void
        {
            this._mapWidth = param1;
            this._mapHeight = param2;
        }

        public function as_setZoomMode(param1:Number, param2:String) : void
        {
            this.mapZoomMode.mapZoomModeContainer.zoomLevelTF.text = param2;
            this.mapZoomMode.gotoAndPlay(2);
        }

        public function as_updateSectorStateStats(param1:Object) : void
        {
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

        private function updateContainersSize() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            _loc1_ = SCALE_SIZES[this._currentSizeIndex];
            this.entriesContainer.scaleX = this.entriesContainer.scaleY = _loc1_;
            _loc2_ = _loc1_ * MMAP_BASE_SIZE;
            var _loc3_:Number = _loc2_ + FRAME_WIDTH_MULTIPLIER * FRAME_IMG_OFFSET;
            var _loc4_:Number = _loc1_ * FRAME_WIDTH_MULTIPLIER;
            this.fgFrame.width = this.fgFrame.height = _loc3_;
            this.bgFrame.width = this.bgFrame.height = _loc3_ + _loc4_ * FRAME_WIDTH_MULTIPLIER;
            this.fgFrame.x = -FRAME_IMG_OFFSET;
            this.fgFrame.y = -FRAME_IMG_OFFSET;
            this.bgFrame.x = this.fgFrame.x - _loc4_ | 0;
            this.bgFrame.y = this.bgFrame.x;
            this.mapHit.scaleX = this.mapHit.scaleY = _loc1_;
            this.mapShortcutLabel.x = -BORDER_OFFSET - _loc4_ | 0;
            this.mapZoomMode.y = -FRAME_IMG_OFFSET - _loc4_ | 0;
        }

        private function checkNewSize(param1:int) : void
        {
            dispatchEvent(new MinimapEvent(MinimapEvent.TRY_SIZE_CHANGED,false,false,param1));
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
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

        override public function get currentWidth() : int
        {
            return MINIMAP_SCALE_SIZES[this._currentSizeIndex];
        }

        override public function get currentHeight() : int
        {
            return MINIMAP_SCALE_SIZES[this._currentSizeIndex];
        }

        override public function get currentTopLeftPoint() : Point
        {
            return TOPLEFT_OFFSET;
        }

        override public function get currentSizeIndex() : Number
        {
            return this._currentSizeIndex;
        }

        private function onMouseClickHandler(param1:MouseEvent) : void
        {
            if(param1 is MouseEventEx && param1.target == this._clickAreaSpr)
            {
                if(this.mapHit.mouseX < MAP_OFFSET || this.mapHit.mouseY < MAP_OFFSET || this.mapHit.mouseX > MAP_OFFSET + this.background.width || this.mapHit.mouseY > MAP_OFFSET + this.background.height)
                {
                    return;
                }
                setAttentionToCellS(this.mapHit.mouseX,this.mapHit.mouseY,MouseEventEx(param1).buttonIdx == MouseEventEx.RIGHT_BUTTON);
            }
        }

        private function onMouseWheelHandler(param1:MouseEvent) : void
        {
            if(param1 is MouseEventEx && param1.target == this._clickAreaSpr)
            {
                onZoomModeChangedS(param1.delta > 0?-1:1);
            }
        }
    }
}
