package net.wg.gui.lobby.profile.components 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.interfaces.*;
    
    public class ScrollPane extends scaleform.clik.core.UIComponent
    {
        public function ScrollPane()
        {
            super();
            return;
        }

        protected function createScrollBar():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (this._scrollBar) 
            {
                this._scrollBar.removeEventListener(flash.events.Event.SCROLL, this.handleScroll, false);
                this._scrollBar.removeEventListener(flash.events.Event.CHANGE, this.handleScroll, false);
                this._scrollBar.focusTarget = null;
                if (this.contains(this._scrollBar as flash.display.DisplayObject)) 
                    this.removeChild(this._scrollBar as flash.display.DisplayObject);
                this._scrollBar = null;
            }
            if (!this._scrollBarValue || this._scrollBarValue == "") 
                return;
            this._autoScrollBar = false;
            if (this._scrollBarValue is String) 
            {
                if (parent != null) 
                    loc1 = parent.getChildByName(this._scrollBarValue.toString()) as scaleform.clik.interfaces.IScrollBar;
                if (loc1 == null) 
                {
                    loc2 = flash.utils.getDefinitionByName(this._scrollBarValue.toString()) as Class;
                    if (loc2) 
                        loc1 = new loc2() as scaleform.clik.interfaces.IScrollBar;
                    if (loc1) 
                    {
                        this._autoScrollBar = true;
                        loc3 = loc1 as Object;
                        if (loc3 && this.thumbOffset) 
                        {
                            loc3.offsetTop = this.thumbOffset.top;
                            loc3.offsetBottom = this.thumbOffset.bottom;
                        }
                        loc1.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.blockMouseWheel, false, 0, true);
                        this.addChild(loc1 as flash.display.DisplayObject);
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
                    (loc1 as Object).offsetTop = this.thumbOffset.top;
                    (loc1 as Object).offsetBottom = this.thumbOffset.bottom;
                    this.addChild(loc1 as flash.display.DisplayObject);
                }
            }
            else 
                loc1 = this._scrollBarValue as scaleform.clik.interfaces.IScrollBar;
            this._scrollBar = loc1;
            invalidateSize();
            if (this._scrollBar == null) 
                return;
            this._scrollBar.addEventListener(flash.events.Event.SCROLL, this.handleScroll, false, 0, true);
            this._scrollBar.addEventListener(flash.events.Event.CHANGE, this.handleScroll, false, 0, true);
            this._scrollBar.focusTarget = this;
            this._scrollBar.tabEnabled = false;
            return;
        }

        protected function handleScroll(arg1:flash.events.Event):void
        {
            this.scrollPosition = this._scrollBar.position;
            return;
        }

        public function get scrollPosition():Number
        {
            return this._scrollPosition;
        }

        public function set scrollPosition(arg1:Number):void
        {
            arg1 = Math.max(0, Math.min(this.maxScroll, Math.round(arg1)));
            if (this._scrollPosition == arg1) 
                return;
            this._scrollPosition = arg1;
            invalidate(SCROLL_UPDATE_INV);
            return;
        }

        public function get maxScroll():Number
        {
            return Math.ceil((this.getContentHeight() - _height) / this._scrollStepFactor);
        }

        protected function getContentHeight():Number
        {
            if (this._target) 
                return this._target.height;
            return 0;
        }

        public function get scrollStepFactor():Number
        {
            return this._scrollStepFactor;
        }

        public function set scrollStepFactor(arg1:Number):void
        {
            this._scrollStepFactor = arg1;
            invalidate(SCROLL_UPDATE_INV);
            return;
        }

        protected function blockMouseWheel(arg1:flash.events.MouseEvent):void
        {
            arg1.stopPropagation();
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            super.dispose();
            this.thumbOffset = null;
            if (this._scrollBar) 
            {
                loc1 = this._scrollBar as flash.display.DisplayObject;
                if (loc1.parent) 
                    loc1.parent.removeChild(loc1);
                this._scrollBar.removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.blockMouseWheel);
                this._scrollBar.removeEventListener(flash.events.Event.SCROLL, this.handleScroll);
                this._scrollBar.removeEventListener(flash.events.Event.CHANGE, this.handleScroll);
                this._scrollBar = null;
            }
            this._scrollBarValue = null;
            this.maskObject = null;
            if (this.background) 
            {
                this.background.removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.targetMouseWheelHandler);
                this.background = null;
            }
            this.removeSource();
            if (this._target is net.wg.infrastructure.interfaces.entity.IDisposable) 
                net.wg.infrastructure.interfaces.entity.IDisposable(this._target).dispose();
            this._target = null;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            if (!this.maskObject) 
            {
                this.maskObject = new flash.display.MovieClip();
                addChild(this.maskObject);
            }
            if (!this.background) 
            {
                this.background = new flash.display.Sprite();
                addChildAt(this.background, 0);
                this.background.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.targetMouseWheelHandler, false, 0, true);
            }
            mask = this.maskObject;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(TARGET_INVALID)) 
                this.applyTargetChanges();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SCROLL_BAR)) 
            {
                this.createScrollBar();
                invalidate(SCROLL_POSITION_INV);
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE, SCROLL_POSITION_INV)) 
            {
                this.drawScrollBar();
                this.drawMask();
                this.drawBackground();
                invalidate(SCROLL_UPDATE_INV);
            }
            if (isInvalid(SCROLL_UPDATE_INV)) 
                this.applyScrollBarUpdating();
            return;
        }

        protected function applyTargetChanges():void
        {
            this.removeSource();
            if (this._target) 
            {
                addChild(this._target);
                this._target.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.targetMouseWheelHandler, false, 0, true);
            }
            return;
        }

        protected function drawBackground():void
        {
            var loc1:*=this.background.graphics;
            loc1.clear();
            loc1.beginFill(0, 0);
            loc1.drawRect(0, 0, _width, this.availableHeight);
            loc1.endFill();
            return;
        }

        protected function drawMask():void
        {
            var loc1:*=this.maskObject.graphics;
            loc1.clear();
            loc1.beginFill(16777215, 1);
            loc1.drawRect(0, 0, _width, this.availableHeight);
            loc1.endFill();
            return;
        }

        internal function targetMouseWheelHandler(arg1:flash.events.MouseEvent):void
        {
            this.scrollPosition = this.scrollPosition - (arg1.delta > 0 ? 1 : -1);
            return;
        }

        protected function applyScrollBarUpdating():void
        {
            var loc1:*=this.scrollPageSize;
            var loc2:*=0;
            var loc3:*=this.maxScroll;
            this.scrollBar.setScrollProperties(loc1, loc2, loc3);
            var loc4:*=(this.scrollBar.position - loc2) / (loc3 - loc2);
            var loc5:*;
            if (!(loc5 = !(isNaN(loc4) || isNaN(loc1) || loc3 <= 0 || loc3 == Infinity))) 
                this._scrollPosition = 0;
            if (this._target) 
                this._target.y = -this._scrollStepFactor * this._scrollPosition;
            this.scrollBar.visible = loc5;
            this.scrollBar.position = this._scrollPosition;
            this.scrollBar.trackScrollPageSize = loc1;
            return;
        }

        protected function drawScrollBar():void
        {
            if (!this._autoScrollBar) 
                return;
            this._scrollBar.x = _width - this._scrollBar.width;
            this._scrollBar.height = this.availableHeight;
            this._scrollBar.validateNow();
            return;
        }

        public function get availableHeight():Number
        {
            return Math.round(_height);
        }

        public function get target():flash.display.DisplayObject
        {
            return this._target;
        }

        public function set target(arg1:flash.display.DisplayObject):void
        {
            this._target = arg1;
            if (_invalidHash) 
                invalidate(TARGET_INVALID);
            return;
        }

        public function get scrollPageSize():Number
        {
            return Math.round(_height / this._scrollStepFactor);
        }

        internal function removeSource():flash.display.DisplayObject
        {
            var loc1:*=null;
            if (this._target) 
            {
                loc1 = this._target.parent;
                if (loc1) 
                    loc1.removeChild(this._target);
                this._target.removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.targetMouseWheelHandler);
            }
            return this._target;
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

        public static const SCROLL_UPDATE_INV:String="scrollUpdInv";

        public static const SCROLL_POSITION_INV:String="scrollPosInv";

        public static const TARGET_INVALID:String="targetInv";

        public var thumbOffset:Object;

        public var _scrollBar:scaleform.clik.interfaces.IScrollBar;

        protected var _scrollBarValue:Object;

        protected var _scrollPosition:uint=0;

        protected var _scrollStepFactor:Number=1;

        public var maskObject:flash.display.MovieClip;

        public var background:flash.display.Sprite;

        internal var _hideIfNotNeeded:Boolean;

        protected var _target:flash.display.DisplayObject;

        protected var _autoScrollBar:Boolean=false;
    }
}
