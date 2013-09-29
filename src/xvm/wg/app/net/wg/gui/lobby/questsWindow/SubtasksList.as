package net.wg.gui.lobby.questsWindow 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class SubtasksList extends scaleform.clik.core.UIComponent
    {
        public function SubtasksList()
        {
            this.data = [];
            super();
            this._tasks = new Vector.<net.wg.gui.lobby.questsWindow.SubtaskComponent>();
            return;
        }

        public function get linkage():String
        {
            return this._linkage;
        }

        public function set linkage(arg1:String):void
        {
            this._linkage = arg1;
            return;
        }

        public function setData(arg1:Array):void
        {
            this.data = arg1;
            invalidateData();
            return;
        }

        public override function dispose():void
        {
            if (this._tasks) 
            {
                this.clearTasks();
                this._tasks = null;
            }
            if (this.data) 
            {
                this.data.splice(0, this.data.length);
                this.data = null;
            }
            super.dispose();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.clearTasks();
                this.createTasks();
                this.layoutTasks();
            }
            return;
        }

        internal function clearTasks():void
        {
            var loc1:*=0;
            while (loc1 < this._tasks.length) 
            {
                this._tasks[loc1].dispose();
                removeChild(this._tasks[loc1]);
                ++loc1;
            }
            this._tasks.splice(0, this._tasks.length);
            return;
        }

        internal function layoutTasks():void
        {
            var loc1:*=1;
            while (loc1 < this._tasks.length) 
            {
                this._tasks[loc1].y = this._tasks[(loc1 - 1)].y + this._tasks[(loc1 - 1)].height;
                ++loc1;
            }
            var loc2:*=this._tasks.length ? this._tasks[(this._tasks.length - 1)] : null;
            var loc3:*=loc2 ? loc2.y + loc2.height : 0;
            dispatchEvent(new flash.events.Event(flash.events.Event.RESIZE));
            setSize(this.width, loc3);
            return;
        }

        internal function createTasks():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            if (this.data) 
            {
                loc1 = this.data.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    loc3 = App.utils.classFactory.getComponent(this._linkage, net.wg.gui.lobby.questsWindow.SubtaskComponent);
                    this._tasks.push(loc3);
                    addChild(loc3);
                    loc3.setData(this.data[loc2]);
                    loc3.validateNow();
                    ++loc2;
                }
            }
            return;
        }

        internal var data:Array;

        internal var _tasks:__AS3__.vec.Vector.<net.wg.gui.lobby.questsWindow.SubtaskComponent>=null;

        internal var _linkage:String="SubtaskComponent_UI";
    }
}
