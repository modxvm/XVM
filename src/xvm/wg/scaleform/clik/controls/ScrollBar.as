package scaleform.clik.controls 
{
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class ScrollBar extends scaleform.clik.controls.ScrollIndicator
    {
        public function ScrollBar()
        {
            super();
            return;
        }

        protected function endDrag(arg1:flash.events.MouseEvent):void
        {
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.doDrag);
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.endDrag);
            _isDragging = false;
            return;
        }

        protected function handleTrackPress(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=NaN;
            if (arg1.shiftKey || this.trackMode == scaleform.clik.constants.ScrollBarTrackMode.SCROLL_TO_CURSOR) 
            {
                loc1 = (mouseY - thumb.height / 2 - track.y) / this.availableHeight;
                this.position = Math.round(loc1 * (_maxPosition - _minPosition) + _minPosition);
                thumb.dispatchEvent(new flash.events.MouseEvent(flash.events.MouseEvent.MOUSE_OVER));
                thumb.dispatchEvent(new flash.events.MouseEvent(flash.events.MouseEvent.MOUSE_DOWN));
                this.handleThumbPress(arg1);
                this._dragOffset = new flash.geom.Point(0, thumb.height / 2);
            }
            if (_isDragging || this.position == this._trackScrollPosition) 
                return;
            if (mouseY > thumb.y && mouseY < thumb.y + thumb.height) 
                return;
            this.position = this.position + (thumb.y < mouseY ? this.trackScrollPageSize : -this.trackScrollPageSize);
            return;
        }

        protected function handleTrackClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            if (arg1.isRepeat) 
            {
                if (_isDragging || this.position == this._trackScrollPosition) 
                    return;
                if (mouseY > thumb.y && mouseY < thumb.y + thumb.height) 
                    return;
                this.position = this.position + (thumb.y < mouseY ? this.trackScrollPageSize : -this.trackScrollPageSize);
            }
            return;
        }

        protected function updateScrollTarget():void
        {
            if (_scrollTarget == null || !this.enabled) 
                return;
            var loc1:*=_scrollTarget as flash.text.TextField;
            if (loc1 != null) 
                _scrollTarget.scrollV = _position;
            return;
        }

        protected function handleMouseWheel(arg1:flash.events.MouseEvent):void
        {
            this.position = this.position - (arg1.delta > 0 ? 1 : -1) * _pageScrollSize;
            return;
        }

        protected override function changeFocus():void
        {
            thumb.displayFocus = _focused || _displayFocus;
            return;
        }

        public override function dispose():void
        {
            removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.handleMouseWheel, false);
            removeEventListener(scaleform.clik.events.InputEvent.INPUT, handleInput, false);
            if (this.upArrow) 
            {
                this.upArrow.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleUpArrowClick, false);
                this.upArrow.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.handleUpArrowPress, false);
                this.upArrow.focusTarget = null;
                this.upArrow.dispose();
            }
            this.upArrow = null;
            if (this.downArrow) 
            {
                this.downArrow.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleDownArrowClick, false);
                this.downArrow.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.handleDownArrowPress, false);
                this.downArrow.focusTarget = null;
                this.downArrow.dispose();
            }
            this.downArrow = null;
            if (thumb) 
            {
                thumb.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleThumbPress, false);
                if (thumb is scaleform.clik.core.UIComponent) 
                {
                    scaleform.clik.core.UIComponent(thumb).focusTarget = null;
                    scaleform.clik.core.UIComponent(thumb).dispose();
                }
            }
            thumb = null;
            if (track) 
            {
                track.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleTrackPress, false);
                track.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleTrackClick, false);
                if (track is scaleform.clik.core.UIComponent) 
                {
                    (track as scaleform.clik.core.UIComponent).focusTarget = null;
                    (track as scaleform.clik.core.UIComponent).dispose();
                }
            }
            track = null;
            this._dragOffset = null;
            super.dispose();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            var loc1:*=rotation;
            rotation = 0;
            if (this.downArrow) 
                constraints.addElement("downArrow", this.downArrow, scaleform.clik.utils.Constraints.BOTTOM);
            constraints.addElement("track", track, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.BOTTOM);
            rotation = loc1;
            return;
        }

        protected override function preInitialize():void
        {
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            return;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            if (this.enabled == arg1) 
                return;
            super.enabled = arg1;
            gotoAndPlay(this.enabled ? "default" : "disabled");
            invalidate(scaleform.clik.constants.InvalidationType.STATE);
            return;
        }

        public override function get position():Number
        {
            return _position;
        }

        public override function set position(arg1:Number):void
        {
            arg1 = Math.round(arg1);
            if (arg1 == this.position) 
                return;
            super.position = arg1;
            this.updateScrollTarget();
            return;
        }

        public function get trackMode():String
        {
            return this._trackMode;
        }

        public function set trackMode(arg1:String):void
        {
            if (arg1 == this._trackMode) 
                return;
            this._trackMode = arg1;
            if (initialized) 
                track.autoRepeat = this.trackMode == scaleform.clik.constants.ScrollBarTrackMode.SCROLL_PAGE;
            return;
        }

        public override function get availableHeight():Number
        {
            return track.height - thumb.height + offsetBottom + offsetTop;
        }

        public override function toString():String
        {
            return "[CLIK ScrollBar " + name + "]";
        }

        protected override function configUI():void
        {
            super.configUI();
            var loc1:*;
            mouseChildren = loc1 = this.enabled;
            mouseEnabled = loc1;
            tabChildren = loc1 = _focusable;
            tabEnabled = loc1;
            addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.handleMouseWheel, false, 0, true);
            addEventListener(scaleform.clik.events.InputEvent.INPUT, handleInput, false, 0, true);
            if (this.upArrow) 
            {
                this.upArrow.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleUpArrowClick, false, 0, true);
                this.upArrow.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.handleUpArrowPress, false, 0, true);
                this.upArrow.focusTarget = this;
                this.upArrow.autoRepeat = true;
            }
            if (this.downArrow) 
            {
                this.downArrow.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleDownArrowClick, false, 0, true);
                this.downArrow.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.handleDownArrowPress, false, 0, true);
                this.downArrow.focusTarget = this;
                this.downArrow.autoRepeat = true;
            }
            thumb.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleThumbPress, false, 0, true);
            thumb.focusTarget = this;
            thumb.lockDragStateChange = true;
            track.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleTrackPress, false, 0, true);
            track.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleTrackClick, false, 0, true);
            if (track is scaleform.clik.core.UIComponent) 
                (track as scaleform.clik.core.UIComponent).focusTarget = this;
            track.autoRepeat = this.trackMode == scaleform.clik.constants.ScrollBarTrackMode.SCROLL_PAGE;
            return;
        }

        protected function scrollUp():void
        {
            this.position = this.position - _pageScrollSize;
            return;
        }

        protected function scrollDown():void
        {
            this.position = this.position + _pageScrollSize;
            return;
        }

        protected override function drawLayout():void
        {
            var loc1:*=NaN;
            thumb.y = track.y - offsetTop;
            if (isHorizontal) 
                constraints.update(_height, _width);
            else 
                constraints.update(_width, _height);
            if (isHorizontal && !(actualWidth == width)) 
            {
                loc1 = width / actualWidth;
                scaleY = loc1;
            }
            return;
        }

        protected override function updateThumb():void
        {
            var loc1:*=Math.max(1, _maxPosition - _minPosition + _pageSize);
            var loc2:*=track.height + offsetTop + offsetBottom;
            thumb.height = Math.max(_minThumbSize, Math.min(loc2, _pageSize / loc1 * loc2));
            if (thumb is scaleform.clik.core.UIComponent) 
                (thumb as scaleform.clik.core.UIComponent).validateNow();
            this.updateThumbPosition();
            return;
        }

        protected override function updateThumbPosition():void
        {
            var loc1:*=(_position - _minPosition) / (_maxPosition - _minPosition);
            var loc2:*=track.y - offsetTop;
            var loc3:*=Math.round(loc1 * this.availableHeight + loc2);
            thumb.y = Math.max(loc2, Math.min(track.y + track.height - thumb.height + offsetBottom, loc3));
            thumb.visible = !(isNaN(loc1) || isNaN(_pageSize) || _maxPosition <= 0 || _maxPosition == Infinity);
            var loc4:*=thumb.visible && this.enabled;
            if (this.upArrow) 
            {
                this.upArrow.enabled = loc4 && _position > _minPosition;
                this.upArrow.validateNow();
            }
            if (this.downArrow) 
            {
                this.downArrow.enabled = loc4 && _position < _maxPosition;
                this.downArrow.validateNow();
            }
            var loc5:*;
            track.mouseEnabled = loc5 = loc4;
            track.enabled = loc5;
            return;
        }

        protected function handleUpArrowClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            if (arg1.isRepeat) 
                this.scrollUp();
            return;
        }

        protected function handleUpArrowPress(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.scrollUp();
            return;
        }

        protected function handleDownArrowClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            if (arg1.isRepeat) 
                this.scrollDown();
            return;
        }

        protected function handleDownArrowPress(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.scrollDown();
            return;
        }

        protected function handleThumbPress(arg1:flash.events.Event):void
        {
            if (_isDragging) 
                return;
            _isDragging = true;
            stage.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.doDrag, false, 0, true);
            stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.endDrag, false, 0, true);
            this._dragOffset = new flash.geom.Point(0, mouseY - thumb.y);
            return;
        }

        protected function doDrag(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=(mouseY - this._dragOffset.y - track.y) / this.availableHeight;
            this.position = _minPosition + loc1 * (_maxPosition - _minPosition);
            return;
        }

        public var trackScrollPageSize:Number=1;

        protected var _dragOffset:flash.geom.Point;

        protected var _trackMode:String="scrollPage";

        protected var _trackScrollPosition:Number=-1;

        protected var _trackDragMouseIndex:Number=-1;

        public var upArrow:scaleform.clik.controls.Button;

        public var downArrow:scaleform.clik.controls.Button;
    }
}
