class gfx.motion.Tween extends MovieClip
{
    var _loc4, tween__props, tween__ease, tween__startProps, tween__startTime, tween__duration, onEnterFrame, onTweenComplete;
    function Tween()
    {
        super();
        MovieClip.prototype.tweenTo = tweenTo;
        MovieClip.prototype.tweenFrom = tweenFrom;
        MovieClip.prototype.tweenEnd = tweenEnd;
        MovieClip.prototype.tween__run = tween__run;
        MovieClip.prototype.tween__to = tween__to;
        MovieClip.prototype.tween__start = tween__start;
        _global.ASSetPropFlags(MovieClip.prototype, "tween__start,tween__to,tween__run", 1);
    } // End of the function
    static function linearEase(t, b, c, d)
    {
        return (c * t / d + b);
    } // End of the function
    static function init()
    {
        if (gfx.motion.Tween._instance != null)
        {
            return (false);
        } // end if
        _instance = new gfx.motion.Tween();
    } // End of the function
    function tweenTo(duration, props, ease)
    {
        var _loc2 = {};
        for (var _loc4 in props)
        {
            _loc2[_loc4] = this[_loc4];
        } // end of for...in
        this.tween__start(duration, props, ease, _loc2);
    } // End of the function
    function tweenFrom(duration, props, ease)
    {
        var _loc3 = {};
        for (var _loc4 in props)
        {
            _loc3[_loc4] = props[_loc4];
            props[_loc4] = this[_loc4];
            this[_loc4] = _loc3[_loc4];
        } // end of for...in
        this.tween__start(duration, props, ease, _loc3);
    } // End of the function
    function tweenEnd(jumpToEnd)
    {
        this.tween__to(1);
        delete this.tween__props;
        delete this.tween__ease;
        delete this.tween__startProps;
        delete this.tween__startTime;
        delete this.tween__duration;
        delete this.onEnterFrame;
    } // End of the function
    function tween__start(duration, props, ease, startProps)
    {
        tween__props = props;
        tween__startProps = startProps;
        tween__ease = ease != null ? (ease) : (gfx.motion.Tween.linearEase);
        tween__startTime = getTimer();
        tween__duration = duration;
        onEnterFrame = tween__run;
    } // End of the function
    function tween__to(position)
    {
        var _loc3 = tween__props;
        var _loc2 = tween__startProps;
        for (var _loc4 in _loc3)
        {
            this[_loc4] = position * (_loc3[_loc4] - _loc2[_loc4]) + _loc2[_loc4];
        } // end of for...in
    } // End of the function
    function tween__run()
    {
        var _loc2 = (getTimer() - tween__startTime) / (tween__duration * 1000);
        if (_loc2 >= 1)
        {
            this.tweenEnd(true);
            if (onTweenComplete)
            {
                this.onTweenComplete();
            } // end if
        }
        else
        {
            this.tween__to(this.tween__ease(_loc2, 0, 1, 1));
        } // end else if
    } // End of the function
    static var _instance = new gfx.motion.Tween();
} // End of Class
