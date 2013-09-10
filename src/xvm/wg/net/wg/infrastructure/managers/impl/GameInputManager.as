package net.wg.infrastructure.managers.impl 
{
    import flash.events.*;
    import flash.utils.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    
    public class GameInputManager extends net.wg.infrastructure.base.meta.impl.GameInputManagerMeta implements net.wg.utils.IGameInputManager
    {
        public function GameInputManager()
        {
            super();
            this._inputHandlers = new flash.utils.Dictionary();
            return;
        }

        public function initStage(arg1:flash.events.IEventDispatcher):void
        {
            this._dispatcher = arg1;
            this._dispatcher.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.onInputHandler, false, 0, true);
            return;
        }

        public function as_addKeyHandler(arg1:Number, arg2:String, arg3:Boolean):void
        {
            this.setKeyHandler(arg1, arg2, this.pyInputHandler, arg3);
            return;
        }

        public function as_clearKeyHandler(arg1:Number, arg2:String):void
        {
            this.clearKeyHandler(arg1, arg2);
            return;
        }

        public function setKeyHandler(arg1:Number, arg2:String, arg3:Function, arg4:Boolean):void
        {
            this.assertEventType(arg2);
            if (this._inputHandlers[arg1] == undefined) 
                this._inputHandlers[arg1] = new flash.utils.Dictionary();
            if (this._inputHandlers[arg1][arg2] != undefined) 
                DebugUtils.LOG_WARNING("GameInputHandler.setKeyHandler. Existing handler for keyCode = " + arg1 + " and event = " + arg2 + " is to be reset!");
            this._inputHandlers[arg1][arg2] = new GameInputCallback(arg3, arg4);
            return;
        }

        public function clearKeyHandler(arg1:Number, arg2:String):void
        {
            this.assertEventType(arg2);
            this._inputHandlers[arg1][arg2].dispose();
            delete this._inputHandlers[arg1][arg2];
            if (this.getDictLength(this._inputHandlers[arg1]) == 0) 
                delete this._inputHandlers[arg1];
            return;
        }

        public function setIgnoredKeyCode(arg1:Number):void
        {
            this._ignoredKeyCode = arg1;
            return;
        }

        public function clearKeyHandlers():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=this._inputHandlers;
            for (loc1 in loc6) 
            {
                loc3 = this._inputHandlers[loc1];
                var loc7:*=0;
                var loc8:*=loc3;
                for (loc2 in loc8) 
                {
                    (loc4 = loc3[loc2]).dispose();
                    delete loc3[loc2];
                }
                delete this._inputHandlers[loc1];
            }
            return;
        }

        public function dispose():void
        {
            this.clearKeyHandlers();
            this._inputHandlers = null;
            this._dispatcher.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.onInputHandler);
            this._dispatcher = null;
            return;
        }

        internal function pyInputHandler(arg1:scaleform.clik.events.InputEvent):void
        {
            var loc1:*=arg1.details;
            handleGlobalKeyEventS(loc1.code, loc1.value);
            return;
        }

        internal function assertEventType(arg1:String):void
        {
            App.utils.asserter.assert(arg1 == scaleform.clik.constants.InputValue.KEY_UP || arg1 == scaleform.clik.constants.InputValue.KEY_DOWN, "Event must be \'keyUp\' or \'keyDown\'");
            return;
        }

        internal function getDictLength(arg1:flash.utils.Dictionary):int
        {
            var loc2:*=null;
            var loc1:*=0;
            var loc3:*=0;
            var loc4:*=arg1;
            for (loc2 in loc4) 
                ++loc1;
            return loc1;
        }

        internal function onInputHandler(arg1:scaleform.clik.events.InputEvent):void
        {
            var event:scaleform.clik.events.InputEvent;
            var details:scaleform.clik.ui.InputDetails;
            var callback:GameInputCallback;
            var focused:scaleform.clik.controls.TextInput;

            var loc1:*;
            details = null;
            callback = null;
            focused = null;
            event = arg1;
            try 
            {
                details = event.details;
                if (event.handled || this._ignoredKeyCode == details.code) 
                    return;
                callback = null;
                if (this._inputHandlers[details.code] == undefined) 
                    return;
                callback = this._inputHandlers[details.code][details.value] as GameInputCallback;
                if (!callback) 
                    return;
                focused = App.utils.focusHandler.getFocus(0) as scaleform.clik.controls.TextInput;
                if (callback.isIgnoreText && !(focused == null)) 
                    if (focused.editable && focused.enabled) 
                        return;
                callback.envoke(event);
            }
            catch (e:Error)
            {
                DebugUtils.LOG_DEBUG(e.message);
                DebugUtils.LOG_DEBUG(e.getStackTrace());
            }
            return;
        }

        internal var _dispatcher:flash.events.IEventDispatcher=null;

        internal var _inputHandlers:flash.utils.Dictionary=null;

        internal var _ignoredKeyCode:Number=-1;
    }
}

import net.wg.data.constants.*;
import net.wg.infrastructure.interfaces.entity.*;
import scaleform.clik.events.*;


class GameInputCallback extends Object implements net.wg.infrastructure.interfaces.entity.IDisposable
{
    public function GameInputCallback(arg1:Function, arg2:Boolean)
    {
        super();
        App.utils.asserter.assertNotNull(arg1, "handler" + net.wg.data.constants.Errors.CANT_NULL);
        this._handler = arg1;
        this._ignoreText = arg2;
        return;
    }

    public function envoke(arg1:scaleform.clik.events.InputEvent):void
    {
        this._handler(arg1);
        return;
    }

    public function get isIgnoreText():Boolean
    {
        return this._ignoreText;
    }

    public function dispose():void
    {
        this._handler = null;
        return;
    }

    internal var _handler:Function=null;

    internal var _ignoreText:Boolean=false;
}