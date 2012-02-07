class net.wargaming.ingame.DamagePanelItem extends gfx.core.UIComponent
{
    var hitTest, gotoAndPlay, __get__toolTipData, onRollOver, onRollOut, onPress, __set__toolTipData;
    function DamagePanelItem()
    {
        super();
    } // End of the function
    function invalidateData(entityName, newState)
    {
        if (m_entityName != entityName)
        {
            return;
        } // end if
        if (m_state != newState)
        {
            m_state = newState;
            if (this.hitTest(_root._xmouse, _root._ymouse, true))
            {
                net.wargaming.managers.ToolTipManager.setContent(this._getToolTipData());
            } // end if
            this.gotoAndPlay(m_state);
        } // end if
    } // End of the function
    function removeTooltip()
    {
        this._destroyToolTip();
    } // End of the function
    function get toolTipData()
    {
        return (m_toolTipData);
    } // End of the function
    function set toolTipData(value)
    {
        m_toolTipData = value;
        //return (this.toolTipData());
        null;
    } // End of the function
    function configUI()
    {
        onRollOver = _createToolTip;
        onRollOut = _destroyToolTip;
        super.configUI();
        onPress = handleMousePress;
    } // End of the function
    function _createToolTip()
    {
        if (m_toolTipData)
        {
            net.wargaming.managers.ToolTipManager.show(this._getToolTipData(), m_toolTipInitProps);
        } // end if
    } // End of the function
    function _destroyToolTip()
    {
        net.wargaming.managers.ToolTipManager.hide();
    } // End of the function
    function _getToolTipData()
    {
        if (m_state == "repaired")
        {
            m_state = "critical";
        } // end if
        return (m_toolTipData + "/" + m_state);
    } // End of the function
    function handleDamageIconClick(entityName, state)
    {
    } // End of the function
    function handleMousePress(mouseIndex, button)
    {
        if (m_entityName.length > 0 && this.hitTest(_root._xmouse, _root._ymouse, true))
        {
            this.handleDamageIconClick(m_entityName, m_state);
        } // end if
    } // End of the function
    var m_toolTipInitProps = {_delay: 0.500000, _leftMargin: 10, _rightMargin: 10, _topMargin: 10, _bottomMargin: 10};
    var m_state = "normal";
    var m_entityName = "";
    var m_toolTipData = "";
} // End of Class
