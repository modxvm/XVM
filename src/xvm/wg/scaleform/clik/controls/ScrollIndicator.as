package scaleform.clik.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.ui.*;
    
    public class ScrollIndicator extends scaleform.clik.core.UIComponent implements scaleform.clik.interfaces.IScrollBar
    {
        public function ScrollIndicator()
        {
            super();
            return;
        }

        public function get scrollTarget():Object
        {
            return this._scrollTarget;
        }

        public function set scrollTarget(arg1:Object):void
        {
            if (arg1 is String) 
            {
                if (!componentInspectorSetting || arg1.toString() == "" || parent == null) 
                    return;
                arg1 = parent.getChildByName(arg1.toString());
                if (arg1 == null) 
                    return;
            }
            var loc1:*=this._scrollTarget;
            this._scrollTarget = arg1;
            if (loc1 != null) 
            {
                loc1.removeEventListener(flash.events.Event.SCROLL, this.handleTargetScroll, false);
                if (loc1.scrollBar != null) 
                    loc1.scrollBar = null;
            }
            if (arg1 is scaleform.clik.core.UIComponent && "scrollBar" in arg1) 
            {
                arg1.scrollBar = this;
                return;
            }
            if (this._scrollTarget == null) 
            {
                tabEnabled = true;
                return;
            }
            this._scrollTarget.addEventListener(flash.events.Event.SCROLL, this.handleTargetScroll, false, 0, true);
            if (this._scrollTarget is scaleform.clik.core.UIComponent) 
                focusTarget = this._scrollTarget as scaleform.clik.core.UIComponent;
            tabEnabled = false;
            this.handleTargetScroll(null);
            invalidate();
            return;
        }

        public function get availableHeight():Number
        {
            var loc1:*=isNaN(this.thumb.height) ? 0 : this.thumb.height;
            return (this.isHorizontal ? _width : _height) - loc1 + this.offsetBottom + this.offsetTop;
        }

        public function setScrollProperties(arg1:Number, arg2:Number, arg3:Number, arg4:Number=NaN):void
        {
            this._pageSize = arg1;
            if (!isNaN(arg4)) 
                this._pageScrollSize = arg4;
            this._minPosition = arg2;
            this._maxPosition = arg3;
            invalidateSize();
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.handled) 
                return;
            var loc1:*=arg1.details;
            if (loc1.value == scaleform.clik.constants.InputValue.KEY_UP) 
                return;
            var loc2:*=this.direction == scaleform.clik.constants.ScrollBarDirection.HORIZONTAL;
            var loc3:*=loc1.navEquivalent;
            switch (loc3) 
            {
                case scaleform.clik.constants.NavigationCode.UP:
                    if (loc2) 
                        return;
                    --this.position;
                    break;
                case scaleform.clik.constants.NavigationCode.DOWN:
                    if (loc2) 
                        return;
                    this.position = this.position + 1;
                    break;
                case scaleform.clik.constants.NavigationCode.LEFT:
                    if (!loc2) 
                        return;
                    --this.position;
                    break;
                case scaleform.clik.constants.NavigationCode.RIGHT:
                    if (!loc2) 
                        return;
                    this.position = this.position + 1;
                    break;
                case scaleform.clik.constants.NavigationCode.HOME:
                    this.position = 0;
                    break;
                case scaleform.clik.constants.NavigationCode.END:
                    this.position = this._maxPosition;
                    break;
                default:
                    return;
            }
            arg1.handled = true;
            return;
        }

        public override function toString():String
        {
            return "[CLIK ScrollIndicator " + name + "]";
        }

        protected override function configUI():void
        {
            super.configUI();
            focusable = false;
            var loc1:*;
            mouseEnabled = loc1 = false;
            mouseChildren = loc1;
            if (this.track == null) 
                this.track = new flash.display.MovieClip();
            this.thumb.enabled = this.enabled;
            initSize();
            this.direction = !(rotation == 0) && !(rotation == 180) ? scaleform.clik.constants.ScrollBarDirection.HORIZONTAL : scaleform.clik.constants.ScrollBarDirection.VERTICAL;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                setActualSize(_width, _height);
                this.drawLayout();
                this.updateThumb();
            }
            else if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                if (this._scrollTarget is flash.text.TextField) 
                {
                    loc1 = this._scrollTarget as flash.text.TextField;
                    this.setScrollProperties(loc1.bottomScrollV - loc1.scrollV, 1, loc1.maxScrollV);
                }
                this.updateThumbPosition();
            }
            return;
        }

        protected function drawLayout():void
        {
            this.track.height = this.isHorizontal ? _width : _height;
            if (this.track is scaleform.clik.core.UIComponent) 
                this.track.validateNow();
            return;
        }

        protected function updateThumb():void
        {
            var loc1:*=Math.max(1, this._maxPosition - this._minPosition + this._pageSize);
            var loc2:*=(this.isHorizontal ? _width : _height) + this.offsetTop + this.offsetBottom;
            this.thumb.height = Math.max(this._minThumbSize, Math.min(_height, this._pageSize / loc1 * loc2));
            if (this.thumb is scaleform.clik.core.UIComponent) 
                (this.thumb as scaleform.clik.core.UIComponent).validateNow();
            this.updateThumbPosition();
            return;
        }

        protected function updateThumbPosition():void
        {
            var loc1:*=(this._position - this._minPosition) / (this._maxPosition - this._minPosition);
            if (isNaN(loc1)) 
                loc1 = 0;
            var loc2:*=loc1 * this.availableHeight;
            this.thumb.y = Math.max(-this.offsetTop, Math.min(this.availableHeight - this.offsetTop, loc2));
            this.thumb.visible = !(this._maxPosition == this._minPosition || isNaN(this._pageSize) || this._maxPosition == 0);
            return;
        }

        protected function handleTargetScroll(arg1:flash.events.Event):void
        {
            if (this._isDragging) 
                return;
            var loc1:*=this._scrollTarget as flash.text.TextField;
            if (loc1 != null) 
            {
                this.setScrollProperties(loc1.bottomScrollV - loc1.scrollV, 1, loc1.maxScrollV);
                this.position = loc1.scrollV;
            }
            return;
        }

        public override function dispose():void
        {
            if (this._scrollTarget) 
            {
                this._scrollTarget.removeEventListener(flash.events.Event.SCROLL, this.handleTargetScroll, false);
                this._scrollTarget = null;
            }
            if (this.thumb && this.thumb is net.wg.infrastructure.interfaces.entity.IDisposable) 
                net.wg.infrastructure.interfaces.entity.IDisposable(this.thumb).dispose();
            this.thumb = null;
            if (this.track && this.track is net.wg.infrastructure.interfaces.entity.IDisposable) 
                net.wg.infrastructure.interfaces.entity.IDisposable(this.track).dispose();
            this.track = null;
            super.dispose();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
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
            gotoAndPlay(this.enabled ? "default" : "disabled");
            return;
        }

        public function get position():Number
        {
            return this._position;
        }

        public function set position(arg1:Number):void
        {
            arg1 = Math.max(this._minPosition, Math.min(this._maxPosition, arg1));
            if (arg1 == this._position) 
                return;
            this._position = arg1;
            dispatchEvent(new flash.events.Event(flash.events.Event.SCROLL));
            invalidateData();
            return;
        }

        public function get minThumbSize():Number
        {
            return this._minThumbSize;
        }

        public function set minThumbSize(arg1:Number):void
        {
            arg1 = Math.max(1, arg1);
            this._minThumbSize = arg1;
            invalidateSize();
            return;
        }

        public function get isHorizontal():Boolean
        {
            return this.direction == scaleform.clik.constants.ScrollBarDirection.HORIZONTAL;
        }

        public var direction:String="vertical";

        public var offsetTop:Number=0;

        public var offsetBottom:Number=0;

        protected var _isDragging:Boolean=false;

        protected var _maxPosition:Number=10;

        protected var _minPosition:Number=0;

        protected var _minThumbSize:Number=10;

        protected var _pageScrollSize:Number=1;

        protected var _pageSize:Number;

        protected var _position:Number=5;

        protected var _scrollTarget:Object;

        public var thumb:flash.display.MovieClip;

        public var track:flash.display.MovieClip;
    }
}
