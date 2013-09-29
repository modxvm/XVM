package scaleform.clik.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;
    
    public class TextArea extends scaleform.clik.controls.TextInput
    {
        public function TextArea()
        {
            this._thumbOffset = {"top":0, "bottom":0};
            super();
            return;
        }

        protected function createScrollBar():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (this._scrollBar != null) 
            {
                this._scrollBar.removeEventListener(flash.events.Event.SCROLL, this.handleScroll, false);
                this._scrollBar.removeEventListener(flash.events.Event.CHANGE, this.handleScroll, false);
                this._scrollBar.focusTarget = null;
                if (this.container.contains(this._scrollBar as flash.display.DisplayObject)) 
                {
                    this.container.removeChild(this._scrollBar as flash.display.DisplayObject);
                }
                this._scrollBar = null;
            }
            if (!this._scrollBarValue || this._scrollBarValue == "") 
            {
                return;
            }
            this._autoScrollBar = false;
            if (this._scrollBarValue is String) 
            {
                if (parent != null) 
                {
                    loc1 = parent.getChildByName(this._scrollBarValue.toString()) as scaleform.clik.interfaces.IScrollBar;
                }
                if (loc1 == null) 
                {
                    loc2 = flash.utils.getDefinitionByName(this._scrollBarValue.toString()) as Class;
                    if (loc2) 
                    {
                        loc1 = new loc2() as scaleform.clik.interfaces.IScrollBar;
                    }
                    if (loc1) 
                    {
                        this._autoScrollBar = true;
                        loc3 = loc1 as Object;
                        if (loc3 && this._thumbOffset) 
                        {
                            loc3.offsetTop = this._thumbOffset.top;
                            loc3.offsetBottom = this._thumbOffset.bottom;
                        }
                        loc1.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.blockMouseWheel, false, 0, true);
                        (loc1 as Object).minThumbSize = this._minThumbSize;
                        this.container.addChild(loc1 as flash.display.DisplayObject);
                    }
                }
            }
            else if (this._scrollBarValue is Class) 
            {
                loc1 = new (this._scrollBarValue as Class)() as scaleform.clik.interfaces.IScrollBar;
                loc1.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.blockMouseWheel, false, 0, true);
                if (loc1 != null) 
                {
                    this._autoScrollBar = true;
                    (loc1 as Object).offsetTop = this._thumbOffset.top;
                    (loc1 as Object).offsetBottom = this._thumbOffset.bottom;
                    (loc1 as Object).minThumbSize = this._minThumbSize;
                    this.container.addChild(loc1 as flash.display.DisplayObject);
                }
            }
            else 
            {
                loc1 = this._scrollBarValue as scaleform.clik.interfaces.IScrollBar;
            }
            this._scrollBar = loc1;
            invalidateSize();
            if (this._scrollBar != null) 
            {
                this._scrollBar.addEventListener(flash.events.Event.SCROLL, this.handleScroll, false, 0, true);
                this._scrollBar.addEventListener(flash.events.Event.CHANGE, this.handleScroll, false, 0, true);
                this._scrollBar.focusTarget = this;
                (this._scrollBar as Object).scrollTarget = textField;
                this._scrollBar.tabEnabled = false;
            }
            return;
        }

        protected function drawScrollBar():void
        {
            if (!this._autoScrollBar) 
            {
                return;
            }
            this._scrollBar.x = _width - this._scrollBar.width;
            this._scrollBar.height = this.availableHeight;
            this._scrollBar.validateNow();
            return;
        }

        protected function updateScrollBar():void
        {
            this._maxScroll = textField.maxScrollV;
            var loc1:*=this._scrollBar as scaleform.clik.controls.ScrollIndicator;
            if (loc1 == null) 
            {
                return;
            }
            var loc2:*=constraints.getElement("textField");
            if (this._scrollPolicy == "on" || this._scrollPolicy == "auto" && textField.maxScrollV > 1) 
            {
                if (this._autoScrollBar && !loc1.visible) 
                {
                    if (loc2 != null) 
                    {
                        constraints.update(_width, _height);
                        invalidate();
                    }
                    this._maxScroll = textField.maxScrollV;
                }
                loc1.visible = true;
            }
            if (this._scrollPolicy == "off" || this._scrollPolicy == "auto" && textField.maxScrollV == 1) 
            {
                if (this._autoScrollBar && loc1.visible) 
                {
                    loc1.visible = false;
                    if (loc2 != null) 
                    {
                        constraints.update(this.availableWidth, _height);
                        invalidate();
                    }
                }
            }
            if (loc1.enabled != this.enabled) 
            {
                loc1.enabled = this.enabled;
            }
            return;
        }

        protected override function updateText():void
        {
            super.updateText();
            this.updateScrollBar();
            return;
        }

        protected override function updateTextField():void
        {
            this._resetScrollPosition = true;
            super.updateTextField();
            return;
        }

        protected function handleScroll(arg1:flash.events.Event):void
        {
            this.position = this._scrollBar.position;
            return;
        }

        protected function blockMouseWheel(arg1:flash.events.MouseEvent):void
        {
            arg1.stopPropagation();
            return;
        }

        protected override function handleTextChange(arg1:flash.events.Event):void
        {
            if (this._maxScroll != textField.maxScrollV) 
            {
                this.updateScrollBar();
            }
            super.handleTextChange(arg1);
            return;
        }

        protected function onScroller(arg1:flash.events.Event):void
        {
            if (this._resetScrollPosition) 
            {
                textField.scrollV = this._position;
            }
            else 
            {
                this._position = textField.scrollV;
            }
            this._resetScrollPosition = false;
            return;
        }

        public override function dispose():void
        {
            textField.removeEventListener(flash.events.Event.SCROLL, this.onScroller, false);
            if (this._scrollBar) 
            {
                this._scrollBar.removeEventListener(flash.events.Event.SCROLL, this.handleScroll, false);
                this._scrollBar.removeEventListener(flash.events.Event.CHANGE, this.handleScroll, false);
                this._scrollBar.removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.blockMouseWheel, false);
                this._scrollBar.focusTarget = null;
                (this._scrollBar as Object).scrollTarget = null;
                if (this._scrollBar is net.wg.infrastructure.interfaces.entity.IDisposable) 
                {
                    net.wg.infrastructure.interfaces.entity.IDisposable(this._scrollBar).dispose();
                }
                if (this.container) 
                {
                    if (this.container.contains(this._scrollBar as flash.display.DisplayObject)) 
                    {
                        this.container.removeChild(this._scrollBar as flash.display.DisplayObject);
                    }
                }
            }
            if (this.container) 
            {
                removeChild(this.container);
                this.container = null;
            }
            this._scrollBar = null;
            this._scrollBarValue = null;
            this._thumbOffset = null;
            super.dispose();
            return;
        }

        protected override function preInitialize():void
        {
            if (!constraintsDisabled) 
            {
                constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.COUNTER_SCALE);
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            if (this.container == null) 
            {
                this.container = new flash.display.Sprite();
                addChild(this.container);
            }
            return;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            super.enabled = arg1;
            this.updateScrollBar();
            return;
        }

        public function get position():int
        {
            return this._position;
        }

        public function set position(arg1:int):void
        {
            this._position = arg1;
            textField.scrollV = this._position;
            return;
        }

        public function get scrollBar():Object
        {
            return this._scrollBar;
        }

        public function set scrollBar(arg1:Object):void
        {
            this._scrollBarValue = arg1;
            invalidate(scaleform.clik.constants.InvalidationType.SCROLL_BAR);
            return;
        }

        public function get minThumbSize():uint
        {
            return this._minThumbSize;
        }

        public function set minThumbSize(arg1:uint):void
        {
            this._minThumbSize = arg1;
            if (!this._autoScrollBar) 
            {
                return;
            }
            var loc1:*=this._scrollBar as scaleform.clik.controls.ScrollIndicator;
            loc1.minThumbSize = arg1;
            return;
        }

        public function get thumbOffset():Object
        {
            return this._thumbOffset;
        }

        public function set thumbOffset(arg1:Object):void
        {
            this._thumbOffset = arg1;
            if (!this._autoScrollBar) 
            {
                return;
            }
            var loc1:*=this._scrollBar as scaleform.clik.controls.ScrollIndicator;
            loc1.offsetTop = this._thumbOffset.top;
            loc1.offsetBottom = this._thumbOffset.bottom;
            return;
        }

        public function get availableWidth():Number
        {
            return Math.round(_width) - (this._autoScrollBar && (this._scrollBar as flash.display.MovieClip).visible ? Math.round(this._scrollBar.width) : 0);
        }

        public function get availableHeight():Number
        {
            return Math.round(_height);
        }

        public override function toString():String
        {
            return "[CLIK TextArea " + name + "]";
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            var loc3:*=NaN;
            super.handleInput(arg1);
            if (arg1.handled) 
            {
                return;
            }
            if (_editable) 
            {
                return;
            }
            loc1 = arg1.details.navEquivalent;
            var loc4:*=loc1;
            switch (loc4) 
            {
                case scaleform.clik.constants.NavigationCode.UP:
                {
                    if (this.position == 1) 
                    {
                        return;
                    }
                    this.position = Math.max(1, (this.position - 1));
                    arg1.handled = true;
                    break;
                }
                case scaleform.clik.constants.NavigationCode.DOWN:
                {
                    if (this.position == this._maxScroll) 
                    {
                        return;
                    }
                    this.position = Math.min(this._maxScroll, this.position + 1);
                    arg1.handled = true;
                    break;
                }
                case scaleform.clik.constants.NavigationCode.END:
                {
                    this.position = this._maxScroll;
                    arg1.handled = true;
                    break;
                }
                case scaleform.clik.constants.NavigationCode.HOME:
                {
                    this.position = 1;
                    arg1.handled = true;
                    break;
                }
                case scaleform.clik.constants.NavigationCode.PAGE_UP:
                {
                    loc2 = textField.bottomScrollV - textField.scrollV;
                    this.position = Math.max(1, this.position - loc2);
                    arg1.handled = true;
                    break;
                }
                case scaleform.clik.constants.NavigationCode.PAGE_DOWN:
                {
                    loc3 = textField.bottomScrollV - textField.scrollV;
                    this.position = Math.min(this._maxScroll, this.position + loc3);
                    arg1.handled = true;
                    break;
                }
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            if (textField != null) 
            {
                textField.addEventListener(flash.events.Event.SCROLL, this.onScroller, false, 0, true);
            }
            return;
        }

        protected override function draw():void
        {
            var loc1:*=0;
            if (isInvalid(scaleform.clik.constants.InvalidationType.SCROLL_BAR)) 
            {
                this.createScrollBar();
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.STATE)) 
            {
                if (_newFrame) 
                {
                    gotoAndPlay(_newFrame);
                    _newFrame = null;
                }
                updateAfterStateChange();
                this.updateTextField();
                dispatchEvent(new scaleform.clik.events.ComponentEvent(scaleform.clik.events.ComponentEvent.STATE_CHANGE));
                invalidate(scaleform.clik.constants.InvalidationType.SIZE);
            }
            else if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.updateText();
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                removeChild(this.container);
                setActualSize(_width, _height);
                this.container.scaleX = 1 / scaleX;
                this.container.scaleY = 1 / scaleY;
                if (!constraintsDisabled) 
                {
                    constraints.update(this.availableWidth, _height);
                    if (!scaleform.gfx.Extensions.enabled) 
                    {
                        loc1 = textField.textWidth;
                    }
                }
                addChild(this.container);
                if (this._autoScrollBar) 
                {
                    this.drawScrollBar();
                }
            }
            return;
        }

        protected var _scrollPolicy:String="auto";

        protected var _position:int=1;

        protected var _maxScroll:Number=1;

        protected var _resetScrollPosition:Boolean=false;

        protected var _scrollBarValue:Object;

        protected var _autoScrollBar:Boolean=false;

        protected var _thumbOffset:Object;

        protected var _minThumbSize:uint=1;

        protected var _scrollBar:scaleform.clik.interfaces.IScrollBar;

        public var container:flash.display.Sprite;
    }
}
