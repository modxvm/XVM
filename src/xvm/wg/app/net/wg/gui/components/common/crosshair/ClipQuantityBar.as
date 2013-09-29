package net.wg.gui.components.common.crosshair 
{
    import flash.display.*;
    import scaleform.clik.core.*;
    
    public class ClipQuantityBar extends scaleform.clik.core.UIComponent
    {
        public function ClipQuantityBar()
        {
            super();
            return;
        }

        public function get mode():String
        {
            return this._mode;
        }

        public function set mode(arg1:String):void
        {
            if (arg1 == this._mode || !(arg1 == MODE_AMMO) && !(arg1 == MODE_PERCENT) && !(arg1 == MODE_BURST)) 
            {
                return;
            }
            this._mode = arg1;
            this.quantityBarTotalFrames = this.calcTotalFrames();
            this.quantityBarCurrentFrame = this.calcCurrentFrame();
            invalidate();
            return;
        }

        public function get burst():Number
        {
            return this._burst;
        }

        public function set burst(arg1:Number):void
        {
            this._burst = arg1;
            return;
        }

        public function change(arg1:Number, arg2:Number, arg3:String, arg4:Boolean):void
        {
            this._quantity = arg1;
            this._quantityInClip = arg2;
            this.quantityBarCurrentFrame = this.calcCurrentFrame();
            if (initialized) 
            {
                if (arg4 && this._quantityInClip == this._clipCapacity) 
                {
                    gotoAndPlay(STATE_RELOADED);
                }
                else if (this._clipState != arg3) 
                {
                    gotoAndStop(arg3);
                }
                this._clipState = arg3;
                invalidate();
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            this.capacityBar.gotoAndStop(this.quantityBarTotalFrames);
            this.quantityInClipBar.gotoAndStop(this.quantityBarCurrentFrame);
            return;
        }

        internal function calcTotalFrames():Number
        {
            var loc1:*=this.capacityBar.totalFrames;
            if (this._mode != MODE_AMMO) 
            {
                if (this._mode == MODE_QUEUE) 
                {
                    loc1 = Math.min(Math.ceil(this._clipCapacity / this._burst) + 1, loc1);
                }
            }
            else 
            {
                loc1 = Math.min(this._clipCapacity + 1, loc1);
            }
            return loc1;
        }

        internal function calcCurrentFrame():Number
        {
            var loc1:*=this.quantityBarCurrentFrame;
            var loc2:*=this.quantityBarTotalFrames > this._clipCapacity / Math.max(this._burst, 1);
            if (this._mode == MODE_AMMO && loc2) 
            {
                loc1 = this._quantityInClip > 0 ? this._quantityInClip + 1 : 0;
            }
            else if (this._mode == MODE_QUEUE && loc2) 
            {
                loc1 = Math.ceil(this._quantityInClip / this._burst) + 1;
            }
            else if (this._clipCapacity > 0) 
            {
                loc1 = Math.ceil(this.quantityBarTotalFrames * this._quantityInClip / this._clipCapacity);
            }
            return Math.min(loc1, this.quantityBarTotalFrames);
        }

        
        {
            storedPropsChanged = false;
            storedProps = {"clipCapacity":1, "burst":1, "quantity":0, "quantityInClip":0, "mode":MODE_CRITICAL};
        }

        public static function create(arg1:Number, arg2:Number):net.wg.gui.components.common.crosshair.ClipQuantityBar
        {
            var loc4:*=null;
            var loc1:*=TYPE_LIGHT;
            var loc2:*=MODE_PERCENT;
            var loc3:*=arg1;
            if (arg2 > 1) 
            {
                loc3 = Math.ceil(loc3 / arg2);
            }
            if (loc3 < HEAVY_LIMIT) 
            {
                loc1 = TYPE_HEAVY;
                loc2 = arg2 > 1 ? MODE_QUEUE : MODE_AMMO;
            }
            else if (loc3 < MEDIUM_LIMIT) 
            {
                loc1 = TYPE_MEDIUM;
                loc2 = arg2 > 1 ? MODE_QUEUE : MODE_AMMO;
            }
            storedProps.clipCapacity = arg1;
            storedProps.mode = loc2;
            storedProps.burst = arg2;
            storedPropsChanged = false;
            return loc4 = App.utils.classFactory.getComponent(loc1, net.wg.gui.components.common.crosshair.ClipQuantityBar, storedProps);
        }

        protected override function configUI():void
        {
            super.configUI();
            if (storedPropsChanged) 
            {
                this._quantity = storedProps.quantity;
                this._quantityInClip = storedProps.quantityInClip;
                this._clipState = storedProps.clipState;
                storedPropsChanged = false;
            }
            gotoAndStop(this._clipState);
            this.quantityBarTotalFrames = this.calcTotalFrames();
            this.quantityBarCurrentFrame = this.calcCurrentFrame();
            return;
        }

        public static function store(arg1:Number, arg2:Number, arg3:String):void
        {
            storedProps.quantity = arg1;
            storedProps.quantityInClip = arg2;
            storedProps.clipState = arg3;
            storedPropsChanged = true;
            return;
        }

        public function get clipCapacity():Number
        {
            return this._clipCapacity;
        }

        public function set clipCapacity(arg1:Number):void
        {
            if (arg1 == this._clipCapacity || arg1 < 0) 
            {
                return;
            }
            this._clipCapacity = arg1;
            if (initialized || true) 
            {
                this.quantityBarTotalFrames = this.calcTotalFrames();
                this.capacityBar.gotoAndStop(this.quantityBarTotalFrames);
            }
            return;
        }

        public function get quantityInClip():Number
        {
            return this._quantityInClip;
        }

        public function set quantityInClip(arg1:Number):void
        {
            if (arg1 == this._quantityInClip || arg1 < 0) 
            {
                return;
            }
            this._quantityInClip = arg1;
            var loc1:*=this.calcCurrentFrame();
            if (loc1 != this.quantityBarCurrentFrame) 
            {
                this.quantityBarCurrentFrame = loc1;
                this.quantityInClipBar.gotoAndStop(this.quantityBarCurrentFrame);
            }
            return;
        }

        public function get quantity():Number
        {
            return this._quantity;
        }

        public function set quantity(arg1:Number):void
        {
            if (arg1 == this._quantity || arg1 < -1) 
            {
                return;
            }
            this._quantity = arg1;
            return;
        }

        public function get clipState():String
        {
            return this._clipState;
        }

        public function set clipState(arg1:String):void
        {
            if (arg1 == this._clipState) 
            {
                return;
            }
            this._clipState = arg1;
            gotoAndStop(this._clipState);
            return;
        }

        public static const STATE_NORMAL:String="normal";

        public static const STATE_WARNING:String="warning";

        public static const STATE_CRITICAL:String="critical";

        public static const STATE_RELOADED:String="reloaded";

        public static const TYPE_LIGHT:String="LightClipQuantityBar";

        public static const MODE_PERCENT:String="percent";

        public static const MODE_QUEUE:String="queue";

        public static const MODE_AMMO:String="ammo";

        public static const MODE_BURST:String="burst";

        public static const MODE_CRITICAL:String="critical";

        public static const MODE_FRAME:String="frame";

        internal static const MEDIUM_LIMIT:int=31;

        public static const TYPE_MEDIUM:String="MediumClipQuantityBar";

        public static const TYPE_HEAVY:String="HeavyClipQuantityBar";

        internal static const HEAVY_LIMIT:int=13;

        public var capacityBar:flash.display.MovieClip;

        public var quantityInClipBar:flash.display.MovieClip;

        internal var _clipCapacity:Number=1;

        internal var _burst:Number=1;

        internal var _quantityInClip:Number=0;

        internal var quantityBarCurrentFrame:Number=0;

        internal var quantityBarTotalFrames:Number=0;

        internal var _clipState:String="normal";

        internal var _mode:String="frame";

        internal var _quantity:Number=0;

        internal static var storedPropsChanged:Boolean=false;

        internal static var storedProps:Object;
    }
}
