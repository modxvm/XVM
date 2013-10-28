package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import __AS3__.vec.Vector;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.Event;


   public class SubtasksList extends UIComponent
   {
          
      public function SubtasksList() {
         this.data = [];
         super();
         this._tasks = new Vector.<SubtaskComponent>();
         this._availableQuests = new Vector.<String>();
      }

      private static const DISABLED_QUESTS:String = "disabledQuests";

      private var data:Array;

      private var _tasks:Vector.<SubtaskComponent> = null;

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

      override public function dispose() : void {
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
         super.dispose();
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.clearTasks();
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
         var _loc1_:SubtaskComponent = null;
         var _loc2_:* = false;
         if(this._needCheck)
         {
            for each (_loc1_ in this._tasks)
            {
               _loc2_ = !(this._availableQuests.indexOf(_loc1_.data.questInfo.questID) == -1);
               _loc1_.disableLinkBtn(_loc2_);
            }
         }
      }

      private function clearTasks() : void {
         var _loc1_:* = 0;
         while(_loc1_ < this._tasks.length)
         {
            this._tasks[_loc1_].dispose();
            removeChild(this._tasks[_loc1_]);
            _loc1_++;
         }
         this._tasks.splice(0,this._tasks.length);
      }

      private function layoutTasks() : void {
         var _loc1_:* = 1;
         while(_loc1_ < this._tasks.length)
         {
            this._tasks[_loc1_].y = this._tasks[_loc1_-1].y + this._tasks[_loc1_-1].height;
            _loc1_++;
         }
         var _loc2_:SubtaskComponent = this._tasks.length?this._tasks[this._tasks.length-1]:null;
         var _loc3_:Number = _loc2_?_loc2_.y + _loc2_.height:0;
         dispatchEvent(new Event(Event.RESIZE));
         setSize(this.width,_loc3_);
      }

      private function createTasks() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:SubtaskComponent = null;
         if(this.data)
         {
            _loc1_ = this.data.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = App.utils.classFactory.getComponent(this._linkage,SubtaskComponent);
               this._tasks.push(_loc3_);
               addChild(_loc3_);
               _loc3_.setData(this.data[_loc2_]);
               _loc3_.validateNow();
               _loc2_++;
            }
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