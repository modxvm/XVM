package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.Event;


   public class QuestAwardsBlock extends UIComponent
   {
          
      public function QuestAwardsBlock() {
         super();
      }

      private static const INVALIDATE_MASK_WIDTH:String = "invMaskWidth";

      private static const TEXT_TOP:int = 4;

      private static const RIGHT_PADDING:int = 40;

      public var awardTF:TextField;

      public var awardDescrTF:TextField;

      public var flagBottom:MovieClip;

      public var flagBody:MovieClip;

      public var maskMC:MovieClip;

      public var bobyBg:MovieClip;

      private var _awardsStr:String = "";

      private var _maskWidth:Number = NaN;

      override public function dispose() : void {
         this.awardTF = null;
         this.awardDescrTF = null;
         this.flagBottom = null;
         this.flagBody = null;
         this.maskMC = null;
         super.dispose();
      }

      override protected function configUI() : void {
         super.configUI();
         this.awardTF.text = QUESTS.QUESTS_TABS_AWARD_TEXT;
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }

      public function setAwards(param1:String) : void {
         this._awardsStr = param1;
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
                  this.flagBottom.width = this._maskWidth + 1;
               }
               this.awardDescrTF.width = this._maskWidth - this.awardDescrTF.x - RIGHT_PADDING;
            }
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.awardDescrTF.htmlText = this._awardsStr;
            if(this._awardsStr)
            {
               _loc2_ = 10;
               this.awardTF.y = TEXT_TOP + _loc2_;
               this.awardDescrTF.y = TEXT_TOP + _loc2_ + 1;
               this.maskMC.height = this.awardDescrTF.y + Math.min(this.awardDescrTF.textHeight,this.awardDescrTF.height) + _loc2_ + TEXT_TOP * 2;
               if(this.flagBottom)
               {
                  this.flagBottom.y = this.maskMC.height + 1;
               }
               if(this.bobyBg)
               {
                  this.bobyBg.height = this.maskMC.height + 20;
               }
               _loc1_ = this.maskMC.height;
            }
            else
            {
               _loc1_ = 0;
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