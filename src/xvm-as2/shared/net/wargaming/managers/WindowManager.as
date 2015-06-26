intrinsic class net.wargaming.managers.WindowManager
{
	public var groupsCounter : Object;
	static public var opened : Object;
	static public var REMAIN_IN_POSITON : Object;
	static public var HOLD_VISIBLE : Object;
	static public var windows : Object;
	static public var _instance : Object;
	public var inited : Object;
	public var groupPositionOffset : Object;

	static public function get instance() : Object;


	public function WindowManager();

	public function initialize(layout);

	public function onSetFocus(old_focus, new_focus);

	public function restoreFocus();

	public function open(symbol, uniqueName, initObj, managed, group, relativeTo, positionPolicy);

	public function close(uniqueName, force);

	public function isOpen(uniqueName);

	public function getWindow(uniqueName);

	public function setWindow(window, uniqueName, managed, group, positionPolicy);

	public function moveTo(window, x, y, group, relativeTo);

	public function swapToNextHighestDepth(window);

	public function closeAllManagedWindow(forse);

	public function update(width, height);

	public function focusToTopWindow();

	public function hasOpened();

	public function handleCloseWindow(event);

	public function deleteWindow(uniqueName);

	public function addGroupCounter(group);

	public function movieGroupWindowToVector(obj, group);

	public function holdVisible(clip, width, height);

}