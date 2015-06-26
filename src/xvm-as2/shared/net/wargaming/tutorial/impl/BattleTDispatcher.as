intrinsic class net.wargaming.tutorial.impl.BattleTDispatcher implements net.wargaming.tutorial.interfaces.ITutorialDispatcher
{
	public var context : Object;

	public function BattleTDispatcher(context);

	static public function refuse();

	public function setup(config, level);

	public function setChapterInfo(title, description);

	public function clearChapterInfo();

	public function setRunMode();

	public function setRestartMode();

	public function setDisabled(flag);

}