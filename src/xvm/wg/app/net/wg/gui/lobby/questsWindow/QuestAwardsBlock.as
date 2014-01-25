package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import net.wg.gui.lobby.questsWindow.components.ResizableContainer;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.Event;


   public class QuestAwardsBlock extends UIComponent
   {
          
      public function QuestAwardsBlock() {
         this._quests = [];
         super();
      }

      private static const INVALIDATE_MASK_WIDTH:String = "invMaskWidth";

      private static const TEXT_TOP:int = 4;

      public static const DOWN_PADDING:int = 10;

      private static const RIGHT_PADDING:int = 40;

      private static const PIXEL_PADDING:int = 1;

      public var awardTF:TextField;

      public var awardDescrTF:TextField;

      public var flagBottom:MovieClip;

      public var flagBody:MovieClip;

      public var maskMC:MovieClip;

      public var bobyBg:MovieClip;

      public var container:ResizableContainer;

      private var _awardsStr:String = "";

      private var _quests:Array;

      private var _maskWidth:Number = NaN;

      override protected function onDispose() : void {
         this.awardTF = null;
         this.awardDescrTF = null;
         this.flagBottom = null;
         this.flagBody = null;
         this.maskMC = null;
         super.onDispose();
         this.bobyBg = null;
         this.container.dispose();
         this.container = null;
         super.dispose();
      }

      override protected function configUI() : void {
         super.configUI();
         this.container.verticalPadding = -PIXEL_PADDING;
         this.container.availableWidth = this.awardDescrTF.width;
         this.awardTF.text = QUESTS.QUESTS_TABS_AWARD_TEXT;
         this.awardTF.mouseEnabled = false;
         this.awardDescrTF.mouseEnabled = false;
         this.flagBottom.mouseEnabled = false;
         this.flagBody.mouseEnabled = false;
         this.maskMC.mouseEnabled = false;
         if(this.bobyBg)
         {
            this.bobyBg.mouseEnabled = false;
         }
         if(this.flagBottom)
         {
            this.flagBottom.mouseEnabled = false;
         }
      }

      public function setAwards(param1:String) : void {
         this._awardsStr = param1;
         invalidateData();
      }

      public function setOpenedQuests(param1:Array) : void {
         this._quests = param1;
         invalidateData();
      }

      override protected function draw() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         super.draw();
         if(isInvalid(INVALIDATE_MASK_WIDTH))
         {
            if(this._maskWidth)
            {
               this.maskMC.width = this._maskWidth;
               if(this.flagBottom)
               {
                  this.flagBottom.width = this._maskWidth + PIXEL_PADDING;
               }
               if(this.container)
               {
                  this.container.availableWidth = this.awardDescrTF.width = this._maskWidth - this.awardDescrTF.x - RIGHT_PADDING;
               }
            }
         }
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = 0;
            this.container.setData(this._quests);
            this.container.validateNow();
            this.awardDescrTF.htmlText = this._awardsStr;
            if((this._awardsStr) || this._quests.length > 0)
            {
               this.awardTF.y = Math.round(TEXT_TOP + DOWN_PADDING);
               this.awardDescrTF.y = Math.round(TEXT_TOP + DOWN_PADDING);
               _loc2_ = Math.round(this.container.height);
               this.container.y = Math.round(this.awardTF.y);
               if(this._awardsStr)
               {
                  this.container.y = Math.round(this.awardDescrTF.y + this.awardDescrTF.textHeight + TEXT_TOP);
                  _loc2_ = _loc2_ + TEXT_TOP;
               }
               this.maskMC.height = Math.round(this.awardDescrTF.y + this.awardDescrTF.textHeight + _loc2_ + DOWN_PADDING);
               if(this.flagBottom)
               {
                  this.flagBottom.y = Math.round(this.maskMC.height + PIXEL_PADDING);
               }
               if(this.bobyBg)
               {
                  this.bobyBg.height = Math.round(this.maskMC.height + DOWN_PADDING * 2);
               }
               _loc1_ = Math.round(this.maskMC.height);
            }
            _height = _loc1_;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }

      public function setActualWidth(param1:Number) : void {
         this._maskWidth = param1;
         invalidate(INVALIDATE_MASK_WIDTH);
      }
   }

}