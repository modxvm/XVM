intrinsic class net.wargaming.tutorial.TutorialLoader extends gfx.controls.UILoader
{
	public var __get__content : Object;
	public var intervatID : Object;
	public var battleWidth : Object;
	public var battleHeight : Object;
	public var gc_onLoadComplete : Object;
	public var gc_getScreenSize : Object;

	public function TutorialLoader();

	public function update(width, height);

	public function loadTutorial(source);

	public function unloadTutorial(isItemsRevert);

	public function onLoadComplete();

	public function waitLayoutInit();

}