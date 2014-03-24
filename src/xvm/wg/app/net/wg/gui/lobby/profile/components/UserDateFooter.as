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
         var _loc2_:String = param1.registrationDate;
         if(_loc2_.lastIndexOf(".") != _loc2_.length-1)
         {
            _loc2_ = _loc2_ + ".";
         }
         var _loc3_:* = _loc2_ + " ";
         var _loc4_:String = param1.lastBattleDate;
         if(_loc4_ != Values.EMPTY_STR)
         {
            if(_loc4_.lastIndexOf(".") != _loc4_.length-1)
            {
               _loc4_ = _loc4_ + ".";
            }
         }
         _loc3_ = _loc3_ + _loc4_;
         this._textDates = _loc3_;
         invalidateData();
      }
   }

}