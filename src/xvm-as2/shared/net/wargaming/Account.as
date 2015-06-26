intrinsic class net.wargaming.Account
{
	static public var _nations : Object;
	static public var ACCOUNT_ATTR : Object;
	static public var accountAttrs : Object;
	static public var denunciationsCount : Object;
	static public var initialized : Object;
	static public var callBackHash : Object;
	static public var initialValues : Object;

	static public function get attrs() : Object;

	static public function get denunciations() : Object;

	static public function get nations() : Object;


	public function Account();

	static public function __addCallBack(type, scope, callBack);

	static public function addCreditsCallBack(scope, callBack);

	static public function addPremiumCallBack(scope, callBack);

	static public function addGoldCallBack(scope, callBack);

	static public function addExperienceCallBack(scope, callBack);

	static public function addVehicleChangeCallBack(scope, callBack);

	static public function addPlayerSpeakingCallBack(scope, callBack);

	static public function addTankmanChangeCallBack(scope, callBack);

	static public function initialize();

	static public function setAccountAttrs(value);

	static public function setDenunciations(value);

	static public function setExp(value);

	static public function setCredits(value);

	static public function setGold(value);

	static public function setPremium(value);

	static public function setVehicleChange(value);

	static public function setTankmanChange(tankmanID);

	static public function setPlayerSpeaking(dbID, isSpeak, isSelf);

	static public function setNations();

	static public function notifyCallbacks(type, value);

	static public function setInitialValue(type, value);

}