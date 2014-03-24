package net.wg.gui.lobby.battleResults
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.ISubtaskComponent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.lobby.questsWindow.components.QuestStatusComponent;
   import net.wg.gui.lobby.questsWindow.components.QuestsCounter;
   import net.wg.gui.lobby.questsWindow.QuestAwardsBlock;
   import net.wg.gui.lobby.questsWindow.SubtasksList;
   import flash.display.MovieClip;
   import net.wg.data.VO.BattleResultsQuestVO;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.QuestsStates;
   import flash.text.TextFieldAutoSize;
   import scaleform.clik.events.ButtonEvent;
   import __AS3__.vec.Vector;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.Event;
   import net.wg.gui.events.QuestEvent;


   public class BattleResultsEventRenderer extends UIComponent implements ISubtaskComponent
   {
          
      public function BattleResultsEventRenderer() {
         super();
      }

      private static const BOTTOM_PADDING:int = 14;

      private static const LINKBTN_PADDING:int = 10;

      private static const AWARDS_PADDING:int = 5;

      private static function hideTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private static const PIXEL_PADDING:int = 1;

      public var taskTF:TextField;

      public var linkBtn:SoundButton;

      public var statusMC:QuestStatusComponent;

      public var counter:QuestsCounter;

      public var awards:QuestAwardsBlock;

      public var progressList:SubtasksList;

      public var alert:MovieClip;

      public var lineMC:MovieClip;

      private var _data:BattleResultsQuestVO = null;

      private var _status:String = "";

      private var _tasksCount:Number = -1;

      override protected function configUI() : void {
         super.configUI();
         this.linkBtn.visible = true;
         this.statusMC.visible = false;
         this.counter.visible = false;
         this.linkBtn.focusable = false;
         this.taskTF.mouseEnabled = false;
         this.progressList.linkage = Linkages.PROGRESS_ELEMENT;
         this.taskTF.textColor = QuestsStates.CLR_TASK_TF_NORMAL;
         this.awards.contentAlign = TextFieldAutoSize.RIGHT;
         this.awards.hasFixedHeight = false;
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
         this.data = param1?new BattleResultsQuestVO(param1):null;
         invalidateData();
      }

      public function disableLinkBtns(param1:Vector.<String>) : void {
         this.linkBtn.enabled = !(param1.indexOf(this.data.questInfo.questID) == -1);
         this.linkBtn.mouseEnabled = true;
      }

      override protected function onDispose() : void {
         this.removeListeners();
         this.linkBtn.dispose();
         this.taskTF = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         this.counter.dispose();
         this.counter = null;
         this.linkBtn = null;
         this.statusMC.dispose();
         this.statusMC = null;
         this.lineMC = null;
         this.awards.dispose();
         this.awards = null;
         this.alert = null;
         this.progressList.dispose();
         this.progressList = null;
         super.onDispose();
      }

      private function removeListeners() : void {
         this.linkBtn.removeEventListener(ButtonEvent.CLICK,this.linkBtnHandler);
         this.linkBtn.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         this.linkBtn.removeEventListener(MouseEvent.ROLL_OVER,this.showLinkBtnTooltip);
      }

      override protected function draw() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this.data)
            {
               this.visible = true;
               this.checkStatus();
               this.checkCounter();
               _loc1_ = 0;
               _loc2_ = this.checkLabels();
               _loc1_ = _loc2_ + BOTTOM_PADDING;
               _loc3_ = this.checkAlertMsg(_loc1_);
               _loc1_ = _loc1_ + (_loc3_?_loc3_ + BOTTOM_PADDING:0);
               _loc4_ = this.checkProgressList(_loc1_);
               _loc1_ = _loc1_ + (_loc4_?_loc4_ + BOTTOM_PADDING:0);
               _loc5_ = this.checkAwards(_loc1_);
               _loc1_ = _loc1_ + _loc5_;
               this.lineMC.y = Math.round(_loc1_);
               _loc6_ = Math.round(this.lineMC.y);
               setSize(this.width,_loc6_);
               dispatchEvent(new Event(Event.RESIZE));
            }
            else
            {
               this.visible = false;
            }
         }
      }

      private function checkAwards(param1:Number) : Number {
         this.awards.setActualWidth(this.progressList.width);
         this.awards.setData(this.data.awards);
         this.awards.visible = (this.data.awards) && (this.data.awards.length);
         this.awards.validateNow();
         this.awards.y = Math.round(param1 + AWARDS_PADDING);
         var _loc2_:Number = this.awards.height > 0?this.awards.height + AWARDS_PADDING:0;
         return Math.round(_loc2_);
      }

      private function checkProgressList(param1:Number) : Number {
         this.progressList.y = param1;
         this.progressList.setData(this.data.progressList);
         this.progressList.validateNow();
         return Math.round(this.progressList.height);
      }

      private function checkAlertMsg(param1:Number) : Number {
         this.alert.visible = Boolean(this.data.alertMsg);
         this.alert.msgTF.text = this.data.alertMsg;
         this.alert.y = param1;
         return this.data.alertMsg?Math.round(TextField(this.alert.msgTF).textHeight):0;
      }

      private function checkLabels() : Number {
         if(this.taskTF.text != this.data.questInfo.description)
         {
            this.taskTF.text = this.data.questInfo.description;
            this.linkBtn.y = (this.taskTF.text?this.taskTF.textHeight + this.taskTF.y - this.linkBtn.height:this.taskTF.y) + PIXEL_PADDING;
            this.linkBtn.x = this.taskTF.text?this.taskTF.x + this.taskTF.getLineMetrics(this.taskTF.numLines-1).width + LINKBTN_PADDING:this.taskTF.x;
            this.taskTF.mouseEnabled = false;
         }
         return Math.round(this.linkBtn.y + this.linkBtn.height - PIXEL_PADDING * 2);
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

      public function get data() : BattleResultsQuestVO {
         return this._data;
      }

      public function set data(param1:BattleResultsQuestVO) : void {
         this._data = param1;
      }

      private function linkBtnHandler(param1:ButtonEvent) : void {
         App.toolTipMgr.hide();
         dispatchEvent(new QuestEvent(QuestEvent.SELECT_QUEST,this.data.questInfo.questID));
      }
   }

}