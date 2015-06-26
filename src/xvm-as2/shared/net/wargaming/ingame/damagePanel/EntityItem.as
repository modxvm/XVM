intrinsic class net.wargaming.ingame.damagePanel.EntityItem extends gfx.core.UIComponent
{
	public var initialized : Object;
	public var invalidateSavedDataName : Object;
	public var invalidateSavedDataState : Object;
	public var m_toolTipInitProps : Object;
	public var m_state : Object;
	public var m_entityName : Object;
	public var m_toolTipData : Object;

	public function get toolTipData() : Object;
	public function set toolTipData(value) : Void;

	public function get entityName() : Object;


	public function EntityItem();

	public function invalidateData(entityName, newState, forced);

	public function startRepairProgress(entityName, progress, secondsLeft);

	public function removeTooltip();

	public function configUI();

	public function _createToolTip();

	public function _destroyToolTip();

	public function _getToolTipData();

	public function handleDamageIconClick(entityName, entityState);

	public function handleMousePress(mouseIndex, button);

	public function handleMouseRollOver(mouseIndex, nestingIdx);

	public function handleMouseRollOut(mouseIndex, nestingIdx);

}