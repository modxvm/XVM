package scaleform.clik.managers 
{
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    import scaleform.gfx.*;
    
    public class InputDelegate extends flash.events.EventDispatcher
    {
        public function InputDelegate()
        {
            super();
            this.keyHash = [];
            return;
        }

        public function initialize(arg1:flash.display.Stage):void
        {
            this.stage = arg1;
            arg1.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.handleKeyDown, false, 0, true);
            arg1.addEventListener(flash.events.KeyboardEvent.KEY_UP, this.handleKeyUp, false, 0, true);
            return;
        }

        public function setKeyRepeat(arg1:Number, arg2:Boolean, arg3:uint=0):void
        {
            var loc1:*=arg3 * MAX_KEY_CODES + arg1;
            if (arg2) 
            {
                this.keyHash[loc1] = this.keyHash[loc1] & ~KEY_SUPRESSED;
            }
            else 
            {
                this.keyHash[loc1] = this.keyHash[loc1] | KEY_SUPRESSED;
            }
            return;
        }

        public function inputToNav(arg1:String, arg2:Number, arg3:Boolean=false, arg4:*=null):String
        {
            if (this.externalInputHandler != null) 
            {
                return this.externalInputHandler(arg1, arg2, arg4);
            }
            if (arg1 == "key") 
            {
                var loc1:*=arg2;
                switch (loc1) 
                {
                    case flash.ui.Keyboard.UP:
                    {
                        return scaleform.clik.constants.NavigationCode.UP;
                    }
                    case flash.ui.Keyboard.DOWN:
                    {
                        return scaleform.clik.constants.NavigationCode.DOWN;
                    }
                    case flash.ui.Keyboard.LEFT:
                    {
                        return scaleform.clik.constants.NavigationCode.LEFT;
                    }
                    case flash.ui.Keyboard.RIGHT:
                    {
                        return scaleform.clik.constants.NavigationCode.RIGHT;
                    }
                    case flash.ui.Keyboard.ENTER:
                    case flash.ui.Keyboard.SPACE:
                    {
                        return scaleform.clik.constants.NavigationCode.ENTER;
                    }
                    case flash.ui.Keyboard.BACKSPACE:
                    {
                        return scaleform.clik.constants.NavigationCode.BACK;
                    }
                    case flash.ui.Keyboard.TAB:
                    {
                        if (arg3) 
                        {
                            return scaleform.clik.constants.NavigationCode.SHIFT_TAB;
                        }
                        return scaleform.clik.constants.NavigationCode.TAB;
                    }
                    case flash.ui.Keyboard.HOME:
                    {
                        return scaleform.clik.constants.NavigationCode.HOME;
                    }
                    case flash.ui.Keyboard.END:
                    {
                        return scaleform.clik.constants.NavigationCode.END;
                    }
                    case flash.ui.Keyboard.PAGE_DOWN:
                    {
                        return scaleform.clik.constants.NavigationCode.PAGE_DOWN;
                    }
                    case flash.ui.Keyboard.PAGE_UP:
                    {
                        return scaleform.clik.constants.NavigationCode.PAGE_UP;
                    }
                    case flash.ui.Keyboard.ESCAPE:
                    {
                        return scaleform.clik.constants.NavigationCode.ESCAPE;
                    }
                }
            }
            return null;
        }

        public function readInput(arg1:String, arg2:int, arg3:Function):Object
        {
            return null;
        }

        protected function handleKeyDown(arg1:flash.events.KeyboardEvent):void
        {
            var loc1:*=arg1 as scaleform.gfx.KeyboardEventEx;
            var loc2:*=loc1 != null ? loc1.controllerIdx : 0;
            var loc3:*=arg1.keyCode;
            var loc4:*=loc2 * MAX_KEY_CODES + loc3;
            var loc5:*;
            if ((loc5 = this.keyHash[loc4]) & KEY_PRESSED) 
            {
                if ((loc5 & KEY_SUPRESSED) == 0) 
                {
                    this.handleKeyPress(scaleform.clik.constants.InputValue.KEY_HOLD, loc3, loc2, arg1.ctrlKey, arg1.altKey, arg1.shiftKey);
                }
            }
            else 
            {
                this.handleKeyPress(scaleform.clik.constants.InputValue.KEY_DOWN, loc3, loc2, arg1.ctrlKey, arg1.altKey, arg1.shiftKey);
                this.keyHash[loc4] = this.keyHash[loc4] | KEY_PRESSED;
            }
            return;
        }

        protected function handleKeyUp(arg1:flash.events.KeyboardEvent):void
        {
            var loc1:*=arg1 as scaleform.gfx.KeyboardEventEx;
            var loc2:*=loc1 != null ? loc1.controllerIdx : 0;
            var loc3:*=arg1.keyCode;
            var loc4:*=loc2 * MAX_KEY_CODES + loc3;
            this.keyHash[loc4] = this.keyHash[loc4] & ~KEY_PRESSED;
            this.handleKeyPress(scaleform.clik.constants.InputValue.KEY_UP, loc3, loc2, arg1.ctrlKey, arg1.altKey, arg1.shiftKey);
            return;
        }

        protected function handleKeyPress(arg1:String, arg2:Number, arg3:Number, arg4:Boolean, arg5:Boolean, arg6:Boolean):void
        {
            var loc1:*=new scaleform.clik.ui.InputDetails("key", arg2, arg1, this.inputToNav("key", arg2, arg6), arg3, arg4, arg5, arg6);
            dispatchEvent(new scaleform.clik.events.InputEvent(scaleform.clik.events.InputEvent.INPUT, loc1));
            return;
        }

        public static function getInstance():scaleform.clik.managers.InputDelegate
        {
            if (instance == null) 
            {
                instance = new InputDelegate();
            }
            return instance;
        }

        public static const MAX_KEY_CODES:uint=1000;

        public static const KEY_PRESSED:uint=1;

        public static const KEY_SUPRESSED:uint=2;

        public var stage:flash.display.Stage;

        public var externalInputHandler:Function;

        protected var keyHash:Array;

        internal static var instance:scaleform.clik.managers.InputDelegate;
    }
}
