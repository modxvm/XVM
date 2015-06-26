intrinsic class gfx.data.DataProvider extends Array
{
	public var length : Object;
	static public var instance : Object;
	public var isDataProvider : Object;

	public function DataProvider(total);

	static public function initialize(data);

	public function indexOf(value, scope, callBack);

	public function requestItemAt(index, scope, callBack);

	public function requestItemRange(startIndex, endIndex, scope, callBack);

	public function invalidate(length);

	public function cleanUp();

	public function toString();

}