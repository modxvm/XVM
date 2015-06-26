intrinsic class net.wargaming.managers.ToolTipManager
{
	public var tooltip_mc : Object;
	static public var __get__instance : Object;
	static public var converter : Object;
	public var _useWheel : Object;
	public var getProfileAchievementData : Object;
	public var getBattleResultsAchievementData : Object;
	public var getProfileRareAchievementData : Object;
	public var getTankmanData : Object;
	public var getCarouselVehicleData : Object;
	public var getInventoryVehicleData : Object;
	public var getInventoryShellData : Object;
	public var getInventoryModuleData : Object;
	public var getShopVehicleData : Object;
	public var getShopShellData : Object;
	public var getShopModuleData : Object;
	public var getHangarShellData : Object;
	public var getTechMainShellData : Object;
	public var getTechMainModuleData : Object;
	public var getHangarModuleData : Object;
	public var getTankmanSkillData : Object;
	public var getEfficiencyParam : Object;
	public var getChinaNewsData : Object;
	public var getSettingsControlData : Object;
	static public var BLOCK_ORDER : Object;
	static public var BLOCK_TAGS_MAP : Object;

	static public function get instance() : Object;


	public function ToolTipManager();

	public function showChinaNews(header, discription);

	public function showTankman(tankmanID, isCurrentVehicle);

	public function getBattleStatsAchievementData(achieveName, value);

	public function showAchievement(doosierType, dossierCompDescr, achieveName, isRare, isVehicleList);

	public function showTankClass(rank);

	public function showCarouselVehicle(vehicleID);

	public function showInventoryVehicle(vehicleID);

	public function showInventoryShell(compact, sellPrice, sellCurrency, invCount);

	public function showInventoryModule(compact, sellPrice, sellCurrency, invCount, vehCount);

	public function showTechMainModule(compact, buyPrice, invCount, vehCount, slotIdx, eqsUnlocks);

	public function showHangarModule(compact, buyPrice, invCount, vehCount, slotIdx);

	public function showShopVehicle(compact);

	public function showShopShell(compact, invCount);

	public function showHangarShell(compact, invCount, vehCount);

	public function showTechMainShell(compact, buyPrice, invCount, vehCount);

	public function showShopModule(compact, invCount, vehCount);

	public function showTankmanSkill(skillName, tankmanID);

	public function showTankmanNewSkill(tankmanID);

	public function showEfficiencyParam(kind, disabled, vals);

	public function showSettingsControl(controlID);

	public function show(string, initProps);

	public function showType(tooltipType, string, initProps);

	public function __getTags(block_type, format_type);

	public function __getFormattedText(text, block_type, format_type);

	public function __getToolTipFromText(string, props);

	public function __getToolTipFromKey(key, props);

	public function showComplex(str, props);

	public function hide();

	public function setContent(content);

}