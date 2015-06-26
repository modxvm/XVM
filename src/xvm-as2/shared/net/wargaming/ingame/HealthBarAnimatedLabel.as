intrinsic class net.wargaming.ingame.HealthBarAnimatedLabel extends net.wargaming.ingame.HealthBarAnimatedPart
{
	public var tweenState : Object;
	public var _imitation : Object;
	public var _imitationFlag : Object;
	public var _m_entityName : Object;
	public var beforeLastHit : Object;

	public function get fakeDamage() : Object;
	public function set fakeDamage(val) : Void;

	public function get imitationFlag() : Object;
	public function set imitationFlag(val) : Void;

	public function get imitation() : Object;
	public function set imitation(val) : Void;


	public function HealthBarAnimatedLabel();

	public function configUI();

	public function damage(dmg, flag);

	public function draw();

	public function imitationDamage(imitation, dmg, flag);

	public function setup(m_entityName);

}