class gfx.controls.TileList extends gfx.controls.CoreList
{
    var _scrollBar, initialized, inspectableScrollBar, _parent, container, invalidate, __get__scrollBar, _rowHeight, __get__rowHeight, _columnWidth, __get__columnWidth, _rowCount, renderers, __width, setSize, __get__rowCount, _columnCount, __height, __get__columnCount, __get__direction, _disabled, __get__disabled, _selectedIndex, __get__selectedIndex, __set__scrollPosition, _dataProvider, __get__scrollPosition, __get__dataProvider, __set__selectedIndex, _name, __set__scrollBar, sizeIsInvalid, _width, _height, externalRenderers, _xscale, _yscale, createItemRenderer, __get__availableHeight, __get__availableWidth, drawRenderers, itemToLabel, focusEnabled, tabEnabled, _focused, gotoAndPlay, __set__columnCount, __set__columnWidth, __set__direction, __set__disabled, __set__rowCount, __set__rowHeight;
    function TileList()
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
                _scrollBar = container.attachMovie(value.toString(), "_scrollBar", 1000);
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
        this.drawScrollBar();
        this.updateScrollBar();
        //return (this.scrollBar());
        null;
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
            return;
        } // end if
        _rowHeight = value;
        this.invalidate();
        //return (this.rowHeight());
        null;
    } // End of the function
    function get columnWidth()
    {
        return (_columnWidth);
    } // End of the function
    function set columnWidth(value)
    {
        if (value == 0)
        {
            value = null;
            return;
        } // end if
        _columnWidth = value;
        this.invalidate();
        //return (this.columnWidth());
        null;
    } // End of the function
    function get rowCount()
    {
        return (totalRows);
    } // End of the function
    function set rowCount(value)
    {
        _rowCount = autoRowCount ? (Math.ceil(value / totalColumns)) : (value);
        var _loc2 = _rowHeight;
        if (_loc2 == null)
        {
            var _loc3 = renderers[0];
            _loc2 = _loc3.height;
        } // end if
        this.setSize(__width, _loc2 * _rowCount + margin * 2);
        //return (this.rowCount());
        null;
    } // End of the function
    function get columnCount()
    {
        return (totalColumns);
    } // End of the function
    function set columnCount(value)
    {
        _columnCount = value;
        var _loc2 = _columnWidth;
        if (_loc2 == null)
        {
            var _loc3 = renderers[0];
            _loc2 = _loc3.width;
        } // end if
        this.setSize(_loc2 * this.__get__columnCount(), __height);
        //return (this.columnCount());
        null;
    } // End of the function
    function get direction()
    {
        return (_direction);
    } // End of the function
    function set direction(value)
    {
        if (value == _direction)
        {
            return;
        } // end if
        _direction = value;
        this.invalidate();
        //return (this.direction());
        null;
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
    function get selectedIndex()
    {
        return (_selectedIndex);
    } // End of the function
    function set selectedIndex(value)
    {
        var _loc3 = this.getRendererAt(_selectedIndex);
        if (_loc3 != null)
        {
            _loc3.selected = false;
        } // end if
        super.__set__selectedIndex(value);
        _loc3 = this.getRendererAt(_selectedIndex);
        if (totalRows * totalColumns == 0)
        {
            return;
        }
        else if (_loc3 != null)
        {
            _loc3.selected = true;
        }
        else
        {
            this.scrollToIndex(_selectedIndex);
        } // end else if
        //return (this.selectedIndex());
        null;
    } // End of the function
    function scrollToIndex(index)
    {
        var _loc2 = _direction == "horizontal" ? (totalRows) : (totalColumns);
        var _loc3 = _scrollPosition * _loc2;
        if (_loc2 == 0)
        {
            return;
        } // end if
        if (index >= _loc3 && index < _loc3 + totalRows * totalColumns)
        {
            return;
        }
        else if (index < _loc3)
        {
            this.__set__scrollPosition(index / _loc2 >> 0);
        }
        else
        {
            this.__set__scrollPosition(Math.floor(index / _loc2) - (_direction == "horizontal" ? (totalColumns) : (totalRows)) + 1);
        } // end else if
    } // End of the function
    function get scrollPosition()
    {
        return (_scrollPosition);
    } // End of the function
    function set scrollPosition(value)
    {
        var _loc3 = Math.ceil((_dataProvider.length - totalRows * totalColumns) / (_direction == "horizontal" ? (totalRows) : (totalColumns)));
        value = Math.max(0, Math.min(_loc3, Math.round(value)));
        if (_scrollPosition == value)
        {
            return;
        } // end if
        _scrollPosition = value;
        this.invalidateData();
        this.updateScrollBar();
        //return (this.scrollPosition());
        null;
    } // End of the function
    function invalidateData()
    {
        if (_dataProvider.length == 0)
        {
            return;
        } // end if
        var _loc3 = _direction == "horizontal" ? (totalRows) : (totalColumns);
        var _loc4 = Math.ceil(_dataProvider.length / _loc3);
        var _loc5 = _loc4 - (_direction == "horizontal" ? (totalColumns) : (totalRows));
        _scrollPosition = Math.max(0, Math.min(_loc5, _scrollPosition));
        var _loc2 = _scrollPosition * _loc3;
        var _loc6 = _loc2 + totalColumns * totalRows - 1;
        _dataProvider.requestItemRange(_loc2, _loc6, this, "populateData");
    } // End of the function
    function get availableWidth()
    {
        return ((autoScrollBar && _direction == "vertical" ? (__width - _scrollBar._width) : (__width)) - margin * 2);
    } // End of the function
    function get availableHeight()
    {
        return ((autoScrollBar && _direction == "horizontal" ? (__height - _scrollBar._height) : (__height)) - margin * 2);
    } // End of the function
    function setRendererList(value, newColumnCount)
    {
        if (newColumnCount != null)
        {
            externalColumnCount = newColumnCount;
        } // end if
        super.setRendererList(value);
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
            var _loc7 = _loc3.handleInput(details, pathToFocus.slice(1));
            if (_loc7)
            {
                return (true);
            } // end if
        } // end if
        var _loc8 = details.value == "keyDown";
        var _loc4 = details.navEquivalent;
        var _loc2;
        if (_direction == "horizontal")
        {
            switch (_loc4)
            {
                case gfx.ui.NavigationCode.RIGHT:
                {
                    _loc2 = _selectedIndex + totalRows;
                    break;
                } 
                case gfx.ui.NavigationCode.LEFT:
                {
                    _loc2 = _selectedIndex - totalRows;
                    break;
                } 
                case gfx.ui.NavigationCode.UP:
                {
                    _loc2 = _selectedIndex - 1;
                    break;
                } 
                case gfx.ui.NavigationCode.DOWN:
                {
                    _loc2 = _selectedIndex + 1;
                    break;
                } 
            } // End of switch
        }
        else
        {
            switch (_loc4)
            {
                case gfx.ui.NavigationCode.DOWN:
                {
                    _loc2 = _selectedIndex + totalColumns;
                    break;
                } 
                case gfx.ui.NavigationCode.UP:
                {
                    _loc2 = _selectedIndex - totalColumns;
                    break;
                } 
                case gfx.ui.NavigationCode.LEFT:
                {
                    _loc2 = _selectedIndex - 1;
                    break;
                } 
                case gfx.ui.NavigationCode.RIGHT:
                {
                    _loc2 = _selectedIndex + 1;
                    break;
                } 
            } // End of switch
        } // end else if
        switch (_loc4)
        {
            case gfx.ui.NavigationCode.HOME:
            {
                _loc2 = 0;
                break;
            } 
            case gfx.ui.NavigationCode.END:
            {
                _loc2 = _dataProvider.length - 1;
                break;
            } 
            case gfx.ui.NavigationCode.PAGE_DOWN:
            {
                _loc2 = Math.min(_dataProvider.length - 1, _selectedIndex + totalColumns * totalRows);
                break;
            } 
            case gfx.ui.NavigationCode.PAGE_UP:
            {
                _loc2 = Math.max(0, _selectedIndex - totalColumns * totalRows);
                break;
            } 
        } // End of switch
        if (_loc2 != null)
        {
            if (!_loc8)
            {
                return (true);
            } // end if
            if (_loc2 >= 0 && _loc2 < this.__get__dataProvider().length)
            {
                this.__set__selectedIndex(Math.max(0, Math.min(_dataProvider.length - 1, _loc2)));
                return (true);
            }
            else if (wrapping == "stick")
            {
                _loc2 = Math.max(0, Math.min(_dataProvider.length - 1, _loc2));
                if (this.__get__selectedIndex() != _loc2)
                {
                    this.__set__selectedIndex(_loc2);
                } // end if
                return (true);
            }
            else if (wrapping == "wrap")
            {
                this.__set__selectedIndex(_loc2 < 0 ? (_dataProvider.length - 1) : (this.__get__selectedIndex() < _dataProvider.length - 1 ? (_dataProvider.length - 1) : (0)));
                return (true);
            } // end else if
        } // end else if
        return (false);
    } // End of the function
    function toString()
    {
        return ("[Scaleform TileList " + _name + "]");
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
            totalColumns = externalColumnCount == 0 ? (1) : (externalColumnCount);
            totalRows = Math.ceil(renderers.length / totalColumns);
        }
        else
        {
            container._xscale = 10000 / _xscale;
            container._yscale = 10000 / _yscale;
            var _loc4 = _columnWidth;
            var _loc3 = _rowHeight;
            if (_loc3 == null || _loc4 == null)
            {
                var _loc5 = this.createItemRenderer(99);
                if (_loc4 == null)
                {
                    _loc4 = _loc5._width;
                } // end if
                if (_loc3 == null)
                {
                    _loc3 = _loc5._height;
                } // end if
                _loc5.removeMovieClip();
            } // end if
            totalRows = this.__get__availableHeight() / _loc3 >> 0;
            totalColumns = this.__get__availableWidth() / _loc4 >> 0;
            var _loc6 = totalRows * totalColumns;
            this.drawRenderers(_loc6);
            this.drawLayout(_loc4, _loc3);
            this.updateScrollBar();
            this.drawScrollBar();
        } // end else if
        this.updateScrollBar();
        this.invalidateData();
        this.setState();
        super.draw();
    } // End of the function
    function drawLayout(rendererWidth, rendererHeight)
    {
        for (var _loc2 = 0; _loc2 < renderers.length; ++_loc2)
        {
            var _loc3 = renderers[_loc2];
            if (this.__get__direction() == "horizontal")
            {
                _loc3._y = _loc2 % totalRows * rendererHeight + margin;
                _loc3._x = (_loc2 / totalRows >> 0) * rendererWidth + margin;
            }
            else
            {
                _loc3._x = _loc2 % totalColumns * rendererWidth + margin;
                _loc3._y = (_loc2 / totalColumns >> 0) * rendererHeight + margin;
            } // end else if
            renderers[_loc2].setSize(rendererWidth, rendererHeight);
        } // end of for
        this.drawScrollBar();
    } // End of the function
    function changeFocus()
    {
        super.changeFocus();
        this.setState();
    } // End of the function
    function populateData(data)
    {
        for (var _loc2 = 0; _loc2 < totalColumns * totalRows; ++_loc2)
        {
            var _loc4 = renderers[_loc2];
            var _loc3 = _scrollPosition * (_direction == "horizontal" ? (totalRows) : (totalColumns)) + _loc2;
            renderers[_loc2].setListData(_loc3, this.itemToLabel(data[_loc2]), _selectedIndex == _loc3);
            _loc4.setData(data[_loc2]);
        } // end of for
    } // End of the function
    function getRendererAt(index)
    {
        var _loc2 = index - _scrollPosition * (_direction == "horizontal" ? (totalRows) : (totalColumns));
        if (_loc2 > _dataProvider.length - 1)
        {
            return (null);
        } // end if
        return (renderers[_loc2]);
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
    function drawScrollBar()
    {
        if (!autoScrollBar)
        {
            return;
        } // end if
        _scrollBar.direction = _direction;
        if (_direction == "vertical")
        {
            _scrollBar._rotation = 0;
            _scrollBar._x = __width - _scrollBar._width + margin;
            _scrollBar._y = margin;
            _scrollBar.height = __height - margin * 2;
        }
        else
        {
            _scrollBar._rotation = -90;
            _scrollBar._x = margin;
            _scrollBar._y = __height - margin;
            _scrollBar.width = __width - margin * 2;
        } // end else if
    } // End of the function
    function updateScrollBar()
    {
        var _loc2;
        if (this.__get__direction() == "horizontal")
        {
            _loc2 = Math.ceil(_dataProvider.length / totalRows) - totalColumns;
        }
        else
        {
            _loc2 = Math.ceil(_dataProvider.length / totalColumns) - totalRows;
        } // end else if
        if (_scrollBar.setScrollProperties != null)
        {
            _scrollBar.setScrollProperties(_direction == "horizontal" ? (totalColumns) : (totalRows), 0, _loc2);
        }
        else
        {
            _scrollBar.minimum = 0;
            _scrollBar.maximum = _loc2;
        } // end else if
        _scrollBar.position = _scrollPosition;
        _scrollBar.trackScrollPageSize = Math.max(1, _direction == "horizontal" ? (totalColumns) : (totalRows));
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
    var _direction = "horizontal";
    var _scrollPosition = 0;
    var totalRows = 0;
    var totalColumns = 0;
    var autoScrollBar = false;
    var externalColumnCount = 0;
    var margin = 1;
} // End of Class
