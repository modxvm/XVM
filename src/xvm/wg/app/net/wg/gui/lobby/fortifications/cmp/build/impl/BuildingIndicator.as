package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.fortifications.cmp.build.IBuildingIndicator;
    import flash.display.MovieClip;
    import scaleform.clik.controls.StatusIndicator;
    import net.wg.gui.lobby.fortifications.data.base.BuildingBaseVO;
    import flash.events.Event;
    
    public class BuildingIndicator extends UIComponentEx implements IBuildingIndicator
    {
        
        public function BuildingIndicator()
        {
            super();
            gotoAndPlay("stop");
            this.buildingLevel.mouseEnabled = false;
            this.hpIndicator.mouseEnabled = false;
            this.defResIndicator.mouseEnabled = false;
            this._labels.mouseEnabled = false;
            this._labels.visible = false;
            this.mouseChildren = false;
        }
        
        public static var STOP_ANIMATION:String = "stopAnimation";
        
        public var buildingLevel:MovieClip;
        
        public var hpIndicator:StatusIndicator;
        
        public var defResIndicator:StatusIndicator;
        
        private var _labels:IndicatorLabels;
        
        public function applyVOData(param1:BuildingBaseVO) : void
        {
            this.hpIndicator.maximum = param1.maxHpValue;
            this.defResIndicator.maximum = param1.maxDefResValue;
            this.setHpValue(param1.hpVal);
            this.setDefResValue(param1.defResVal);
            this.buildingLevel.gotoAndStop(param1.buildingLevel);
        }
        
        override protected function onDispose() : void
        {
            this.hpIndicator.dispose();
            this.hpIndicator = null;
            this.defResIndicator.dispose();
            this.defResIndicator = null;
            this._labels = null;
            this.buildingLevel = null;
            super.onDispose();
        }
        
        override protected function addedToStage(param1:Event) : void
        {
            super.addedToStage(param1);
        }
        
        private function setHpValue(param1:int) : void
        {
            this.hpIndicator.value = param1;
            this._labels.hpValue.htmlText = App.utils.locale.integer(param1);
        }
        
        private function setDefResValue(param1:int) : void
        {
            this.defResIndicator.value = param1;
            this._labels.defResValue.htmlText = App.utils.locale.integer(param1);
        }
        
        public function get labels() : IndicatorLabels
        {
            return this._labels;
        }
        
        public function set labels(param1:IndicatorLabels) : void
        {
            this._labels = param1;
        }
    }
}
