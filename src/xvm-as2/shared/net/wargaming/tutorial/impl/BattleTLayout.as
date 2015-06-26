intrinsic class net.wargaming.tutorial.impl.BattleTLayout extends net.wargaming.tutorial.TutorialLayout
{
	public var areasManager : Object;

	public function get dispatcher() : Object;


	public function BattleTLayout();

	public function configUI();

	public function startAnimTaskDone(e);

	public function continueAnimTaskDone(e);

	public function finishAnimTaskDone1();

	public function populateProgressBar(currentChapter, totalChapters);

	public function setTrainingProgressBar(mask);

	public function setChapterProgressBar(totalSteps, mask);

	public function setSize(width, height);

	public function clearStage();

}