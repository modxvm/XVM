intrinsic class mx.utils.CollectionImpl implements mx.utils.Collection
{
	public var _items : Object;

	public function CollectionImpl();

	public function addItem(item);

	public function clear();

	public function contains(item);

	public function getItemAt(index);

	public function getIterator();

	public function getLength();

	public function isEmpty();

	public function removeItem(item);

	public function internalGetItem(item);

}