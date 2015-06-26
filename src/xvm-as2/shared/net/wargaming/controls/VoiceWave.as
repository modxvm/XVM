intrinsic class net.wargaming.controls.VoiceWave extends gfx.core.UIComponent
{
	public var mutedClip : Object;
	public var _speak : Object;
	public var _muted : Object;

	public function VoiceWave();

	public function configUI();

	public function isSpeak();

	public function setSpeaking(isSpeak, farcedStop);

	public function isMuted();

	public function setMuted(isMuted);

}