intrinsic class net.wargaming.collections.DynamicSquadHelper
{
	public var _addToSquad : Object;
	static public var DS_NONE : Object;
	static public var DS_INVITE_DISABLED : Object;
	static public var DS_IN_SQUAD : Object;
	static public var DS_INVITE_AVAILABLE : Object;
	static public var DS_INVITE_WAS_SENT : Object;
	static public var DS_INVITE_RECEIVED : Object;
	static public var DS_INVITE_RECEIVED_FROM_SQUAD : Object;
	static public var TYPE_ALLY : Object;
	static public var TYPE_ENEMY : Object;
	static public var TOOLTIP_START_KEY : Object;
	static public var TOOLTIP_MAP : Object;
	public var _currentDynamicBtnActive : Object;
	public var _currentDynamicBtnClickHandler : Object;
	public var _teamType : Object;
	public var _hit : Object;
	public var _squadMask : Object;
	public var _uid : Object;
	public var _isDynamicSquadActive : Object;

	public function DynamicSquadHelper(hit, addToSquad, acceptSquadInvite, inviteWasSent, inviteReceived, inviteReceivedFromSquad, inviteDisabled, teamType);

	public function onRendererOver();

	public function showTooltip();

	public function onRendererOut();

	public function showHideDynamicSquadBtn(btn, isShow, clickEvent);

	public function onDynamicBtnRollOutHandler(mouseIndex);

	public function onDynamicBtnRollOverHandler(mouseIndex);

	public function onAddToSquadClickHandler(event);

	public function onAcceptInviteSquadClickHandler(event);

	public function update(uid, squadMask);

	public function updateDynamicSquadItems(oldDynamicSquadMask, newDynamicSquadMask);

	public function hideDynamicItems();

	public function isDynamicSquadActive(val);

	public function hideAllItems();

}