package net.wg.gui.cyberSport.views.autoSearch
{
   import flash.text.TextField;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;


   public class ErrorState extends StateViewBase
   {
          
      public function ErrorState() {
         super();
         currentState = CYBER_SPORT_ALIASES.AUTO_SEARCH_ERROR_STATE;
         this.headerField.text = CYBERSPORT.WINDOW_AUTOSEARCH_ERRORSTATE_HEADERTEXT;
         mainField.text = CYBERSPORT.WINDOW_AUTOSEARCH_ERRORSTATE_MAINTEXT;
         this.ctxText.text = CYBERSPORT.WINDOW_AUTOSEARCH_ERRORSTATE_CTXMESSAGE;
         submitButton.label = CYBERSPORT.WINDOW_AUTOSEARCH_ERRORSTATE_SUBMITLLBL;
         cancelButton.label = CYBERSPORT.WINDOW_AUTOSEARCH_ERRORSTATE_CANCELLBL;
         this.headerField.mouseEnabled = this.ctxText.mouseEnabled = false;
      }

      public var headerField:TextField;

      public var ctxText:TextField;
   }

}