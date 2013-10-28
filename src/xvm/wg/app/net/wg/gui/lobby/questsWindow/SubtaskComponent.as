package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButton;
   import flash.display.MovieClip;
   import net.wg.gui.lobby.questsWindow.data.SubtaskVO;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.MouseEvent;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.Event;
   import net.wg.data.constants.QuestsStates;
   import net.wg.gui.events.QuestEvent;


   public class SubtaskComponent extends UIComponent
   {
          
      public function SubtaskComponent() {
         super();
      }

      private static const BOTTOM_PADDING:int = 20;

      private static const LINKBTN_PADDING:int = 10;

      public var typeTF:TextField;

      public var taskTF:TextField;

      public var linkBtn:SoundButton;

      public var statusMC:MovieClip;

      public var counter:MovieClip;

      public var progressIndicator:ProgressQuestIndicator;

      public var lineMC:MovieClip;

      private var _data:SubtaskVO = null;

      public var disableBtnHitArea:MovieClip;

      private var _statusTooltip:String = "";

      override protected function configUI() : void {
         super.configUI();
         this.statusMC.visible = false;
         this.progressIndicator.visible = false;
         this.linkBtn.visible = true;
         this.linkBtn.focusable = false;
         this.typeTF.mouseEnabled = false;
         this.taskTF.mouseEnabled = false;
         this.disableBtnHitArea.visible = false;
         this.linkBtn.addEventListener(ButtonEvent.CLICK,this.linkBtnHandler);
         this.linkBtn.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.linkBtn.addEventListener(MouseEvent.ROLL_OVER,this.showLinkBtnTooltip);
         this.disableBtnHitArea.addEventListener(ButtonEvent.CLICK,this.hideTooltip);
         this.disableBtnHitArea.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.disableBtnHitArea.addEventListener(MouseEvent.ROLL_OVER,this.showDisableLinkBtnTooltip);
         this.counter.addEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.counter.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.counter.addEventListener(MouseEvent.ROLL_OVER,this.showCounterTooltip);
         this.statusMC.addEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.statusMC.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.statusMC.addEventListener(MouseEvent.ROLL_OVER,this.showStatusTooltip);
      }

      private function showStatusTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.show(this._statusTooltip);
      }

      private function hideTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private function showLinkBtnTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.show(TOOLTIPS.QUESTS_LINKBTN_TASK);
      }

      public function setData(param1:Object) : void {
         this.data = param1?new SubtaskVO(param1):null;
         invalidateData();
      }

      public function disableLinkBtn(param1:Boolean) : void {
         this.linkBtn.enabled = param1;
         this.disableBtnHitArea.visible = !param1;
      }

      override public function dispose() : void {
         this.linkBtn.removeEventListener(ButtonEvent.CLICK,this.linkBtnHandler);
         this.linkBtn.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.linkBtn.removeEventListener(MouseEvent.ROLL_OVER,this.showLinkBtnTooltip);
         this.disableBtnHitArea.removeEventListener(ButtonEvent.CLICK,this.hideTooltip);
         this.disableBtnHitArea.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.disableBtnHitArea.removeEventListener(MouseEvent.ROLL_OVER,this.showDisableLinkBtnTooltip);
         this.counter.removeEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.counter.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.counter.removeEventListener(MouseEvent.ROLL_OVER,this.showCounterTooltip);
         this.statusMC.removeEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.statusMC.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.statusMC.removeEventListener(MouseEvent.ROLL_OVER,this.showStatusTooltip);
         this.typeTF = null;
         this.taskTF = null;
         this.linkBtn.dispose();
         this.linkBtn = null;
         this.statusMC = null;
         this.lineMC = null;
         this.progressIndicator.dispose();
         this.progressIndicator = null;
         this._data = null;
         super.dispose();
      }

      private function showCounterTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.show(TOOLTIPS.QUESTS_COUNTER_LABEL);
      }

      override protected function draw() : void {
         var _loc1_:* = NaN;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this.data)
            {
               this.visible = true;
               this.typeTF.text = this.data.title;
               this.taskTF.text = this.data.questInfo.description;
               this.disableBtnHitArea.y = this.linkBtn.y = (this.taskTF.text?this.taskTF.textHeight + this.taskTF.y - this.linkBtn.height:this.taskTF.y) + 2;
               this.disableBtnHitArea.x = this.linkBtn.x = this.taskTF.text?this.taskTF.x + this.taskTF.getLineMetrics(this.taskTF.numLines-1).width + LINKBTN_PADDING:this.taskTF.x;
               this.linkBtn.validateNow();
               this.checkStatus();
               this.checkCounter();
               this.checkProgressBar();
               this.lineMC.y = this.linkBtn.y + this.linkBtn.height + BOTTOM_PADDING;
               _loc1_ = Math.round(this.lineMC.y + this.lineMC.height);
               setSize(this.width,_loc1_);
               dispatchEvent(new Event(Event.RESIZE));
            }
            else
            {
               this.visible = false;
            }
         }
      }

      private function checkProgressBar() : void {
         if((this.data.questInfo.progrBarType) && !this.data.questInfo.status)
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
         if(this.data.questInfo.tasksCount >= 0 && !this.data.questInfo.status)
         {
            this.counter.visible = true;
            this.counter.textField.text = this.data.questInfo.tasksCount.toString();
         }
         else
         {
            this.counter.visible = false;
         }
      }

      private function checkStatus() : void {
         this.taskTF.textColor = 6644049;
         if(this.data.questInfo.status == QuestsStates.NOT_AVAILABLE)
         {
            this.statusMC.visible = true;
            this.statusMC.gotoAndStop(QuestsStates.NOT_AVAILABLE);
            this.statusMC.textField.text = QUESTS.QUESTS_STATUS_NOTAVAILABLE;
            TextField(this.statusMC.textField).textColor = 6381142;
            this._statusTooltip = TOOLTIPS.QUESTS_STATUS_NOTREADY;
         }
         else
         {
            if(this.data.questInfo.status == QuestsStates.DONE)
            {
               this.statusMC.visible = true;
               this.statusMC.gotoAndStop(QuestsStates.DONE);
               this.statusMC.textField.text = QUESTS.QUESTS_STATUS_DONE;
               TextField(this.statusMC.textField).textColor = 7785801;
               this._statusTooltip = TOOLTIPS.QUESTS_STATUS_DONE;
            }
            else
            {
               this.statusMC.visible = false;
               this.taskTF.textColor = 12104084;
               this._statusTooltip = "";
            }
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

      private function showDisableLinkBtnTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.show(TOOLTIPS.QUESTS_DISABLELINKBTN_TASK);
      }
   }

}