class net.wargaming.ScrollingList extends gfx.controls.ScrollingList
{
    var renderers, _scrollPosition, _selectedIndex, itemToLabel, showEmptyItems, updateScrollBar;
    function ScrollingList()
    {
        super();
    } // End of the function
    function populateData(data)
    {
        for (var _loc2 = 0; _loc2 < renderers.length; ++_loc2)
        {
            var _loc3 = renderers[_loc2];
            var _loc4 = _scrollPosition + _loc2;
            renderers[_loc2].setListData(_loc4, this.itemToLabel(data[_loc2]), _selectedIndex == _loc4);
            _loc3.setData(data[_loc2]);
            if (!showEmptyItems)
            {
                _loc3.visible = data[_loc2] != null;
            } // end if
        } // end of for
        this.updateScrollBar();
    } // End of the function
} // End of Class
