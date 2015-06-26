intrinsic class net.wargaming.tutorial.impl.ItemsManager implements net.wargaming.tutorial.interfaces.IItemsManager
{
	public var context : Object;

	public function ItemsManager(context);

	public function setProps(itemID, itemPath, props, revert);

	public function resetAll();

	public function destroy(isRevertItems);

}