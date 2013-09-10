package net.wg.gui.components.common.crosshair 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.utils.*;
    
    public class CrosshairSniper extends net.wg.gui.components.common.crosshair.CrosshairBase
    {
        public function CrosshairSniper()
        {
            super();
            this.init();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            if (this.radiusFW) 
            {
                this.radiusFW.dispose();
                this.radiusFW = null;
            }
            return;
        }

        internal function init():void
        {
            this.initCallbacks();
            this.initView();
            if (stage) 
                this.initStage();
            else 
                addEventListener(flash.events.Event.ADDED_TO_STAGE, this.initStage);
            return;
        }

        internal function initStage(arg1:flash.events.Event=null):void
        {
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.initStage);
            stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
            stage.align = flash.display.StageAlign.TOP_LEFT;
            return;
        }

        protected override function initView():void
        {
            this.radiusFW = new net.wg.gui.utils.FrameWalker(this.crosshairMC.radiusMC.mixingMC, 37, false);
            return;
        }

        protected override function initCallbacks():void
        {
            return;
        }

        protected override function onSetReloading(arg1:Number, arg2:Number, arg3:Boolean, arg4:Number=0):void
        {
            this.radiusFW.stop();
            this.isReloaded = false;
            this.onSetMarkerType(MARKER_STATE_RELOADING);
            if (arg1 != 0) 
                if (arg1 != -1) 
                    if (arg4 > 0) 
                    {
                        this.radiusFW.setPosAsPercent(arg4);
                        this.radiusFW.restartFromCurrentFrame(arg1);
                    }
                    else 
                        this.radiusFW.start(arg1, arg2);
                else 
                    this.radiusFW.setPosAsPercent(0);
            else 
            {
                this.radiusFW.setPosAsPercent(100);
                this.isReloaded = true;
                this.onSetMarkerType(MARKER_STATE_RELOADED);
            }
            return;
        }

        protected override function onSetReloadingAsPercent(arg1:Number):void
        {
            if (arg1 >= 100) 
            {
                this.radiusFW.setPosAsPercent(100);
                this.onSetMarkerType(MARKER_STATE_RELOADED);
            }
            else 
                this.radiusFW.setPosAsPercent(arg1);
            return;
        }

        protected function onCorrectReloadingTime(arg1:Number):void
        {
            if (!this.isReloaded) 
            {
                this.radiusFW.stop();
                this.radiusFW.restartFromCurrentFrame(arg1);
            }
            return;
        }

        protected function onSetMarkerType(arg1:String):void
        {
            this.crosshairMC.markerMC.tag.gotoAndStop(arg1);
            return;
        }

        protected function onSetTagType(arg1:Number, arg2:Number):void
        {
            this.crosshairMC.markerMC.gotoAndStop("type" + arg2);
            this.crosshairMC.markerMC.alpha = arg1;
            this.onSetMarkerType(MARKER_STATE_NORMAL);
            if (this.isReloaded) 
                this.onSetReloading(0, 0, false);
            return;
        }

        protected function onSetReloadingType(arg1:Number, arg2:Number):void
        {
            this.crosshairMC.radiusMC.gotoAndStop("type" + arg2);
            this.crosshairMC.radiusMC.mixingMC.alpha = arg1;
            if (this.isReloaded) 
                this.onSetReloading(0, 0, false);
            this.radiusFW.setTarget(this.crosshairMC.radiusMC.mixingMC);
            return;
        }

        internal static const MARKER_STATE_RELOADED:String="reloaded";

        internal static const MARKER_STATE_RELOADING:String="reloading";

        internal static const MARKER_STATE_NORMAL:String="normal";

        public var crosshairMC:flash.display.MovieClip;

        internal var radiusFW:net.wg.gui.utils.FrameWalker;

        internal var isReloaded:Boolean=false;
    }
}
