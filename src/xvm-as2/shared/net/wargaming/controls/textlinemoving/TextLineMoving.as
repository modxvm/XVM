intrinsic class net.wargaming.controls.textlinemoving.TextLineMoving extends gfx.core.UIComponent
{
	public var _alpha : Object;
	public var _rss : Object;
	public var carusel : Object;
	public var nextItem : Object;
	public var uniquiId : Object;
	public var intervalID : Object;
	public var _connected : Object;
	public var allowOpenLink : Object;
	public var itemsOffset : Object;
	static public var startOffset : Object;
	static public var minWidth : Object;
	public var speedItemsOffset : Object;
	public var speedMoveUpdate : Object;
	static public var ON_STATE_CHANGE : Object;
	static public var STATE_INITED : Object;
	static public var STATE_SHOW : Object;
	static public var STATE_HIDE : Object;
	static public var STATE_DESTROY : Object;
	public var status : Object;
	public var getEntries : Object;
	public var showBrowser : Object;
	public var isShowMovingText : Object;
	public var id : Object;
	public var isCursorHidden : Object;

	public function get width() : Object;


	public function TextLineMoving();

	public function configUI();

	public function init(this_mc);

	public function draw();

	public function createConnectComplete(connected, isBattle);

	public function isShowMoving();

	public function setBeckground(isBattle);

	public function onCursorShow();

	public function onCursorHide();

	public function startAnim();

	public function stopAnim();

	public function anim(this_mc);

	public function removeElemFromCarusel();

	public function addElemToCarusel();

	public function updateEntries(rss);

	public function itemClick(e);

	public function itemOver(e);

	public function itemOut(e);

	public function rollOver();

	public function rollOut();

	public function onMouseUp(button, target);

	public function onMouseDown(button, target);

	public function show();

	public function hide();

	public function tweenComplete();

	public function clearData();

	public function destroy();

	public function toString();

}