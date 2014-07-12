package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.ISubtaskComponent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.lobby.questsWindow.components.QuestStatusComponent;
   import net.wg.gui.lobby.questsWindow.components.QuestsCounter;
   import net.wg.gui.lobby.questsWindow.components.ProgressQuestIndicator;
   import flash.display.MovieClip;
   import net.wg.gui.lobby.questsWindow.data.SubtaskVO;
   import net.wg.data.constants.QuestsStates;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.Event;
   import net.wg.gui.events.QuestEvent;
   
   public class SubtaskComponent extends UIComponent implements ISubtaskComponent
   {
      
      public function SubtaskComponent() {
         super();
      }
      
      private static const BOTTOM_PADDING:int = 20;
      
      private static const LINKBTN_PADDING:int = 10;
      
      private static const DEFAULT_LINKBTN_Y:int = 2;
      
      private static function hideTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }
      
      public var typeTF:TextField;
      
      public var taskTF:TextField;
      
      public var linkBtn:SoundButton;
      
      public var statusMC:QuestStatusComponent;
      
      public var counter:QuestsCounter;
      
      public var progressIndicator:ProgressQuestIndicator;
      
      public var lineMC:MovieClip;
      
      private var _data:SubtaskVO = null;
      
      private var _status:String = "";
      
      private var _tasksCount:Number = -1;
      
      override protected function configUI() : void {
         super.configUI();
         this.linkBtn.visible = true;
         this.statusMC.visible = false;
         this.counter.visible = false;
         this.linkBtn.focusable = false;
         this.typeTF.mouseEnabled = false;
         this.taskTF.mouseEnabled = false;
         this.progressIndicator.visible = false;
         this.taskTF.textColor = QuestsStates.CLR_TASK_TF_NORMAL;
         this.addListeners();
      }
      
      private function addListeners() : void {
         this.linkBtn.addEventListener(ButtonEvent.CLICK,this.linkBtnHandler);
         this.linkBtn.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         this.linkBtn.addEventListener(MouseEvent.ROLL_OVER,this.showLinkBtnTooltip);
      }
      
      private function showLinkBtnTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.show(this.linkBtn.enabled?TOOLTIPS.QUESTS_LINKBTN_TASK:TOOLTIPS.QUESTS_DISABLELINKBTN_TASK);
      }
      
      public function setData(param1:Object) : void {
         this.data = param1?new SubtaskVO(param1):null;
         invalidateData();
      }
      
      public function disableLinkBtns(param1:Vector.<String>) : void {
         this.linkBtn.enabled = !(param1.indexOf(this.data.questInfo.questID) == -1);
         this.linkBtn.mouseEnabled = true;
      }
      
      override protected function onDispose() : void {
         this.removeListeners();
         this.linkBtn.dispose();
         this.progressIndicator.dispose();
         this.statusMC.dispose();
         this.counter.dispose();
         this.typeTF = null;
         this.taskTF = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         this.linkBtn = null;
         this.statusMC = null;
         this.lineMC = null;
         this.progressIndicator = null;
         super.onDispose();
      }
      
      private function removeListeners() : void {
         this.linkBtn.removeEventListener(ButtonEvent.CLICK,this.linkBtnHandler);
         this.linkBtn.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         this.linkBtn.removeEventListener(MouseEvent.ROLL_OVER,this.showLinkBtnTooltip);
      }
      
      override protected function draw() : void {
         var _loc1_:* = NaN;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this.data)
            {
               this.visible = true;
               this.checkLabels();
               this.checkStatus();
               this.checkCounter();
               this.checkProgressBar();
               this.lineMC.y = Math.round(this.linkBtn.y + this.linkBtn.height + BOTTOM_PADDING);
               _loc1_ = Math.round(this.lineMC.y);
               setSize(this.width,_loc1_);
               dispatchEvent(new Event(Event.RESIZE));
            }
            else
            {
               this.visible = false;
            }
         }
      }
      
      private function checkLabels() : void {
         var _loc1_:* = NaN;
         if(this.typeTF.text != this.data.title)
         {
            this.typeTF.text = this.data.title;
         }
         if(this.taskTF.text != this.data.questInfo.description)
         {
            this.taskTF.text = this.data.questInfo.description;
            if(this.taskTF.text)
            {
               _loc1_ = this.taskTF.getLineMetrics(this.taskTF.numLines - 1).width;
               this.linkBtn.y = Math.round(this.taskTF.textHeight + this.taskTF.y - this.linkBtn.height + DEFAULT_LINKBTN_Y);
               this.linkBtn.x = Math.round(this.taskTF.x + _loc1_ + LINKBTN_PADDING);
            }
            else
            {
               this.linkBtn.y = Math.round(this.taskTF.y + DEFAULT_LINKBTN_Y);
               this.linkBtn.x = Math.round(this.taskTF.x);
            }
            this.taskTF.mouseEnabled = false;
         }
      }
      
      private function checkProgressBar() : void {
         if((this.data.questInfo.progrBarType) && !this._status)
         {
            this.progressIndicator.visible = true;
            this.progressIndicator.setValues(this.data.questInfo.progrBarType,this.data.questInfo.currentProgrVal,this.data.questInfo.maxProgrVal);
            this.progressIndicator.setTooltip(this.data.questInfo.progrTooltip);
            this.progressIndicator.validateNow();
         }
         else
         {
            this.progressIndicator.visible = false;
         }
      }
      
      private function checkCounter() : void {
         if(this._tasksCount != this.data.questInfo.tasksCount)
         {
            this._tasksCount = this.data.questInfo.tasksCount;
            if(this._tasksCount >= 0 && !this._status)
            {
               this.counter.visible = true;
               this.counter.textField.text = this._tasksCount.toString();
            }
            else
            {
               this.counter.visible = false;
            }
         }
      }
      
      private function checkStatus() : void {
         if(this._status != this.data.questInfo.status)
         {
            this._status = this.data.questInfo.status;
            this.statusMC.setStatus(this._status);
            this.taskTF.textColor = this._status?QuestsStates.CLR_TASK_TF_WITH_STATUS:QuestsStates.CLR_TASK_TF_NORMAL;
         }
      }
      
      public function get data() : SubtaskVO {
         return this._data;
      }
      
      public function set data(param1:SubtaskVO) : void {
         this._data = param1;
      }
      
      private function linkBtnHandler(param1:ButtonEvent) : void {
         App.toolTipMgr.hide();
         dispatchEvent(new QuestEvent(QuestEvent.SELECT_QUEST,this.data.questInfo.questID));
      }
   }
}
