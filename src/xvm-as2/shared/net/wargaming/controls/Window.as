intrinsic class net.wargaming.controls.Window extends gfx.core.UIComponent implements net.wargaming.interfaces.IDraggable
{
	public var invalidate : Object;
	public var childName : Object;
	public var _formType : Object;
	public var _formSource : Object;
	public var _title : Object;
	public var _icon : Object;
	public var _allowResize : Object;
	public var _allowDrag : Object;
	public var _showClose : Object;
	public var formCreated : Object;
	public var _offsetTop : Object;
	public var _offsetBottom : Object;
	public var _offsetLeft : Object;
	public var _offsetRight : Object;
	public var _isChannel : Object;
	static public var index : Object;
	public var __firstDrawComplete : Object;

	public function get formSource() : Object;
	public function set formSource(value) : Void;

	public function get title() : Object;
	public function set title(value) : Void;

	public function get icon() : Object;
	public function set icon(value) : Void;

	public function get allowResize() : Object;
	public function set allowResize(value) : Void;

	public function get allowDrag() : Object;
	public function set allowDrag(value) : Void;

	public function get showClose() : Object;
	public function set showClose(value) : Void;

	public function get isWaiting() : Object;


	public function Window();

	public function minimize();

	public function handleMinimize();

	public function toString();

	public function configUI();

	public function registerDragging();

	public function __waiting_fade_in(target);

	public function onStartDrag();

	public function onEndDrag();

	public function getDragType();

	public function getHitArea();

	public function onDrop(target);

	public function getDropGroup();

	public function showWaiting(msg, props);

	public function timeoutEnded();

	public function hideWaiting();

	public function onMouseDown(button, target);

	public function handleInput(details, path);

	public function draw();

	public function onLoadComplete();

	public function onLoadInit();

	public function configForm();

	public function onTitleBtnClick(args);

	public function handleResizeDragStart();

	public function handleResizeDragStop();

	public function handleResize();

	public function updateSize();

	public function handleClose();

	public function windowClosed();

	public function changeFocus();

}