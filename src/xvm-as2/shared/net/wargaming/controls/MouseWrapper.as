intrinsic class net.wargaming.controls.MouseWrapper
{
	static public var DRAGGING : Object;
	static public var RESIZING : Object;
	static public var LAST_CURSOR : Object;
	static public var DRAG_TYPE : Object;
	static public var MOUSE_CURSOR : Object;
	static public var ms_instance : Object;
	public var m_cursor : Object;
	public var m_forcedCursorType : Object;

	public function MouseWrapper();

	public function setCursorControl(cursorControl);

	public function onLoad();

	public function onMouseMove();

	public function onSetPosition(x, y);

	public function getCursorType();

	public function onSetForcedCursorType(cursor);

	public function setCursorType(cursor);

	public function setIsDragging(isDragging);

	public function setIsResizing(isResizing);

	public function show();

	public function hide();

	public function isCurrentCursor(cursor);

	public function setToLastCursor();

	public function setToResizeCursor();

}