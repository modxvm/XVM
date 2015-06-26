intrinsic class net.wargaming.dialogs.VehicleSellDialog extends net.wargaming.notification.MessageDialog
{
	public var complexDevice : Object;
	static public var dialogSource : Object;
	public var vehInvID : Object;
	public var creditsCommon : Object;
	public var goldCommon : Object;
	public var goldComplDev : Object;
	public var creditsComplDev : Object;
	public var tankPrice : Object;
	public var removePrice : Object;
	public var complexDevicesArr : Object;
	public var sell : Object;
	public var setDialogSettings : Object;
	public var getDialogSettings : Object;
	public var wasDrawn : Object;
	public var goldInvis : Object;

	public function VehicleSellDialog();

	public function configUI();

	public function handleClose(args);

	public function handleSubmit(event);

	public function startAnimation();

	public function draw();

	public function getDevHeight();

	public function wasDrawnHandler(e);

	static public function show(vehInvID);

	public function populateUI();

	public function setData(vehicle, modules, shells, removePrice);

	public function submitSellDialog();

	public function setInventory(modules, shells);

	public function setShells(vehicle);

	public function setEquipment(vehicle);

	public function setDevices(vehicle);

	public function setHeader(vehicle);

	public function updateMoneyResult(event);

	public function checkGold(value);

	public function changeGold(value);

	public function setGoldText(creditsCommon, goldCommon);

	public function showLevel(level);

	public function handleInput(details, pathToFocus);

}