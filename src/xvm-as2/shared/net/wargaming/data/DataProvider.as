intrinsic class gfx.data.DataProvider extends Array
{
    static var instance;
    var isDataProvider;
    static function initialize(data);
    function indexOf(value, scope, callBack);
    function requestItemAt(index, scope, callBack);
    function requestItemRange(startIndex, endIndex, scope, callBack);
    function invalidate(length);
    function cleanUp();
}
