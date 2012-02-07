class net.wargaming.TileList extends gfx.controls.TileList
{
    var totalColumns, totalRows, renderers, _scrollPosition, _direction, _selectedIndex, itemToLabel, showEmptyItems, _dataProvider, __get__direction, paddingBottom, margin, paddingRight, drawScrollBar;
    function TileList()
    {
        super();
    } // End of the function
    function populateData(data)
    {
        for (var _loc2 = 0; _loc2 < totalColumns * totalRows; ++_loc2)
        {
            var _loc3 = renderers[_loc2];
            var _loc4 = _scrollPosition * (_direction == "horizontal" ? (totalRows) : (totalColumns)) + _loc2;
            renderers[_loc2].setListData(_loc4, this.itemToLabel(data[_loc2]), _selectedIndex == _loc4);
            _loc3.setData(data[_loc2]);
            if (!showEmptyItems)
            {
                _loc3.visible = data[_loc2] != null;
            } // end if
        } // end of for
    } // End of the function
    function invalidateData()
    {
        var _loc3 = _direction == "horizontal" ? (totalRows) : (totalColumns);
        var _loc4 = Math.ceil(_dataProvider.length / _loc3);
        var _loc5 = _loc4 - (_direction == "horizontal" ? (totalColumns) : (totalRows));
        _scrollPosition = Math.max(0, Math.min(_loc5, _scrollPosition));
        var _loc2 = _scrollPosition * _loc3;
        var _loc6 = _loc2 + totalColumns * totalRows - 1;
        _dataProvider.requestItemRange(_loc2, _loc6, this, "populateData");
    } // End of the function
    function drawLayout(rendererWidth, rendererHeight)
    {
        for (var _loc2 = 0; _loc2 < renderers.length; ++_loc2)
        {
            var _loc3 = renderers[_loc2];
            if (this.__get__direction() == "horizontal")
            {
                _loc3._y = _loc2 % totalRows * (rendererHeight + paddingBottom) + margin;
                _loc3._x = (_loc2 / totalRows >> 0) * (rendererWidth + paddingRight) + margin;
            }
            else
            {
                _loc3._x = _loc2 % totalColumns * (rendererWidth + paddingRight) + margin;
                _loc3._y = (_loc2 / totalColumns >> 0) * (rendererHeight + paddingBottom) + margin;
            } // end else if
            renderers[_loc2].setSize(rendererWidth, rendererHeight);
        } // end of for
        this.drawScrollBar();
    } // End of the function
} // End of Class
