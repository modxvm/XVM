package net.wg.infrastructure.managers.utils.impl 
{
    import flash.display.*;
    import net.wg.utils.*;
    import scaleform.clik.managers.*;
    import scaleform.clik.ui.*;
    
    public class FocusHandlerEx extends Object implements net.wg.utils.IFocusHandler
    {
        public function FocusHandlerEx()
        {
            super();
            this._focusHandler = scaleform.clik.managers.FocusHandler.getInstance();
            return;
        }

        public function set stage(arg1:flash.display.Stage):void
        {
            this._focusHandler.stage = arg1;
            return;
        }

        public function getFocus(arg1:uint):flash.display.InteractiveObject
        {
            return this._focusHandler.getFocus(arg1);
        }

        public function setFocus(arg1:flash.display.InteractiveObject, arg2:uint=0, arg3:Boolean=false):void
        {
            this._focusHandler.setFocus(arg1, arg2, arg3);
            return;
        }

        public function input(arg1:scaleform.clik.ui.InputDetails):void
        {
            this._focusHandler.input(arg1);
            return;
        }

        public function dispose():void
        {
            this._focusHandler.setFocus(null);
            this._focusHandler = null;
            return;
        }

        internal var _focusHandler:scaleform.clik.managers.FocusHandler=null;
    }
}
