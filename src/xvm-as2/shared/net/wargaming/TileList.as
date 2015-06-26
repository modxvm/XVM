intrinsic class net.wargaming.TileList extends gfx.controls.TileList
{
	public var totalColumns : Object;

	public function TileList();

	public function populateData(data);

	public function invalidateData();

	public function drawLayout(rendererWidth, rendererHeight);

}