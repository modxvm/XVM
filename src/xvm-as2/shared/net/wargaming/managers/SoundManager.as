intrinsic class net.wargaming.managers.SoundManager extends MovieClip
{
	static public var _instance : Object;

	public function SoundManager();

	static public function playSound(state, type, id);

	public function soundEventHandler(state, type, id);

}