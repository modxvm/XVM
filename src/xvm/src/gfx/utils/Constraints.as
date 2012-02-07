class gfx.utils.Constraints
{
    var scope, elements;
    function Constraints(scope, scaled)
    {
        this.scope = scope;
        this.scaled = scaled;
        elements = [];
    } // End of the function
    function addElement(clip, edges)
    {
        if (clip == null)
        {
            return;
        } // end if
        var _loc8 = 100 / scope._xscale;
        var _loc7 = 100 / scope._yscale;
        var _loc6 = scope._width;
        var _loc5 = scope._height;
        if (scope == _root)
        {
            _loc6 = Stage.width;
            _loc5 = Stage.height;
        } // end if
        var _loc4 = {clip: clip, edges: edges, metrics: {left: clip._x, top: clip._y, right: _loc6 * _loc8 - (clip._x + clip._width), bottom: _loc5 * _loc7 - (clip._y + clip._height), xscale: clip._xscale, yscale: clip._yscale}};
        var _loc14 = _loc4.metrics;
        elements.push(_loc4);
    } // End of the function
    function removeElement(clip)
    {
        for (var _loc2 = 0; _loc2 < elements.length; ++_loc2)
        {
            if (elements[_loc2].clip == clip)
            {
                elements.splice(_loc2, 1);
                break;
            } // end if
        } // end of for
    } // End of the function
    function getElement(clip)
    {
        for (var _loc2 = 0; _loc2 < elements.length; ++_loc2)
        {
            if (elements[_loc2].clip == clip)
            {
                return (elements[_loc2]);
            } // end if
        } // end of for
        return (null);
    } // End of the function
    function update(width, height)
    {
        var _loc10 = 100 / scope._xscale;
        var _loc9 = 100 / scope._yscale;
        if (!scaled)
        {
            scope._xscale = 100;
            scope._yscale = 100;
        } // end if
        for (var _loc8 = 0; _loc8 < elements.length; ++_loc8)
        {
            var _loc5 = elements[_loc8];
            var _loc4 = _loc5.edges;
            var _loc2 = _loc5.clip;
            var _loc3 = _loc5.metrics;
            var _loc14 = _loc2.width != null ? ("width") : ("_width");
            var _loc13 = _loc2.height != null ? ("height") : ("_height");
            if (scaled)
            {
                _loc2._xscale = _loc3.xscale * _loc10;
                _loc2._yscale = _loc3.yscale * _loc9;
                if ((_loc4 & gfx.utils.Constraints.LEFT) > 0)
                {
                    _loc2._x = _loc3.left * _loc10;
                    if ((_loc4 & gfx.utils.Constraints.RIGHT) > 0)
                    {
                        var _loc7 = width - _loc3.left - _loc3.right;
                        if (!(_loc2 instanceof TextField))
                        {
                            _loc7 = _loc7 * _loc10;
                        } // end if
                        _loc2[_loc14] = _loc7;
                    } // end if
                }
                else if ((_loc4 & gfx.utils.Constraints.RIGHT) > 0)
                {
                    _loc2._x = (width - _loc3.right) * _loc10 - _loc2._width;
                } // end else if
                if ((_loc4 & gfx.utils.Constraints.TOP) > 0)
                {
                    _loc2._y = _loc3.top * _loc9;
                    if ((_loc4 & gfx.utils.Constraints.BOTTOM) > 0)
                    {
                        var _loc6 = height - _loc3.top - _loc3.bottom;
                        if (!(_loc2 instanceof TextField))
                        {
                            _loc6 = _loc6 * _loc9;
                        } // end if
                        _loc2[_loc13] = _loc6;
                    } // end if
                }
                else if ((_loc4 & gfx.utils.Constraints.BOTTOM) > 0)
                {
                    _loc2._y = (height - _loc3.bottom) * _loc9 - _loc2._height;
                } // end else if
                continue;
            } // end if
            if ((_loc4 & gfx.utils.Constraints.RIGHT) > 0)
            {
                if ((_loc4 & gfx.utils.Constraints.LEFT) > 0)
                {
                    _loc2[_loc14] = width - _loc3.left - _loc3.right;
                }
                else
                {
                    _loc2._x = width - _loc2._width - _loc3.right;
                } // end if
            } // end else if
            if ((_loc4 & gfx.utils.Constraints.BOTTOM) > 0)
            {
                if ((_loc4 & gfx.utils.Constraints.TOP) > 0)
                {
                    _loc2[_loc13] = height - _loc3.top - _loc3.bottom;
                    continue;
                } // end if
                _loc2._y = height - _loc2._height - _loc3.bottom;
            } // end if
        } // end of for
    } // End of the function
    function toString()
    {
        return ("[Scaleform Constraints]");
    } // End of the function
    static var LEFT = 1;
    static var RIGHT = 2;
    static var TOP = 4;
    static var BOTTOM = 8;
    static var ALL = gfx.utils.Constraints.LEFT | gfx.utils.Constraints.RIGHT | gfx.utils.Constraints.TOP | gfx.utils.Constraints.BOTTOM;
    var scaled = false;
} // End of Class
