package net.wg.gui.lobby.fortifications.windows.impl
{
   import net.wg.infrastructure.base.meta.impl.FortCreationCongratulationsWindowMeta;
   import net.wg.infrastructure.base.meta.IFortCreationCongratulationsWindowMeta;
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.text.TextField;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import flash.display.InteractiveObject;
   import scaleform.clik.events.ButtonEvent;


   public class FortCreationCongratulationsWindow extends FortCreationCongratulationsWindowMeta implements IFortCreationCongratulationsWindowMeta
   {
          
      public function FortCreationCongratulationsWindow() {
         super();
         isModal = true;
         isCentered = true;
         canDrag = false;
      }

      public var applyButton:SoundButtonEx;

      public var body:TextField;

      public var title:TextField;

      private var textTitle:String = "";

      private var textBody:String = "";

      public function as_setTitle(param1:String) : void {
         this.textTitle = param1;
         invalidate(InvalidationType.DATA);
      }

      public function as_setText(param1:String) : void {
         this.textBody = param1;
         invalidate(InvalidationType.DATA);
      }

      public function as_setWindowTitle(param1:String) : void {
         window.title = param1;
      }

      public function as_setButtonLbl(param1:String) : void {
         this.applyButton.label = param1;
         invalidate(InvalidationType.DATA);
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && !(this.textTitle == Values.EMPTY_STR) && !(this.textBody == Values.EMPTY_STR))
         {
            this.title.htmlText = this.textTitle;
            this.body.htmlText = this.textBody;
         }
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         window.useBottomBtns = true;
      }

      override protected function onInitModalFocus(param1:InteractiveObject) : void {
         super.onInitModalFocus(param1);
         setFocus(this.applyButton);
      }

      override protected function onDispose() : void {
         this.applyButton.addEventListener(ButtonEvent.CLICK,this.buttonClickHandler);
         this.applyButton.dispose();
         this.applyButton = null;
         super.onDispose();
      }

      override protected function configUI() : void {
         super.configUI();
         this.applyButton.addEventListener(ButtonEvent.CLICK,this.buttonClickHandler);
      }

      private function buttonClickHandler(param1:ButtonEvent) : void {
         onWindowCloseS();
      }
   }

}