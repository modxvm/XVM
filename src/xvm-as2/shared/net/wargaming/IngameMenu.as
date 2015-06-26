intrinsic class net.wargaming.IngameMenu extends net.wargaming.Dialog
{
	public var mustReopen : Object;
	static public var menuSource : Object;
	public var _serverInfoDirty : Object;
	public var _serverInfoData : Object;
	public var _serverNameDirty : Object;
	public var _serverName : Object;
	public var _showReportBugPanel : Object;
	public var isShow : Object;
	public var SHOW_ALL : Object;
	public var HIDE_SERVER_STATS : Object;
	public var STATE_HIDE_ALL : Object;
	public var STATE_SHOW_SERVER_NAME : Object;
	public var STATE_HIDE_SERVER_STATS_ITEM : Object;
	public var STATE_SHOW_ALL : Object;

	public function IngameMenu();

	public function configUI();

	public function draw();

	public function setServerStats(clusterCCU, regionCCU);

	public function setServerName(serverName);

	public function setServerStatsInfo(tooltipFullData);

	public function setReportBugLink(value);

	public function getReopenCallerObject();

	static public function show();

	static public function leave();

	static public function refuseTraining();

	static public function hideCursor();

	static public function showCursor(x, y);

	public function onTryLeaveResponse(msg, isAlive);

	public function populateUI();

	public function handleClickSettingsButton(event);

	public function handleClickQuitBattleButton(event);

	public function handleClickRefuseButton();

	public function handleClickHelpButton(event);

	public function handleClickReportBugLink(event);

}