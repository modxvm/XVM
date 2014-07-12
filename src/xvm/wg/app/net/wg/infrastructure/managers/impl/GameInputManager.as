package net.wg.infrastructure.managers.impl
{
    import net.wg.infrastructure.base.meta.impl.GameInputManagerMeta;
    import net.wg.utils.IGameInputManager;
    import flash.events.IEventDispatcher;
    import scaleform.clik.events.InputEvent;
    import flash.events.FocusEvent;
    import flash.utils.Dictionary;
    import scaleform.clik.ui.InputDetails;
    import scaleform.clik.constants.InputValue;
    import flash.text.TextField;
    import scaleform.clik.controls.TextInput;
    import flash.text.TextFieldType;
    import flash.display.InteractiveObject;
    import scaleform.gfx.Extensions;
    import scaleform.gfx.FocusManager;
    
    public class GameInputManager extends GameInputManagerMeta implements IGameInputManager
    {
        
        public function GameInputManager() {
            super();
            this._inputHandlers = new Dictionary();
        }
        
        public function initStage(param1:IEventDispatcher) : void {
            this._dispatcher = param1;
            this._dispatcher.addEventListener(InputEvent.INPUT,this.onInputHandler,false,0,true);
            this._dispatcher.addEventListener(FocusEvent.FOCUS_IN,this.onFocusInHandler,true,0,true);
        }
        
        public function as_addKeyHandler(param1:Number, param2:String, param3:Boolean, param4:String = null) : void {
            this.setKeyHandler(param1,param2,this.pyInputHandler,param3,param4);
        }
        
        public function as_clearKeyHandler(param1:Number, param2:String) : void {
            this.clearKeyHandler(param1,param2);
        }
        
        private var _dispatcher:IEventDispatcher = null;
        
        private var _inputHandlers:Dictionary = null;
        
        private var _ignoredKeyCode:Number = -1;
        
        private var _exclusiveHandlers:Dictionary = null;
        
        private var _changedTextFields:Array = null;
        
        public function setKeyHandler(param1:Number, param2:String, param3:Function, param4:Boolean, param5:String = null) : void {
            this.assertEventType(param2);
            if(this._inputHandlers[param1] == undefined)
            {
                this._inputHandlers[param1] = new Dictionary();
            }
            if(this._inputHandlers[param1][param2] != undefined)
            {
                DebugUtils.LOG_WARNING("GameInputHandler.setKeyHandler. Existing handler for keyCode = " + param1 + " and event = " + param2 + " is to be reset!");
            }
            this._inputHandlers[param1][param2] = new GameInputCallback(param3,param4,param5);
        }
        
        public function clearKeyHandler(param1:Number, param2:String) : void {
            this.assertEventType(param2);
            if(this._inputHandlers[param1])
            {
                this._inputHandlers[param1][param2].dispose();
                delete this._inputHandlers[param1][param2];
                if(this.getDictLength(this._inputHandlers[param1]) == 0)
                {
                    delete this._inputHandlers[param1];
                }
            }
        }
        
        public function setIgnoredKeyCode(param1:Number) : void {
            this._ignoredKeyCode = param1;
        }
        
        public function clearKeyHandlers() : void {
            /*
             * Decompilation error
             * Code may be obfuscated
             * Error type: TranslateException
             */
            throw new Error("Not decompiled due to error");
        }
        
        public function dispose() : void {
            this.clearKeyHandlers();
            this._inputHandlers = null;
            if(this._changedTextFields)
            {
                this._changedTextFields.splice();
                this._changedTextFields = null;
            }
            this._dispatcher.removeEventListener(InputEvent.INPUT,this.onInputHandler);
            this._dispatcher.removeEventListener(FocusEvent.FOCUS_IN,this.onFocusInHandler,true);
            this._dispatcher = null;
        }
        
        private function pyInputHandler(param1:InputEvent) : void {
            var _loc2_:InputDetails = param1.details;
            handleGlobalKeyEventS(_loc2_.code,_loc2_.value);
        }
        
        private function assertEventType(param1:String) : void {
            App.utils.asserter.assert(param1 == InputValue.KEY_UP || param1 == InputValue.KEY_DOWN,"Event must be \'keyUp\' or \'keyDown\'");
        }
        
        private function getDictLength(param1:Dictionary) : int {
            var _loc3_:Object = null;
            var _loc2_:* = 0;
            for(_loc3_ in param1)
            {
                _loc2_++;
            }
            return _loc2_;
        }
        
        private function onInputHandler(param1:InputEvent) : void {
            var details:InputDetails = null;
            var callback:GameInputCallback = null;
            var focused:TextField = null;
            var ti:TextInput = null;
            var focusedParent:TextInput = null;
            var event:InputEvent = param1;
            try
            {
                details = event.details;
                if((event.handled) || this._ignoredKeyCode == details.code)
                {
                    return;
                }
                callback = null;
                if(this._inputHandlers[details.code] == undefined)
                {
                    return;
                }
                callback = this._inputHandlers[details.code][details.value] as GameInputCallback;
                if(!callback)
                {
                    return;
                }
                if(callback.cancelEvent)
                {
                    if(!this._exclusiveHandlers)
                    {
                        this._exclusiveHandlers = new Dictionary(true);
                    }
                    this._exclusiveHandlers[details.code] = callback.cancelEvent;
                }
                else if((this._exclusiveHandlers) && this._exclusiveHandlers[details.code] == details.value)
                {
                    delete this._exclusiveHandlers[details.code];
                    if(this._changedTextFields)
                    {
                        for each(ti in this._changedTextFields)
                        {
                            ti.editable = true;
                        }
                        this._changedTextFields.splice();
                    }
                }
                
                focused = this.getSystemFocus(0) as TextField;
                if((callback.isIgnoreText) && !(focused == null))
                {
                    focusedParent = focused.parent as TextInput;
                    if(focused.type == TextFieldType.INPUT || (focusedParent && focusedParent.enabled) && (focusedParent.editable))
                    {
                        return;
                    }
                }
                callback.envoke(event);
            }
            catch(e:Error)
            {
                DebugUtils.LOG_DEBUG(e.message);
                DebugUtils.LOG_DEBUG(e.getStackTrace());
            }
        }
        
        private function getSystemFocus(param1:uint) : InteractiveObject {
            if(Extensions.isScaleform)
            {
                return FocusManager.getFocus(param1);
            }
            return App.stage.focus;
        }
        
        private function onFocusInHandler(param1:FocusEvent) : void {
            var _loc3_:TextInput = null;
            var _loc2_:TextField = param1.target as TextField;
            if(_loc2_)
            {
                _loc3_ = _loc2_.parent as TextInput;
                if(_loc2_.type == TextFieldType.INPUT && (_loc3_ && _loc3_.enabled) && (_loc3_.editable))
                {
                    if(this.hasExclusiveHandlers())
                    {
                        if(!this._changedTextFields)
                        {
                            this._changedTextFields = [];
                        }
                        this._changedTextFields.push(_loc3_);
                        _loc3_.editable = false;
                    }
                }
            }
        }
        
        private function hasExclusiveHandlers() : Boolean {
            var _loc2_:Object = null;
            var _loc1_:* = false;
            for(_loc2_ in this._exclusiveHandlers)
            {
                _loc1_ = true;
                return _loc1_;
            }
        }
    }
}
import net.wg.infrastructure.interfaces.entity.IDisposable;
import scaleform.clik.events.InputEvent;
import net.wg.data.constants.Errors;

class GameInputCallback extends Object implements IDisposable
{
    
    function GameInputCallback(param1:Function, param2:Boolean, param3:String = null) {
        super();
        App.utils.asserter.assertNotNull(param1,"handler" + Errors.CANT_NULL);
        this._handler = param1;
        this._ignoreText = param2;
        this._cancelEvent = param3;
    }
    
    private var _handler:Function = null;
    
    private var _ignoreText:Boolean = false;
    
    private var _cancelEvent:String = null;
    
    public function envoke(param1:InputEvent) : void {
        this._handler(param1);
    }
    
    public function get isIgnoreText() : Boolean {
        return this._ignoreText;
    }
    
    public function get cancelEvent() : String {
        return this._cancelEvent;
    }
    
    public function dispose() : void {
        this._handler = null;
        this._cancelEvent = null;
    }
}
