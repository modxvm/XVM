package net.wg.gui.login.impl 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class Spark extends flash.display.Sprite implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function Spark(arg1:flash.geom.Rectangle, arg2:String)
        {
            this.zone = arg1;
            this.name = arg2;
            super();
            return;
        }

        public function set zone(arg1:flash.geom.Rectangle):void
        {
            this._zone = arg1;
            return;
        }

        public function get zone():flash.geom.Rectangle
        {
            return this._zone;
        }

        public function startAnimation(arg1:flash.events.Event=null):void
        {
            var loc1:*=NaN;
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.startAnimation, false);
            if (stage) 
            {
                this.reposition();
                loc1 = (this.sparkAnimation.totalFrames - 1);
                this.sparkAnimation.gotoAndPlay(1 + Math.floor(Math.random() * loc1));
                this.sparkAnimation.addFrameScript(loc1, this.sparkAnimationDispatch);
            }
            else 
            {
                addEventListener(flash.events.Event.ADDED_TO_STAGE, this.startAnimation, false);
            }
            return;
        }

        internal function sparkAnimationDispatch():void
        {
            this.reposition();
            return;
        }

        internal function reposition():void
        {
            var loc1:*=1;
            if (Math.random() > 0.75) 
            {
                loc1 = randRange(0.7, 1);
            }
            else 
            {
                loc1 = randRange(0.2, 0.4);
            }
            x = Math.floor(randRange(this._zone.x, this._zone.width));
            y = Math.floor(randRange(this._zone.y, this._zone.height));
            var loc2:*;
            this.scaleY = loc2 = loc1;
            scaleX = loc2;
            alpha = randRange(0.05, 0.5);
            rotation = randRange(-120, -100);
            return;
        }

        public function dispose():void
        {
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.startAnimation);
            this.zone = null;
            this.sparkAnimation.stop();
            this.sparkAnimation = null;
            return;
        }

        internal static function randRange(arg1:Number, arg2:Number):Number
        {
            var loc1:*=Math.random() * (arg2 - arg1) + arg1;
            return loc1;
        }

        internal var _zone:flash.geom.Rectangle=null;

        public var sparkAnimation:flash.display.MovieClip=null;
    }
}
