import com.xvm.GlobalEventDispatcher;

/**
 * Shoots custom events by timer.
 *
 * Timer is automatically destroyed. Timer lifetime is 16 minutes.
 * 
 * Routines invocation by timer can be much easier than by WG\XVM methods.
 */

class com.xvm.AutoUpdate
{
    public static var UPDATE_BY_TIMER_EVENT:String = "AutoUpdateEvent";
    
    private static var _instance:AutoUpdate;
    
    private static var TICK_INTERVAL_MS:Number = 300; // 300ms
    
    /**
     * Maximum battle duration in seconds
     * plus prebattle and postbattle stuff.
     */
    private static var SELF_DESTRUCT_TICKS_THRESHOLD:Number = 16 * 60 * 1000;

    private var flashTimer;
    private var destructionTimer:Number;
    
    public static function get instance():AutoUpdate
    {
        if (!_instance)
        {
            _instance = new AutoUpdate();
        }
        
        return _instance;
    }

    public function AutoUpdate()
    {
        destructionTimer = 0;
    }
    
    public function startTimer():Void
    {
        /** Should be invoked each time battle is loaded */
        if (!flashTimer)
        {
            flashTimer = _global.setInterval(this, UPDATE_FUNC_NAME, TICK_INTERVAL_MS);
        }
    }

    // -- Private

    /** Actions performed by timer */
    private var UPDATE_FUNC_NAME:String = "update";
    private function update():Void
    {
        checkIfTimerIsObsolete();
        
        /**
         * Listener template:
         *  GlobalEventDispatcher.addEventListener(AutoUpdate.UPDATE_BY_TIMER_EVENT, this, onTimerTick);
         */ 
        GlobalEventDispatcher.dispatchEvent( { type: UPDATE_BY_TIMER_EVENT } );
    }

    /** Selfdestruct if timer have not been used for long time */
    private function checkIfTimerIsObsolete():Void
    {
        destructionTimer += TICK_INTERVAL_MS;
        if (destructionTimer > SELF_DESTRUCT_TICKS_THRESHOLD)
            _global.clearInterval(flashTimer);
    }
}
