class gfx.controls.ScrollingList extends gfx.controls.CoreList
{
    var _scrollBar, initialized, inspectableScrollBar, _parent, container, invalidate, __get__scrollBar, _rowHeight, __get__rowHeight, _dataProvider, __get__scrollPosition, _selectedIndex, __get__selectedIndex, _disabled, __get__disabled, __set__scrollPosition, renderers, createItemRenderer, __set__height, __get__rowCount, __set__selectedIndex, __width, _name, __set__scrollBar, sizeIsInvalid, _width, __height, _height, externalRenderers, _xscale, _yscale, drawRenderers, __get__availableWidth, itemToLabel, __get__dataProvider, focusEnabled, tabEnabled, _focused, gotoAndPlay, __set__disabled, __set__rowCount, __set__rowHeight;
    function ScrollingList()
    {
        super();
    } // End of the function
    function get scrollBar()
    {
        return (_scrollBar);
    } // End of the function
    function set scrollBar(value)
    {
        if (!initialized)
        {
            inspectableScrollBar = value;
            return;
        } // end if
        if (_scrollBar != null)
        {
            _scrollBar.removeEventListener("scroll", this, "handleScroll");
            _scrollBar.removeEventListener("change", this, "handleScroll");
            _scrollBar.focusTarget = null;
            if (autoScrollBar)
            {
                _scrollBar.removeMovieClip();
            } // end if
        } // end if
        autoScrollBar = false;
        if (typeof(value) == "string")
        {
            _scrollBar = (MovieClip)(_parent[value.toString()]);
            if (_scrollBar == null)
            {
                _scrollBar = container.attachMovie(value.toString(), "_scrollBar", 1000, {offsetTop: thumbOffsetTop, offsetBottom: thumbOffsetBottom});
                if (_scrollBar != null)
                {
                    autoScrollBar = true;
                } // end if
            } // end if
        }
        else
        {
            _scrollBar = (MovieClip)(value);
        } // end else if
        this.invalidate();
        if (_scrollBar == null)
        {
            return;
        } // end if
        if (_scrollBar.setScrollProperties != null)
        {
            _scrollBar.addEventListener("scroll", this, "handleScroll");
        }
        else
        {
            _scrollBar.addEventListener("change", this, "handleScroll");
        } // end else if
        _scrollBar.focusTarget = this;
        _scrollBar.tabEnabled = false;
        this.updateScrollBar();
        //return (this.scrollBar());
        //null;
    } // End of the function
    function get rowHeight()
    {
        return (_rowHeight);
    } // End of the function
    function set rowHeight(value)
    {
        if (value == 0)
        {
            value = null;
        } // end if
        _rowHeight = value;
        this.invalidate();
        //return (this.rowHeight());
        //null;
    } // End of the function
    function get scrollPosition()
    {
        return (_scrollPosition);
    } // End of the function
    function set scrollPosition(value)
    {
        value = Math.max(0, Math.min(_dataProvider.length - totalRenderers, Math.round(value)));
        if (_scrollPosition == value)
        {
            return;
        } // end if
        _scrollPosition = value;
        this.invalidateData();
        this.updateScrollBar();
        //return (this.scrollPosition());
        //null;
    } // End of the function
    function get selectedIndex()
    {
        return (_selectedIndex);
    } // End of the function
    function set selectedIndex(value)
    {
        if (value == _selectedIndex)
        {
            return;
        } // end if
        var _loc3 = this.getRendererAt(_selectedIndex);
        if (_loc3 != null)
        {
            _loc3.selected = false;
        } // end if
        super.__set__selectedIndex(value);
        if (totalRenderers == 0)
        {
            return;
        } // end if
        _loc3 = this.getRendererAt(_selectedIndex);
        if (_loc3 != null)
        {
            _loc3.selected = true;
        }
        else
        {
            this.scrollToIndex(_selectedIndex);
        } // end else if
        //return (this.selectedIndex());
        //null;
    } // End of the function
    function get disabled()
    {
        return (_disabled);
    } // End of the function
    function set disabled(value)
    {
        super.__set__disabled(value);
        if (initialized)
        {
            this.setState();
        } // end if
        //return (this.disabled());
        null;
    } // End of the function
    function scrollToIndex(index)
    {
        if (totalRenderers == 0)
        {
            return;
        } // end if
        if (index >= _scrollPosition && index < _scrollPosition + totalRenderers)
        {
            return;
        }
        else if (index < _scrollPosition)
        {
            this.__set__scrollPosition(index);
        }
        else
        {
            this.__set__scrollPosition(index - (totalRenderers - 1));
        } // end else if
    } // End of the function
    function get rowCount()
    {
        return (totalRenderers);
    } // End of the function
    function set rowCount(value)
    {
        var _loc3 = _rowHeight;
        if (_loc3 == null)
        {
            var _loc2 = renderers[0];
            if (_loc2 == null)
            {
                _loc2 = this.createItemRenderer(0);
                if (_loc2 == null)
                {
                    return;
                } // end if
                _loc3 = _loc2._height;
                _loc2.removeMovieClip();
            }
            else
            {
                _loc3 = _loc2.height;
            } // end else if
            if (_loc3 == null || _loc3 == 0)
            {
                return;
            } // end if
        } // end if
        this.__set__height(_loc3 * value + margin * 2 + paddingTop + paddingBottom);
        //return (this.rowCount());
        null;
    } // End of the function
    function invalidateData()
    {
        _scrollPosition = Math.min(Math.max(0, _dataProvider.length - totalRenderers), _scrollPosition);
        this.__set__selectedIndex(Math.min(_dataProvider.length - 1, _selectedIndex));
        _dataProvider.requestItemRange(_scrollPosition, Math.min(_dataProvider.length - 1, _scrollPosition + totalRenderers - 1), this, "populateData");
    } // End of the function
    function handleInput(details, pathToFocus)
    {
        if (pathToFocus == null)
        {
            pathToFocus = [];
        } // end if
        var _loc3 = this.getRendererAt(_selectedIndex);
        if (_loc3 != null && _loc3.handleInput != null)
        {
            var _loc6 = _loc3.handleInput(details, pathToFocus.slice(1));
            if (_loc6)
            {
                return (true);
            } // end if
        } // end if
        var _loc2 = details.value == "keyDown";
        switch (details.navEquivalent)
        {
            case gfx.ui.NavigationCode.UP:
            {
                if (_selectedIndex > 0)
                {
                    if (_loc2)
                    {
                        // fix decompiler errors (sirmax2)
                        this.selectedIndex = this.selectedIndex - 1;
                    } // end if
                    return (true);
                }
                else if (wrapping == "stick")
                {
                    return (true);
                }
                else if (wrapping == "wrap")
                {
                    if (_loc2)
                    {
                        this.__set__selectedIndex(_dataProvider.length - 1);
                    } // end if
                    return (true);
                }
                else
                {
                    return (false);
                } // end else if
                break;
            }
            case gfx.ui.NavigationCode.DOWN:
            {
                if (_selectedIndex < _dataProvider.length - 1)
                {
                    if (_loc2)
                    {
                        // fix decompiler errors (sirmax2)
                        this.selectedIndex = this.selectedIndex + 1;
                    } // end if
                    return (true);
                }
                else if (wrapping == "stick")
                {
                    return (true);
                }
                else if (wrapping == "wrap")
                {
                    if (_loc2)
                    {
                        this.__set__selectedIndex(0);
                    } // end if
                    return (true);
                }
                else
                {
                    return (false);
                } // end else if
                break;
            }
            case gfx.ui.NavigationCode.END:
            {
                if (!_loc2)
                {
                    this.__set__selectedIndex(_dataProvider.length - 1);
                } // end if
                return (true);
            }
            case gfx.ui.NavigationCode.HOME:
            {
                if (!_loc2)
                {
                    this.__set__selectedIndex(0);
                } // end if
                return (true);
            }
            case gfx.ui.NavigationCode.PAGE_UP:
            {
                if (_loc2)
                {
                    this.__set__selectedIndex(Math.max(0, _selectedIndex - totalRenderers));
                } // end if
                return (true);
            }
            case gfx.ui.NavigationCode.PAGE_DOWN:
            {
                if (_loc2)
                {
                    this.__set__selectedIndex(Math.min(_dataProvider.length - 1, _selectedIndex + totalRenderers));
                } // end if
                return (true);
            }
        } // End of switch
        return (false);
    } // End of the function
    function get availableWidth()
    {
        return (autoScrollBar ? (__width - _scrollBar._width) : (__width));
    } // End of the function
    function toString()
    {
        return ("[Scaleform ScrollingList " + _name + "]");
    } // End of the function
    function configUI()
    {
        super.configUI();
        if (inspectableScrollBar != "" && inspectableScrollBar != null)
        {
            this.__set__scrollBar(inspectableScrollBar);
            inspectableScrollBar = null;
        } // end if
    } // End of the function
    function draw()
    {
        if (sizeIsInvalid)
        {
            _width = __width;
            _height = __height;
        } // end if
        if (externalRenderers)
        {
            totalRenderers = renderers.length;
        }
        else
        {
            container._xscale = 10000 / _xscale;
            container._yscale = 10000 / _yscale;
            var _loc3 = _rowHeight;
            if (_loc3 == null)
            {
                var _loc4 = this.createItemRenderer(99);
                _loc3 = _loc4._height;
                _loc4.removeMovieClip();
            } // end if
            var _loc5 = margin * 2 + paddingTop + paddingBottom;
            totalRenderers = Math.max(0, (__height - _loc5 + 0.050000) / _loc3 >> 0);
            this.drawRenderers(totalRenderers);
            this.drawLayout(this.__get__availableWidth(), _loc3);
        } // end else if
        this.updateScrollBar();
        this.invalidateData();
        this.setState();
        super.draw();
    } // End of the function
    function drawLayout(rendererWidth, rendererHeight)
    {
        var _loc5 = paddingLeft + paddingRight + margin * 2;
        rendererWidth = rendererWidth - _loc5;
        for (var _loc2 = 0; _loc2 < renderers.length; ++_loc2)
        {
            renderers[_loc2]._x = margin + paddingLeft;
            renderers[_loc2]._y = _loc2 * rendererHeight + margin + paddingTop;
            renderers[_loc2].setSize(rendererWidth, rendererHeight);
        } // end of for
        this.drawScrollBar();
    } // End of the function
    function drawScrollBar()
    {
        if (!autoScrollBar)
        {
            return;
        } // end if
        _scrollBar._x = __width - _scrollBar._width - margin;
        _scrollBar._y = margin;
        _scrollBar.height = __height - margin * 2;
    } // End of the function
    function changeFocus()
    {
        super.changeFocus();
        this.setState();
    } // End of the function
    function populateData(data)
    {
        for (var _loc2 = 0; _loc2 < renderers.length; ++_loc2)
        {
            var _loc4 = renderers[_loc2];
            var _loc3 = _scrollPosition + _loc2;
            renderers[_loc2].setListData(_loc3, this.itemToLabel(data[_loc2]), _selectedIndex == _loc3);
            _loc4.setData(data[_loc2]);
        } // end of for
        this.updateScrollBar();
    } // End of the function
    function handleScroll(event)
    {
        var _loc2 = event.target.position;
        if (isNaN(_loc2))
        {
            return;
        } // end if
        this.__set__scrollPosition(_loc2);
    } // End of the function
    function updateScrollBar()
    {
        var _loc2 = Math.max(0, this.__get__dataProvider().length - totalRenderers);
        if (_scrollBar.setScrollProperties != null)
        {
            _scrollBar.setScrollProperties(totalRenderers * thumbSizeFactor, 0, _loc2);
        }
        else
        {
            _scrollBar.minimum = 0;
            _scrollBar.maximum = _loc2;
        } // end else if
        _scrollBar.position = _scrollPosition;
        _scrollBar.trackScrollPageSize = Math.max(1, totalRenderers);
    } // End of the function
    function getRendererAt(index)
    {
        return (renderers[index - _scrollPosition]);
    } // End of the function
    function scrollWheel(delta)
    {
        if (_disabled)
        {
            return;
        } // end if
        this.__set__scrollPosition(_scrollPosition - delta);
    } // End of the function
    function setState()
    {
        tabEnabled = focusEnabled = !_disabled;
        this.gotoAndPlay(_disabled ? ("disabled") : (_focused ? ("focused") : ("default")));
        if (_scrollBar)
        {
            _scrollBar.disabled = _disabled;
        } // end if
        for (var _loc2 = 0; _loc2 < renderers.length; ++_loc2)
        {
            renderers[_loc2].disabled = _disabled;
        } // end of for
    } // End of the function
    var wrapping = "normal";
    var autoRowCount = false;
    var _scrollPosition = 0;
    var totalRenderers = 0;
    var autoScrollBar = false;
    var margin = 1;
    var paddingTop = 0;
    var paddingBottom = 0;
    var paddingLeft = 0;
    var paddingRight = 0;
    var thumbOffsetTop = 0;
    var thumbOffsetBottom = 0;
    var thumbSizeFactor = 1;
} // End of Class
