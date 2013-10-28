package net.wg.gui.lobby.profile.components
{


   public class LditMarksOfMastery extends LineDescrIconText
   {
          
      public function LditMarksOfMastery() {
         super();
      }

      private var _totalCount:uint = 0;

      public function set totalCount(param1:uint) : void {
         this._totalCount = param1;
         invalidate(TEXT_INVALID);
      }

      override protected function applyText() : void {
         if(enabled)
         {
            gotoAndStop("up");
            textComponent.text = _text + "<font size=\'14\' color=\'#939188\'>" + "/" + App.utils.locale.integer(this._totalCount) + "</font>";
         }
         else
         {
            gotoAndStop("disabled");
            textComponent.text = "--";
         }
         invalidate(DESCRIPTION_TEXT_INVALID);
      }
   }

}