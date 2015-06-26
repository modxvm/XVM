intrinsic class net.wargaming.ingame.HealthBar extends gfx.core.UIComponent
{
	public var _entityName : Object;
	public var _frameLabel : Object;
	public var _maxHealth : Object;
	public var _curHealth : Object;
	public var _isSplashRunning : Object;
	public var HEALTH_BAR_WIDTH : Object;

	public function get maxHealth() : Object;
	public function set maxHealth(value) : Void;

	public function get curHealth() : Object;
	public function set curHealth(value) : Void;

	public function get isSplashRunning() : Object;

	public function get entityName() : Object;
	public function set entityName(val) : Void;

	public function get frameLabel() : Object;
	public function set frameLabel(val) : Void;


	public function HealthBar();

	public function reset(maxValue, curValue);

	public function validateCurValue();

	public function updateHealth(val, flag);

	public function configUI();

	public function draw();

	public function onSplashVisible();

	public function onSplashHidden();

	public function fakeHit(maxVal);

	public function getVisibleWidth();

	public function getXforHealth(health, floor);

	public function updateHealthBar();

	public function setLabel();

}
