intrinsic class net.wargaming.controls.buttons.RadialButton extends gfx.controls.Button
{
	public var handleDragOver : Object;
	public var _angleSize : Object;
	public var _angleOffset : Object;
	public var _customOffset : Object;
	public var _currentIcon : Object;
	public var _sectorAngleSize : Object;
	public var _action : Object;

	public function get action() : Object;
	public function set action(value) : Void;

	public function get title() : Object;
	public function set title(value) : Void;

	public function get hotKey() : Object;
	public function set hotKey(value) : Void;

	public function get icon() : Object;
	public function set icon(value) : Void;

	public function get customOffset() : Object;
	public function set customOffset(value) : Void;


	public function RadialButton();

	public function configUI();

	public function invalidate();

	public function getAngle();

	public function setAngle(angle);

	public function getAngleSize();

	public function setAngleSize(angleSize);

	public function getSectorOffset();

	public function setSectorOffset(offset);

	public function getSectorAngleSize();

	public function setSectorAngleSize(sectorSize);

	public function show();

	public function update();

	public function rotateSector();

	public function updateAlign();

	public function setRightAlign(textField);

	public function updateHit();

	public function drawHitAsSector(hit);

	public function handleMousePress(mouseIndex, button);

	public function handleMouseRelease(mouseIndex, button);

	public function processDrawRadian(hit, startRad, endRad, size, step, reversed);

}
