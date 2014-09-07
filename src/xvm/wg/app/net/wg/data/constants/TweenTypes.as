package net.wg.data.constants
{
    public class TweenTypes extends Object
    {
        
        public function TweenTypes()
        {
            super();
        }
        
        public static var FADE_IN:String = "fadeIn";
        
        public static var FADE_OUT:String = "fadeOut";
        
        public static var BLINK_IN:String = "blinkIn";
        
        public static var BLINK_OUT:String = "blinkOut";
        
        public static var MOVE_UP:String = "moveUp";
        
        public static var MOVE_DOWN:String = "moveDown";
        
        public static var GLOW_IN:String = "glowIn";
        
        public static var GLOW_OUT:String = "glowOut";
        
        public static var SHADOW_IN:String = "shadowIn";
        
        public static var SHADOW_OUT:String = "shadowOut";
        
        public static var TURN_HALF:String = "turnHalf";
        
        public static var USER_TWEEN:String = "userTween";
        
        public static var SIMPLE_ANIM_TYPES:Vector.<String> = new <String>[MOVE_UP,MOVE_DOWN,FADE_IN,FADE_OUT,TURN_HALF];
        
        public static var FADE_TYPES:Vector.<String> = new <String>[FADE_IN,FADE_OUT];
        
        public static var BLINKING_TYPES:Vector.<String> = new <String>[BLINK_IN,BLINK_OUT];
        
        public static var MOVE_TYPES:Vector.<String> = new <String>[MOVE_UP,MOVE_DOWN];
        
        public static var TURN_TYPES:Vector.<String> = new <String>[TURN_HALF];
        
        public static var GLOW_TYPES:Vector.<String> = new <String>[GLOW_IN,GLOW_OUT];
        
        public static var SHADOW_TYPES:Vector.<String> = new <String>[SHADOW_IN,SHADOW_OUT];
        
        public static var DURATIONS_BY_TYPES:Vector.<Object> = new <Object>[{"types":FADE_TYPES,
        "duration":TweenConstraints.FADE_DURATION
    },{"types":BLINKING_TYPES,
    "duration":TweenConstraints.BLINKING_DURATION
},{"types":MOVE_TYPES,
"duration":TweenConstraints.MOVE_DURATION
},{"types":GLOW_TYPES,
"duration":TweenConstraints.GLOW_DURATION
},{"types":SHADOW_TYPES,
"duration":TweenConstraints.SHADOW_DURATION
},{"types":TURN_TYPES,
"duration":TweenConstraints.HALF_TURN_DURATION
}];
}
}
