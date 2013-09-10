package scaleform.clik.managers
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;

    public class FocusHandler extends Object
    {
        public function FocusHandler()
        {
            super();
            this.currentFocusLookup = new flash.utils.Dictionary();
            this.actualFocusLookup = new flash.utils.Dictionary();
            return;
        }

        public function set stage(arg1:flash.display.Stage):void
        {
            if (this._stage == null)
            {
                this._stage = arg1;
            }
            this._stage.stageFocusRect = false;
            if (scaleform.gfx.Extensions.enabled)
            {
                this._stage.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.trackMouseDown, false, 0, true);
                this._stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.trackMouseDown, false, 0, true);
            }
            this._stage.addEventListener(flash.events.FocusEvent.FOCUS_IN, this.updateActualFocus, false, 0, true);
            this._stage.addEventListener(flash.events.FocusEvent.FOCUS_OUT, this.updateActualFocus, false, 0, true);
            this._stage.addEventListener(flash.events.FocusEvent.KEY_FOCUS_CHANGE, this.handleMouseFocusChange, false, 0, true);
            this._stage.addEventListener(flash.events.FocusEvent.MOUSE_FOCUS_CHANGE, this.handleMouseFocusChange, false, 0, true);
            var loc1:*=scaleform.clik.managers.InputDelegate.getInstance();
            loc1.initialize(this._stage);
            loc1.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false, 0, true);
            return;
        }

        public function getFocus(arg1:uint):flash.display.InteractiveObject
        {
            return this.getCurrentFocusDisplayObject(arg1);
        }

        public function setFocus(arg1:flash.display.InteractiveObject, arg2:uint=0, arg3:Boolean=false):void
        {
            var loc2:*=null;
            var loc8:*=NaN;
            var loc9:*=0;
            var loc10:*=0;
            var loc11:*=false;
            var loc1:*=arg1;
            if (arg1 != null)
            {
                for (;;)
                {
                    if ((loc2 = arg1 as scaleform.clik.core.UIComponent) != null)
                    {
                    };
                    if (loc2.focusTarget != null)
                    {
                        arg1 = loc2.focusTarget;
                        continue;
                    }
                }
            }
            if (loc2 != null)
            {
                if (loc2.focusable == false)
                {
                    arg1 = null;
                }
            }
            var loc3:*;
            if ((loc3 = arg1 as flash.display.Sprite) && arg3 && loc3.tabEnabled == false)
            {
                arg1 = null;
            }
            if (scaleform.clik.core.CLIK.disableNullFocusMoves && (arg1 == null || arg1 == this._stage))
            {
                return;
            }
            var loc4:*=this.getActualFocusDisplayObject(arg2);
            var loc5:*;
            if ((loc5 = this.getCurrentFocusDisplayObject(arg2)) != arg1)
            {
                if ((loc2 = loc5 as scaleform.clik.core.UIComponent) != null)
                {
                    loc2.focused = loc2.focused & ~(1 << arg2);
                }
                if (loc5 != null)
                {
                    loc5.dispatchEvent(new scaleform.clik.events.FocusHandlerEvent(scaleform.clik.events.FocusHandlerEvent.FOCUS_OUT, true, false, arg2));
                }
                loc5 = arg1;
                this.setCurrentFocusDisplayObject(arg2, arg1);
                if ((loc2 = loc5 as scaleform.clik.core.UIComponent) != null)
                {
                    loc2.focused = loc2.focused | 1 << arg2;
                }
                if (loc5 != null)
                {
                    loc5.dispatchEvent(new scaleform.clik.events.FocusHandlerEvent(scaleform.clik.events.FocusHandlerEvent.FOCUS_IN, true, false, arg2));
                }
            }
            var loc6:*=loc4 is flash.text.TextField;
            var loc7:*=loc5 is scaleform.clik.core.UIComponent;
            if (!(loc4 == loc5) && (!loc6 || loc6 && !loc7))
            {
                if (loc1 is flash.text.TextField && !(loc1 == arg1) && arg1 == null)
                {
                    arg1 = loc1;
                }
                this.preventStageFocusChanges = true;
                if (scaleform.gfx.Extensions.isScaleform)
                {
                    loc8 = scaleform.gfx.FocusManager.getControllerMaskByFocusGroup(arg2);
                    loc9 = scaleform.gfx.Extensions.numControllers;
                    loc10 = 0;
                    while (loc10 < loc9)
                    {
                        loc11 = !((loc8 >> loc10 & 1) == 0);
                        if (loc11)
                        {
                            this.setSystemFocus(arg1 as flash.display.InteractiveObject, loc10);
                        }
                        ++loc10;
                    }
                }
                else
                {
                    this.setSystemFocus(arg1 as flash.display.InteractiveObject);
                }
                this._stage.addEventListener(flash.events.Event.ENTER_FRAME, this.clearFocusPrevention, false, 0, true);
            }
            return;
        }

        protected function getCurrentFocusDisplayObject(arg1:uint):flash.display.InteractiveObject
        {
            var loc1:*=this.currentFocusLookup[arg1] as scaleform.clik.utils.WeakReference;
            if (loc1)
            {
                return loc1.value as flash.display.InteractiveObject;
            }
            return null;
        }

        protected function setCurrentFocusDisplayObject(arg1:uint, arg2:flash.display.InteractiveObject):void
        {
            this.currentFocusLookup[arg1] = new scaleform.clik.utils.WeakReference(arg2);
            return;
        }

        protected function getActualFocusDisplayObject(arg1:uint):flash.display.InteractiveObject
        {
            var loc1:*=this.actualFocusLookup[arg1] as scaleform.clik.utils.WeakReference;
            if (loc1)
            {
                return loc1.value as flash.display.InteractiveObject;
            }
            return null;
        }

        protected function setActualFocusDisplayObject(arg1:uint, arg2:flash.display.InteractiveObject):void
        {
            this.actualFocusLookup[arg1] = new scaleform.clik.utils.WeakReference(arg2);
            return;
        }

        protected function setSystemFocus(arg1:flash.display.InteractiveObject, arg2:uint=0):void
        {
            if (scaleform.gfx.Extensions.isScaleform)
            {
                scaleform.gfx.FocusManager.setFocus(arg1, arg2);
            }
            else
            {
                this._stage.focus = arg1;
            }
            return;
        }

        protected function getSystemFocus(arg1:uint=0):flash.display.InteractiveObject
        {
            if (scaleform.gfx.Extensions.isScaleform)
            {
                return scaleform.gfx.FocusManager.getFocus(arg1);
            }
            return this._stage.focus;
        }

        protected function clearFocusPrevention(arg1:flash.events.Event):void
        {
            this.preventStageFocusChanges = false;
            this._stage.removeEventListener(flash.events.Event.ENTER_FRAME, this.clearFocusPrevention, false);
            return;
        }

        public function input(arg1:scaleform.clik.ui.InputDetails):void
        {
            var loc1:*=new scaleform.clik.events.InputEvent(scaleform.clik.events.InputEvent.INPUT, arg1);
            this.handleInput(loc1);
            return;
        }

        public function trackMouseDown(arg1:flash.events.MouseEvent):void
        {
            this.mouseDown = arg1.buttonDown;
            return;
        }

        protected function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            var loc15:*=null;
            var loc1:*=arg1.details.controllerIndex;
            var loc2:*=scaleform.gfx.FocusManager.getControllerFocusGroup(loc1);
            var loc3:*;
            if ((loc3 = this.getCurrentFocusDisplayObject(loc2)) == null)
            {
                loc3 = this._stage;
            }
            var loc4:*=arg1.clone() as scaleform.clik.events.InputEvent;
            var loc5:*;
            if (!(loc5 = loc3.dispatchEvent(loc4)) || loc4.handled)
            {
                return;
            }
            if (arg1.details.value == scaleform.clik.constants.InputValue.KEY_UP)
            {
                return;
            }
            var loc6:*;
            if ((loc6 = arg1.details.navEquivalent) == null)
            {
                return;
            }
            var loc7:*=this.getCurrentFocusDisplayObject(loc2);
            var loc8:*=this.getActualFocusDisplayObject(loc2);
            var loc9:*=this.getSystemFocus(loc2);
            if (loc8 is flash.text.TextField && loc8 == loc7 && this.handleTextFieldInput(loc6, loc1))
            {
                return;
            }
            if (loc8 is flash.text.TextField && this.handleTextFieldInput(loc6, loc1))
            {
                return;
            }
            var loc10:*=loc6 == scaleform.clik.constants.NavigationCode.LEFT || loc6 == scaleform.clik.constants.NavigationCode.RIGHT;
            var loc11:*=loc6 == scaleform.clik.constants.NavigationCode.UP || scaleform.clik.constants.NavigationCode.DOWN;
            if (loc7 == null)
            {
                if (loc9 && loc9 is scaleform.clik.core.UIComponent)
                {
                    loc7 = loc9 as scaleform.clik.core.UIComponent;
                }
            }
            if (loc7 == null)
            {
                if (loc8 && loc8 is scaleform.clik.core.UIComponent)
                {
                    loc7 = loc8 as scaleform.clik.core.UIComponent;
                }
            }
            if (loc7 == null)
            {
                return;
            }
            var loc12:*=loc7.parent;
            var loc13:*=scaleform.clik.constants.FocusMode.DEFAULT;
            if (loc10 || loc11)
            {
                loc15 = loc10 ? scaleform.clik.constants.FocusMode.HORIZONTAL : scaleform.clik.constants.FocusMode.VERTICAL;
                while (loc12 != null)
                {
                    if (loc15 in loc12)
                    {
                        if (!((loc13 = loc12[loc15]) == null) && !(loc13 == scaleform.clik.constants.FocusMode.DEFAULT))
                        {
                            break;
                        }
                        loc12 = loc12.parent;
                        continue;
                    }
                    break;
                }
            }
            else
            {
                loc12 = null;
            }
            if (loc8 is flash.text.TextField && loc8.parent == loc7)
            {
                loc7 = this.getSystemFocus(loc1);
            }
            var loc14:*;
            if ((loc14 = scaleform.gfx.FocusManager.findFocus(loc6, null, loc13 == scaleform.clik.constants.FocusMode.LOOP, loc7, false, loc1)) != null)
            {
                this.setFocus(loc14, loc2);
            }
            return;
        }

        protected function handleMouseFocusChange(arg1:flash.events.FocusEvent):void
        {
            this.handleFocusChange(arg1.target as flash.display.InteractiveObject, arg1.relatedObject as flash.display.InteractiveObject, arg1);
            return;
        }

        protected function handleFocusChange(arg1:flash.display.InteractiveObject, arg2:flash.display.InteractiveObject, arg3:flash.events.FocusEvent):void
        {
            var loc4:*=null;
            if (this.mouseDown && arg2 is flash.text.TextField)
            {
                arg3.preventDefault();
                return;
            }
            if (scaleform.clik.core.CLIK.disableDynamicTextFieldFocus && arg2 is flash.text.TextField)
            {
                if ((loc4 = arg2 as flash.text.TextField).type == "dynamic")
                {
                    arg3.stopImmediatePropagation();
                    arg3.stopPropagation();
                    arg3.preventDefault();
                    return;
                }
            }
            if (arg2 is scaleform.clik.core.UIComponent)
            {
                arg3.preventDefault();
            }
            if (arg1 is flash.text.TextField && arg2 == null && scaleform.clik.core.CLIK.disableTextFieldToNullFocusMoves)
            {
                arg3.preventDefault();
                return;
            }
            var loc1:*;
            var loc2:*=(loc1 = arg3 as scaleform.gfx.FocusEventEx) != null ? loc1.controllerIdx : 0;
            var loc3:*=scaleform.gfx.FocusManager.getControllerFocusGroup(loc2);
            this.setActualFocusDisplayObject(loc3, arg2);
            this.setFocus(arg2, loc3, arg3.type == flash.events.FocusEvent.MOUSE_FOCUS_CHANGE);
            return;
        }

        protected function updateActualFocus(arg1:flash.events.FocusEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1.type != flash.events.FocusEvent.FOCUS_IN)
            {
                loc1 = arg1.target as flash.display.InteractiveObject;
                loc2 = arg1.relatedObject as flash.display.InteractiveObject;
            }
            else
            {
                loc1 = arg1.relatedObject as flash.display.InteractiveObject;
                loc2 = arg1.target as flash.display.InteractiveObject;
            }
            if (arg1.type == flash.events.FocusEvent.FOCUS_OUT)
            {
                if (this.preventStageFocusChanges)
                {
                    arg1.stopImmediatePropagation();
                    arg1.stopPropagation();
                }
            }
            var loc3:*;
            var loc4:*=(loc3 = arg1 as scaleform.gfx.FocusEventEx) != null ? loc3.controllerIdx : 0;
            var loc5:*=scaleform.gfx.FocusManager.getControllerFocusGroup(loc4);
            this.setActualFocusDisplayObject(loc5, loc2);
            var loc6:*=this.getCurrentFocusDisplayObject(loc5);
            if (!(loc2 == null) && loc2 is flash.text.TextField && !(loc2.parent == null) && loc6 == loc2.parent && loc6 == loc1)
            {
                return;
            }
            var loc7:*=loc2 is flash.text.TextField;
            var loc8:*=loc6 is scaleform.clik.core.UIComponent;
            if (loc2 != loc6)
            {
                if (!(loc7 && loc8) || loc2 == null)
                {
                    if (!this.preventStageFocusChanges || loc7)
                    {
                        this.setFocus(loc2, loc5);
                    }
                }
            }
            return;
        }

        protected function handleTextFieldInput(arg1:String, arg2:uint):Boolean
        {
            var loc1:*=this.getActualFocusDisplayObject(arg2) as flash.text.TextField;
            if (loc1 == null)
            {
                return false;
            }
            var loc2:*=loc1.caretIndex;
            var loc3:*=0;
            var loc4:*=arg1;
            switch (loc4)
            {
                case scaleform.clik.constants.NavigationCode.UP:
                {
                    if (!loc1.multiline)
                    {
                        return false;
                    }
                }
                case scaleform.clik.constants.NavigationCode.LEFT:
                {
                    return loc2 > 0;
                }
                case scaleform.clik.constants.NavigationCode.DOWN:
                {
                    if (!loc1.multiline)
                    {
                        return false;
                    }
                }
                case scaleform.clik.constants.NavigationCode.RIGHT:
                {
                    return loc2 < loc1.length;
                }
            }
            return false;
        }

        public static function getInstance():scaleform.clik.managers.FocusHandler
        {
            if (instance == null)
            {
                instance = new FocusHandler();
            }
            return instance;
        }

        public static function init(arg1:flash.display.Stage, arg2:scaleform.clik.core.UIComponent):void
        {
            if (initialized)
            {
                return;
            }
            var loc1:*=scaleform.clik.managers.FocusHandler.getInstance();
            loc1.stage = arg1;
            scaleform.gfx.FocusManager.alwaysEnableArrowKeys = true;
            scaleform.gfx.FocusManager.disableFocusKeys = true;
            initialized = true;
            return;
        }


        {
            initialized = false;
        }

        protected var _stage:flash.display.Stage;

        protected var currentFocusLookup:flash.utils.Dictionary;

        protected var actualFocusLookup:flash.utils.Dictionary;

        protected var preventStageFocusChanges:Boolean=false;

        protected var mouseDown:Boolean=false;

        protected static var initialized:Boolean=false;

        public static var instance:scaleform.clik.managers.FocusHandler;
    }
}
