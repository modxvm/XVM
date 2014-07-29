package net.wg.gui.components.common.crosshair
{
    import flash.display.MovieClip;
    import net.wg.gui.utils.FrameWalker;
    import flash.events.Event;
    import flash.display.StageScaleMode;
    import flash.display.StageAlign;
    
    public class CrosshairSniper extends CrosshairBase
    {
        
        public function CrosshairSniper()
        {
            super();
            this.init();
        }
        
        private static var MARKER_STATE_RELOADED:String = "reloaded";
        
        private static var MARKER_STATE_RELOADING:String = "reloading";
        
        private static var MARKER_STATE_NORMAL:String = "normal";
        
        public var crosshairMC:MovieClip;
        
        private var radiusFW:FrameWalker;
        
        private var isReloaded:Boolean = false;
        
        override protected function onDispose() : void
        {
            super.onDispose();
            if(this.radiusFW)
            {
                this.radiusFW.dispose();
                this.radiusFW = null;
            }
        }
        
        private function init() : void
        {
            this.initCallbacks();
            this.initView();
            if(stage)
            {
                this.initStage();
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE,this.initStage);
            }
        }
        
        private function initStage(param1:Event = null) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE,this.initStage);
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
        }
        
        override protected function initView() : void
        {
            this.radiusFW = new FrameWalker(this.crosshairMC.radiusMC.mixingMC,37,false);
        }
        
        override protected function initCallbacks() : void
        {
        }
        
        override protected function onSetReloading(param1:Number, param2:Number, param3:Boolean, param4:Number = 0) : void
        {
            this.radiusFW.stop();
            this.isReloaded = false;
            this.onSetMarkerType(MARKER_STATE_RELOADING);
            if(param1 == 0)
            {
                this.radiusFW.setPosAsPercent(100);
                this.isReloaded = true;
                this.onSetMarkerType(MARKER_STATE_RELOADED);
            }
            else if(param1 == -1)
            {
                this.radiusFW.setPosAsPercent(0);
            }
            else if(param4 > 0)
            {
                this.radiusFW.setPosAsPercent(param4);
                this.radiusFW.restartFromCurrentFrame(param1);
            }
            else
            {
                this.radiusFW.start(param1,param2);
            }
            
            
        }
        
        override protected function onSetReloadingAsPercent(param1:Number) : void
        {
            if(param1 >= 100)
            {
                this.radiusFW.setPosAsPercent(100);
                this.onSetMarkerType(MARKER_STATE_RELOADED);
            }
            else
            {
                this.radiusFW.setPosAsPercent(param1);
            }
        }
        
        protected function onCorrectReloadingTime(param1:Number) : void
        {
            if(!this.isReloaded)
            {
                this.radiusFW.stop();
                this.radiusFW.restartFromCurrentFrame(param1);
            }
        }
        
        protected function onSetMarkerType(param1:String) : void
        {
            this.crosshairMC.markerMC.tag.gotoAndStop(param1);
        }
        
        protected function onSetTagType(param1:Number, param2:Number) : void
        {
            this.crosshairMC.markerMC.gotoAndStop("type" + param2);
            this.crosshairMC.markerMC.alpha = param1;
            this.onSetMarkerType(MARKER_STATE_NORMAL);
            if(this.isReloaded)
            {
                this.onSetReloading(0,0,false);
            }
        }
        
        protected function onSetReloadingType(param1:Number, param2:Number) : void
        {
            this.crosshairMC.radiusMC.gotoAndStop("type" + param2);
            this.crosshairMC.radiusMC.mixingMC.alpha = param1;
            if(this.isReloaded)
            {
                this.onSetReloading(0,0,false);
            }
            this.radiusFW.setTarget(this.crosshairMC.radiusMC.mixingMC);
        }
    }
}
