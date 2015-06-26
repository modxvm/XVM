intrinsic class gfx.utils.Constraints
{
	public var scope : Object;
	static public var LEFT : Object;
	static public var RIGHT : Object;
	static public var TOP : Object;
	static public var BOTTOM : Object;
	static public var ALL : Object;
	public var scaled : Object;

	public function Constraints(scope, scaled);

	public function addElement(clip, edges);

	public function removeElement(clip);

	public function getElement(clip);

	public function update(width, height);

	public function toString();

}