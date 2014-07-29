package net.wg.gui.components.common.crosshair
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.MovieClip;
    import net.wg.gui.utils.FrameWalker;
    import flash.events.Event;
    import flash.display.StageScaleMode;
    import flash.display.StageAlign;
    
    public class CrosshairPanelBase extends Sprite implements IDisposable
    {
        
        public function CrosshairPanelBase()
        {
            this._reloadingSettings = [0,0,false];
            super();
            this.init();
        }
        
        public var g_modeMC:MovieClip;
        
        protected var _universalBarFW:FrameWalker;
        
        protected var _reloadingBarFW:FrameWalker;
        
        protected var _fadingTargetFW:FrameWalker;
        
        protected var _health:Number = 0;
        
        protected var _reloadingSettings:Array;
        
        protected var _clipCapacity:Number = 1;
        
        protected var clipQuanityBar:ClipQuantityBar = null;
        
        protected var reloadingTimer:ReloadingTimer;
        
        private function init() : void
        {
            this.initCallbacks();
            this.initFrameWalkers();
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
        
        protected function initView() : void
        {
            this.setDefaultTargetState();
            this.onSetAmmoStock(0,0,true,"critical");
            this._fadingTargetFW.setPosAsPercent(100);
        }
        
        protected function initFrameWalkers() : void
        {
            this._universalBarFW = new FrameWalker(this.g_modeMC.universalBarMC,60,true);
            this._reloadingBarFW = new FrameWalker(this.g_modeMC.reloadingBarMC,60,false);
            this._fadingTargetFW = new FrameWalker(this.g_modeMC.targetMC,60,false);
        }
        
        protected function initCallbacks() : void
        {
        }
        
        protected function onRecreateDevice(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            this.g_modeMC.x = 0.5 * param1 * (1 + param3);
            this.g_modeMC.y = 0.5 * param2 * (1 - param4);
        }
        
        protected function onSetReloading(param1:Number, param2:Number, param3:Boolean, param4:Number = 0) : void
        {
            this._reloadingSettings = [param1,param2,param3];
            this._reloadingBarFW.stop();
            if(param1 == 0)
            {
                this._reloadingBarFW.setPosAsPercent(100);
                if(param3)
                {
                    this._reloadingBarFW.play("reloaded");
                }
            }
            else if(param1 == -1)
            {
                this._reloadingBarFW.setPosAsPercent(0);
            }
            else if(param4 > 0)
            {
                this._reloadingBarFW.setPosAsPercent(param4);
                this._reloadingBarFW.restartFromCurrentFrame(param1);
            }
            else
            {
                this._reloadingBarFW.start(param1,param2);
            }
            
            
        }
        
        protected function onSetReloadingAsPercent(param1:Number) : void
        {
            if(param1 > 100)
            {
                this._reloadingBarFW.setPosAsPercent(100);
                this._reloadingBarFW.play("reloaded");
            }
            else
            {
                this._reloadingBarFW.setPosAsPercent(param1);
            }
        }
        
        protected function onCorrectReloadingTime(param1:Number) : void
        {
            var _loc2_:Boolean = this._reloadingSettings[2];
            if(_loc2_)
            {
                this._reloadingBarFW.stop();
                this._reloadingBarFW.restartFromCurrentFrame(param1);
            }
        }
        
        protected function onSetReloadingTimeWithCorrection(param1:Number, param2:Number, param3:Boolean) : void
        {
            this._reloadingBarFW.stop();
        }
        
        protected function onSetHealth(param1:Number) : void
        {
            this._health = param1;
            this._universalBarFW.setPosAsPercent(param1 * 100);
        }
        
        protected function onSetAmmoStock(param1:Number, param2:Number, param3:Boolean, param4:String, param5:Boolean = false) : void
        {
            var _loc6_:MovieClip = this.g_modeMC.ammoCountMC;
            _loc6_.gotoAndStop(param3?"ammo_low":"ammo_normal");
            _loc6_.count.text = param1.toString();
            if((this.clipQuanityBar) && (this.clipQuanityBar.initialized))
            {
                this.clipQuanityBar.change(param1,param2,param4,param5);
            }
            else
            {
                ClipQuantityBar.store(param1,param2,param4);
            }
        }
        
        protected function onSetClipParams(param1:Number, param2:Number) : void
        {
            var _loc3_:MovieClip = null;
            if(this._clipCapacity == param1)
            {
                return;
            }
            this._clipCapacity = param1;
            if(this._clipCapacity > 1)
            {
                _loc3_ = this.g_modeMC.cassette;
                if((_loc3_) && !this.clipQuanityBar)
                {
                    this.clipQuanityBar = ClipQuantityBar.create(this._clipCapacity,param2);
                    _loc3_.addChild(this.clipQuanityBar);
                }
            }
        }
        
        protected function onSetTarget(param1:String, param2:String, param3:Number) : void
        {
            this._fadingTargetFW.stop();
            this._fadingTargetFW.setPosAsPercent(0);
        }
        
        protected function setDefaultTargetState() : void
        {
            var _loc1_:MovieClip = this.g_modeMC.targetMC.target;
            _loc1_.distance.text = "";
        }
        
        protected function onClearTarget(param1:Number) : void
        {
            this._fadingTargetFW.stop();
            this._fadingTargetFW.start(4,param1);
        }
        
        protected function onUpdateTarget(param1:Number) : void
        {
            var _loc2_:MovieClip = this.g_modeMC.targetMC.target;
            _loc2_.distance.text = param1 + "m";
        }
        
        protected function onSetCenterType(param1:Number, param2:Number) : void
        {
            this.g_modeMC.center.gotoAndStop("type" + param2);
            this.g_modeMC.center.alpha = param1;
        }
        
        protected function onSetNetType(param1:Number, param2:Number) : void
        {
            this.g_modeMC.gotoAndStop("type" + param2);
            this.g_modeMC.grid1.alpha = param1;
        }
        
        protected function onSetReloaderType(param1:Number, param2:Number) : void
        {
            this.g_modeMC.reloadingBarMC.alpha = param1;
            this._reloadingBarFW.setTarget(this.g_modeMC.reloadingBarMC);
            this.onSetReloading(this._reloadingSettings[0],this._reloadingSettings[1],this._reloadingSettings[2]);
        }
        
        protected function onSetConditionType(param1:Number, param2:Number) : void
        {
            this.g_modeMC.universalBarMC.alpha = param1;
            this._universalBarFW.setTarget(this.g_modeMC.universalBarMC);
            this.onSetHealth(this._health);
        }
        
        protected function onSetCassetteType(param1:Number, param2:Number) : void
        {
            this.g_modeMC.cassette.alpha = param1;
        }
        
        public function dispose() : void
        {
            if(this._universalBarFW)
            {
                this._universalBarFW.dispose();
                this._universalBarFW = null;
            }
            if(this._reloadingBarFW)
            {
                this._reloadingBarFW.dispose();
                this._reloadingBarFW = null;
            }
            if(this._fadingTargetFW)
            {
                this._fadingTargetFW.dispose();
                this._fadingTargetFW = null;
            }
            if(this._reloadingSettings)
            {
                this._reloadingSettings.splice(0,this._reloadingSettings.length);
                this._reloadingSettings = null;
            }
            removeEventListener(Event.ADDED_TO_STAGE,this.initStage);
            var _loc1_:MovieClip = this.g_modeMC.cassette;
            if((_loc1_) && (this.clipQuanityBar))
            {
                if(_loc1_.contains(this.clipQuanityBar))
                {
                    _loc1_.removeChild(this.clipQuanityBar);
                }
                this.clipQuanityBar = null;
            }
        }
    }
}
