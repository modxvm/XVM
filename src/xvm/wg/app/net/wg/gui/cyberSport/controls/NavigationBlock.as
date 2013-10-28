package net.wg.gui.cyberSport.controls
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.cyberSport.vo.NavigationBlockVO;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;


   public class NavigationBlock extends UIComponent
   {
          
      public function NavigationBlock() {
         super();
      }

      public var previousTF:TextField;

      public var nextTF:TextField;

      public var previousButton:ButtonDnmIcon;

      public var nextButton:ButtonDnmIcon;

      public function setup(param1:NavigationBlockVO) : void {
         this.previousTF.visible = this.previousButton.visible = param1.previousVisible;
         this.nextTF.visible = this.nextButton.visible = param1.nextVisible;
         this.previousButton.enabled = param1.previousEnabled;
         this.nextButton.enabled = param1.nextEnabled;
      }

      public function setInCoolDown(param1:Boolean) : void {
         if(this.previousButton)
         {
            this.previousButton.enabled = !param1;
         }
         if(this.nextButton)
         {
            this.nextButton.enabled = !param1;
         }
      }

      override protected function configUI() : void {
         super.configUI();
         this.previousTF.text = CYBERSPORT.WINDOW_UNITLISTVIEW_RENDERER_PREVIOUS;
         this.nextTF.text = CYBERSPORT.WINDOW_UNITLISTVIEW_RENDERER_NEXT;
         this.previousButton.addEventListener(ButtonEvent.CLICK,this.onPreviousClick);
         this.nextButton.addEventListener(ButtonEvent.CLICK,this.onNextClick);
      }

      private function onNextClick(param1:ButtonEvent) : void {
         param1.stopImmediatePropagation();
         dispatchEvent(new CSComponentEvent(CSComponentEvent.LOAD_NEXT_REQUEST));
      }

      private function onPreviousClick(param1:ButtonEvent) : void {
         param1.stopImmediatePropagation();
         dispatchEvent(new CSComponentEvent(CSComponentEvent.LOAD_PREVIOUS_REQUEST));
      }

      override public function dispose() : void {
         this.previousButton.removeEventListener(ButtonEvent.CLICK,this.onPreviousClick);
         this.nextButton.removeEventListener(ButtonEvent.CLICK,this.onNextClick);
         this.previousButton.dispose();
         this.nextButton.dispose();
         super.dispose();
      }
   }

}