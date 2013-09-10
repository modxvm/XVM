package net.wg.gui.components.common.crosshair 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.utils.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class CrosshairPanelBase extends flash.display.Sprite implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function CrosshairPanelBase()
        {
            this._reloadingSettings = [0, 0, false];
            super();
            this.init();
            return;
        }

        internal function init():void
        {
            this.initCallbacks();
            this.initFrameWalkers();
            this.initView();
            if (stage) 
            {
                this.initStage();
            }
            else 
            {
                addEventListener(flash.events.Event.ADDED_TO_STAGE, this.initStage);
            }
            return;
        }

        internal function initStage(arg1:flash.events.Event=null):void
        {
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.initStage);
            stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
            stage.align = flash.display.StageAlign.TOP_LEFT;
            return;
        }

        protected function initView():void
        {
            this.setDefaultTargetState();
            this.onSetAmmoStock(0, 0, true, "critical");
            this._fadingTargetFW.setPosAsPercent(100);
            return;
        }

        protected function initFrameWalkers():void
        {
            this._universalBarFW = new net.wg.gui.utils.FrameWalker(this.g_modeMC.universalBarMC, 60, true);
            this._reloadingBarFW = new net.wg.gui.utils.FrameWalker(this.g_modeMC.reloadingBarMC, 60, false);
            this._fadingTargetFW = new net.wg.gui.utils.FrameWalker(this.g_modeMC.targetMC, 60, false);
            return;
        }

        protected function initCallbacks():void
        {
            return;
        }

        protected function onRecreateDevice(arg1:Number, arg2:Number, arg3:Number, arg4:Number):void
        {
            this.g_modeMC.x = 0.5 * arg1 * (1 + arg3);
            this.g_modeMC.y = 0.5 * arg2 * (1 - arg4);
            return;
        }

        protected function onSetReloading(arg1:Number, arg2:Number, arg3:Boolean, arg4:Number=0):void
        {
            this._reloadingSettings = [arg1, arg2, arg3];
            this._reloadingBarFW.stop();
            if (arg1 != 0) 
            {
                if (arg1 != -1) 
                {
                    if (arg4 > 0) 
                    {
                        this._reloadingBarFW.setPosAsPercent(arg4);
                        this._reloadingBarFW.restartFromCurrentFrame(arg1);
                    }
                    else 
                    {
                        this._reloadingBarFW.start(arg1, arg2);
                    }
                }
                else 
                {
                    this._reloadingBarFW.setPosAsPercent(0);
                }
            }
            else 
            {
                this._reloadingBarFW.setPosAsPercent(100);
                if (arg3) 
                {
                    this._reloadingBarFW.play("reloaded");
                }
            }
            return;
        }

        protected function onSetReloadingAsPercent(arg1:Number):void
        {
            if (arg1 > 100) 
            {
                this._reloadingBarFW.setPosAsPercent(100);
                this._reloadingBarFW.play("reloaded");
            }
            else 
            {
                this._reloadingBarFW.setPosAsPercent(arg1);
            }
            return;
        }

        protected function onCorrectReloadingTime(arg1:Number):void
        {
            var loc1:*=this._reloadingSettings[2];
            if (loc1) 
            {
                this._reloadingBarFW.stop();
                this._reloadingBarFW.restartFromCurrentFrame(arg1);
            }
            return;
        }

        protected function onSetReloadingTimeWithCorrection(arg1:Number, arg2:Number, arg3:Boolean):void
        {
            this._reloadingBarFW.stop();
            return;
        }

        protected function onSetHealth(arg1:Number):void
        {
            this._health = arg1;
            this._universalBarFW.setPosAsPercent(arg1 * 100);
            return;
        }

        protected function onSetAmmoStock(arg1:Number, arg2:Number, arg3:Boolean, arg4:String, arg5:Boolean=false):void
        {
            var loc1:*;
            (loc1 = this.g_modeMC.ammoCountMC).gotoAndStop(arg3 ? "ammo_low" : "ammo_normal");
            loc1.count.text = arg1.toString();
            if (this.clipQuanityBar && this.clipQuanityBar.initialized) 
            {
                this.clipQuanityBar.change(arg1, arg2, arg4, arg5);
            }
            else 
            {
                net.wg.gui.components.common.crosshair.ClipQuantityBar.store(arg1, arg2, arg4);
            }
            return;
        }

        protected function onSetClipParams(arg1:Number, arg2:Number):void
        {
            var loc1:*=null;
            if (this._clipCapacity == arg1) 
            {
                return;
            }
            this._clipCapacity = arg1;
            if (this._clipCapacity > 1) 
            {
                loc1 = this.g_modeMC.cassette;
                if (loc1 && !this.clipQuanityBar) 
                {
                    this.clipQuanityBar = net.wg.gui.components.common.crosshair.ClipQuantityBar.create(this._clipCapacity, arg2);
                    loc1.addChild(this.clipQuanityBar);
                }
            }
            return;
        }

        protected function onSetTarget(arg1:String, arg2:String, arg3:Number):void
        {
            this._fadingTargetFW.stop();
            this._fadingTargetFW.setPosAsPercent(0);
            return;
        }

        protected function setDefaultTargetState():void
        {
            var loc1:*=this.g_modeMC.targetMC.target;
            loc1.distance.text = "";
            return;
        }

        protected function onClearTarget(arg1:Number):void
        {
            this._fadingTargetFW.stop();
            this._fadingTargetFW.start(4, arg1);
            return;
        }

        protected function onUpdateTarget(arg1:Number):void
        {
            var loc1:*=this.g_modeMC.targetMC.target;
            loc1.distance.text = arg1 + "m";
            return;
        }

        protected function onSetCenterType(arg1:Number, arg2:Number):void
        {
            this.g_modeMC.center.gotoAndStop("type" + arg2);
            this.g_modeMC.center.alpha = arg1;
            return;
        }

        protected function onSetNetType(arg1:Number, arg2:Number):void
        {
            this.g_modeMC.gotoAndStop("type" + arg2);
            this.g_modeMC.grid1.alpha = arg1;
            return;
        }

        protected function onSetReloaderType(arg1:Number, arg2:Number):void
        {
            this.g_modeMC.reloadingBarMC.alpha = arg1;
            this._reloadingBarFW.setTarget(this.g_modeMC.reloadingBarMC);
            this.onSetReloading(this._reloadingSettings[0], this._reloadingSettings[1], this._reloadingSettings[2]);
            return;
        }

        protected function onSetConditionType(arg1:Number, arg2:Number):void
        {
            this.g_modeMC.universalBarMC.alpha = arg1;
            this._universalBarFW.setTarget(this.g_modeMC.universalBarMC);
            this.onSetHealth(this._health);
            return;
        }

        protected function onSetCassetteType(arg1:Number, arg2:Number):void
        {
            this.g_modeMC.cassette.alpha = arg1;
            return;
        }

        public function dispose():void
        {
            if (this._universalBarFW) 
            {
                this._universalBarFW.dispose();
                this._universalBarFW = null;
            }
            if (this._reloadingBarFW) 
            {
                this._reloadingBarFW.dispose();
                this._reloadingBarFW = null;
            }
            if (this._fadingTargetFW) 
            {
                this._fadingTargetFW.dispose();
                this._fadingTargetFW = null;
            }
            if (this._reloadingSettings) 
            {
                this._reloadingSettings.splice(0, this._reloadingSettings.length);
                this._reloadingSettings = null;
            }
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.initStage);
            var loc1:*=this.g_modeMC.cassette;
            if (loc1 && this.clipQuanityBar) 
            {
                if (loc1.contains(this.clipQuanityBar)) 
                {
                    loc1.removeChild(this.clipQuanityBar);
                }
                this.clipQuanityBar = null;
            }
            return;
        }

        public var g_modeMC:flash.display.MovieClip;

        protected var _universalBarFW:net.wg.gui.utils.FrameWalker;

        protected var _reloadingBarFW:net.wg.gui.utils.FrameWalker;

        protected var _fadingTargetFW:net.wg.gui.utils.FrameWalker;

        protected var _health:Number=0;

        protected var _reloadingSettings:Array;

        protected var _clipCapacity:Number=1;

        protected var clipQuanityBar:net.wg.gui.components.common.crosshair.ClipQuantityBar=null;
    }
}
