package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import net.wg.gui.lobby.questsWindow.data.HeaderDataVO;
   import flash.events.MouseEvent;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.Event;
   import net.wg.data.constants.QuestsStates;


   public class HeaderBlock extends UIComponent
   {
          
      public function HeaderBlock() {
         super();
         this.statusMC.visible = false;
         this.counter.visible = false;
         this.progressIndicator.visible = false;
      }

      private static const VERTICAL_PADDING:int = 20;

      private static const MIDDLE_PADDING:int = 13;

      private static const TEXT_MARGIN:int = 10;

      private static const COUNTER_NO_DATA:int = -1;

      private static const COUNTER_X:int = 307;

      private static const STATUS_MARGIN:int = 18;

      public var lableTF:TextField;

      public var timeTF:TextField;

      public var typeTF:TextField;

      public var notAvailableTF:TextField;

      public var statusMC:MovieClip;

      public var counter:MovieClip;

      public var bg:MovieClip;

      public var maskMC:MovieClip;

      public var progressIndicator:ProgressQuestIndicator;

      private var headerData:HeaderDataVO = null;

      private var _noProgress:Boolean = true;

      private var _statusTooltip:String = "";

      public function setData(param1:HeaderDataVO) : void {
         this.headerData = param1;
         invalidateData();
      }

      override protected function configUI() : void {
         super.configUI();
         this.counter.addEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.counter.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.counter.addEventListener(MouseEvent.ROLL_OVER,this.showCounterTooltip);
         this.statusMC.addEventListener(MouseEvent.CLICK,this.hideTooltip);
         this.statusMC.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.statusMC.addEventListener(MouseEvent.ROLL_OVER,this.showStatusTooltip);
         this.hitArea = this.maskMC;
      }

      private function showStatusTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.show(this._statusTooltip);
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this.headerData)
            {
               this.setTexts();
               this.checkStatus();
               this.checkCounter();
               this.checkProgress();
               this.layoutComponents();
            }
            else
            {
               setSize(this.width,0);
            }
            dispatchEvent(new Event(Event.RESIZE));
         }
      }

      override public function dispose() : void {
         if(this.counter)
         {
            this.counter.removeEventListener(MouseEvent.CLICK,this.hideTooltip);
            this.counter.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
            this.counter.removeEventListener(MouseEvent.ROLL_OVER,this.showCounterTooltip);
            this.statusMC.removeEventListener(MouseEvent.CLICK,this.hideTooltip);
            this.statusMC.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
            this.statusMC.removeEventListener(MouseEvent.ROLL_OVER,this.showStatusTooltip);
            this.counter = null;
         }
         this.lableTF = null;
         this.timeTF = null;
         this.typeTF = null;
         this.notAvailableTF = null;
         this.statusMC = null;
         this.bg = null;
         this.maskMC = null;
         if(this.progressIndicator)
         {
            this.progressIndicator.dispose();
            this.progressIndicator = null;
         }
         if(this.headerData)
         {
            this.headerData.dispose();
            this.headerData = null;
         }
         super.dispose();
      }

      private function setTexts() : void {
         this.lableTF.text = this.headerData.title;
         this.timeTF.text = this.headerData.date;
         this.typeTF.text = this.headerData.type;
         this.notAvailableTF.text = this.headerData.impDescr;
      }

      private function layoutComponents() : void {
         this.lableTF.height = this.lableTF.textHeight + TEXT_MARGIN;
         var _loc1_:Number = this.lableTF.textHeight + this.lableTF.y;
         this.timeTF.y = Math.round(_loc1_ + MIDDLE_PADDING);
         var _loc2_:Number = this.timeTF.textHeight + this.timeTF.y;
         this.typeTF.y = Math.round(_loc2_ + 2);
         this.typeTF.height = this.typeTF.textHeight + TEXT_MARGIN;
         var _loc3_:Number = this.typeTF.textHeight + this.typeTF.y;
         this.notAvailableTF.y = Math.round((Boolean(this.headerData.type)?_loc3_:_loc2_) + MIDDLE_PADDING);
         this.notAvailableTF.height = this.notAvailableTF.textHeight + TEXT_MARGIN;
         var _loc4_:Number = this.notAvailableTF.y + this.notAvailableTF.textHeight;
         this.bg.y = Math.round((Boolean(this.headerData.impDescr)?_loc4_:this.notAvailableTF.y - MIDDLE_PADDING) + VERTICAL_PADDING);
         this.maskMC.height = this.headerData.status == QuestsStates.DONE?this.bg.y:0;
         var _loc5_:Number = Math.round(this.bg.y);
         setSize(this.width,_loc5_);
      }

      private function checkProgress() : void {
         this.progressIndicator.visible = (Boolean(this.headerData.progrBarType)) && !this._noProgress;
         if(this.headerData.progrBarType)
         {
            this.progressIndicator.setValues(this.headerData.progrBarType,this.headerData.currentProgrVal,this.headerData.maxProgrVal);
            this.progressIndicator.setTooltip(this.headerData.progrTooltip);
         }
      }

      private function checkCounter() : void {
         this.counter.textField.text = this.headerData.tasksCount.toString();
         if(this.headerData.tasksCount > COUNTER_NO_DATA && !this._noProgress)
         {
            this.counter.visible = true;
            this.progressIndicator.y = this.counter.y + this.counter.height - 5;
         }
         else
         {
            this.counter.visible = false;
            this.progressIndicator.y = 30;
         }
      }

      private function checkStatus() : void {
         this._noProgress = false;
         if(this.headerData.status == QuestsStates.NOT_AVAILABLE)
         {
            this._noProgress = this.headerData.tasksCount <= 0 && this.headerData.currentProgrVal <= 0;
            this.statusMC.visible = this._noProgress;
            this.statusMC.gotoAndStop(QuestsStates.NOT_AVAILABLE);
            this._statusTooltip = TOOLTIPS.QUESTS_STATUS_NOTREADY;
            this.counter.x = this._noProgress?COUNTER_X:COUNTER_X + STATUS_MARGIN;
            this.lableTF.textColor = 6644049;
         }
         else
         {
            if(this.headerData.status == QuestsStates.DONE)
            {
               this.statusMC.visible = true;
               this.statusMC.gotoAndStop(QuestsStates.DONE);
               this._statusTooltip = TOOLTIPS.QUESTS_STATUS_DONE;
               this.counter.x = COUNTER_X;
               this.lableTF.textColor = 6644049;
            }
            else
            {
               this.statusMC.visible = false;
               this.lableTF.textColor = 12104084;
               this._statusTooltip = "";
               this.counter.x = COUNTER_X + STATUS_MARGIN;
            }
         }
      }

      private function hideTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private function showCounterTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.show(TOOLTIPS.QUESTS_COUNTER_LABEL);
      }
   }

}