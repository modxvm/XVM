package net.wg.gui.lobby.sellDialog
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.infrastructure.interfaces.IFormattedInt;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.InputValue;
   import flash.ui.Keyboard;
   import flash.events.Event;


   public class ControlQuestionComponent extends UIComponent
   {
          
      public function ControlQuestionComponent() {
         super();
      }

      public static const USER_INPUT_HANDLER:String = "userInputHandler";

      private static const PADDING_FOR_NEXT_ELEMENT:int = 10;

      private static const AUTO_UPDATE_TIMER:int = 5000;

      public var arrowBG:MovieClip;

      public var textHeader:TextField;

      public var controlQuestion:TextField;

      public var userInput:TextInput;

      public var errorMessage:TextField;

      private var _headerText:String = "";

      private var _questionText:String = "";

      private var _errorText:String = "";

      private var _controlText:String = "";

      private var _formattedControlText:String = "";

      private var creditsParseResult:IFormattedInt;

      public function get controlText() : String {
         return this._controlText;
      }

      public function set controlText(param1:String) : void {
         this._controlText = param1;
      }

      public function get formattedControlText() : String {
         return this._formattedControlText;
      }

      public function set formattedControlText(param1:String) : void {
         this.creditsParseResult = App.utils.locale.parseFormattedInteger(param1);
         this._formattedControlText = param1;
      }

      public function get headerText() : String {
         return this._headerText;
      }

      public function set headerText(param1:String) : void {
         this._headerText = param1;
      }

      public function get questionText() : String {
         return this._questionText;
      }

      public function set questionText(param1:String) : void {
         this._questionText = param1;
      }

      public function get errorText() : String {
         return this._errorText;
      }

      public function set errorText(param1:String) : void {
         this._errorText = param1;
      }

      public function getNextPosition() : int {
         return this.errorMessage.y + this.errorMessage.height + PADDING_FOR_NEXT_ELEMENT;
      }

      public function getUserText() : String {
         var _loc1_:IFormattedInt = App.utils.locale.parseFormattedInteger(this.userInput.text);
         return _loc1_.value.toString();
      }

      override protected function configUI() : void {
         super.configUI();
         this.showErrorState(false);
         this.userInput.addEventListener(InputEvent.INPUT,this.userInputHandler);
      }

      override public function dispose() : void {
         super.dispose();
         this.userInput.removeEventListener(InputEvent.INPUT,this.userInputHandler);
         this.userInput.dispose();
         this.creditsParseResult = null;
         App.utils.scheduler.cancelTask(this.runtimeValidate);
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.textHeader.htmlText = this._headerText;
            this.controlQuestion.htmlText = this._questionText;
            this.errorMessage.htmlText = this._errorText;
         }
      }

      private function userInputHandler(param1:InputEvent) : void {
         if(param1.details.value == InputValue.KEY_UP)
         {
            this.showErrorState(false);
            App.utils.scheduler.cancelTask(this.runtimeValidate);
            if(param1.details.code == Keyboard.ENTER)
            {
               this.showErrorState(!this.isValidControlInput);
            }
            else
            {
               if(!this.isEmptyText)
               {
                  App.utils.scheduler.scheduleTask(this.runtimeValidate,AUTO_UPDATE_TIMER);
               }
            }
            dispatchEvent(new Event(USER_INPUT_HANDLER));
         }
      }

      private function showErrorState(param1:Boolean) : void {
         if(this.userInput.text == "")
         {
            this.userInput.highlight = false;
            this.errorMessage.visible = false;
         }
         else
         {
            this.userInput.highlight = param1;
            this.errorMessage.visible = param1;
         }
      }

      private function runtimeValidate() : void {
         this.showErrorState(!this.isValidControlInput);
      }

      private function get isEmptyText() : Boolean {
         return this.userInput.text == "";
      }

      public function get isValidControlInput() : Boolean {
         return this.userInput.text == this.controlText || (this.parseUserString());
      }

      private function parseUserString() : Boolean {
         var _loc5_:* = 0;
         var _loc1_:Array = this.userInput.text.split("");
         if(this.creditsParseResult.delimiter.charCodeAt(0) == 160)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc1_.length)
            {
               if(_loc1_[_loc5_] == " ")
               {
                  _loc1_[_loc5_] = this.creditsParseResult.delimiter;
               }
               _loc5_++;
            }
         }
         var _loc2_:String = _loc1_.join("");
         var _loc3_:* = false;
         var _loc4_:* = this.formattedControlText.split("");
         if(_loc4_[_loc4_.length-1].charCodeAt(0) == 32)
         {
            _loc4_.pop();
            _loc3_ = _loc4_.join("") == _loc2_;
         }
         else
         {
            _loc3_ = this.formattedControlText == _loc2_;
         }
         return _loc3_;
      }

      public function cleanField() : void {
         if(this.userInput)
         {
            this.userInput.text = "";
         }
         this.showErrorState(false);
      }
   }

}