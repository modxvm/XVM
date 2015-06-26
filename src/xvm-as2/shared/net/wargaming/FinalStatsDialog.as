intrinsic class net.wargaming.FinalStatsDialog extends net.wargaming.Dialog
{
	public var closeBtn : Object;
	static public var menuSource : Object;

	public function FinalStatsDialog();

	static public function handleCloseWindow(event);

	static public function show();

	public function configUI();

	public function StatsDialog();

}