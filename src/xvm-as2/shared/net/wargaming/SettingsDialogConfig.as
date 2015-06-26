intrinsic class net.wargaming.SettingsDialogConfig
{
	public var __get__OPTIONS_CONFIG : Object;
	static public var COLOR_GRADING_TECHNIQUE : Object;
	static public var DRR_AUTOSCALER_ENABLED : Object;
	static public var RENDER_PIPELINE : Object;
	static public var REFRESH_RATE_DEF_VALUE : Object;
	static public var DYNAMIC_RENDERER : Object;
	public var dynamicRendererPrevVal : Object;
	public var SKIP_VALUES : Object;
	public var advancedExtraControls : Object;
	public var graphicsPartsList : Object;
	public var DISABLED_VALUE : Object;
	public var mouseControlsList : Object;
	public var KEY_RANGE : Object;
	public var DATA_OPTIONS_CONFIG : Object;
	public var VIDEO_OPTIONS_CONFIG : Object;
	public var COLOR_FILTER_IMAGES : Object;
	public var COLOR_FILTER_IMAGES_KEY : Object;
	public var isDebug : Object;
	public var debugData : Object;
	public var debugVideo : Object;

	public function get OPTIONS_CONFIG() : Object;


	public function SettingsDialogConfig();

	public function initCurrentControls(current, viewData, eventScope);

	public function initMarkers(current, viewData, eventScope, tabIndex);

	public function updateView(dialog, currentView, viewData);

	public function getInterfaceScales(viewData);

	public function tryGetGuiElementLabelForGraphics(guiLabelKey);

	public function tryGetGuiElementForGraphicsTabs(guiKey);

	public function populateView(dialog, currentView, viewData);

	public function populateOptions(dialog, currentView, viewData);

	public function populateSliderExtend(dialog, guiElement, optKey, eventListener, viewData);

	public function onGraphicsTabChange(ev);

	public function controlsIsChanged(controlsView, viewData);

	public function getOptionGUIKey(option);

	public function getOptionGUILabelKey(option);

	public function isOptionValid(opt, settings);

	public function updateViewData(event, isInited, currentView, dialogView, viewData, defaultData);

	public function addTooltipEventsToControl(control);

	public function removeTooltipEventsFromControl(control);

	public function onCotrolOver(event);

	public function getControlId(controlName);

	public function searchSelectedIndexIfValueLabelOrData(serchedVal, options, isData);

	public function onCotrolOut(event);

	public function onCotrolClick(event);

	public function showToolTipForControl(controlId);

	public function getPresetIndex(indexId, presets);

}