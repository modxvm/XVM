class gfx.controls.ScrollIndicator extends gfx.core.UIComponent
{
    var tabChildren, _disabled, tabEnabled, focusEnabled, _scrollTarget, initialized, thumb, __get__disabled, pageSize, pageScrollSize, dispatchEvent, invalidate, __get__position, focusTarget, __get__scrollTarget, __height, __width, _name, track, useHandCursor, initSize, _rotation, inspectableScrollTarget, _parent, __set__scrollTarget, __get__availableHeight, lastVScrollPos, __set__position, scrollerIntervalID, __set__disabled;
    function ScrollIndicator()
    {
        super();
        tabChildren = false;
        focusEnabled = tabEnabled = !_disabled;
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
        focusEnabled = tabEnabled = !_disabled;
        if (_scrollTarget)
        {
            tabEnabled = false;
        } // end if
        if (initialized)
        {
            thumb.__set__disabled(_disabled);
        } // end if
        //return (this.disabled());
        null;
    } // End of the function
    function setScrollProperties(pageSize, minPosition, maxPosition, pageScrollSize)
    {
        this.pageSize = pageSize;
        this.pageScrollSize = pageScrollSize;
        this.minPosition = minPosition;
        this.maxPosition = maxPosition;
        this.updateThumb();
    } // End of the function
    function get position()
    {
        return (_position);
    } // End of the function
    function set position(value)
    {
        if (value == _position)
        {
            return;
        } // end if
        _position = Math.max(minPosition, Math.min(maxPosition, value));
        this.dispatchEvent({type: "scroll", position: _position});
        this.invalidate();
        //return (this.position());
        null;
    } // End of the function
    function update()
    {
    } // End of the function
    function get scrollTarget()
    {
        return (_scrollTarget);
    } // End of the function
    function set scrollTarget(value)
    {
        var _loc2 = _scrollTarget;
        _scrollTarget = value;
        if (_loc2 && value._parent != _loc2)
        {
            _loc2.removeListener(this);
            if (_loc2.scrollBar != null)
            {
                _loc2.scrollBar = null;
            } // end if
            focusTarget = null;
            _loc2.noAutoSelection = false;
        } // end if
        if (value instanceof gfx.core.UIComponent && value.scrollBar !== null)
        {
            value.scrollBar = this;
            return;
        } // end if
        if (_scrollTarget == null)
        {
            tabEnabled = true;
            return;
        } // end if
        _scrollTarget.addListener(this);
        _scrollTarget.noAutoSelection = true;
        focusTarget = _scrollTarget;
        tabEnabled = false;
        this.onScroller();
        //return (this.scrollTarget());
        null;
    } // End of the function
    function get availableHeight()
    {
        //return ((direction == "horizontal" ? (__width) : (__height)) - thumb.height() + offsetBottom + offsetTop);
    } // End of the function
    function toString()
    {
        return ("[Scaleform ScrollIndicator " + _name + "]");
    } // End of the function
    function configUI()
    {
        super.configUI();
        if (track == null)
        {
            track = new gfx.controls.Button();
        } // end if
        thumb.focusTarget = this;
        track.focusTarget = this;
        thumb.__set__disabled(_disabled);
        function onRelease()
        {
        } // End of the function
        useHandCursor = false;
        this.initSize();
        direction = _rotation != 0 ? ("horizontal") : ("vertical");
        if (inspectableScrollTarget != null)
        {
            var _loc3 = _parent[inspectableScrollTarget];
            if (_loc3 != null)
            {
                this.__set__scrollTarget(_loc3);
            } // end if
            inspectableScrollTarget = null;
        } // end if
    } // End of the function
    function draw()
    {
        track._height = direction == "horizontal" ? (__width) : (__height);
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
        if (!thumb.initialized)
        {
            this.invalidate();
            return;
        } // end if
        if (_disabled)
        {
            return;
        } // end if
        var _loc5 = Math.max(1, maxPosition - minPosition + pageSize);
        var _loc4 = (direction == "horizontal" ? (__width) : (__height)) + offsetTop + offsetBottom;
        thumb.__set__height(Math.max(10, pageSize / _loc5 * _loc4));
        var _loc2 = (this.__get__position() - minPosition) / (maxPosition - minPosition);
        var _loc3 = -offsetTop;
        var _loc6 = _loc2 * this.__get__availableHeight() + _loc3;
        thumb._y = Math.max(_loc3, Math.min(_loc4 - offsetTop, _loc6));
        thumb.__set__visible(!(isNaN(_loc2) || maxPosition == 0));
    } // End of the function
    function onScroller()
    {
        if (isDragging)
        {
            return;
        } // end if
        if (lastVScrollPos == _scrollTarget.scroll)
        {
            delete this.lastVScrollPos;
            return;
        } // end if
        this.setScrollProperties(_scrollTarget.bottomScroll - _scrollTarget.scroll, 1, _scrollTarget.maxscroll);
        this.__set__position(_scrollTarget.scroll);
        lastVScrollPos = _scrollTarget.scroll;
        if (scrollerIntervalID == undefined)
        {
            scrollerIntervalID = setInterval(this, "scrollerDelayUpdate", 10);
        } // end if
    } // End of the function
    function scrollerDelayUpdate()
    {
        this.onScroller();
        clearInterval(scrollerIntervalID);
        delete this.scrollerIntervalID;
    } // End of the function
    var direction = "vertical";
    var minPosition = 0;
    var maxPosition = 10;
    var _position = 5;
    var offsetTop = 0;
    var offsetBottom = 0;
    var isDragging = false;
} // End of Class
