intrinsic class gfx.managers.PopUpManager
{
	static public var index : Object;

	public function PopUpManager();

	static public function createPopUp(context, linkage, initProperties, relativeTo);

	static public function destroyPopUp(popUp);

	static public function movePopUp(context, popUp, relativeTo, x, y);

	static public function centerPopUp(popUp);

	static public function createPopUpRetry(context, linkage, initProperties, relativeTo);

}