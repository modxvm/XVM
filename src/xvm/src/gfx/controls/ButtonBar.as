class gfx.controls.ButtonBar extends gfx.core.UIComponent
{
    var renderers, _disabled, tabEnabled, focusEnabled, tabChildren, initialized, __get__disabled, _dataProvider, invalidate, __get__dataProvider, __get__itemRenderer, __get__spacing, __get__direction, __get__autoSize, __get__buttonWidth, __get__selectedItem, dispatchEvent, __get__selectedIndex, __get__labelField, _labelFunction, __get__labelFunction, __set__selectedIndex, _name, _focused, __set__autoSize, __set__buttonWidth, __get__data, __set__dataProvider, __set__direction, __set__disabled, __set__itemRenderer, __set__labelField, __set__labelFunction, __set__spacing;
    function ButtonBar()
    {
        super();
        renderers = [];
        focusEnabled = tabEnabled = !_disabled;
        tabChildren = false;
    } // End of the function
    function get disabled()
    {
        return (_disabled);
    } // End of the function
    function set disabled(value)
    {
        super.__set__disabled(value);
        focusEnabled = tabEnabled = !_disabled;
        if (!initialized)
        {
            return;
        } // end if
        for (var _loc3 = 0; _loc3 < renderers.length; ++_loc3)
        {
            renderers[_loc3].disabled = _disabled;
        } // end of for
        //return (this.disabled());
        null;
    } // End of the function
    function get dataProvider()
    {
        return (_dataProvider);
    } // End of the function
    function set dataProvider(value)
    {
        _dataProvider = value;
        _selectedIndex = 0;
        tabEnabled = focusEnabled = !_disabled && _dataProvider.length > 0;
        this.invalidate();
        //return (this.dataProvider());
        null;
    } // End of the function
    function get itemRenderer()
    {
        return (_itemRenderer);
    } // End of the function
    function set itemRenderer(value)
    {
        _itemRenderer = value;
        while (renderers.length > 0)
        {
            renderers.pop().removeMovieClip();
        } // end while
        this.invalidate();
        //return (this.itemRenderer());
        null;
    } // End of the function
    function get spacing()
    {
        return (_spacing);
    } // End of the function
    function set spacing(value)
    {
        _spacing = value;
        this.invalidate();
        //return (this.spacing());
        null;
    } // End of the function
    function get direction()
    {
        return (_direction);
    } // End of the function
    function set direction(value)
    {
        _direction = value;
        this.invalidate();
        //return (this.direction());
        null;
    } // End of the function
    function get autoSize()
    {
        return (_autoSize);
    } // End of the function
    function set autoSize(value)
    {
        if (value == _autoSize)
        {
            return;
        } // end if
        _autoSize = value;
        for (var _loc2 = 0; _loc2 < renderers.length; ++_loc2)
        {
            renderers[_loc2].autoSize = _autoSize;
        } // end of for
        this.invalidate();
        //return (this.autoSize());
        null;
    } // End of the function
    function get buttonWidth()
    {
        return (_buttonWidth);
    } // End of the function
    function set buttonWidth(value)
    {
        _buttonWidth = value;
        this.invalidate();
        //return (this.buttonWidth());
        null;
    } // End of the function
    function get selectedIndex()
    {
        return (_selectedIndex);
    } // End of the function
    function set selectedIndex(value)
    {
        if (_selectedIndex == value)
        {
            return;
        } // end if
        _selectedIndex = value;
        this.selectItem(_selectedIndex);
        this.dispatchEvent({type: "change", index: _selectedIndex, renderer: renderers[_selectedIndex], item: this.__get__selectedItem(), data: this.__get__selectedItem().data});
        //return (this.selectedIndex());
        null;
    } // End of the function
    function get selectedItem()
    {
        return (_dataProvider[_selectedIndex]);
    } // End of the function
    function get data()
    {
        //return (this.selectedItem().data);
    } // End of the function
    function get labelField()
    {
        return (_labelField);
    } // End of the function
    function set labelField(value)
    {
        _labelField = value;
        this.invalidate();
        //return (this.labelField());
        null;
    } // End of the function
    function get labelFunction()
    {
        return (_labelFunction);
    } // End of the function
    function set labelFunction(value)
    {
        _labelFunction = value;
        this.invalidate();
        //return (this.labelFunction());
        null;
    } // End of the function
    function itemToLabel(item)
    {
        if (item == null)
        {
            return ("");
        } // end if
        if (_labelFunction != null)
        {
            return (this._labelFunction(item));
        }
        else if (_labelField != null && item[_labelField] != null)
        {
            return (item[_labelField]);
        } // end else if
        return (item.toString());
    } // End of the function
    function handleInput(details, pathToFocus)
    {
        var _loc3 = details.value == "keyDown";
        var _loc2;
        switch (details.navEquivalent)
        {
            case gfx.ui.NavigationCode.LEFT:
            {
                if (_direction == "horizontal")
                {
                    _loc2 = _selectedIndex - 1;
                } // end if
                break;
            } 
            case gfx.ui.NavigationCode.RIGHT:
            {
                if (_direction == "horizontal")
                {
                    _loc2 = _selectedIndex + 1;
                } // end if
                break;
            } 
            case gfx.ui.NavigationCode.UP:
            {
                if (_direction == "vertical")
                {
                    _loc2 = _selectedIndex - 1;
                } // end if
                break;
            } 
            case gfx.ui.NavigationCode.DOWN:
            {
                if (_direction == "vertical")
                {
                    _loc2 = _selectedIndex + 1;
                } // end if
                break;
            } 
        } // End of switch
        if (_loc2 != null)
        {
            _loc2 = Math.max(0, Math.min(_dataProvider.length - 1, _loc2));
            if (_loc2 != _selectedIndex)
            {
                if (!_loc3)
                {
                    return (true);
                } // end if
                this.__set__selectedIndex(_loc2);
                return (true);
            } // end if
        } // end if
        return (false);
    } // End of the function
    function toString()
    {
        return ("[Scaleform ButtonBar " + _name + "]");
    } // End of the function
    function draw()
    {
        if (!reflowing)
        {
            var _loc5 = _dataProvider.length;
            while (renderers.length > _loc5)
            {
                var _loc4 = (MovieClip)(renderers.pop());
                _loc4.group.removeButton(_loc4);
                _loc4.removeMovieClip();
            } // end while
            while (renderers.length < _loc5)
            {
                renderers.push(this.createRenderer(renderers.length));
            } // end while
            for (var _loc2 = 0; _loc2 < renderers.length; ++_loc2)
            {
                var _loc3 = renderers[_loc2];
                _loc3.label = this.itemToLabel(_dataProvider[_loc2]);
                _loc3.data = _dataProvider[_loc2];
                _loc3.disabled = _disabled;
            } // end of for
            reflowing = true;
            this.invalidate();
            return;
        } // end if
        if (this.drawLayout())
        {
            this.selectItem(_selectedIndex);
        } // end if
    } // End of the function
    function drawLayout()
    {
        if (renderers.length > 0 && !renderers[renderers.length - 1].initialized)
        {
            reflowing = true;
            this.invalidate();
            return (false);
        } // end if
        reflowing = false;
        var _loc5 = 0;
        var _loc4 = 0;
        for (var _loc3 = 0; _loc3 < renderers.length; ++_loc3)
        {
            var _loc2 = renderers[_loc3];
            if (!_autoSize && _buttonWidth > 0)
            {
                _loc2.width = _buttonWidth;
            } // end if
            if (_direction == "horizontal")
            {
                _loc2._y = 0;
                _loc2._x = _loc5;
                _loc5 = _loc5 + (_loc2.width + _spacing);
                continue;
            } // end if
            _loc2._x = 0;
            _loc2._y = _loc4;
            _loc4 = _loc4 + (_loc2.height + _spacing);
        } // end of for
        return (true);
    } // End of the function
    function createRenderer(index)
    {
        var _loc2 = gfx.core.UIComponent.createInstance(this, this.__get__itemRenderer(), "clip" + index, index, {toggle: true, focusTarget: this, tabEnabled: false, autoSize: _autoSize});
        if (_loc2 == null)
        {
            return (null);
        } // end if
        _loc2.addEventListener("click", this, "handleItemClick");
        _loc2.index = index;
        _loc2.groupName = _name + "ButtonGroup";
        return (_loc2);
    } // End of the function
    function handleItemClick(event)
    {
        var _loc2 = event.target;
        var _loc5 = _loc2.index;
        this.__set__selectedIndex(_loc5);
        this.dispatchEvent({type: "itemClick", data: this.__get__selectedItem().data, item: this.__get__selectedItem(), index: _loc5, mouseIndex: event.mouseIndex});
    } // End of the function
    function selectItem(index)
    {
        if (renderers.length < 1)
        {
            return;
        } // end if
        var _loc6 = renderers[index];
        if (!_loc6.selected)
        {
            _loc6.selected = true;
        } // end if
        var _loc4 = renderers.length;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            if (_loc2 == index)
            {
                continue;
            } // end if
            var _loc3 = 100 + _loc4 - _loc2;
            renderers[_loc2].swapDepths(_loc3);
            renderers[_loc2].displayFocus = false;
        } // end of for
        _loc6.swapDepths(1000);
        _loc6.displayFocus = _focused;
    } // End of the function
    function changeFocus()
    {
        var _loc2 = renderers[_selectedIndex];
        if (_loc2 == null)
        {
            return;
        } // end if
        _loc2.displayFocus = _focused;
    } // End of the function
    var _itemRenderer = "Button";
    var _spacing = 0;
    var _direction = "horizontal";
    var _selectedIndex = -1;
    var _autoSize = false;
    var _buttonWidth = 0;
    var _labelField = "label";
    var reflowing = false;
} // End of Class
