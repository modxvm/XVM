package net.wg.gui.lobby.profile.components
{
   import flash.text.TextField;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.lobby.profile.data.ProfileUserVO;
   import net.wg.data.constants.Values;


   public class UserDateFooter extends ProfileFooter
   {
          
      public function UserDateFooter() {
         super();
      }

      private var _textDates:String = "";

      public var textDates:TextField;

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.textDates.htmlText = this._textDates;
         }
      }

      override public function setUserData(param1:ProfileUserVO) : void {
         super.setUserData(param1);
         var _loc2_:* = param1.registrationDate + "  ";
         _loc2_ = _loc2_ + (param1.lastBattleDate != Values.EMPTY_STR?param1.lastBattleDate:"");
         this._textDates = _loc2_;
         invalidateData();
      }
   }

}