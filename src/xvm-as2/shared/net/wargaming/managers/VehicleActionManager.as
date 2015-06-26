intrinsic class net.wargaming.managers.VehicleActionManager
{
	static public var __ACTIONS : Object;

	static public function get allActions() : Object;


	public function VehicleActionManager();

	static public function getActionsObject();

	static public function getActions(team, bitMask);

	static public function proccessActions(teamActions, bitMask);

}