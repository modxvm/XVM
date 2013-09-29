package net.wg.infrastructure.managers.utils.impl 
{
    import flash.events.*;
    import flash.utils.*;
    import net.wg.utils.*;
    
    public class Scheduler extends Object implements net.wg.utils.IScheduler
    {
        public function Scheduler()
        {
            super();
            this._taskStack = new TaskStack();
            this._timer = new flash.utils.Timer(CONCURRENT_FRAME_TICK);
            this._timer.addEventListener(flash.events.TimerEvent.TIMER, this.onFrame, false, 0, true);
            return;
        }

        public function scheduleTask(arg1:Function, arg2:Number, ... rest):void
        {
            var loc1:*=new Date().time + arg2;
            var loc2:*=new Task(loc1, arg1, rest);
            this._taskStack.pushTask(loc2);
            this.updateTimer();
            return;
        }

        public function envokeInNextFrame(arg1:Function, ... rest):void
        {
            rest = [arg1, CONCURRENT_FRAME_TICK].concat(rest);
            this.scheduleTask.apply(this, rest);
            return;
        }

        public function cancelTask(arg1:Function):void
        {
            this._taskStack.removeTaskByHandler(arg1);
            this.updateTimer();
            return;
        }

        public function cancelAll():void
        {
            var loc1:*=null;
            while (!this._taskStack.isEmpty()) 
            {
                loc1 = this._taskStack.popTask();
                loc1.dispose();
            }
            this.updateTimer();
            return;
        }

        public function dispose():void
        {
            this.cancelAll();
            this._taskStack = null;
            this._timer.removeEventListener(flash.events.TimerEvent.TIMER, this.onFrame);
            this._timer.stop();
            this._timer = null;
            this._disposed = true;
            return;
        }

        internal function onFrame(arg1:flash.events.TimerEvent):void
        {
            this.processFrame();
            return;
        }

        internal function processFrame():void
        {
            var loc1:*=this._taskStack.popTask();
            loc1.invoke();
            loc1.dispose();
            if (!this._disposed) 
            {
                this.updateTimer();
            }
            return;
        }

        internal function updateTimer():void
        {
            var loc1:*=NaN;
            if (this._taskStack.isEmpty()) 
            {
                this._timer.stop();
            }
            else 
            {
                loc1 = this._taskStack.top().finishTime - new Date().time;
                if (loc1 > 0) 
                {
                    this._timer.delay = loc1;
                    this._timer.reset();
                    this._timer.start();
                }
                else 
                {
                    this.processFrame();
                }
            }
            return;
        }

        public static const GLOBAL_FRAME_TICK:Number=50;

        public static const CONCURRENT_FRAME_TICK:Number=Math.floor(GLOBAL_FRAME_TICK / 2);

        internal var _timer:flash.utils.Timer=null;

        internal var _taskStack:TaskStack=null;

        internal var _disposed:Boolean=false;
    }
}

import __AS3__.vec.*;
import net.wg.infrastructure.interfaces.entity.*;


class Task extends Object implements net.wg.infrastructure.interfaces.entity.ICallable, net.wg.infrastructure.interfaces.entity.IDisposable
{
    public function Task(arg1:Number, arg2:Function, arg3:Array)
    {
        super();
        this._finishTime = arg1;
        this._handler = arg2;
        this._args = arg3;
        return;
    }

    public function get finishTime():Number
    {
        return this._finishTime;
    }

    public function get handler():Function
    {
        return this._handler;
    }

    public function invoke():void
    {
        if (this._args.length > 0) 
        {
            this._handler.apply(null, this._args);
        }
        else 
        {
            this._handler();
        }
        return;
    }

    public function dispose():void
    {
        this._handler = null;
        this._args = null;
        return;
    }

    internal var _finishTime:Number=0;

    internal var _handler:Function=null;

    internal var _args:Array=null;
}

class TaskStack extends Object
{
    public function TaskStack()
    {
        super();
        this._tasks = new Vector.<Task>();
        return;
    }

    internal function pushTask(arg1:Task):void
    {
        var loc1:*=this._tasks.length;
        while (loc1 > 0) 
        {
            if (this._tasks[(loc1 - 1)].finishTime > arg1.finishTime) 
            {
                break;
            }
            --loc1;
        }
        this._tasks.splice(loc1, 0, arg1);
        return;
    }

    internal function removeTaskByHandler(arg1:Function):void
    {
        var loc3:*=null;
        var loc1:*=null;
        var loc2:*=0;
        while (loc2 < this._tasks.length) 
        {
            if ((loc3 = this._tasks[loc2]).handler == arg1) 
            {
                loc1 = loc3;
                this._tasks.splice(loc2, 1);
                return;
            }
            ++loc2;
        }
        return;
    }

    internal function popTask():Task
    {
        return this._tasks.pop();
    }

    internal function top():Task
    {
        return this._tasks[(this._tasks.length - 1)];
    }

    internal function isEmpty():Boolean
    {
        return this._tasks.length == 0;
    }

    internal var _tasks:__AS3__.vec.Vector.<Task>=null;
}