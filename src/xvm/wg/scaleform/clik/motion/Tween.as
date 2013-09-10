package scaleform.clik.motion
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Tween extends Object
    {
        public function Tween(arg1:Number, arg2:Object=null, arg3:Object=null, arg4:Object=null)
        {
            super();
            this.duration = arg1;
            this.target = arg2;
            if (arg2 is flash.display.DisplayObject)
            {
                this.targetDO = flash.display.DisplayObject(arg2);
                this.transform = this.targetDO.transform;
            }
            this.props = arg3;
            if (arg4)
                this.quickSet(arg4);
            if (arg4 == null || arg4.paused == null)
                this.paused = false;
            return;
        }


        {
            ticker = new flash.display.Shape();
            workingMatrix = new flash.geom.Matrix();
            lastTime = flash.utils.getTimer();
            degToRad = 1 / 180 * Math.PI;
            propsDO = {"x":true, "y":true, "rotation":true, "scaleX":true, "scaleY":true, "alpha":true};
            ticker.addEventListener(flash.events.Event.ENTER_FRAME, Tween.tick, false, 0, true);
        }

        public function get paused():Boolean
        {
            return this._paused;
        }

        public function set position(arg1:Number):void
        {
            this.updatePosition(arg1 + this.delay - this._position);
            return;
        }

        public function get position():Number
        {
            return this._position - this.delay;
        }

        public function set paused(arg1:Boolean):void
        {
            if (arg1 == this._paused)
                return;
            this._paused = arg1;
            if (arg1)
                removeTween(this);
            else
            {
                if (firstTween)
                {
                    firstTween.prev = this;
                    this.next = firstTween;
                }
                firstTween = this;
                if (this._position >= this.delay + this.duration)
                    this._position = 0;
            }
            return;
        }

        public function reset():void
        {
            this._position = 0;
            return;
        }

        public function quickSet(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=arg1;
            for (loc1 in loc3)
                this[loc1] = arg1[loc1];
            return;
        }

        protected function constructProp(arg1:String):Prop
        {
            var loc1:*=new Prop();
            loc1.name = arg1;
            loc1.prev = null;
            if (this.firstProp)
                this.firstProp.prev = loc1;
            loc1.next = this.firstProp;
            var loc2:*;
            this.firstProp = loc2 = loc1;
            return loc2;
        }

        protected function init():void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=false;
            var loc4:*=0;
            var loc5:*=this.props;
            for (loc2 in loc5)
            {
                if (this.fastTransform && this.transform && propsDO[loc2])
                {
                    loc1 = true;
                    continue;
                }
                loc3 = this.constructProp(loc2);
                var loc6:*;
                loc3.start = loc6 = this.target[loc2];
                loc3.delta = this.props[loc2] - loc6;
            }
            if (loc1)
            {
                this.startMatrix = new flash.geom.Matrix(this.targetDO.scaleX, this.targetDO.rotation * degToRad, this.targetDO.alpha, this.targetDO.scaleY, this.targetDO.x, this.targetDO.y);
                this.deltaMatrix = new flash.geom.Matrix(isNaN(this.props.scaleX) ? 0 : this.props.scaleX - this.startMatrix.a, isNaN(this.props.rotation) ? 0 : (this.props.rotation - this.targetDO.rotation) * degToRad, isNaN(this.props.alpha) ? 0 : this.props.alpha - this.startMatrix.c, isNaN(this.props.scaleY) ? 0 : this.props.scaleY - this.startMatrix.d, isNaN(this.props.x) ? 0 : this.props.x - this.startMatrix.tx, isNaN(this.props.y) ? 0 : this.props.y - this.startMatrix.ty);
            }
            this.props = null;
            return;
        }

        protected function updatePosition(arg1:Number):void
        {
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            if (this.target == null)
            {
                this.paused = true;
                var loc2:*=true;
                return;
            }
            this._position = this._position + arg1;
            if (this._position <= this.delay)
                return;
            if (this.props)
                this.init();
            var loc1:*=(this._position - this.delay) / this.duration;
            loc2 = loc1 >= 1;
            if (loc2)
            {
                loc1 = 1;
                this._position = this.duration + this.delay;
            }
            if (this.ease != null)
                loc1 = this.easeParam != null ? this.ease(loc1, 0, 1, 1, this.easeParam) : this.ease(loc1, 0, 1, 1);
            if (this.startMatrix)
            {
                loc4 = this.startMatrix.b + this.deltaMatrix.b * loc1;
                if (loc4)
                {
                    loc5 = Math.cos(loc4);
                    loc6 = Math.sin(loc4);
                }
                else
                {
                    loc5 = 1;
                    loc6 = 0;
                }
                workingMatrix.a = loc5 * this.startMatrix.a + this.deltaMatrix.a * loc1;
                workingMatrix.b = loc6;
                workingMatrix.c = -loc6;
                workingMatrix.d = loc5 * this.startMatrix.d + this.deltaMatrix.d * loc1;
                workingMatrix.tx = this.startMatrix.tx + this.deltaMatrix.tx * loc1;
                workingMatrix.ty = this.startMatrix.ty + this.deltaMatrix.ty * loc1;
                this.transform.matrix = workingMatrix;
                if (this.deltaMatrix.c)
                    this.targetDO.alpha = this.startMatrix.c + this.deltaMatrix.c * loc1;
            }
            var loc3:*=this.firstProp;
            while (loc3)
            {
                this.target[loc3.name] = loc3.start + loc3.delta * loc1;
                loc3 = loc3.next;
            }
            if (this.onChange != null)
                this.onChange(this);
            if (loc2)
            {
                if (this.loop)
                    this.reset();
                else
                    this.paused = true;
                if (this.nextTween)
                    this.nextTween.paused = false;
                if (this.onComplete != null)
                    this.onComplete(this);
            }
            return;
        }

        protected static function tick(arg1:flash.events.Event):void
        {
            var loc4:*=null;
            var loc1:*=flash.utils.getTimer();
            var loc2:*=loc1 - lastTime;
            lastTime = loc1;
            var loc3:*=firstTween;
            while (loc3)
            {
                loc4 = loc3.next;
                loc3.updatePosition(loc3.frameBased ? 1 : loc2);
                loc3 = loc4;
            }
            return;
        }

        protected static function removeTween(arg1:scaleform.clik.motion.Tween):void
        {
            if (arg1.prev)
                arg1.prev.next = arg1.next;
            if (arg1.next)
                arg1.next.prev = arg1.prev;
            if (arg1 == firstTween)
                firstTween = arg1.next;
            var loc1:*;
            arg1.next = loc1 = null;
            arg1.prev = loc1;
            return;
        }

        public static function removeAllTweens():void
        {
            firstTween = null;
            return;
        }

        protected var invalid:Boolean;

        protected var next:scaleform.clik.motion.Tween;

        protected var prev:scaleform.clik.motion.Tween;

        protected var _paused:Boolean=true;

        protected var startMatrix:flash.geom.Matrix;

        protected var deltaMatrix:flash.geom.Matrix;

        protected var transform:flash.geom.Transform;

        public var onComplete:Function;

        protected var firstProp:Prop;

        protected var props:Object;

        public var target:Object;

        public var duration:Number;

        protected var targetDO:flash.display.DisplayObject;

        public var ease:Function;

        public var easeParam:Object;

        public var onChange:Function;

        public var data:Object;

        public var nextTween:scaleform.clik.motion.Tween;

        public var frameBased:Boolean=false;

        protected static var ticker:flash.display.Shape;

        protected static var workingMatrix:flash.geom.Matrix;

        protected static var firstTween:scaleform.clik.motion.Tween;

        protected static var lastTime:uint;

        protected var _position:Number=0;

        public var delay:Number=0;

        public var loop:Boolean=false;

        public var fastTransform:Boolean=true;

        public static var propsDO:Object;

        protected static var degToRad:Number=0.0174532925199;
    }
}


final class Prop extends Object
{
    public function Prop()
    {
        super();
        return;
    }

    public var next:Prop;

    public var prev:Prop;

    public var name:String;

    public var start:Number;

    public var delta:Number;
}
