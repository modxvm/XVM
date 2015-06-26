intrinsic class net.wargaming.tutorial.items.BattleTasks extends gfx.core.UIComponent
{
	public var headerMc : Object;
	static public var FLAG_DONE : Object;
	static public var FLAG_IN_PROGRESS : Object;
	static public var FLAG_NO_STATUS : Object;
	static public var ANIM_STATUS_HIDING : Object;
	static public var ANIM_STATUS_SHOWING : Object;
	static public var ANIM_STATUS_HIDE : Object;
	static public var ANIM_STATUS_SET : Object;
	static public var ANIM_STATUS_NONE : Object;
	static public var ICO_OFFSET : Object;
	public var _headerStr : Object;
	public var _headerStrSeted : Object;
	public var _headerNum : Object;
	public var _headerNumSeted : Object;
	public var _headerAnimStatus : Object;
	public var needChangeHeader : Object;
	public var _taskStr : Object;
	public var _taskStrSeted : Object;
	public var _taskStatus : Object;
	public var _taskFlag : Object;
	public var _taskFlagStatus : Object;
	public var flagIsChangedAlphaOnly : Object;
	public var needChangeTask : Object;
	public var _taskId : Object;
	public var _taskIdSeted : Object;
	public var _hintStr : Object;
	public var _hintStrSeted : Object;
	public var _hintStatus : Object;
	public var _img : Object;
	public var _altImg : Object;
	public var needChangeHint : Object;
	public var _hintId : Object;
	public var _hintIdSeted : Object;
	public var chapterPos : Object;
	public var taskPos : Object;
	public var hintPos : Object;
	public var offsetY : Object;
	public var _w : Object;
	public var _h : Object;

	public function BattleTasks();

	public function configUI();

	public function init();

	public function reset();

	public function draw();

	public function setChapter(num, str);

	public function resetChapter();

	public function hideChapter();

	public function showChapter();

	public function headerTweenComplete();

	public function setChapterData();

	public function getHtmlStrForChapter(headerNum, headerStr);

	public function setTask(str, flag, taskID);

	public function startAnimTask();

	public function resetTask();

	public function hideTask();

	public function showTask();

	public function taskMcTweenComplete();

	public function setTaskData();

	public function changeFlag();

	public function startFXAnim();

	public function finishedAnimTaskDone();

	public function hideFlag();

	public function showFlag();

	public function flagTweenComplete();

	public function setFlagData();

	public function getIcoMcTaskFlag();

	public function getTaskFlag(flag);

	public function setHint(str, img, altImg, hintID);

	public function changeHint();

	public function hideHint();

	public function showHint();

	public function hintTweenComplete();

	public function setHintData();

	public function changeHintPos();

	public function rescaleBg();

	public function changeImage();

	public function hidePicture();

	public function showPicture();

	public function pictureTweenComplete();

	public function setPictureData();

	public function updateSize(w, h);

}