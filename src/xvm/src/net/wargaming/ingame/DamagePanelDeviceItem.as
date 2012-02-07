class net.wargaming.ingame.DamagePanelDeviceItem extends net.wargaming.ingame.DamagePanelItem
{
    var m_entityName;
    function DamagePanelDeviceItem()
    {
        super();
    } // End of the function
    function configUI()
    {
        super.configUI();
        if (deviceName != "N/A")
        {
            m_entityName = deviceName;
        } // end if
    } // End of the function
    function handleDamageIconClick(entityName, entityState)
    {
        gfx.io.GameDelegate.call("battle.damagePanel.onClickToDeviceIconButon", [entityName, entityState]);
    } // End of the function
    var deviceName = "N/A";
} // End of Class
