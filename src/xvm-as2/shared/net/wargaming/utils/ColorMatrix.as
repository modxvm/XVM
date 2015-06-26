intrinsic class net.wargaming.utils.ColorMatrix extends Array
{
	public var _loc2 : Object;
	public var DELTA_INDEX : Object;
	public var IDENTITY_MATRIX : Object;
	public var LENGTH : Object;

	public function ColorMatrix(p_matrix);

	public function reset();

	public function adjustColor(p_brightness, p_contrast, p_saturation, p_hue);

	public function adjustBrightness(p_val);

	public function adjustContrast(p_val);

	public function adjustSaturation(p_val);

	public function adjustHue(p_val);

	public function concat(p_matrix);

	public function clone();

	public function toString();

	public function toArray();

	public function copyMatrix(p_matrix);

	public function multiplyMatrix(p_matrix);

	public function cleanValue(p_val, p_limit);

	public function fixMatrix(p_matrix);

}