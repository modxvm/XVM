package net.wg.gui.lobby.dialogs
{
   import net.wg.infrastructure.base.meta.impl.FreeXPInfoWindowMeta;
   import net.wg.infrastructure.base.meta.IFreeXPInfoWindowMeta;
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.CheckBox;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.FocusEvent;
   import net.wg.gui.components.windows.Window;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.events.InputEvent;
   import flash.ui.Keyboard;
   import scaleform.clik.constants.InputValue;


   public class FreeXPInfoWindow extends FreeXPInfoWindowMeta implements IFreeXPInfoWindowMeta
   {
          
      public function FreeXPInfoWindow() {
         super();
         canClose = false;
         isModal = true;
         isCentered = true;
         canDrag = false;
         this.updateElements(false);
         this.checkBoxConfirm.selected = false;
         this.textInfo.mouseEnabled = false;
         this.titleText.mouseEnabled = false;
         this.textBottom.mouseEnabled = false;
         scaleX = scaleY = 1;
      }

      private static const INFO_STATE:String = "infoState";

      private static const CONFIRM_STATE:String = "confirmState";

      private static const TEXT_PADDING:int = 5;

      public var submitButton:SoundButtonEx;

      public var textInfo:TextField;

      public var dottedLine:MovieClip;

      public var cancelButton:SoundButtonEx;

      public var checkBoxConfirm:CheckBox;

      private var currentState:String = "infoState";

      private var latestFocus:UIComponent;

      public var titleText:TextField;

      public var textBottom:TextField;

      private function updateElements(param1:Boolean=false) : void {
         this.checkBoxConfirm.visible = param1;
         this.dottedLine.visible = param1;
         this.cancelButton.visible = param1;
         this.titleText.visible = !param1;
         this.textBottom.visible = !param1;
      }

      public function as_setCheckBoxLbl(param1:String) : void {
         this.checkBoxConfirm.label = param1;
      }

      public function as_setState(param1:String) : void {
         this.currentState = param1;
         if(param1 == CONFIRM_STATE)
         {
            this.updateElements(true);
            this.submitButton.enabled = false;
         }
         else
         {
            this.updateElements(false);
            this.submitButton.x = this.cancelButton.x;
         }
      }

      public function as_setSubmitLabel(param1:String) : void {
         if((this.submitButton) && !(this.submitButton.label == param1))
         {
            this.submitButton.label = param1;
         }
      }

      public function as_setCancelLabel(param1:String) : void {
         this.cancelButton.label = param1;
      }

      public function as_setTitle(param1:String) : void {
         window.title = param1;
      }

      public function as_setText(param1:Object) : void {
         this.textInfo.htmlText = param1["body"];
         this.textInfo.height = this.textInfo.textHeight + TEXT_PADDING;
         this.textInfo.scaleX = 1;
         this.textInfo.scaleY = 1;
         if(this.currentState == CONFIRM_STATE)
         {
            this.textInfo.y = 195;
            this.dottedLine.y = Math.round(this.textInfo.y + this.textInfo.height + 12);
            this.checkBoxConfirm.y = this.dottedLine.y + 14;
            this.submitButton.y = Math.round(this.checkBoxConfirm.y + this.checkBoxConfirm.height + 18);
            this.cancelButton.y = this.submitButton.y;
            this.checkBoxConfirm.addEventListener(ButtonEvent.CLICK,this.onClickCheckBox);
            this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onClickCancelButton);
            this.cancelButton.addEventListener(FocusEvent.FOCUS_IN,this.cancelButton_focusInHandler);
            this.checkBoxConfirm.addEventListener(FocusEvent.FOCUS_IN,this.cancelButton_focusInHandler);
         }
         else
         {
            if(this.currentState == INFO_STATE)
            {
               this.titleText.text = param1["title"];
               this.textBottom.y = this.textInfo.y + this.textInfo.height;
               this.textBottom.text = param1["bottom"];
               this.submitButton.y = Math.round(this.textBottom.y + this.textBottom.height - 8);
            }
         }
         this.submitButton.addEventListener(FocusEvent.FOCUS_IN,this.cancelButton_focusInHandler);
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         Window(window).visible = false;
         showWindowBg = true;
         window.useBottomBtns = true;
         this.submitButton.addEventListener(ButtonEvent.CLICK,this.onClickSubmitButton);
      }

      override protected function configUI() : void {
         super.configUI();
         window.getConstraints().scaleMode = ConstrainMode.COUNTER_SCALE;
         App.utils.scheduler.envokeInNextFrame(this.updateWindowSize);
      }

      private function updateWindowSize() : void {
         var _loc1_:int = this.submitButton.y + this.submitButton.height;
         _loc1_ = _loc1_ + window.contentPadding.top + window.contentPadding.bottom;
         window.updateSize(window.width,_loc1_,false);
         window.validateNow();
         Window(window).visible = true;
         Window(window).addEventListener(FocusEvent.FOCUS_IN,this.focusInHandler);
         if(this.currentState == CONFIRM_STATE)
         {
            App.utils.scheduler.envokeInNextFrame(this.setFocusToCheckBox);
         }
         else
         {
            App.utils.scheduler.envokeInNextFrame(this.setFocusToSubmitButton);
         }
      }

      private function focusInHandler(param1:FocusEvent) : void {
         if(this.currentState == CONFIRM_STATE)
         {
            if(this.latestFocus == null)
            {
               App.utils.scheduler.envokeInNextFrame(this.setFocusToCheckBox);
            }
            else
            {
               App.utils.scheduler.envokeInNextFrame(this.updateLatestFocus);
            }
         }
         else
         {
            App.utils.scheduler.envokeInNextFrame(this.setFocusToSubmitButton);
         }
      }

      private function updateLatestFocus() : void {
         App.utils.focusHandler.setFocus(this.latestFocus);
      }

      private function setFocusToSubmitButton() : void {
         this.latestFocus = this.submitButton;
         App.utils.focusHandler.setFocus(this.submitButton);
      }

      private function setFocusToCheckBox() : void {
         this.latestFocus = this.checkBoxConfirm;
         App.utils.focusHandler.setFocus(this.checkBoxConfirm);
      }

      override protected function onDispose() : void {
         App.utils.scheduler.cancelTask(this.updateWindowSize);
         App.utils.scheduler.cancelTask(this.setFocusToCheckBox);
         App.utils.scheduler.cancelTask(this.setFocusToSubmitButton);
         App.utils.scheduler.cancelTask(this.updateLatestFocus);
         this.cancelButton.removeEventListener(FocusEvent.FOCUS_IN,this.cancelButton_focusInHandler);
         this.checkBoxConfirm.removeEventListener(FocusEvent.FOCUS_IN,this.cancelButton_focusInHandler);
         this.submitButton.removeEventListener(FocusEvent.FOCUS_IN,this.cancelButton_focusInHandler);
         Window(window).removeEventListener(FocusEvent.FOCUS_IN,this.focusInHandler);
         this.submitButton.removeEventListener(ButtonEvent.CLICK,this.onClickSubmitButton);
         this.checkBoxConfirm.removeEventListener(ButtonEvent.CLICK,this.onClickCheckBox);
         this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onClickCancelButton);
         this.cancelButton.dispose();
         this.checkBoxConfirm.dispose();
         this.submitButton.dispose();
         this.latestFocus = null;
         super.onDispose();
      }

      private function onClickSubmitButton(param1:ButtonEvent) : void {
         onSubmitButtonS();
      }

      private function onClickCheckBox(param1:ButtonEvent) : void {
         if(this.currentState == CONFIRM_STATE)
         {
            this.submitButton.enabled = this.checkBoxConfirm.selected;
            if(this.submitButton.enabled)
            {
               this.latestFocus = this.submitButton;
               App.utils.scheduler.envokeInNextFrame(this.updateLatestFocus);
            }
         }
      }

      private function onClickCancelButton(param1:ButtonEvent) : void {
         onCancelButtonS();
      }

      override public function handleInput(param1:InputEvent) : void {
         if(param1.details.code == Keyboard.ESCAPE && param1.details.value == InputValue.KEY_DOWN)
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            onCancelButtonS();
            return;
         }
         super.handleInput(param1);
      }

      private function cancelButton_focusInHandler(param1:FocusEvent) : void {
         this.latestFocus = UIComponent(param1.target);
      }
   }

}