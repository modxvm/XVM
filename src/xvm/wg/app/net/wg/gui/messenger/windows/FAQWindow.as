package net.wg.gui.messenger.windows
{
   import net.wg.gui.messenger.meta.impl.FAQWindowMeta;
   import net.wg.gui.messenger.meta.IFAQWindowMeta;
   import net.wg.gui.components.advanced.TextAreaSimple;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.ScrollBar;
   import scaleform.clik.events.ButtonEvent;


   public class FAQWindow extends FAQWindowMeta implements IFAQWindowMeta
   {
          
      public function FAQWindow() {
         super();
         isCentered = false;
      }

      public var textArea:TextAreaSimple;

      public var closeButton:SoundButtonEx;

      public var scrollBar:ScrollBar;

      public function as_appendText(param1:String) : void {
         this.textArea.appendHtml(param1);
      }

      override protected function configUI() : void {
         super.configUI();
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.onCancelClick);
      }

      override protected function draw() : void {
         super.draw();
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         window.useBottomBtns = true;
         window.title = MESSENGER.LOBBY_FAQ_TITLE;
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onCancelClick);
      }

      private function onCancelClick(param1:ButtonEvent) : void {
         onWindowCloseS();
      }
   }

}