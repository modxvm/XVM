package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.lobby.questsWindow.data.QuestDataVO;
   import flash.events.Event;
   import __AS3__.vec.Vector;
   import scaleform.clik.constants.InvalidationType;


   public class QuestBlock extends UIComponent
   {
          
      public function QuestBlock() {
         super();
      }

      public var infoBlock:MiddleInfoBlock;

      private var _showNextTasks:Boolean = false;

      private var questData:QuestDataVO = null;

      public var nextTasksList:SubtasksList;

      private var infoBlockResized:Boolean = false;

      private var nextTasksListResized:Boolean = false;

      override protected function configUI() : void {
         super.configUI();
         this.infoBlock.visible = false;
         this.nextTasksList.visible = false;
         this.infoBlock.addEventListener(Event.RESIZE,this.layoutBlocks);
         this.nextTasksList.addEventListener(Event.RESIZE,this.layoutBlocks);
      }

      public function setData(param1:QuestDataVO) : void {
         this.questData = param1;
         invalidateData();
      }

      public function setAvailableQuests(param1:Vector.<String>) : void {
         this.nextTasksList.checkDisabledQuests(param1);
         this.infoBlock.subtasksList.checkDisabledQuests(param1);
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this.questData))
         {
            this._showNextTasks = Boolean(this.questData.nextTasks.length);
            this.infoBlock.setData(this.questData.info);
            this.nextTasksList.setData(this.questData.nextTasks);
         }
      }

      private function layoutBlocks(param1:Event) : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         if(param1.target == this.infoBlock)
         {
            this.infoBlockResized = true;
         }
         if(param1.target == this.nextTasksList)
         {
            this.nextTasksListResized = true;
         }
         if((this.infoBlockResized) && (this.nextTasksListResized))
         {
            _loc2_ = Math.round(this.infoBlock.y + this.infoBlock.height);
            _loc3_ = Math.round(this._showNextTasks?this.nextTasksList.height + 10:0);
            _loc4_ = _loc2_ + _loc3_;
            this.nextTasksList.y = _loc2_;
            this.infoBlock.visible = true;
            this.nextTasksList.visible = this._showNextTasks;
            setSize(this.width,_loc4_);
            dispatchEvent(new Event(Event.RESIZE));
            this.infoBlockResized = false;
            this.nextTasksListResized = false;
         }
      }

      override public function dispose() : void {
         this.infoBlock.removeEventListener(Event.RESIZE,this.layoutBlocks);
         this.nextTasksList.removeEventListener(Event.RESIZE,this.layoutBlocks);
         this.infoBlock.dispose();
         this.nextTasksList.dispose();
         if(this.questData)
         {
            this.questData.dispose();
            this.questData = null;
         }
         this.infoBlock = null;
         this.nextTasksList = null;
         super.dispose();
      }
   }

}