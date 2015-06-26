intrinsic class net.wargaming.StatsDialog extends net.wargaming.Dialog
{
	public var battleTip : Object;
	static public var menuSource : Object;
	public var startContentYPos : Object;
	public var _isDynamicSquadActive_ally : Object;
	public var _isDynamicSquadActive_enemy : Object;

	public function StatsDialog();

	public function show(modalBg);

	public function updateTipProps();

	public function removeListeners();

	public function addListeners();

	public function configUI();

	public function updateExtraMode(val);

	public function setIsDynamicSquadActive(valAlly, valEnemy);

	public function updateTeamDynamicSquadData();

	public function updateTeam(team);

	public function dialogReinit();

	public function dialogDispose();

	public function populateUI();

	public function scrollWheel(delta);

	public function onMouseWheel(delta, target);

	public function onScroll(ev);

	static public function blockInteraction();

}
