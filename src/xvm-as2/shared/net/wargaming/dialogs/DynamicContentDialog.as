intrinsic class net.wargaming.dialogs.DynamicContentDialog extends net.wargaming.Dialog
{
	public var dispatchEvent : Object;
	static public var _contProps : Object;
	static public var dialogSource : Object;
	public var contentStartXPos : Object;
	public var contentStartYPos : Object;
	public var _contentOffsetLeft : Object;
	public var _contentOffsetTop : Object;
	public var _minHeight : Object;
	public var btnStartYPos : Object;
	public var intervalID : Object;
	public var timeout : Object;
	public var sumbitVisible : Object;
	public var focusSubmit : Object;
	public var submitDisabled : Object;
	public var dragable : Object;

	public function get contentOffsetLeft() : Object;
	public function set contentOffsetLeft(val) : Void;

	public function get contentOffsetTop() : Object;
	public function set contentOffsetTop(val) : Void;

	public function get minHeight() : Object;
	public function set minHeight(val) : Void;


	public function DynamicContentDialog();

	static public function show(dialog, focusSubmit, sumbitVisible, store, contProps);

	static public function show2(title, contProps, timeOut);

	public function removeMovieClip();

	public function automaticallyClose();

	public function onContentLoadInit(ev);

	public function onChangePayStatus(pay);

	public function reposContent();

	public function configUI();

	public function draw();

	public function redraw();

	public function populateUI();

	public function setBtnStatus();

}