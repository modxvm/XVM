class mx.utils.IteratorImpl implements mx.utils.Iterator
{
    var _collection, _cursor;
    function IteratorImpl(coll)
    {
        _collection = coll;
        _cursor = 0;
    } // End of the function
    function hasNext()
    {
        return (_cursor < _collection.getLength());
    } // End of the function
    function next()
    {
        return (_collection.getItemAt(_cursor++));
    } // End of the function
} // End of Class
