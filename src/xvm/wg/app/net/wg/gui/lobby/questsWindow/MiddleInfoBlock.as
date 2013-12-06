package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.lobby.questsWindow.data.InfoDataVO;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.Event;
   import net.wg.gui.lobby.questsWindow.data.DescriptionVO;


   public class MiddleInfoBlock extends UIComponent
   {
          
      public function MiddleInfoBlock() {
         super();
      }

      private static const CONDITION_PADDING:int = 10;

      public var description:DescriptionBlock;

      public var subtasksList:SubtasksList;

      public var conditions:ConditionsComponent;

      public var infoData:InfoDataVO = null;

      private var descrHeight:Number = 0;

      private var subtasksHeight:Number = 0;

      private var conditionsHeight:Number = 0;

      override protected function configUI() : void {
         super.configUI();
         this.conditions.visible = false;
         this.description.visible = false;
         this.subtasksList.visible = false;
         this.description.mouseChildren = false;
         this.description.mouseEnabled = false;
      }

      override public function dispose() : void {
         if(this.description)
         {
            this.description.dispose();
            this.description = null;
         }
         if(this.subtasksList)
         {
            this.subtasksList.dispose();
            this.subtasksList = null;
         }
         if(this.conditions)
         {
            this.conditions.dispose();
            this.conditions = null;
         }
         if(this.infoData)
         {
            this.infoData.dispose();
            this.infoData = null;
         }
         super.dispose();
      }

      public function setData(param1:InfoDataVO) : void {
         this.infoData = param1;
         invalidateData();
      }

      override protected function draw() : void {
         var _loc1_:* = NaN;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = 0;
            if(this.infoData)
            {
               this.setDescription();
               this.setSubtasks();
               this.setCondition();
               _loc1_ = this.descrHeight + this.subtasksHeight + this.conditionsHeight;
            }
            setSize(this.width,_loc1_);
            dispatchEvent(new Event(Event.RESIZE));
         }
      }

      private function setCondition() : void {
         this.conditions.y = this.descrHeight + this.subtasksHeight > 0?this.descrHeight + this.subtasksHeight + CONDITION_PADDING:0;
         if(this.infoData.conditions)
         {
            this.conditions.setData(this.infoData.conditions);
            this.conditions.validateNow();
            this.conditions.visible = true;
            this.conditionsHeight = Math.round(this.conditions.height);
         }
         else
         {
            this.conditionsHeight = 0;
            this.conditions.visible = false;
         }
      }

      private function setSubtasks() : void {
         this.subtasksList.y = this.descrHeight;
         if(this.infoData.subtasks)
         {
            this.subtasksList.setData(this.infoData.subtasks);
            this.subtasksList.validateNow();
            this.subtasksList.visible = true;
            this.subtasksHeight = Math.round(this.subtasksList.height);
         }
         else
         {
            this.subtasksList.visible = false;
            this.subtasksHeight = 0;
         }
      }

      private function setDescription() : void {
         var _loc1_:DescriptionVO = null;
         if(this.infoData.descr)
         {
            _loc1_ = this.infoData.descr;
            this.description.setLabels(_loc1_.title,_loc1_.descr);
            this.description.validateNow();
            this.description.visible = true;
            this.descrHeight = Math.round(this.description.height);
         }
         else
         {
            this.description.visible = false;
            this.descrHeight = 0;
         }
      }
   }

}