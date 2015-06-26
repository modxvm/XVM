intrinsic class net.wargaming.controls.TankIcon extends gfx.core.UIComponent
{
	public var invalidate : Object;
	public var _favorite : Object;
	public var _favoriteDirty : Object;
	public var _showMultyXp : Object;
	public var _showMultyXpDirty : Object;
	public var _showXp : Object;
	public var _showXpDirty : Object;
	public var _showName : Object;
	public var _showNameDirty : Object;
	public var _nationDirty : Object;
	public var _nationNameDirty : Object;
	public var _imageDirty : Object;
	public var _tankTypeDirty : Object;
	public var _levelDirty : Object;
	public var _multyXpValDirty : Object;
	public var _xpVal : Object;
	public var _xpValDirty : Object;
	public var _tankNameDirty : Object;
	public var _isEliteDirty : Object;
	public var _isPremiumDirty : Object;
	public var DIRTY_FLAGS : Object;

	public function get favorite() : Object;
	public function set favorite(value) : Void;

	public function get showMultyXp() : Object;
	public function set showMultyXp(value) : Void;

	public function get showXp() : Object;
	public function set showXp(value) : Void;

	public function get showName() : Object;
	public function set showName(value) : Void;

	public function get nation() : Object;
	public function set nation(value) : Void;

	public function get nationName() : Object;
	public function set nationName(value) : Void;

	public function get image() : Object;
	public function set image(value) : Void;

	public function get tankType() : Object;
	public function set tankType(value) : Void;

	public function get level() : Object;
	public function set level(value) : Void;

	public function get multyXpVal() : Object;
	public function set multyXpVal(value) : Void;

	public function get xpVal() : Object;
	public function set xpVal(value) : Void;

	public function get tankName() : Object;
	public function set tankName(value) : Void;

	public function get isElite() : Object;
	public function set isElite(value) : Void;

	public function get isPremium() : Object;
	public function set isPremium(value) : Void;


	public function TankIcon();

	public function configUI();

	public function draw();

	public function updateTankType();

	public function updateMultyXp();

	public function updateTankName();

}