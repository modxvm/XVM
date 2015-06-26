intrinsic class net.wargaming.SettingsDialog extends net.wargaming.Dialog
{
	public var config : Object;
	static public var dialogApplyContent : Object;
	static public var is_need_to_apply_settings : Object;
	static public var is_need_to_apply_settings_dont_closed : Object;
	static public var viewData : Object;
	static public var defaultData : Object;
	static public var pendingSettings : Object;
	static public var isSubmitBtnClick : Object;
	public var isChanged : Object;
	public var isInited : Object;
	static public var __currentPage : Object;
	static public var __currentSubPage : Object;
	public var needViewReload : Object;
	public var isVoiceTestStarted : Object;
	public var voiceTestTimoutID : Object;
	public var voiceTestTimerID : Object;
	static public var UNCHECK_VOICE_TEST_BTN_TIMEOUT : Object;
	static public var SETTINGS_TAB_SELECTED : Object;
	static public var settingsDialogSource : Object;
	public var altVoicesPreview : Object;
	public var isSoundModeValid : Object;
	public var __dont_hide_tooltip : Object;
	public var lastVarHorStabilizationSnp : Object;
	public var graphicsQualityHDSDVal : Object;
	static public var GRAPHICS_QUALITY_HDSD_ID : Object;

	public function get currentView() : Object;


	public function SettingsDialog();

	static public function show();

	static public function killDialog(event);

	public function getReopenCallerObject();

	public function handleInput(details, pathToFocus);

	public function buildGraphicsData(graficsData);

	public function buildData(qualitySettings, configData, keyboard, mouse);

	static public function setDefault();

	public function applyCloseSettings(event);

	static public function oncontrolsWrongNotificationClose(args);

	static public function onsoundModeInvalidClose(args);

	static public function oncontrolsWrongNotificationsoundModeInvalidClose(args);

	static public function onWrongNotificationSubmit(event);

	static public function onWrongNotificationSubmitForApply(event);

	public function onApplyClose(args);

	public function cancelSettings(event);

	public function collectPendingSettings();

	public function populatePendingSettings();

	public function __checkControlsSettings();

	public function tryApplySettings(event);

	public function applySettings(event);

	static public function confirmApplySettings();

	static public function onApplyDelayConfirm(event);

	static public function onApplyDelayCancel(event);

	static public function onDialogInit(event);

	static public function clearPendingSettings(event);

	static public function commitSettings(event);

	static public function delaySettings(event);

	public function autodetectQuality(event);

	public function onVoiceChatEnabledSelect(args);

	public function showPTTTooltip(args);

	public function hideTooltip(args);

	public function setCursorView(currentSubPage);

	public function updateMarkersView();

	public function setVivoxMicVolume(args);

	public function onColorBlindChange(args);

	public function onDynamicCameraChange(args);

	public function onVoiceTestProcess(args);

	public function __setVoiceTestState(isStarted);

	public function onVoiceTestResponse();

	public function __checkVoiceTest();

	public function setControlsDefaults(args);

	public function __checkVoiceButton(args);

	public function onTabsChanged(args);

	public function defferendViewUpdate();

	public function viewLoaded();

	public function populateUI();

	public function updateTabs(vibroIsEnabled);

	public function onUpdateCaptureDevices();

	public function setPreset(presetId);

	public function onCaptureDevicesBtnClick(args);

	public function onTestAlternativeVoicesButton(args);

	public function onTestAlternativeVoicesButtonOver(args);

	public function onVibroManagerConnect();

	public function onVibroManagerDisconnect();

	public function doVibroManagerConnect(isOn);

	public function showAlternativeVoices(isShow);

	public function handleClickFullScreenCheckbox(event);

	public function handleMonitorChange(event);

	public function handleSizeChange(event);

	public function proccessRENDER_PIPELINE();

	public function findGraphicControl(label, labelAsControl);

	public function handleChangeQuality(event);

	public function handleChangeQualityPreset(event);

	public function handleChangeDynamicFov(event);

	public function handleChangeVertSync(event);

	public function handleChange(event);

	public function setLastSubPage(subPageNum);

	static public function setCurrentPage(pageNum);

	public function dialogIsCreated();

	public function dialogDispose();

}