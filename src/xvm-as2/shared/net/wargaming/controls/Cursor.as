intrinsic class net.wargaming.controls.Cursor extends net.wargaming.controls.MouseWrapper
{
	public var setCursorType : Object;
	static public var CAST_MSG_ERROR : Object;
	static public var DISPATCH_MSG_ERROR : Object;
	static public var CLICKABLE_CONTROLS : Object;

	public function Cursor();

	static public function getInstance();

	public function useResizeCursor(movieClip);

	public function registerDragging(wrapper, draggingCursor, fullRestoreTest);

	public function unsafeRegister(wrapper, hit, dragType, draggingCursor, fullRestoreTest);

	public function resetCursorFully();

	public function resetCursorQuick();

	public function resetCursor(useOptimization);

	public function onStartDrag(wrapper, draggingCursor);

	public function onEndDrag(wrapper);

	public function setArrow();

	public function forceSetLastCursor();

	public function setCursorToResize();

	public function enterToResizingModeIfCursorIsResize();

	public function enterToDragMode();

	public function exitFromResizingMode();

	public function exitFromResizingModeAndRestoreCursor();

	public function canUseHandCursor(control, useOptimization);

}