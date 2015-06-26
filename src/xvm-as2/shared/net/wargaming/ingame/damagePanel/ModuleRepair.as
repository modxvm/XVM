intrinsic class net.wargaming.ingame.damagePanel.ModuleRepair extends gfx.core.UIComponent
{
	public var data : Object;
	public var repairIntervalID : Object;
	static public var repairLastFrame : Object;
	static public var repairStartFrame : Object;
	public var repairCurFrame : Object;
	public var _state : Object;

	public function ModuleRepair();

	public function handleEntityState(state);

	public function startRepairProgress(entityName, progress, secondsLeft);

	public function stopRepairProgress();

	public function repair();

	public function correctCurRepairFrame(progress);

	public function setState(newState, isPlay);

	public function clearRepairInterval(state);

}