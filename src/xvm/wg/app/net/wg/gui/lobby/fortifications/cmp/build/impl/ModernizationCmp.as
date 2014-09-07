package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.filters.GlowFilter;
    import flash.text.TextField;
    import net.wg.gui.lobby.fortifications.data.ModernizationCmpVO;
    
    public class ModernizationCmp extends MovieClip implements IDisposable
    {
        
        public function ModernizationCmp()
        {
            super();
        }
        
        private static var GLOW_COLOR:uint = 12273152;
        
        private static function getGlowFilter(param1:Number) : Array
        {
            var _loc2_:Array = [];
            var _loc3_:Number = 1;
            var _loc4_:Number = 30;
            var _loc5_:Number = 30;
            var _loc6_:Number = 0.3;
            var _loc7_:Number = 3;
            var _loc8_:* = false;
            var _loc9_:* = false;
            var _loc10_:GlowFilter = new GlowFilter(param1,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
            _loc2_.push(_loc10_);
            return _loc2_;
        }
        
        public var buildingIcon:MovieClip = null;
        
        public var buildingLevel:MovieClip = null;
        
        public var buildingIndicators:BuildingIndicatorsCmp = null;
        
        public var orderInfo:OrderInfoCmp = null;
        
        public var titleText:TextField = null;
        
        public function setData(param1:ModernizationCmpVO) : void
        {
            this.buildingIndicators.setData(param1.buildingIndicators);
            this.orderInfo.setData(param1.defResInfo);
            this.buildingLevel.gotoAndStop(param1.buildingLevel);
            this.buildingIcon.gotoAndStop(param1.buildingType);
            this.titleText.htmlText = param1.titleText;
        }
        
        public function dispose() : void
        {
            this.buildingIcon = null;
            this.buildingLevel = null;
            this.buildingIndicators.dispose();
            this.buildingIndicators = null;
            this.orderInfo.dispose();
            this.orderInfo = null;
            this.titleText = null;
        }
        
        public function applyGlowFilter() : void
        {
            this.buildingIcon.filters = getGlowFilter(GLOW_COLOR);
        }
    }
}
