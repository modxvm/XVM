intrinsic class net.wargaming.ingame.PlayerStatus
{
	static public var DEFAULT : Object;
	static public var IS_TEAM_KILLER : Object;
	static public var IS_SQUAD_MAN : Object;
	static public var IS_MUTED : Object;
	static public var IS_OFFLINE : Object;
	static public var ICO_KILLED : Object;
	static public var ICO_OFFLINE : Object;
	static public var ICO_IN_BATTLE : Object;

	public function PlayerStatus();

	static public function getStatusColorSchemeNames(isUnknown, isAlive, selected, squad, isTeamKiller, VIP, isOffline);

}