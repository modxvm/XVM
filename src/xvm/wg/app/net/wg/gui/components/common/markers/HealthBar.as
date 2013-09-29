package net.wg.gui.components.common.markers 
{
    import flash.display.*;
    import flash.events.*;
    import scaleform.clik.core.*;
    
    public class HealthBar extends scaleform.clik.core.UIComponent
    {
        public function HealthBar()
        {
            super();
            return;
        }

        public function get color():String
        {
            return this._color;
        }

        public function set color(arg1:String):void
        {
            if (arg1 == this._color) 
            {
                return;
            }
            this._color = arg1;
            invalidate(INVALIDATE_COLOR);
            return;
        }

        public function get maxHealth():Number
        {
            return this._maxHealth;
        }

        public function set maxHealth(arg1:Number):void
        {
            this._maxHealth = arg1;
            invalidate(INVALIDATE_BAR);
            return;
        }

        public function get curHealth():Number
        {
            return this._curHealth;
        }

        public function set curHealth(arg1:Number):void
        {
            this._curHealth = arg1;
            this._curHealth = this._curHealth >= 0 ? this._curHealth : 0;
            invalidate(INVALIDATE_BAR);
            return;
        }

        public function get isSplashRunning():Boolean
        {
            return this._isSplashRunning;
        }

        public function updateHealth(arg1:Number, arg2:String):void
        {
            if (this.maxHealth == 0) 
            {
                return;
            }
            this.hitSplash.setAnimationType(arg2);
            if (!this.isSplashRunning) 
            {
                this.beforeLastHit = this.curHealth;
            }
            this.curHealth = arg1;
            this._isSplashRunning = true;
            this.hitSplash.x = this.getXforHealth(this.curHealth, true);
            var loc1:*=this.getXforHealth(this.beforeLastHit, false) - this.hitSplash.x;
            this.hitSplash.scaleX = loc1 / ORIGINAL_SPLASH_WIDTH;
            this.hitSplash.playShowTween();
            return;
        }

        protected override function configUI():void
        {
            this.hitSplash.addEventListener(net.wg.gui.components.common.markers.HealthBarAnimatedPart.SHOW, this.onSplashVisible);
            this.hitSplash.addEventListener(net.wg.gui.components.common.markers.HealthBarAnimatedPart.HIDE, this.onSplashHidden);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            super.draw();
            if (isInvalid(INVALIDATE_COLOR)) 
            {
                gotoAndStop(this._color);
            }
            if (isInvalid(INVALIDATE_BAR)) 
            {
                if (!isNaN(this.maxHealth) && !isNaN(this.curHealth)) 
                {
                    loc1 = this.curHealth / this.maxHealth;
                    loc2 = Math.ceil(loc1 * (this.healthBar.totalFrames - 1)) + 1;
                    this.healthBar.gotoAndStop(loc2);
                }
            }
            return;
        }

        internal function onSplashVisible(arg1:flash.events.Event):void
        {
            invalidate(INVALIDATE_BAR);
            return;
        }

        internal function onSplashHidden(arg1:flash.events.Event):void
        {
            this._isSplashRunning = false;
            return;
        }

        internal function getXforHealth(arg1:Number, arg2:Boolean):Number
        {
            var loc2:*=NaN;
            var loc1:*=0;
            if (!isNaN(this.maxHealth) && !(this.maxHealth == 0)) 
            {
                loc2 = HEALTH_BAR_WIDTH * arg1 / this.maxHealth;
                loc1 = arg2 ? Math.floor(loc2) : Math.round(loc2);
            }
            return loc1 > 0 ? loc1 : 0;
        }

        internal static const ORIGINAL_SPLASH_WIDTH:Number=26;

        internal static const HEALTH_BAR_WIDTH:Number=70;

        internal static const INVALIDATE_COLOR:String="invalidateColor";

        internal static const INVALIDATE_BAR:String="invalidateBar";

        public var healthBar:flash.display.MovieClip;

        public var hitSplash:net.wg.gui.components.common.markers.HealthBarAnimatedPart;

        internal var _color:String="green";

        internal var _maxHealth:Number=NaN;

        internal var _curHealth:Number=NaN;

        internal var _isSplashRunning:Boolean=false;

        internal var beforeLastHit:Number;
    }
}
