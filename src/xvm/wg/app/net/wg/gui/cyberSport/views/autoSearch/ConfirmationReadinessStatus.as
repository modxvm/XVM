package net.wg.gui.cyberSport.views.autoSearch
{
   import flash.text.TextField;
   import flash.events.Event;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;


   public class ConfirmationReadinessStatus extends StateViewBase
   {
          
      public function ConfirmationReadinessStatus() {
         super();
         currentState = CYBER_SPORT_ALIASES.AUTO_SEARCH_CONFIRMATION_STATE;
         this.headerField.text = CYBERSPORT.WINDOW_AUTOSEARCH_CONFIRMATION_HEADERTEXT;
         mainField.text = CYBERSPORT.WINDOW_AUTOSEARCH_CONFIRMATION_MAINTEXT;
         this.ctxText.text = CYBERSPORT.WINDOW_AUTOSEARCH_CONFIRMATION_CTXMESSAGE;
         submitButton.label = CYBERSPORT.WINDOW_AUTOSEARCH_CONFIRMATION_SUBMITLLBL;
         cancelButton.label = CYBERSPORT.WINDOW_AUTOSEARCH_CONFIRMATION_CANCELLBL;
         this.countDownSec.text = CYBERSPORT.WINDOW_AUTOSEARCH_CONFIRMATION_CTXSECONDS;
         this.countDown.mouseEnabled = this.countDownSec.mouseEnabled = false;
         this.headerField.mouseEnabled = this.ctxText.mouseEnabled = false;
      }

      public var headerField:TextField;

      public var ctxText:TextField;

      public var countDown:TextField;

      public var countDownSec:TextField;

      override protected function updateView() : void {
         _time = model.countDownSeconds;
         this.contextMessage(String(_time));
         startTimer();
      }

      override protected function onTimer() : void {
         _time--;
         if(_time > 0)
         {
            this.contextMessage(String(_time));
            startTimer();
         }
      }

      override protected function contextMessage(param1:String) : void {
         this.countDown.text = param1;
         dispatchEvent(new Event(UPDATE_TIMER,true));
      }
   }

}