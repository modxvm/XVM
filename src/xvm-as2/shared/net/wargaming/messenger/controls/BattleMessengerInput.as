intrinsic class net.wargaming.messenger.controls.BattleMessengerInput extends net.wargaming.controls.TextInput
{
	public var textField : Object;

	public function get storeLastReceiver() : Object;
	public function set storeLastReceiver(value) : Void;

	public function set removeReceivers(removeReceivers) : Void;

	public function get receiverIdx() : Object;
	public function set receiverIdx(value) : Void;

	public function get receiverColor() : Object;

	public function get receiverLabel() : Object;

	public function get channelID() : Object;

	public function get isEnableReceiver() : Object;

	public function get hintText() : Object;
	public function set hintText(value) : Void;

	public function get toolTipText() : Object;
	public function set toolTipText(value) : Void;


	public function BattleMessengerInput();

	public function historyEnabled(isHistoryEnabled);

	public function updateHistoryState();

	public function enableHistoryControl(isUpEnabled, isDownEnabled, isDownHistoryEnbl);

	public function enableHistoryControls();

	public function addReceiver(id, label, modifiers, order, byDefault, inputColor, isChatEnabled);

	public function setReceiversLabels(data);

	public function nextReceiver();

	public function changeReceiverByKeyMod();

	public function setState();

	public function updateHitArea();

	public function handleHitAreaRelease();

	public function updateReceiverField();

	public function updateEditableState(isEditable);

	public function updateHintField();

	public function showAnimation(value);

	public function showText();

	public function showToolTipText();

}