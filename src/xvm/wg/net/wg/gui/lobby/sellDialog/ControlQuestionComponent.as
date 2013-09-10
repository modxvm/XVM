package net.wg.gui.lobby.sellDialog 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    
    public class ControlQuestionComponent extends scaleform.clik.core.UIComponent
    {
        public function ControlQuestionComponent()
        {
            super();
            return;
        }

        public function get controlText():String
        {
            return this._controlText;
        }

        public function set controlText(arg1:String):void
        {
            this._controlText = arg1;
            return;
        }

        public function get headerText():String
        {
            return this._headerText;
        }

        public function set headerText(arg1:String):void
        {
            this._headerText = arg1;
            return;
        }

        public function get questionText():String
        {
            return this._questionText;
        }

        public function set questionText(arg1:String):void
        {
            this._questionText = arg1;
            return;
        }

        public function get errorText():String
        {
            return this._errorText;
        }

        public function set errorText(arg1:String):void
        {
            this._errorText = arg1;
            return;
        }

        public function getNextPosition():int
        {
            return this.errorMessage.y + this.errorMessage.height + PADDING_FOR_NEXT_ELEMENT;
        }

        public function getUserText():String
        {
            return this.userInput.text;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.showErrorState(false);
            this.userInput.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.userInputHandler);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.userInput.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.userInputHandler);
            this.userInput.dispose();
            App.utils.scheduler.cancelTask(this.runtimeValidate);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.textHeader.htmlText = this._headerText;
                this.controlQuestion.htmlText = this._questionText;
                this.errorMessage.htmlText = this._errorText;
            }
            return;
        }

        internal function userInputHandler(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.details.value == scaleform.clik.constants.InputValue.KEY_UP) 
            {
                this.showErrorState(false);
                App.utils.scheduler.cancelTask(this.runtimeValidate);
                if (arg1.details.code != flash.ui.Keyboard.ENTER) 
                    if (!this.isEmptyText) 
                        App.utils.scheduler.scheduleTask(this.runtimeValidate, AUTO_UPDATE_TIMER);
                else 
                    this.showErrorState(!this.isValidControlInput);
                dispatchEvent(new flash.events.Event(USER_INPUT_HANDLER));
            }
            return;
        }

        internal function showErrorState(arg1:Boolean):void
        {
            this.userInput.highlight = arg1;
            this.errorMessage.visible = arg1;
            return;
        }

        internal function runtimeValidate():void
        {
            this.showErrorState(!this.isValidControlInput);
            return;
        }

        internal function get isEmptyText():Boolean
        {
            return this.userInput.text == "";
        }

        public function get isValidControlInput():Boolean
        {
            return this.userInput.text == this.controlText;
        }

        public function cleanField():void
        {
            if (this.userInput) 
                this.userInput.text = "";
            this.showErrorState(false);
            return;
        }

        public static const USER_INPUT_HANDLER:String="userInputHandler";

        internal static const PADDING_FOR_NEXT_ELEMENT:int=10;

        internal static const AUTO_UPDATE_TIMER:int=5000;

        public var arrowBG:flash.display.MovieClip;

        public var textHeader:flash.text.TextField;

        public var controlQuestion:flash.text.TextField;

        public var userInput:net.wg.gui.components.controls.TextInput;

        public var errorMessage:flash.text.TextField;

        internal var _headerText:String="";

        internal var _questionText:String="";

        internal var _errorText:String="";

        internal var _controlText:String="";
    }
}
