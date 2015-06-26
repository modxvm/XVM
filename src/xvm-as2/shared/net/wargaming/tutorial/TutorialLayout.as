intrinsic class net.wargaming.tutorial.TutorialLayout extends gfx.core.UIComponent implements net.wargaming.tutorial.interfaces.ITutorialLayout
{
	public var tutorialMask : Object;
	public var areasManager : Object;
	public var itemsManager : Object;
	public var effectsPlayer : Object;
	public var resizeTimerID : Object;
	public var screenWidth : Object;
	public var screenHeight : Object;
	public var gc_proxyMouseClick : Object;

	public function get areas() : Object;

	public function get items() : Object;

	public function get effects() : Object;


	public function TutorialLayout();

	public function setSize(width, height);

	public function notifyMouseClicked(targetID);

	public function notifyMouseClicked2AA(targetID, areaID);

	public function getTargetMovie(targetString);

	public function findTargetByPath(path, startMovie);

	public function findTargetByCriteria(targetPath, valuePath, value);

	public function findChildrenValue(target, valuePath, value);

	public function convertTargetToPath(targetString);

	public function setDefaultInputHandler(clip);

	public function showMask(x, y, hitWidht, hitHeight);

	public function hideMask(mode);

	public function hideMaskImmediately();

	public function isGuiDialogOnStage();

	public function isTutorialDialogOnStage(dialogID);

	public function isTutorialWindowOnStage(windowID);

	public function clearStage();

	public function destroy(isRevertItems);

	public function configUI();

	public function draw();

	public function invalidateSize();

}