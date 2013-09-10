package scaleform.clik.core
{
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.utils.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.layout.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;

    public class UIComponent extends flash.display.MovieClip implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function UIComponent()
        {
            this.preInitialize();
            super();
            this._invalidHash = {};
            this.initialize();
            this.addEventListener(flash.events.Event.ADDED_TO_STAGE, this.addedToStage, false, 0, true);
            return;
        }

        public function validateNow(arg1:flash.events.Event=null):void
        {
            if (!this.initialized)
            {
                this.initialized = true;
                this.configUI();
            }
            this.removeEventListener(flash.events.Event.ENTER_FRAME, this.handleEnterFrameValidation, false);
            this.removeEventListener(flash.events.Event.RENDER, this.validateNow, false);
            if (!this._invalid)
                return;
            this.draw();
            this._invalidHash = {};
            this._invalid = false;
            return;
        }

        public override function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            this.throwLifeCycleException();
            var loc1:*;
            if ((loc1 = App.instance ? App.utils : null) && loc1.events && this._listenerFlag)
            {
                this._listenerFlag = false;
                loc1.events.addEvent(this, type, listener, useCapture, priority, useWeakReference);
                this._listenerFlag = true;
            }
            else
                super.addEventListener(type, listener, useCapture, priority, useWeakReference);
            return;
        }

        public override function removeEventListener(arg1:String, arg2:Function, arg3:Boolean=false):void
        {
            var loc1:*;
            if ((loc1 = App.instance ? App.utils : null) && loc1.events && this._listenerFlag)
            {
                this._listenerFlag = false;
                loc1.events.removeEvent(this, arg1, arg2);
                this._listenerFlag = true;
            }
            else
                super.removeEventListener(arg1, arg2, arg3);
            return;
        }

        public function removeSuperEventListener(arg1:String, arg2:Function, arg3:Boolean=false):void
        {
            super.removeEventListener(arg1, arg2, arg3);
            return;
        }

        public function addSuperEventListener(arg1:String, arg2:Function, arg3:Boolean=false, arg4:int=0, arg5:Boolean=false):void
        {
            super.addEventListener(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        protected function isInvalid(... rest):Boolean
        {
            this.throwLifeCycleException();
            if (!this._invalid)
                return false;
            var loc1:*=rest.length;
            if (loc1 == 0)
                return this._invalid;
            if (this._invalidHash[scaleform.clik.constants.InvalidationType.ALL])
                return true;
            var loc2:*=0;
            while (loc2 < loc1)
            {
                if (this._invalidHash[rest[loc2]])
                    return true;
                ++loc2;
            }
            return false;
        }

        public function invalidateSize():void
        {
            this.invalidate(scaleform.clik.constants.InvalidationType.SIZE);
            return;
        }

        public function invalidateData():void
        {
            this.invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        public function invalidateState():void
        {
            this.invalidate(scaleform.clik.constants.InvalidationType.STATE);
            return;
        }

        protected function addedToStage(arg1:flash.events.Event):void
        {
            this.removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.addedToStage, false);
            if (!scaleform.clik.core.CLIK.initialized)
                scaleform.clik.core.CLIK.initialize(stage, this);
            if (this._enableInitCallback && !(scaleform.gfx.Extensions.CLIK_addedToStageCallback == null))
                scaleform.clik.core.CLIK.queueInitCallback(this);
            return;
        }

        protected function handleStageChange(arg1:flash.events.Event):void
        {
            if (arg1.type == flash.events.Event.ADDED_TO_STAGE)
            {
                this.removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.handleStageChange, false);
                this.addEventListener(flash.events.Event.RENDER, this.validateNow, false, 0, true);
                if (stage != null)
                    stage.invalidate();
            }
            return;
        }

        protected function handleEnterFrameValidation(arg1:flash.events.Event):void
        {
            this.throwLifeCycleException();
            this.validateNow();
            return;
        }

        protected function getInvalid():String
        {
            var loc4:*=null;
            var loc1:*=[];
            var loc2:*=[scaleform.clik.constants.InvalidationType.ALL, scaleform.clik.constants.InvalidationType.DATA, scaleform.clik.constants.InvalidationType.RENDERERS, scaleform.clik.constants.InvalidationType.SIZE, scaleform.clik.constants.InvalidationType.STATE];
            var loc3:*=0;
            while (loc3 < loc2.length)
            {
                loc1.push("* " + loc2[loc3] + ": " + (this._invalidHash[loc2[loc3]] == true));
                ++loc3;
            }
            var loc5:*=0;
            var loc6:*=this._invalidHash;
            for (loc4 in loc6)
            {
                if (loc2.indexOf(loc4))
                    continue;
                loc1.push("* " + loc4 + ": true");
            }
            return "Invalid " + this + ": \n" + loc1.join("\n");
        }

        public function dispatchEventAndSound(arg1:flash.events.Event):Boolean
        {
            var loc1:*=super.dispatchEvent(arg1);
            return loc1;
        }

        public function dispose():void
        {
            var loc1:*=null;
            this._baseDisposed = true;
            if (this.constraints)
            {
                this.constraints.removeAllElements();
                this.constraints.dispose();
                this.constraints = null;
            }
            while (numChildren > 0)
                removeChildAt(0);
            this._focusTarget = null;
            var loc2:*=0;
            var loc3:*=this._invalidHash;
            for (loc1 in loc3)
                delete this._invalidHash[loc1];
            this._invalidHash = null;
            loc2 = 0;
            loc3 = this._labelHash;
            for (loc1 in loc3)
                delete this._labelHash[loc1];
            this._labelHash = null;
            this._layoutData = null;
            this.removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.addedToStage, false);
            this.removeEventListener(flash.events.Event.ENTER_FRAME, this.handleEnterFrameValidation, false);
            this.removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.handleStageChange, false);
            this.removeEventListener(flash.events.Event.RENDER, this.validateNow, false);
            return;
        }

        internal function simpleAssert(arg1:Boolean, arg2:String, arg3:Class=null):void
        {
            if (!arg1)
            {
                if (arg3 == null)
                    arg3 = net.wg.infrastructure.exceptions.AssertionException;
                throw new arg3(arg2);
            }
            return;
        }

        internal function throwLifeCycleException():void
        {
            var loc1:*="\nMay be you can find a custom override method Draw and place after each gotoAnd... " + "method next code block:if (_baseDisposed){return;}";
            this.simpleAssert(!this._baseDisposed, "invalidation after dispose!" + loc1, net.wg.infrastructure.exceptions.LifecycleException);
            return;
        }

        protected function preInitialize():void
        {
            return;
        }

        protected function initialize():void
        {
            this._labelHash = scaleform.clik.core.UIComponent.generateLabelHash(this);
            this._originalWidth = super.width / super.scaleX;
            this._originalHeight = super.height / super.scaleY;
            if (this._width == 0)
                this._width = super.width;
            if (this._height == 0)
                this._height = super.height;
            this.invalidate();
            return;
        }

        public static function generateLabelHash(arg1:flash.display.MovieClip):Object
        {
            var loc1:*={};
            if (!arg1)
                return loc1;
            var loc2:*=arg1.currentLabels;
            var loc3:*=loc2.length;
            var loc4:*=0;
            while (loc4 < loc3)
            {
                loc1[loc2[loc4].name] = true;
                ++loc4;
            }
            return loc1;
        }

        public function get componentInspectorSetting():Boolean
        {
            return this._inspector;
        }

        public function set componentInspectorSetting(arg1:Boolean):void
        {
            this._inspector = arg1;
            if (arg1)
                this.beforeInspectorParams();
            else
                this.afterInspectorParams();
            return;
        }

        public override function get width():Number
        {
            return this._width;
        }

        public override function set width(arg1:Number):void
        {
            this.setSize(arg1, this._height);
            return;
        }

        public override function get height():Number
        {
            return this._height;
        }

        public override function set height(arg1:Number):void
        {
            this.setSize(this._width, arg1);
            return;
        }

        public override function get scaleX():Number
        {
            return this._width / this._originalWidth;
        }

        public override function set scaleX(arg1:Number):void
        {
            super.scaleX = arg1;
            if (rotation == 0)
                this.width = super.width;
            return;
        }

        public override function get scaleY():Number
        {
            return this._height / this._originalHeight;
        }

        public override function set scaleY(arg1:Number):void
        {
            super.scaleY = arg1;
            if (rotation == 0)
                this.height = super.height;
            return;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            if (arg1 == super.enabled)
                return;
            super.enabled = arg1;
            tabEnabled = this.enabled ? this._focusable : false;
            mouseEnabled = arg1;
            return;
        }

        public override function get visible():Boolean
        {
            return super.visible;
        }

        public override function set visible(arg1:Boolean):void
        {
            super.visible = arg1;
            dispatchEvent(new scaleform.clik.events.ComponentEvent(arg1 ? scaleform.clik.events.ComponentEvent.SHOW : scaleform.clik.events.ComponentEvent.HIDE));
            return;
        }

        public function get hasFocus():Boolean
        {
            return this._focused > 0;
        }

        public function get focusable():Boolean
        {
            return this._focusable;
        }

        public function set focusable(arg1:Boolean):void
        {
            var loc1:*=!(this._focusable == arg1);
            this._focusable = arg1;
            if (!this._focusable && this.enabled)
            {
                var loc2:*;
                tabChildren = loc2 = false;
                tabEnabled = loc2;
            }
            else if (this._focusable && this.enabled)
                tabEnabled = true;
            if (loc1)
                this.changeFocus();
            return;
        }

        public function get focused():Number
        {
            return this._focused;
        }

        public function set focused(arg1:Number):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=NaN;
            var loc4:*=false;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=false;
            if (arg1 == this._focused || !this._focusable)
                return;
            this._focused = arg1;
            if (scaleform.gfx.Extensions.isScaleform)
            {
                loc1 = scaleform.gfx.FocusManager.numFocusGroups;
                loc2 = scaleform.gfx.Extensions.numControllers;
                loc3 = 0;
                while (loc3 < loc1)
                {
                    loc4 = !((this._focused >> loc3 & 1) == 0)
                    if (loc4)
                    {
                        loc5 = scaleform.gfx.FocusManager.getControllerMaskByFocusGroup(loc3);
                        loc6 = 0;
                        while (loc6 < loc2)
                        {
                            if ((loc7 = !((loc5 >> loc6 & 1) == 0)) && !(scaleform.gfx.FocusManager.getFocus(loc6) == this))
                                scaleform.gfx.FocusManager.setFocus(this, loc6);
                            ++loc6;
                        }
                    }
                    ++loc3;
                }
            }
            else if (!(stage == null) && this._focused > 0)
                stage.focus = this;
            this.changeFocus();
            return;
        }

        public function get displayFocus():Boolean
        {
            return this._displayFocus;
        }

        public function set displayFocus(arg1:Boolean):void
        {
            if (arg1 == this._displayFocus)
                return;
            this._displayFocus = arg1;
            this.changeFocus();
            return;
        }

        public function get focusTarget():scaleform.clik.core.UIComponent
        {
            return this._focusTarget;
        }

        public function set focusTarget(arg1:scaleform.clik.core.UIComponent):void
        {
            this._focusTarget = arg1;
            return;
        }

        public function get layoutData():scaleform.clik.layout.LayoutData
        {
            return this._layoutData;
        }

        public function set layoutData(arg1:scaleform.clik.layout.LayoutData):void
        {
            this._layoutData = arg1;
            return;
        }

        public function get enableInitCallback():Boolean
        {
            return this._enableInitCallback;
        }

        public function set enableInitCallback(arg1:Boolean):void
        {
            if (arg1 == this._enableInitCallback)
                return;
            this._enableInitCallback = arg1;
            if (this._enableInitCallback && !(stage == null) && !(scaleform.gfx.Extensions.CLIK_addedToStageCallback == null))
            {
                if (!scaleform.clik.core.CLIK.initialized)
                    scaleform.clik.core.CLIK.initialize(stage, this);
                scaleform.clik.core.CLIK.queueInitCallback(this);
            }
            return;
        }

        public final function get actualWidth():Number
        {
            return super.width;
        }

        public final function get actualHeight():Number
        {
            return super.height;
        }

        public final function get actualScaleX():Number
        {
            return super.scaleX;
        }

        public final function get actualScaleY():Number
        {
            return super.scaleY;
        }

        public function setSize(arg1:Number, arg2:Number):void
        {
            this._width = arg1;
            this._height = arg2;
            this.invalidateSize();
            return;
        }

        public function setActualSize(arg1:Number, arg2:Number):void
        {
            if (!(super.width == arg1) || !(this._width == arg1))
            {
                var loc1:*;
                this._width = loc1 = arg1;
                super.width = loc1;
            }
            if (!(super.height == arg2) || !(this._height == arg2))
            {
                this._height = loc1 = arg2;
                super.height = loc1;
            }
            return;
        }

        public final function setActualScale(arg1:Number, arg2:Number):void
        {
            super.scaleX = arg1;
            super.scaleY = arg2;
            this._width = this._originalWidth * arg1;
            this._height = this._originalHeight * arg2;
            this.invalidateSize();
            return;
        }

        public function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            return;
        }

        public function dispatchEventToGame(arg1:flash.events.Event):void
        {
            flash.external.ExternalInterface.call("__handleEvent", name, arg1);
            return;
        }

        public override function toString():String
        {
            return "[CLIK " + flash.utils.getQualifiedClassName(this) + " " + name + "]";
        }

        protected function configUI():void
        {
            return;
        }

        protected function draw():void
        {
            return;
        }

        protected function changeFocus():void
        {
            return;
        }

        protected function beforeInspectorParams():void
        {
            return;
        }

        protected function afterInspectorParams():void
        {
            return;
        }

        protected function initSize():void
        {
            var loc1:*=this._width != 0 ? this._width : this.actualWidth;
            var loc2:*=this._height != 0 ? this._height : this.actualHeight;
            var loc3:*;
            super.scaleY = loc3 = 1;
            super.scaleX = loc3;
            this.setSize(loc1, loc2);
            return;
        }

        public function invalidate(... rest):void
        {
            var loc1:*=0;
            var loc2:*=0;
            this.throwLifeCycleException();
            if (!this._baseDisposed)
            {
                if (rest.length != 0)
                {
                    loc1 = rest.length;
                    loc2 = 0;
                    while (loc2 < loc1)
                    {
                        this._invalidHash[rest[loc2]] = true;
                        ++loc2;
                    }
                }
                else
                    this._invalidHash[scaleform.clik.constants.InvalidationType.ALL] = true;
                if (this._invalid)
                    if (stage != null)
                        stage.invalidate();
                else
                {
                    this._invalid = true;
                    if (stage != null)
                    {
                        this.addEventListener(flash.events.Event.ENTER_FRAME, this.handleEnterFrameValidation, false, 0, true);
                        this.addEventListener(flash.events.Event.RENDER, this.validateNow, false, 0, true);
                        stage.invalidate();
                    }
                    else
                        this.addEventListener(flash.events.Event.ADDED_TO_STAGE, this.handleStageChange, false, 0, true);
                }
            }
            return;
        }

        public var initialized:Boolean=false;

        protected var _invalidHash:Object;

        protected var _invalid:Boolean=false;

        protected var _width:Number=0;

        protected var _height:Number=0;

        protected var _originalWidth:Number=0;

        protected var _originalHeight:Number=0;

        protected var _focusTarget:scaleform.clik.core.UIComponent;

        protected var _focusable:Boolean=true;

        protected var _displayFocus:Boolean=false;

        protected var _mouseWheelEnabled:Boolean=true;

        protected var _inspector:Boolean=false;

        protected var _labelHash:Object;

        protected var _layoutData:scaleform.clik.layout.LayoutData;

        protected var _enableInitCallback:Boolean=false;

        public var constraints:scaleform.clik.utils.Constraints;

        protected var _focused:Number=0;

        internal var _listenerFlag:Boolean=true;

        protected var _baseDisposed:Boolean=false;
    }
}
