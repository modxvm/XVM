class mx.utils.CollectionImpl extends Object implements mx.utils.Collection
{
    var _items;
    function CollectionImpl()
    {
        super();
        _items = new Array();
    } // End of the function
    function addItem(item)
    {
        var _loc2 = false;
        if (item != null)
        {
            _items.push(item);
            _loc2 = true;
        } // end if
        return (_loc2);
    } // End of the function
    function clear()
    {
        _items = new Array();
    } // End of the function
    function contains(item)
    {
        return (this.internalGetItem(item) > -1);
    } // End of the function
    function getItemAt(index)
    {
        return (_items[index]);
    } // End of the function
    function getIterator()
    {
        return (new mx.utils.IteratorImpl(this));
    } // End of the function
    function getLength()
    {
        return (_items.length);
    } // End of the function
    function isEmpty()
    {
        return (_items.length == 0);
    } // End of the function
    function removeItem(item)
    {
        var _loc2 = false;
        var _loc3 = this.internalGetItem(item);
        if (_loc3 > -1)
        {
            _items.splice(_loc3, 1);
            _loc2 = true;
        } // end if
        return (_loc2);
    } // End of the function
    function internalGetItem(item)
    {
        var _loc3 = -1;
        for (var _loc2 = 0; _loc2 < _items.length; ++_loc2)
        {
            if (_items[_loc2] == item)
            {
                _loc3 = _loc2;
                break;
            } // end if
        } // end of for
        return (_loc3);
    } // End of the function
} // End of Class
