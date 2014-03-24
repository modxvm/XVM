package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.lobby.questsWindow.components.QuestsCounter;
   import flash.display.MovieClip;
   import net.wg.gui.lobby.questsWindow.components.ProgressQuestIndicator;
   import net.wg.gui.components.advanced.ContentTabBar;
   import net.wg.gui.lobby.questsWindow.data.HeaderDataVO;
   import scaleform.clik.data.DataProvider;
   import net.wg.data.constants.QuestsStates;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.Event;


   public class HeaderBlock extends UIComponent
   {
          
      public function HeaderBlock() {
         super();
         this.counter.visible = false;
         this.progressIndicator.visible = false;
      }

      private static const VERTICAL_PADDING:int = 20;

      private static const MIDDLE_PADDING:int = 12;

      private static const TEXT_MARGIN:int = 10;

      private static const COUNTER_NO_DATA:int = -1;

      private static const COUNTER_X:int = 347;

      private static const STATUS_MARGIN:int = 18;

      public static const CONTENT_TABS_PADDING:int = 30;

      public static const LOWER_TABS_PADDING:int = 45;

      private static const TIME_TF_PADDING:int = 6;

      private static const COUNTER_PADDING:int = 5;

      public var lableTF:TextField;

      public var timeTF:TextField;

      public var counter:QuestsCounter;

      public var bg:MovieClip;

      public var maskMC:MovieClip;

      public var progressIndicator:ProgressQuestIndicator;

      public var contentTabs:ContentTabBar;

      private var headerData:HeaderDataVO = null;

      private var _noProgress:Boolean = true;

      public var statusMC:MovieClip;

      public function setData(param1:HeaderDataVO) : void {
         this.headerData = param1;
         invalidateData();
      }

      override protected function configUI() : void {
         super.configUI();
         this.maskMC.height = 0;
         this.bg.mouseEnabled = false;
         this.bg.mouseChildren = false;
         this.hitArea = this.maskMC;
         this.contentTabs.dataProvider = new DataProvider([
            {
               "label":QUESTS.QUESTS_CONDITIONS,
               "data":QuestsStates.CONDITIONS,
               "tooltip":""
            }
         ,
            {
               "label":QUESTS.QUESTS_REQUIREMENTS,
               "data":QuestsStates.REQUIREMENTS,
               "tooltip":""
            }
         ]);
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

      override protected function onDispose() : void {
         this.progressIndicator.dispose();
         this.counter.dispose();
         if(this.headerData)
         {
            this.headerData.dispose();
            this.headerData = null;
         }
         this.contentTabs.dispose();
         this.contentTabs = null;
         this.hitArea = null;
         this.counter = null;
         this.lableTF = null;
         this.timeTF = null;
         this.statusMC = null;
         this.bg = null;
         this.maskMC = null;
         this.progressIndicator = null;
         super.onDispose();
      }

      private function setTexts() : void {
         this.lableTF.htmlText = this.headerData.title;
         this.timeTF.htmlText = this.headerData.date;
      }

      private function layoutComponents() : void {
         this.lableTF.height = this.lableTF.textHeight + TEXT_MARGIN;
         this.timeTF.height = this.timeTF.textHeight + TEXT_MARGIN;
         var _loc1_:Number = this.lableTF.textHeight + this.lableTF.y;
         this.timeTF.y = Math.round(_loc1_ + MIDDLE_PADDING);
         var _loc2_:Number = this.timeTF.textHeight + this.timeTF.y;
         this.statusMC.y = Math.round(this.timeTF.text?_loc2_ + TIME_TF_PADDING:this.timeTF.y);
         var _loc3_:Number = Math.round(TextField(this.statusMC.textField).textHeight + this.statusMC.y);
         var _loc4_:* = true;
         if(this.headerData.eventType == QuestsStates.ACTION || !this.headerData.hasRequirements)
         {
            _loc4_ = false;
            this.contentTabs.selectedIndex = 0;
         }
         else
         {
            if(!this.headerData.hasConditions)
            {
               _loc4_ = false;
               this.contentTabs.selectedIndex = 1;
            }
         }
         this.contentTabs.visible = _loc4_;
         this.contentTabs.y = Math.round(_loc3_ + CONTENT_TABS_PADDING);
         this.bg.y = _loc4_?this.contentTabs.y + LOWER_TABS_PADDING:_loc3_ + VERTICAL_PADDING;
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
            this.progressIndicator.validateNow();
         }
      }

      private function checkCounter() : void {
         this.counter.textField.text = this.headerData.tasksCount.toString();
         if(this.headerData.tasksCount > COUNTER_NO_DATA && !this._noProgress)
         {
            this.counter.visible = true;
            this.progressIndicator.y = Math.round(this.counter.y + this.counter.height - COUNTER_PADDING);
         }
         else
         {
            this.counter.visible = false;
            this.progressIndicator.y = Math.round(this.counter.y + this.counter.height / 2);
         }
      }

      private function checkStatus() : void {
         this._noProgress = false;
         if(this.headerData.status == QuestsStates.NOT_AVAILABLE)
         {
            this.statusMC.gotoAndStop("notAvailable");
            this._noProgress = this.headerData.tasksCount <= 0 && this.headerData.currentProgrVal <= 0;
            this.counter.x = COUNTER_X + STATUS_MARGIN;
            this.lableTF.textColor = QuestsStates.CLR_TASK_TF_WITH_STATUS;
         }
         else
         {
            if(this.headerData.status == QuestsStates.DONE)
            {
               this.statusMC.gotoAndStop("done");
               this.counter.x = COUNTER_X + STATUS_MARGIN;
               this.lableTF.textColor = QuestsStates.CLR_TASK_TF_WITH_STATUS;
            }
            else
            {
               this.statusMC.gotoAndStop("another");
               this.lableTF.textColor = QuestsStates.CLR_TASK_TF_NORMAL;
               this.counter.x = COUNTER_X + STATUS_MARGIN;
            }
         }
         TextField(this.statusMC.textField).text = this.headerData.statusDescription;
         TextField(this.statusMC.textField).height = TextField(this.statusMC.textField).textHeight + TEXT_MARGIN;
         this.statusMC.visible = Boolean(this.headerData.statusDescription);
      }
   }

}