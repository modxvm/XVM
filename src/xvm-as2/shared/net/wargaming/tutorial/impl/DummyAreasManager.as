intrinsic class net.wargaming.tutorial.impl.DummyAreasManager implements net.wargaming.tutorial.interfaces.IAreasManager
{
	public function DummyAreasManager();

	public function updateLockedAreas(data);

	public function updateActiveAreas(data);

	public function destroyLockedArea(areaID);

	public function destroyActiveArea(areaID);

	public function destroyAllAreas(locked, acvite);

	public function destroy();

	public function onStageSizeChanged();

}