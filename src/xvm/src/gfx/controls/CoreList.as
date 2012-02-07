class gfx.controls.CoreList extends gfx.core.UIComponent
{
    var renderers, __set__dataProvider, createEmptyMovieClip, container, focusEnabled, tabEnabled, invalidate, __get__itemRenderer, _dataProvider, __get__dataProvider, dispatchEvent, __get__selectedIndex, __get__labelField, _labelFunction, __get__labelFunction, __width, __height, _parent, owner, __get__rendererInstanceName, _name, inspectableRendererInstanceName, __set__rendererInstanceName, __set__selectedIndex, __get__availableHeight, __get__availableWidth, __set__itemRenderer, __set__labelField, __set__labelFunction;
    function CoreList()
    {
        super();
        renderers = [];
        this.__set__dataProvider([]);
        container = this.createEmptyMovieClip("container", 1);
        container.scale9Grid = new flash.geom.Rectangle(0, 0, 1, 1);
        tabEnabled = focusEnabled = true;
    } // End of the function
    function get itemRenderer()
    {
        return (_itemRenderer);
    } // End of the function
    function set itemRenderer(value)
    {
        if (value == _itemRenderer || value == "")
        {
            return;
        } // end if
        _itemRenderer = value;
        this.resetRenderers();
        this.invalidate();
        //return (this.itemRenderer());
        null;
    } // End of the function
    function get dataProvider()
    {
        return (_dataProvider);
    } // End of the function
    function set dataProvider(value)
    {
        if (_dataProvider == value)
        {
            return;
        } // end if
        if (_dataProvider != null)
        {
            _dataProvider.removeEventListener("change", this, "onDataChange");
        } // end if
        _dataProvider = value;
        if (_dataProvider == null)
        {
            return;
        } // end if
        if (value instanceof Array && !value.isDataProvider)
        {
            gfx.data.DataProvider.initialize(_dataProvider);
        }
        else if (_dataProvider.initialize != null)
        {
            _dataProvider.initialize(this);
        } // end else if
        _dataProvider.addEventListener("change", this, "onDataChange");
        this.invalidate();
        //return (this.dataProvider());
        null;
    } // End of the function
    function get selectedIndex()
    {
        return (_selectedIndex);
    } // End of the function
    function set selectedIndex(value)
    {
        var _loc3 = _selectedIndex;
        _selectedIndex = value;
        this.dispatchEvent({type: "change", index: _selectedIndex, lastIndex: _loc3});
        //return (this.selectedIndex());
        null;
    } // End of the function
    function scrollToIndex(index)
    {
    } // End of the function
    function get labelField()
    {
        return (_labelField);
    } // End of the function
    function set labelField(value)
    {
        _labelField = value;
        this.invalidateData();
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
        this.invalidateData();
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
    function invalidateData()
    {
    } // End of the function
    function get availableWidth()
    {
        return (__width);
    } // End of the function
    function get availableHeight()
    {
        return (__height);
    } // End of the function
    function setRendererList(value)
    {
        if (externalRenderers)
        {
            for (var _loc3 = 0; _loc3 < renderers.length; ++_loc3)
            {
                var _loc2 = renderers[_loc3];
                _loc2.owner = null;
                _loc2.removeEventListener("click", this, "handleItemClick");
                _loc2.removeEventListener("rollOver", this, "dispatchItemEvent");
                _loc2.removeEventListener("rollOut", this, "dispatchItemEvent");
                _loc2.removeEventListener("press", this, "dispatchItemEvent");
                _loc2.removeEventListener("doubleClick", this, "dispatchItemEvent");
                Mouse.removeListener(_loc2);
            } // end of for
        }
        else
        {
            this.resetRenderers();
        } // end else if
        externalRenderers = value != null;
        if (externalRenderers)
        {
            renderers = value;
        } // end if
        this.invalidate();
    } // End of the function
    function get rendererInstanceName()
    {
        return (null);
    } // End of the function
    function set rendererInstanceName(value)
    {
        if (value == null || value == "")
        {
            return;
        } // end if
        var _loc3 = 0;
        var _loc4 = [];
        while (true)
        {
            ++_loc3;
            var _loc2 = _parent[value + _loc3];
            if (_loc2 == null && _loc3 > 0)
            {
                break;
            } // end if
            if (_loc2 == null)
            {
                continue;
            } // end if
            this.setUpRenderer(_loc2);
            Mouse.addListener(_loc2);
            _loc2.scrollWheel = function (delta)
            {
                owner.scrollWheel(delta);
            };
            _loc4.push(_loc2);
        } // end while
        if (_loc4.length == 0)
        {
            _loc4 = null;
        } // end if
        this.setRendererList(_loc4);
        //return (this.rendererInstanceName());
        null;
    } // End of the function
    function toString()
    {
        return ("[Scaleform CoreList " + _name + "]");
    } // End of the function
    function configUI()
    {
        super.configUI();
        if (_selectedIndex > -1)
        {
            deferredScrollIndex = _selectedIndex;
        } // end if
        if (inspectableRendererInstanceName != "")
        {
            this.__set__rendererInstanceName(inspectableRendererInstanceName);
        } // end if
        Mouse.addListener(this);
    } // End of the function
    function createItemRenderer(index)
    {
        var _loc2 = container.attachMovie(_itemRenderer, "renderer" + index, index);
        if (_loc2 == null)
        {
            return (null);
        } // end if
        this.setUpRenderer(_loc2);
        return (_loc2);
    } // End of the function
    function setUpRenderer(clip)
    {
        clip.owner = this;
        clip.tabEnabled = false;
        clip.doubleClickEnabled = true;
        clip.addEventListener("press", this, "dispatchItemEvent");
        clip.addEventListener("click", this, "handleItemClick");
        clip.addEventListener("doubleClick", this, "dispatchItemEvent");
        clip.addEventListener("rollOver", this, "dispatchItemEvent");
        clip.addEventListener("rollOut", this, "dispatchItemEvent");
    } // End of the function
    function createItemRenderers(startIndex, endIndex)
    {
        var _loc3 = [];
        for (var _loc2 = startIndex; _loc2 <= endIndex; ++_loc2)
        {
            _loc3.push(createItemRenderer[_loc2]);
        } // end of for
        return (_loc3);
    } // End of the function
    function draw()
    {
        if (deferredScrollIndex != -1)
        {
            this.scrollToIndex(deferredScrollIndex);
            deferredScrollIndex = -1;
        } // end if
    } // End of the function
    function drawRenderers(totalRenderers)
    {
        while (renderers.length > totalRenderers)
        {
            renderers.pop().removeMovieClip();
        } // end while
        while (renderers.length < totalRenderers)
        {
            renderers.push(this.createItemRenderer(renderers.length));
        } // end while
    } // End of the function
    function getRendererAt(index)
    {
        return (renderers[index]);
    } // End of the function
    function resetRenderers()
    {
        while (renderers.length > 0)
        {
            renderers.pop().removeMovieClip();
        } // end while
    } // End of the function
    function drawLayout(rendererWidth, rendererHeight)
    {
    } // End of the function
    function onDataChange(event)
    {
        this.invalidateData();
    } // End of the function
    function dispatchItemEvent(event)
    {
        var _loc9;
        switch (event.type)
        {
            case "press":
            {
                _loc9 = "itemPress";
                break;
            } 
            case "click":
            {
                _loc9 = "itemClick";
                break;
            } 
            case "rollOver":
            {
                _loc9 = "itemRollOver";
                break;
            } 
            case "rollOut":
            {
                _loc9 = "itemRollOut";
                break;
            } 
            case "doubleClick":
            {
                _loc9 = "itemDoubleClick";
                break;
            } 
            default:
            {
                return;
            } 
        } // End of switch
        var _loc3 = {target: this, type: _loc9, item: event.target.data, renderer: event.target, index: event.target.index, mouseIndex: event.mouseIndex};
        this.dispatchEvent(_loc3);
    } // End of the function
    function handleItemClick(event)
    {
        var _loc2 = event.target.index;
        if (isNaN(_loc2))
        {
            return;
        } // end if
        this.__set__selectedIndex(_loc2);
        this.dispatchItemEvent(event);
    } // End of the function
    var _itemRenderer = "ListItemRenderer";
    var _selectedIndex = -1;
    var _labelField = "label";
    var externalRenderers = false;
    var deferredScrollIndex = -1;
} // End of Class
