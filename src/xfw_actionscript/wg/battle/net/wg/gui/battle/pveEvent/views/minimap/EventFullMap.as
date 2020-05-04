package net.wg.gui.battle.pveEvent.views.minimap
{
    import net.wg.gui.battle.views.epicDeploymentMap.EpicDeploymentMap;
    import flash.display.MovieClip;
    import flash.display.Sprite;

    public class EventFullMap extends EpicDeploymentMap
    {

        private static const BG_SHADOW_SIZE:int = 1536;

        private static const MAX_STAGE_HEIGHT:int = 2088;

        private static const MAP_STAGE_PADDING:int = 30;

        public var shadowBackground:MovieClip = null;

        public var background:Sprite = null;

        public function EventFullMap()
        {
            super();
        }

        override public function as_setBackground(param1:String) : void
        {
            var _loc3_:* = NaN;
            var _loc4_:Sprite = null;
            mapContainer.mapHit.width = mapWidth;
            mapContainer.mapHit.height = mapHeight;
            mapContainer.mapMask.width = mapWidth;
            mapContainer.mapMask.height = mapHeight;
            EventFullMapContainer(mapContainer).init(param1,mapWidth,mapHeight);
            var _loc2_:Number = mapWidth >> 1;
            _loc3_ = mapHeight >> 1;
            for each(_loc4_ in entryContainers)
            {
                _loc4_.x = _loc2_;
                _loc4_.y = _loc3_;
            }
        }

        override public function updateStagePosition(param1:int, param2:int) : void
        {
            var _loc4_:* = 0;
            var _loc5_:* = NaN;
            var _loc3_:int = param2 < MAX_STAGE_HEIGHT?param2:MAX_STAGE_HEIGHT;
            _loc4_ = _loc3_ - (MAP_STAGE_PADDING << 1);
            _loc5_ = _loc4_ / mapHeight;
            var _loc6_:Number = _loc5_ * mapWidth;
            var _loc7_:Number = _loc5_ * mapHeight;
            mapContainer.scaleX = _loc5_;
            mapContainer.scaleY = _loc5_;
            this.shadowBackground.scaleX = _loc6_ / BG_SHADOW_SIZE;
            this.shadowBackground.scaleY = _loc7_ / BG_SHADOW_SIZE;
            var _loc8_:* = param1 - _loc6_ >> 1;
            var _loc9_:* = param2 - _loc7_ >> 1;
            this.x = _loc8_;
            this.y = _loc9_;
            this.background.width = param1;
            this.background.height = param2;
            this.background.x = -_loc8_;
            this.background.y = -_loc9_;
        }

        override protected function onDispose() : void
        {
            this.shadowBackground = null;
            this.background = null;
            super.onDispose();
        }
    }
}
