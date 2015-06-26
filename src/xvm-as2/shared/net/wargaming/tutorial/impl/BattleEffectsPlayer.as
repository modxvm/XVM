intrinsic class net.wargaming.tutorial.impl.BattleEffectsPlayer implements net.wargaming.tutorial.interfaces.IEffectsPlayer
{
	public var context : Object;
	public var currentTaskID : Object;
	public var currentHintID : Object;
	public var chapterTitle : Object;
	public var chapterDescription : Object;
	public var isGreetingShow : Object;

	public function BattleEffectsPlayer(context, dialogSources);

	public function play(effectName, args);

	public function stop(effectName, id);

	public function stopAll();

	public function destroy();

	public function onStageSizeChanged();

	public function showGreeting(targetID, title, description);

	public function showChapterInfo(title, description);

	public function showNextTask(taskID, text, prevDone);

	public function showHint(hintID, text, imagePath, imageAltPath);

	public function showDialog(props);

	public function hideGreeting(targetID);

	public function closeDialog(dialogID);

	public function handleSubmitDialog(event);

	public function handleCloseDialog(event);

}