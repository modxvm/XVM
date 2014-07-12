package net.wg.infrastructure.managers.utils.impl
{
    import net.wg.utils.IScheduler;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    
    public class Scheduler extends Object implements IScheduler
    {
        
        public function Scheduler() {
            super();
            this._taskStack = new TaskStack();
            this._timer = new Timer(CONCURRENT_FRAME_TICK);
            this._timer.addEventListener(TimerEvent.TIMER,this.onFrame,false,0,true);
        }
        
        public static var GLOBAL_FRAME_TICK:Number = 50;
        
        public static var CONCURRENT_FRAME_TICK:Number;
        
        private var _timer:Timer = null;
        
        private var _taskStack:TaskStack = null;
        
        private var _disposed:Boolean = false;
        
        public function scheduleTask(param1:Function, param2:Number, ... rest) : void {
            var _loc4_:Number = new Date().time + param2;
            var _loc5_:Task = new Task(_loc4_,param1,rest);
            this._taskStack.pushTask(_loc5_);
            this.updateTimer();
        }
        
        public function scheduleNonCancelableTask(param1:Function, param2:Number, ... rest) : void {
            var _loc4_:Number = new Date().time + param2;
            var _loc5_:Task = new Task(_loc4_,param1,rest);
            this._taskStack.pushTask(_loc5_,true);
            this.updateTimer();
        }
        
        public function envokeInNextFrame(param1:Function, ... rest) : void {
            var rest:Array = [param1,CONCURRENT_FRAME_TICK].concat(rest);
            this.scheduleTask.apply(this,rest);
        }
        
        public function cancelTask(param1:Function) : void {
            this._taskStack.removeTaskByHandler(param1);
            this.updateTimer();
        }
        
        public function cancelAll() : void {
            var _loc1_:Task = null;
            while(!this._taskStack.isEmpty())
            {
                _loc1_ = this._taskStack.popTask();
                _loc1_.dispose();
            }
            this.updateTimer();
        }
        
        public function isEmpty() : Boolean {
            return this._taskStack.isEmpty();
        }
        
        public function dispose() : void {
            this.cancelAll();
            this._taskStack = null;
            this._timer.removeEventListener(TimerEvent.TIMER,this.onFrame);
            this._timer.stop();
            this._timer = null;
            this._disposed = true;
        }
        
        private function onFrame(param1:TimerEvent) : void {
            this.processFrame();
        }
        
        private function processFrame() : void {
            var _loc1_:Task = this._taskStack.popTask();
            _loc1_.invoke();
            _loc1_.dispose();
            if(!this._disposed)
            {
                this.updateTimer();
            }
        }
        
        private function updateTimer() : void {
            var _loc1_:* = NaN;
            if(this._taskStack.isEmpty())
            {
                this._timer.stop();
            }
            else
            {
                _loc1_ = this._taskStack.top().finishTime - new Date().time;
                if(_loc1_ > 0)
                {
                    this._timer.delay = _loc1_;
                    this._timer.reset();
                    this._timer.start();
                }
                else
                {
                    this.processFrame();
                }
            }
        }
    }
}
import net.wg.infrastructure.interfaces.entity.ICallable;
import net.wg.infrastructure.interfaces.entity.IDisposable;

class Task extends Object implements ICallable, IDisposable
{
    
    function Task(param1:Number, param2:Function, param3:Array) {
        super();
        this._finishTime = param1;
        this._handler = param2;
        this._args = param3;
    }
    
    private var _finishTime:Number = 0;
    
    private var _handler:Function = null;
    
    private var _args:Array = null;
    
    public function get finishTime() : Number {
        return this._finishTime;
    }
    
    public function get handler() : Function {
        return this._handler;
    }
    
    public function invoke() : void {
        if(this._args.length > 0)
        {
            this._handler.apply(null,this._args);
        }
        else
        {
            this._handler();
        }
    }
    
    public function dispose() : void {
        this._handler = null;
        this._args = null;
    }
}
class TaskStack extends Object
{
    
    function TaskStack() {
        super();
        this._tasks = new Vector.<Task>();
    }
    
    private var _tasks:Vector.<Task> = null;
    
    private function pushTask(param1:Task, param2:Boolean = false) : void {
        var _loc3_:Number = this._tasks.length - 1;
        var _loc4_:Number = -1;
        var _loc5_:Number = -1;
        while(_loc3_ >= 0)
        {
            if(this._tasks[_loc3_].finishTime > param1.finishTime && _loc4_ == -1)
            {
                _loc4_ = _loc3_ + 1;
            }
            if(!param2 && this._tasks[_loc3_].handler == param1.handler)
            {
                _loc5_ = _loc3_;
            }
            if(!(_loc4_ == -1) && !(_loc5_ == -1))
            {
                break;
            }
            _loc3_--;
        }
        if(_loc4_ == -1)
        {
            _loc4_ = 0;
        }
        if(_loc5_ < _loc4_ && !(_loc5_ == -1))
        {
            _loc4_--;
        }
        if(_loc5_ != -1)
        {
            this._tasks.splice(_loc5_,1);
        }
        this._tasks.splice(_loc4_,0,param1);
    }
    
    private function removeTaskByHandler(param1:Function) : void {
        var _loc4_:Task = null;
        var _loc2_:Task = null;
        var _loc3_:Number = 0;
        while(_loc3_ < this._tasks.length)
        {
            _loc4_ = this._tasks[_loc3_];
            if(_loc4_.handler == param1)
            {
                _loc2_ = _loc4_;
                this._tasks.splice(_loc3_,1);
                return;
            }
            _loc3_++;
        }
    }
    
    private function popTask() : Task {
        return this._tasks.pop();
    }
    
    private function top() : Task {
        return this._tasks[this._tasks.length - 1];
    }
    
    private function isEmpty() : Boolean {
        return this._tasks.length == 0;
    }
}
