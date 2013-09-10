package net.wg.gui.components.controls 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.ui.*;
    
    public class ScrollingListPx extends net.wg.gui.components.controls.CoreListEx
    {
        public function ScrollingListPx()
        {
            super();
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

        protected function populateData(arg1:Array):void
        {
            return;
        }

        protected override function drawLayout():void
        {
            return;
        }

        protected override function createRenderer(arg1:uint):scaleform.clik.interfaces.IListItemRenderer
        {
            var loc2:*=null;
            var loc1:*="List Couldn\'t create item renderer, because ";
            if (_itemRenderer) 
            {
                loc2 = new _itemRenderer() as scaleform.clik.interfaces.IListItemRenderer;
                if (loc2 != null) 
                    return loc2;
                else 
                    loc1 = loc1 + "_itemRenderer have to be implementer of IListItemRenderer";
            }
            else 
                loc1 = loc1 + "item renderer class have to be not null!";
            return null;
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

        protected override function configUI():void
        {
            super.configUI();
            if (!this.maskObject) 
            {
                this.maskObject = new flash.display.Sprite();
                addChild(this.maskObject);
            }
            mask = this.maskObject;
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.handled) 
                return;
            var loc1:*=arg1.details;
            var loc2:*=loc1.value == scaleform.clik.constants.InputValue.KEY_DOWN || loc1.value == scaleform.clik.constants.InputValue.KEY_HOLD;
            var loc3:*=loc1.navEquivalent;
            switch (loc3) 
            {
                case scaleform.clik.constants.NavigationCode.UP:
                    --this.scrollPosition;
                    break;
                case scaleform.clik.constants.NavigationCode.DOWN:
                    this.scrollPosition = this.scrollPosition + 1;
                    break;
                case scaleform.clik.constants.NavigationCode.END:
                    if (!loc2) 
                        this.scrollPosition = this.maxScroll;
                    break;
                case scaleform.clik.constants.NavigationCode.HOME:
                    if (!loc2) 
                        this.scrollPosition = 0;
                    break;
                case scaleform.clik.constants.NavigationCode.PAGE_UP:
                    if (loc2) 
                        this.scrollPosition = this.scrollPosition - this.scrollPageSize;
                    break;
                case scaleform.clik.constants.NavigationCode.PAGE_DOWN:
                    if (loc2) 
                        this.scrollPosition = this.scrollPosition + this.scrollPageSize;
                    break;
                default:
                    return;
            }
            arg1.handled = true;
            return;
        }

        protected override function scrollList(arg1:int):void
        {
            this.scrollPosition = this.scrollPosition - arg1;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            if (isInvalid(scaleform.clik.constants.InvalidationType.SCROLL_BAR)) 
            {
                this.createScrollBar();
                invalidate(SCROLL_POSITION_INV);
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE, SCROLL_POSITION_INV)) 
            {
                this.drawScrollBar();
                (loc5 = this.maskObject.graphics).beginFill(0, 1);
                loc5.drawRect(0, 0, _width, _height);
                loc5.endFill();
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.STATE)) 
                if (_newFrame) 
                {
                    gotoAndPlay(_newFrame);
                    _newFrame = null;
                }
            if (!_usingExternalRenderers && isInvalid(scaleform.clik.constants.InvalidationType.RENDERERS, scaleform.clik.constants.InvalidationType.DATA)) 
            {
                if (_renderers != null) 
                {
                    loc2 = _renderers.length;
                    loc1 = 0;
                    while (loc1 < loc2) 
                    {
                        loc3 = getRendererAt(loc1);
                        cleanUpRenderer(loc3);
                        loc4 = loc3 as flash.display.DisplayObject;
                        if (container.contains(loc4)) 
                            container.removeChild(loc4);
                        ++loc1;
                    }
                }
                _renderers = new Vector.<scaleform.clik.interfaces.IListItemRenderer>();
                if (_dataProvider) 
                    this.drawRenderers(_dataProvider.length);
            }
            if (isInvalid(SCROLL_UPDATE_INV)) 
                this.applyScrollBarUpdating();
            return;
        }

        protected function applyScrollBarUpdating():void
        {
            container.y = -this._scrollStepFactor * this._scrollPosition;
            this.scrollBar.setScrollProperties(this.scrollPageSize, 0, this.maxScroll);
            this.scrollBar.position = this.scrollPosition;
            this.scrollBar.trackScrollPageSize = this.scrollPageSize;
            return;
        }

        protected function drawScrollBar():void
        {
            if (!this._autoScrollBar) 
                return;
            this._scrollBar.x = _width - this._scrollBar.width;
            this._scrollBar.height = availableHeight;
            this._scrollBar.validateNow();
            return;
        }

        protected override function drawRenderers(arg1:Number):void
        {
            this.totalHeight = 0;
            var loc1:*=0;
            while (loc1 < arg1) 
            {
                this.createRendererByDataIndex(loc1);
                ++loc1;
            }
            this.scrollPosition = 0;
            return;
        }

        protected function createRendererByDataIndex(arg1:int):void
        {
            var loc1:*=this.createRenderer(arg1);
            if (loc1 == null) 
                return;
            container.addChild(loc1 as flash.display.DisplayObject);
            _renderers.push(loc1);
            var loc2:*=_dataProvider[arg1];
            loc1.setListData(new scaleform.clik.data.ListData(arg1, itemToLabel(loc2), false));
            loc1.setData(loc2);
            loc1.owner = this;
            loc1.validateNow();
            loc1.y = this.totalHeight;
            this.totalHeight = this.totalHeight + Math.round(loc1.height);
            return;
        }

        public function get maxScroll():Number
        {
            if (this.maskObject) 
                return Math.round((this.totalHeight - this.maskObject.height) / this._scrollStepFactor);
            return 0;
        }

        public function get scrollPageSize():Number
        {
            return Math.round(this.maskObject.height / this._scrollStepFactor);
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

        protected function blockMouseWheel(arg1:flash.events.MouseEvent):void
        {
            arg1.stopPropagation();
            return;
        }

        public static const SCROLL_UPDATE_INV:String="scrollUpdInv";

        public static const SCROLL_POSITION_INV:String="scrollPosInv";

        public var _scrollBar:scaleform.clik.interfaces.IScrollBar;

        protected var _scrollBarValue:Object;

        protected var totalHeight:uint;

        internal var _scrollStepFactor:Number=1;

        public var wrapping:String="normal";

        public var thumbOffset:Object;

        protected var _autoScrollBar:Boolean=false;

        protected var _scrollPosition:uint=0;

        public var maskObject:flash.display.Sprite;
    }
}
