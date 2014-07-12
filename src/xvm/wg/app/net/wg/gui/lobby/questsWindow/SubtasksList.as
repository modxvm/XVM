package net.wg.gui.lobby.questsWindow
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.ISubtaskComponent;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    import flash.display.DisplayObject;
    
    public class SubtasksList extends UIComponent
    {
        
        public function SubtasksList() {
            this.data = [];
            super();
            this._tasks = new Vector.<ISubtaskComponent>();
            this._availableQuests = new Vector.<String>();
        }
        
        private static var DISABLED_QUESTS:String = "disabledQuests";
        
        private var data:Array;
        
        private var _tasks:Vector.<ISubtaskComponent> = null;
        
        private var _availableQuests:Vector.<String> = null;
        
        private var _linkage:String = "SubtaskComponent_UI";
        
        private var _needCheck:Boolean = false;
        
        public function get linkage() : String {
            return this._linkage;
        }
        
        public function set linkage(param1:String) : void {
            this._linkage = param1;
        }
        
        public function setData(param1:Array) : void {
            this.data = param1;
            invalidateData();
        }
        
        public function checkDisabledQuests(param1:Vector.<String>) : void {
            this._availableQuests = param1;
            this.needCheck = true;
            invalidate(DISABLED_QUESTS);
        }
        
        override protected function onDispose() : void {
            if(this._tasks)
            {
                this.clearTasks();
                this._tasks = null;
            }
            if(this.data)
            {
                this.data.splice(0,this.data.length);
                this.data = null;
            }
            if(this._availableQuests)
            {
                this._availableQuests.splice(0,this._availableQuests.length);
                this._availableQuests = null;
            }
            super.onDispose();
        }
        
        override protected function draw() : void {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.createTasks();
                this.layoutTasks();
                this.disableInvalidQuests();
            }
            if(isInvalid(DISABLED_QUESTS))
            {
                this.disableInvalidQuests();
            }
        }
        
        private function disableInvalidQuests() : void {
            var _loc1_:ISubtaskComponent = null;
            if(this._needCheck)
            {
                for each(_loc1_ in this._tasks)
                {
                    _loc1_.disableLinkBtns(this._availableQuests);
                }
            }
        }
        
        private function layoutTasks() : void {
            var _loc1_:* = 1;
            while(_loc1_ < this._tasks.length)
            {
                this._tasks[_loc1_].y = this._tasks[_loc1_ - 1].y + this._tasks[_loc1_ - 1].height;
                _loc1_++;
            }
            var _loc2_:ISubtaskComponent = this._tasks.length?this._tasks[this._tasks.length - 1]:null;
            var _loc3_:Number = _loc2_?_loc2_.y + _loc2_.height:0;
            setSize(this.width,_loc3_);
            dispatchEvent(new Event(Event.RESIZE));
        }
        
        private function clearTasks() : void {
            var _loc1_:* = 0;
            while(_loc1_ < this._tasks.length)
            {
                this._tasks[_loc1_].dispose();
                removeChild(DisplayObject(this._tasks[_loc1_]));
                _loc1_++;
            }
            this._tasks.splice(0,this._tasks.length);
        }
        
        private function createTasks() : void {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc5_:ISubtaskComponent = null;
            var _loc6_:ISubtaskComponent = null;
            if(this.data)
            {
                _loc1_ = this.data.length;
                if(this._tasks.length < _loc1_)
                {
                    _loc3_ = _loc1_ - this._tasks.length;
                    _loc4_ = 0;
                    while(_loc4_ < _loc3_)
                    {
                        _loc5_ = App.utils.classFactory.getComponent(this._linkage,ISubtaskComponent);
                        this._tasks.push(_loc5_);
                        addChild(DisplayObject(_loc5_));
                        _loc4_++;
                    }
                }
                else if(this._tasks.length > _loc1_)
                {
                    while(this._tasks.length > _loc1_)
                    {
                        _loc6_ = this._tasks.pop();
                        _loc6_.dispose();
                        removeChild(DisplayObject(_loc6_));
                    }
                }
                
                _loc2_ = 0;
                while(_loc2_ < this.data.length)
                {
                    this._tasks[_loc2_].setData(this.data[_loc2_]);
                    this._tasks[_loc2_].validateNow();
                    _loc2_++;
                }
            }
            else
            {
                this.clearTasks();
            }
        }
        
        public function get needCheck() : Boolean {
            return this._needCheck;
        }
        
        public function set needCheck(param1:Boolean) : void {
            this._needCheck = param1;
        }
    }
}
