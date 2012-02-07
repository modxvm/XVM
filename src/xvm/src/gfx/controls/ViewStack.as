class gfx.controls.ViewStack extends gfx.core.UIComponent
{
    var cachedViews, createEmptyMovieClip, container, currentView, invalidate, _targetGroup, _parent, __get__targetGroup, _name, tabEnabled, inspectableTargetGroup, __set__targetGroup, sizeIsInvalid, __width, _width, __height, _height, _xscale, _yscale;
    function ViewStack()
    {
        super();
        cachedViews = {};
        container = this.createEmptyMovieClip("container", 1);
    } // End of the function
    function show(linkage, cache)
    {
        cache = Boolean(cache);
        if (currentView != null)
        {
            if (currentView.__cached__ == true)
            {
                currentView._visible = false;
            }
            else
            {
                currentView.removeMovieClip();
            } // end if
        } // end else if
        var _loc2 = this.createView(linkage, cache);
        currentView = _loc2;
        if (_loc2 != null)
        {
            _loc2._visible = true;
            if (_loc2.scale9Grid == null)
            {
                _loc2.scale9Grid = new flash.geom.Rectangle(0, 0, 1, 1);
            } // end if
        } // end if
        this.invalidate();
        return (_loc2);
    } // End of the function
    function precache(linkages)
    {
        var _loc3 = linkages.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            this.createView(linkages[_loc2], true);
        } // end of for
        this.invalidate();
    } // End of the function
    function get targetGroup()
    {
        return (_targetGroup);
    } // End of the function
    function set targetGroup(value)
    {
        if (_targetGroup == value)
        {
            return;
        } // end if
        if (_targetGroup != null)
        {
            _targetGroup.removeEventListener("change", this, "changeView");
        } // end if
        if (typeof(value) == "string")
        {
            _targetGroup = _parent[value] || _parent["_buttonGroup_" + value];
        }
        else
        {
            _targetGroup = value;
        } // end else if
        if (_targetGroup == null)
        {
            return;
        } // end if
        _targetGroup.addEventListener("change", this, "changeView");
        this.changeView();
        //return (this.targetGroup());
        null;
    } // End of the function
    function toString()
    {
        return ("[Scaleform ViewStack " + _name + "]");
    } // End of the function
    function configUI()
    {
        super.configUI();
        tabEnabled = false;
        if (inspectableTargetGroup != "")
        {
            this.__set__targetGroup(inspectableTargetGroup);
        } // end if
    } // End of the function
    function draw()
    {
        if (sizeIsInvalid)
        {
            container._width = container._height = 5;
            _width = __width;
            _height = __height;
        } // end if
        container._xscale = 10000 / _xscale;
        container._yscale = 10000 / _yscale;
    } // End of the function
    function createView(linkage, cache)
    {
        if (cachedViews[linkage] != null)
        {
            return ((MovieClip)(cachedViews[linkage]));
        } // end if
        var _loc2 = container.attachMovie(linkage, "view" + depth, depth++, {_visible: false});
        if (_loc2 == null)
        {
            return (null);
        } // end if
        if (cache || this.cache)
        {
            _loc2.__cached__ = true;
            cachedViews[linkage] = _loc2;
        } // end if
        return (_loc2);
    } // End of the function
    function changeView(event)
    {
        var _loc2 = _targetGroup.data;
        if (_loc2 != null)
        {
            this.show(_loc2.toString());
        } // end if
    } // End of the function
    var cache = false;
    var depth = 0;
} // End of Class
