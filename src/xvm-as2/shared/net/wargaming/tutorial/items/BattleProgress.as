intrinsic class net.wargaming.tutorial.items.BattleProgress extends gfx.core.UIComponent
{
	public var separateTemp : Object;
	static public var PHASE_DONE : Object;
	static public var PHASE_FAIL : Object;
	static public var PHASE_NONE : Object;
	static public var MASK : Object;
	static public var progressDoneLineYOffset : Object;
	public var _separatesUI : Object;
	public var _curPhase : Object;
	public var _allPhases : Object;
	public var _phasesUI : Object;
	public var _phaseStatusMask : Object;
	public var phaseLen : Object;
	public var _allTasks : Object;
	public var _tasksUI : Object;
	public var _taskForPhase : Object;
	public var linkageProgressItemAnim : Object;
	public var linkageSeparate : Object;

	public function BattleProgress();

	public function configUI();

	public function draw();

	public function populateUI(curPhase, allPhases);

	public function setPhases(phaseMask);

	public function rebuildPhases();

	public function setupPhases();

	public function setTasks(allTasks, tasksStatusMask);

	public function setupTasks();

	public function rebuildTasks();

	public function getLineStatus(n);

	public function clearMovieFromArray(arr);

}