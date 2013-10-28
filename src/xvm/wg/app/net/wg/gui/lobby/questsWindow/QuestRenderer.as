package net.wg.gui.lobby.questsWindow
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.TextFieldShort;
   import flash.events.MouseEvent;
   import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ComponentEvent;
   import net.wg.data.constants.QuestsStates;


   public class QuestRenderer extends SoundListItemRenderer
   {
          
      public function QuestRenderer() {
         super();
         this.newIndicator.visible = false;
         this.indicatorIGR.visible = false;
         this.counter.visible = false;
         this.statusMC.visible = false;
         this.progressIndicator.visible = false;
      }

      private static const DEF_COUNTER_Y:int = 27;

      private static const COMPLEX_COUNTER_Y:int = 18;

      private static const NOT_AVAILABLE_COLOR:int = 6381142;

      private static const DONE_COLOR:int = 7785801;

      public var newIndicator:MovieClip;

      public var indicatorIGR:MovieClip;

      public var counter:MovieClip;

      public var statusMC:MovieClip;

      public var lockUpMC:MovieClip;

      public var lockDownMC:MovieClip;

      public var progressIndicator:ProgressQuestIndicator;

      public var taskTF:TextField;

      public var descrTF:TextFieldShort;

      public var timerTF:TextField;

      public var hitMc:MovieClip;

      public var hitTooltipMc:MovieClip;

      private var _statusTooltip:String = "";

      private var wasAnimated:Boolean = false;

      override protected function configUI() : void {
         super.configUI();
         this.mouseChildren = true;
         this.mouseEnabled = true;
         this.hitTooltipMc.addEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.hitTooltipMc.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.hitTooltipMc.addEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
         this.counter.addEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.counter.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.counter.addEventListener(MouseEvent.ROLL_OVER,this.showCounterTooltip);
         this.indicatorIGR.addEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.indicatorIGR.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.indicatorIGR.addEventListener(MouseEvent.ROLL_OVER,this.showIGRTooltip);
         this.newIndicator.addEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.newIndicator.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.newIndicator.addEventListener(MouseEvent.ROLL_OVER,this.showNewTooltip);
         this.lockUpMC.addEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.lockUpMC.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.lockUpMC.addEventListener(MouseEvent.ROLL_OVER,this.showLockTooltip);
         this.lockDownMC.addEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.lockDownMC.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.lockDownMC.addEventListener(MouseEvent.ROLL_OVER,this.showLockTooltip);
         this.statusMC.addEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.statusMC.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.statusMC.addEventListener(MouseEvent.ROLL_OVER,this.showStatusTooltip);
         this.hitArea = this.hitMc;
         this.newIndicator.hitArea = this.newIndicator.hitMC;
         this.hitTooltipMc.buttonMode = true;
         this.buttonMode = true;
         this.newIndicator.mouseChildren = false;
      }

      override public function dispose() : void {
         this.hitTooltipMc.removeEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.hitTooltipMc.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.hitTooltipMc.removeEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
         this.counter.removeEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.counter.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.counter.removeEventListener(MouseEvent.ROLL_OVER,this.showCounterTooltip);
         this.indicatorIGR.removeEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.indicatorIGR.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.indicatorIGR.removeEventListener(MouseEvent.ROLL_OVER,this.showIGRTooltip);
         this.newIndicator.removeEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.newIndicator.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.newIndicator.removeEventListener(MouseEvent.ROLL_OVER,this.showNewTooltip);
         this.lockUpMC.removeEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.lockUpMC.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.lockUpMC.removeEventListener(MouseEvent.ROLL_OVER,this.showLockTooltip);
         this.lockDownMC.removeEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.lockDownMC.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.lockDownMC.removeEventListener(MouseEvent.ROLL_OVER,this.showLockTooltip);
         this.statusMC.removeEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.statusMC.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.statusMC.removeEventListener(MouseEvent.ROLL_OVER,this.showStatusTooltip);
         this.progressIndicator.dispose();
         super.dispose();
      }

      override public function get enabled() : Boolean {
         return super.enabled;
      }

      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         mouseChildren = true;
      }

      override public function setData(param1:Object) : void {
         this.data = param1;
         invalidateData();
      }

      override protected function draw() : void {
         var _loc1_:QuestRendererVO = null;
         if(isInvalid(InvalidationType.STATE))
         {
            if(_newFrame)
            {
               gotoAndPlay(_newFrame);
               _newFrame = null;
            }
            if((focusIndicator) && (_newFocusIndicatorFrame))
            {
               focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
               _newFocusIndicatorFrame = null;
            }
            dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
            if(data)
            {
               _loc1_ = QuestRendererVO(data);
               this.checkData(_loc1_);
            }
         }
         if(isInvalid(InvalidationType.DATA))
         {
            if(data)
            {
               _loc1_ = QuestRendererVO(data);
               this.checkData(_loc1_);
               this.checkNew(_loc1_);
               this.visible = true;
            }
            else
            {
               this.visible = false;
            }
            this.wasAnimated = true;
         }
         this.mouseChildren = true;
         this.mouseEnabled = true;
         this.newIndicator.mouseChildren = false;
      }

      private function checkData(param1:QuestRendererVO) : void {
         this.setTexts(param1);
         this.checkStatus(param1);
         this.checkCounter(param1);
         this.checkProgress(param1);
         this.checkLock(param1);
         this.checkIGR(param1);
      }

      private function checkLock(param1:QuestRendererVO) : void {
         this.lockUpMC.visible = param1.isLocked;
         this.lockDownMC.visible = param1.isLock;
      }

      public function hideNew() : void {
         this.newIndicator.gotoAndStop("pause");
         this.newIndicator.newLabel.gotoAndPlay("hide");
      }

      private function setTexts(param1:QuestRendererVO) : void {
         this.taskTF.text = param1.taskType;
         this.descrTF.label = param1.description;
         this.timerTF.htmlText = param1.timerDescr;
      }

      private function checkProgress(param1:QuestRendererVO) : void {
         if((param1.progrBarType) && !param1.status)
         {
            this.progressIndicator.visible = true;
            this.progressIndicator.setValues(param1.progrBarType,param1.currentProgrVal,param1.maxProgrVal);
            this.progressIndicator.setTooltip(param1.progrTooltip);
         }
         else
         {
            this.progressIndicator.visible = false;
         }
         if((this.counter.visible) && (this.progressIndicator.visible))
         {
            this.counter.y = COMPLEX_COUNTER_Y;
         }
      }

      private function checkCounter(param1:QuestRendererVO) : void {
         if(param1.tasksCount >= 0 && !param1.status)
         {
            this.counter.visible = true;
            this.counter.textField.text = param1.tasksCount.toString();
            this.counter.y = DEF_COUNTER_Y;
         }
         else
         {
            this.counter.visible = false;
         }
      }

      private function checkIGR(param1:QuestRendererVO) : void {
         this.indicatorIGR.visible = param1.IGR;
         this.indicatorIGR.x = this.taskTF.x + this.taskTF.textWidth + 5;
      }

      private function checkNew(param1:QuestRendererVO) : void {
         if(param1.isNew)
         {
            this.newIndicator.newLabel.gotoAndStop("show");
         }
         this.newIndicator.visible = param1.isNew;
         if((param1.isNew) && !this.wasAnimated)
         {
            this.newIndicator.gotoAndPlay("shine");
         }
         else
         {
            this.newIndicator.gotoAndStop("pause");
         }
      }

      private function checkStatus(param1:QuestRendererVO) : void {
         this.descrTF.textColor = 6644049;
         if(param1.status == QuestsStates.NOT_AVAILABLE)
         {
            this.statusMC.visible = true;
            this.statusMC.gotoAndStop(QuestsStates.NOT_AVAILABLE);
            this.statusMC.textField.text = QUESTS.QUESTS_STATUS_NOTAVAILABLE;
            TextField(this.statusMC.textField).textColor = NOT_AVAILABLE_COLOR;
            this._statusTooltip = TOOLTIPS.QUESTS_STATUS_NOTREADY;
         }
         else
         {
            if(param1.status == QuestsStates.DONE)
            {
               this.statusMC.visible = true;
               this.statusMC.gotoAndStop(QuestsStates.DONE);
               this.statusMC.textField.text = QUESTS.QUESTS_STATUS_DONE;
               TextField(this.statusMC.textField).textColor = DONE_COLOR;
               this._statusTooltip = TOOLTIPS.QUESTS_STATUS_DONE;
            }
            else
            {
               this._statusTooltip = "";
               this.statusMC.visible = false;
               this.descrTF.textColor = 12104084;
            }
         }
      }

      private function showNewTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.show(TOOLTIPS.QUESTS_NEWLABEL_TASK);
      }

      private function showLockTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.show(TOOLTIPS.QUESTS_COMPLEXTASK_LABEL);
      }

      private function showIGRTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.show(TOOLTIPS.QUESTS_IGR);
      }

      private function hideTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private function showTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.show(TOOLTIPS.QUESTS_RENDERER_LABEL);
      }

      private function showCounterTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.show(TOOLTIPS.QUESTS_COUNTER_LABEL);
      }

      private function showStatusTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.show(this._statusTooltip);
      }
   }

}