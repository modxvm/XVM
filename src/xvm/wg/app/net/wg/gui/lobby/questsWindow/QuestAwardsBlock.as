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

      private static const TEXT_TOP:int = 4;

      public var awardTF:TextField;

      public var awardDescrTF:TextField;

      public var flagBottom:MovieClip;

      public var flagBody:MovieClip;

      public var maskMC:MovieClip;

      private var _awardsStr:String = "";

      override protected function configUI() : void {
         super.configUI();
         this.awardTF.text = QUESTS.QUESTS_TABS_AWARD_TEXT;
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }

      public function setAwards(param1:String) : void {
         this._awardsStr = param1;
         this.awardDescrTF.htmlText = this._awardsStr;
         invalidateData();
      }

      override protected function draw() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._awardsStr)
            {
               _loc2_ = 20;
               if(this.awardDescrTF.numLines > 1)
               {
                  _loc2_ = 10;
               }
               else
               {
                  _loc2_ = 20;
               }
               this.awardTF.y = TEXT_TOP + _loc2_;
               this.awardDescrTF.y = TEXT_TOP + _loc2_ + 1;
               _loc3_ = this.awardDescrTF.y + this.awardDescrTF.textHeight + _loc2_;
               this.maskMC.height = _loc3_ <= this.flagBody.height?_loc3_:this.flagBody.height;
               this.flagBottom.y = this.maskMC.height-1;
               _loc1_ = this.maskMC.height;
            }
            else
            {
               _loc1_ = 0;
            }
            setSize(this.width,_loc1_);
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
   }

}