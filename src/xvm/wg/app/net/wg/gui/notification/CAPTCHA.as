package net.wg.gui.notification
{
   import net.wg.infrastructure.base.meta.impl.CAPTCHAMeta;
   import net.wg.infrastructure.base.meta.ICAPTCHAMeta;
   import flash.display.Sprite;
   import net.wg.gui.components.controls.TextInput;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.constants.InputValue;
   import flash.ui.Keyboard;


   public class CAPTCHA extends CAPTCHAMeta implements ICAPTCHAMeta
   {
          
      public function CAPTCHA() {
         super();
         showWindowBg = false;
         canClose = false;
         canDrag = false;
         isModal = true;
      }

      private static const INVALID_IMAGE:String = "invalidImage";

      private static const INVALID_MESSAGE:String = "invalidMessage";

      public var imageHolder:Sprite;

      public var inputField:TextInput;

      public var errorField:TextField;

      public var submitButton:SoundButtonEx;

      public var reloadButton:SoundButtonEx;

      public var closeButton:SoundButtonEx;

      private var _imageURL:String;

      private var _imageWidth:Number;

      private var _imageHeight:Number;

      private var _errorMessage:String;

      public var captuteIcon:UILoaderAlt;

      public function as_setImage(param1:String, param2:Number, param3:Number) : void {
         this._imageURL = param1;
         this._imageWidth = param2;
         this._imageHeight = param3;
         this.setInputFocus();
         invalidate(INVALID_IMAGE);
      }

      public function as_setErrorMessage(param1:String) : void {
         this._errorMessage = param1;
         this.setInputFocus();
         invalidate(INVALID_MESSAGE);
      }

      override protected function configUI() : void {
         super.configUI();
         this.submitButton.addEventListener(ButtonEvent.CLICK,this.onSubmitClick);
         this.reloadButton.addEventListener(ButtonEvent.CLICK,this.onReloadClick);
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.onCloseClick);
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(INVALID_IMAGE)) && (this._imageURL))
         {
            this.imageHolder.width = this._imageWidth;
            this.imageHolder.height = this._imageHeight;
            this.captuteIcon.source = "img://" + this._imageURL;
         }
         if(isInvalid(INVALID_MESSAGE))
         {
            this.errorField.text = this._errorMessage;
         }
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         window.getBackground().visible = false;
         window.getTitleBtn().visible = false;
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.captuteIcon.dispose();
         this.submitButton.removeEventListener(ButtonEvent.CLICK,this.onSubmitClick);
         this.reloadButton.removeEventListener(ButtonEvent.CLICK,this.onReloadClick);
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onCloseClick);
      }

      private function clearFields() : void {
         this.inputField.text = "";
         this.errorField.text = "";
      }

      private function setInputFocus() : void {
         setFocus(this.inputField);
      }

      private function onSubmitClick(param1:ButtonEvent=null) : void {
         submitS(this.inputField.text);
         this.clearFields();
      }

      private function onReloadClick(param1:ButtonEvent) : void {
         this.clearFields();
         reloadS();
      }

      private function onCloseClick(param1:ButtonEvent) : void {
         onWindowCloseS();
      }

      override public function handleInput(param1:InputEvent) : void {
         super.handleInput(param1);
         if(param1.handled)
         {
            return;
         }
         var _loc2_:Number = param1.details.code;
         if(param1.details.value == InputValue.KEY_UP)
         {
            switch(_loc2_)
            {
               case Keyboard.ENTER:
                  param1.handled = true;
                  this.onSubmitClick();
                  break;
            }
         }
      }
   }

}