class gfx.controls.ScrollBar extends gfx.controls.ScrollIndicator
{
    var _disabled, gotoAndPlay, initialized, upArrow, downArrow, track, __get__disabled, __get__position, __get__trackMode, thumb, offsetBottom, offsetTop, _name, onRelease, _rotation, constraints, direction, __width, __height, _scrollTarget, setScrollProperties, invalidate, maxPosition, minPosition, pageSize, _position, __get__availableHeight, __set__position, isDragging, onMouseMove, onMouseUp, _ymouse, dragOffset, trackDragMouseIndex, __set__disabled, __set__trackMode;
    function ScrollBar()
    {
        super();
    } // End of the function
    function get disabled()
    {
        return (_disabled);
    } // End of the function
    function set disabled(value)
    {
        if (_disabled == value)
        {
            return;
        } // end if
        super.__set__disabled(value);
        this.gotoAndPlay(_disabled ? ("disabled") : ("default"));
        if (initialized)
        {
            upArrow.__set__disabled(_disabled);
            downArrow.__set__disabled(_disabled);
            track.__set__disabled(_disabled);
        } // end if
        //return (this.disabled());
        null;
    } // End of the function
    function get position()
    {
        //return (super.position());
    } // End of the function
    function set position(value)
    {
        value = Math.round(value);
        if (value == this.__get__position())
        {
            return;
        } // end if
        super.__set__position(value);
        this.updateScrollTarget();
        //return (this.position());
        null;
    } // End of the function
    function get trackMode()
    {
        return (_trackMode);
    } // End of the function
    function set trackMode(value)
    {
        if (value == _trackMode)
        {
            return;
        } // end if
        _trackMode = value;
        if (initialized)
        {
            track.autoRepeat = this.__get__trackMode() == "scrollPage";
        } // end if
        //return (this.trackMode());
        null;
    } // End of the function
    function get availableHeight()
    {
        //return (track.height() - thumb.__get__height() + offsetBottom + offsetTop);
    } // End of the function
    function toString()
    {
        return ("[Scaleform ScrollBar " + _name + "]");
    } // End of the function
    function configUI()
    {
        super.configUI();
        delete this.onRelease;
        if (downArrow == null)
        {
            downArrow = new gfx.controls.Button();
        } // end if
        if (upArrow == null)
        {
            upArrow = new gfx.controls.Button();
        } // end if
        upArrow.addEventListener("click", this, "scrollUp");
        downArrow.addEventListener("click", this, "scrollDown");
        thumb.addEventListener("press", this, "beginDrag");
        track.addEventListener("press", this, "beginTrackScroll");
        track.addEventListener("click", this, "trackScroll");
        upArrow.useHandCursor = !_disabled;
        downArrow.useHandCursor = !_disabled;
        thumb.useHandCursor = !_disabled;
        upArrow.__set__disabled(_disabled);
        downArrow.__set__disabled(_disabled);
        track.__set__disabled(_disabled);
        upArrow.focusTarget = this;
        downArrow.focusTarget = this;
        upArrow.autoRepeat = true;
        downArrow.autoRepeat = true;
        track.autoRepeat = this.__get__trackMode() == "scrollPage";
        thumb.lockDragStateChange = true;
        Mouse.addListener(this);
        var _loc3 = _rotation;
        _rotation = 0;
        constraints = new gfx.utils.Constraints(this);
        constraints.addElement(downArrow, gfx.utils.Constraints.BOTTOM);
        constraints.addElement(track, gfx.utils.Constraints.TOP | gfx.utils.Constraints.BOTTOM);
        _rotation = _loc3;
    } // End of the function
    function draw()
    {
        if (direction == "horizontal")
        {
            constraints.update(__height, __width);
        }
        else
        {
            constraints.update(__width, __height);
        } // end else if
        if (_scrollTarget instanceof TextField)
        {
            this.setScrollProperties(_scrollTarget.bottomScroll - _scrollTarget.scroll, 1, _scrollTarget.maxscroll);
        }
        else
        {
            this.updateThumb();
        } // end else if
    } // End of the function
    function updateThumb()
    {
        if (!initialized)
        {
            this.invalidate();
            return;
        } // end if
        if (_disabled)
        {
            return;
        } // end if
        var _loc5 = Math.max(1, maxPosition - minPosition + pageSize);
        var _loc4 = track.__get__height() + offsetTop + offsetBottom;
        var _loc6 = _loc4;
        thumb.__set__height(Math.max(10, Math.min(_loc4, pageSize / _loc5 * _loc6)));
        var _loc2 = (_position - minPosition) / (maxPosition - minPosition);
        var _loc3 = track._y - offsetTop;
        var _loc7 = _loc2 * this.__get__availableHeight() + _loc3;
        thumb._y = Math.max(_loc3, Math.min(track._y + track.__get__height() - thumb.__get__height() + offsetBottom, _loc7));
        thumb.__set__visible(!(isNaN(_loc2) || maxPosition <= 0 || maxPosition == Infinity));
        if (thumb.__get__visible())
        {
            track.__set__disabled(false);
            if (_position == minPosition)
            {
                upArrow.__set__disabled(true);
            }
            else
            {
                upArrow.__set__disabled(false);
            } // end else if
            if (_position == maxPosition)
            {
                downArrow.__set__disabled(true);
            }
            else
            {
                downArrow.__set__disabled(false);
            } // end else if
        }
        else
        {
            upArrow.__set__disabled(true);
            downArrow.__set__disabled(true);
            track.__set__disabled(true);
        } // end else if
    } // End of the function
    function scrollUp()
    {
        this.__set__position(--this.__get__position());
    } // End of the function
    function scrollDown()
    {
        this.__set__position(++this.__get__position());
    } // End of the function
    function beginDrag()
    {
        if (isDragging == true)
        {
            return;
        } // end if
        isDragging = true;
        onMouseMove = doDrag;
        onMouseUp = endDrag;
        dragOffset = {y: _ymouse - thumb._y};
    } // End of the function
    function doDrag()
    {
        var _loc2 = (_ymouse - dragOffset.y - track._y) / this.__get__availableHeight();
        this.__set__position(minPosition + _loc2 * (maxPosition - minPosition));
    } // End of the function
    function endDrag()
    {
        delete this.onMouseUp;
        delete this.onMouseMove;
        isDragging = false;
        if (trackDragMouseIndex != undefined)
        {
            if (!thumb.hitTest(_root._xmouse, _root._ymouse))
            {
                thumb.onReleaseOutside(trackDragMouseIndex);
            }
            else
            {
                thumb.onRelease(trackDragMouseIndex);
            } // end if
        } // end else if
        delete this.trackDragMouseIndex;
    } // End of the function
    function beginTrackScroll(e)
    {
        var _loc2 = (_ymouse - thumb.__get__height() / 2 - track._y) / this.__get__availableHeight();
        trackScrollPosition = Math.round(_loc2 * (maxPosition - minPosition) + minPosition);
        if (Key.isDown(16) || this.__get__trackMode() == "scrollToCursor")
        {
            this.__set__position(trackScrollPosition);
            trackDragMouseIndex = e.mouseIndex;
            thumb.onPress(trackDragMouseIndex);
            dragOffset = {y: thumb.__get__height() / 2};
        } // end if
    } // End of the function
    function trackScroll()
    {
        if (isDragging || this.__get__position() == trackScrollPosition)
        {
            return;
        } // end if
        var _loc3 = this.__get__position() < trackScrollPosition ? (trackScrollPageSize) : (-trackScrollPageSize);
        var _loc2 = this.__get__position() + _loc3;
        this.__set__position(_loc3 < 0 ? (Math.max(_loc2, trackScrollPosition)) : (Math.min(_loc2, trackScrollPosition)));
    } // End of the function
    function updateScrollTarget()
    {
        if (_scrollTarget == null)
        {
            return;
        } // end if
        if (_scrollTarget && !_disabled)
        {
            _scrollTarget.scroll = _position;
        } // end if
    } // End of the function
    function scrollWheel(delta)
    {
        position = position - delta;
    } // End of the function
    var trackScrollPageSize = 1;
    var _trackMode = "scrollPage";
    var trackScrollPosition = -1;
} // End of Class
