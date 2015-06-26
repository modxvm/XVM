intrinsic class net.wargaming.ingame.PlayersVerticalLayout extends MovieClip
{
	public var createEmptyMovieClip : Object;
	public var _isPlayerTeam : Object;
	public var _teamName : Object;
	public var _rendererHeight : Object;
	public var _isDynamicSquadActive : Object;
	public var _isShowExtraModeActive : Object;

	public function get isShowExtraModeActive() : Object;
	public function set isShowExtraModeActive(val) : Void;


	public function PlayersVerticalLayout();

	public function update();

	public function getTeamName();

	public function onLoad();

	public function createPlayerRenderer(index);

	public function draw();

	public function setDynamicSquadActive(val);

}