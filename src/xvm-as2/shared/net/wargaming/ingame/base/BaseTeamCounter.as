intrinsic class net.wargaming.ingame.base.BaseTeamCounter extends gfx.core.UIComponent implements net.wargaming.interfaces.ITeamCounter
{
	public function BaseTeamCounter();

	public function showVehiclesCounter(isShown);

	public function setTeamNames(alliedName, enemyName);

	public function updateFrags(allied, enemy);

	public function updatePlayerTeam();

	public function updateEnemyTeam();

	public function updateColors();

}