package net.wg.gui.lobby.techtree.data.state 
{
    import flash.display.*;
    
    public class AnimationProperties extends Object
    {
        public function AnimationProperties(arg1:Number, arg2:Object, arg3:Object)
        {
            super();
            this.duration = arg1;
            this.from = arg2;
            this.to = arg3;
            return;
        }

        public function setTo(arg1:flash.display.MovieClip):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this.to;
            for (loc1 in loc3) 
            {
                arg1[loc1] = this.to[loc1];
            }
            return;
        }

        public function setFrom(arg1:flash.display.MovieClip):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this.from;
            for (loc1 in loc3) 
            {
                arg1[loc1] = this.from[loc1];
            }
            return;
        }

        public var duration:Number;

        public var from:Object;

        public var to:Object;
    }
}
