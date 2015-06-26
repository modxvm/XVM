intrinsic class net.wargaming.messenger.controls.BattleMessageRenderer extends net.wargaming.notification.FadingMessageRenderer
{
	public var _shown : Object;
	public var textBottomPadding : Object;
	public var textRightPadding : Object;
	public var showAlpha : Object;
	public var showTime : Object;

	public function BattleMessageRenderer();

	public function startShow();

	public function configUI();

	public function draw();

	public function populateData(initData);

}