intrinsic class gfx.controls.ListItemRenderer extends gfx.controls.Button
{
	public var index : Object;
	public var selectable : Object;

	public function ListItemRenderer();

	public function setListData(index, label, selected);

	public function setData(data);

	public function toString();

	public function configUI();

}