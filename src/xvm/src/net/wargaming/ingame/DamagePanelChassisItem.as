class net.wargaming.ingame.DamagePanelChassisItem extends net.wargaming.ingame.DamagePanelItem
{
    var trackStates, m_state, m_entityName;
    function DamagePanelChassisItem()
    {
        super();
        trackStates = {leftTrack: "normal", rightTrack: "normal"};
    } // End of the function
    function invalidateData(entityName, state)
    {
        if (entityName != "leftTrack" && entityName != "rightTrack")
        {
            return;
        } // end if
        trackStates[entityName] = state;
        if (state == "critical" && m_state == "destroyed")
        {
            return;
        } // end if
        var _loc5 = entityName == "leftTrack" ? ("rightTrack") : ("leftTrack");
        if ((state == "repaired" || state == "normal") && trackStates[_loc5] == "destroyed")
        {
            return;
        } // end if
        super.invalidateData(deviceName, state);
    } // End of the function
    function configUI()
    {
        super.configUI();
        m_entityName = deviceName;
    } // End of the function
    function handleDamageIconClick(entityName, entityState)
    {
        if (entityState != "normal")
        {
            var _loc2 = trackStates.leftTrack != "normal" ? ("leftTrack") : (null);
            if (trackStates.rightTrack == "destroyed")
            {
                _loc2 = "rightTrack";
            } // end if
            if (_loc2.length > 0)
            {
                gfx.io.GameDelegate.call("battle.damagePanel.onClickToDeviceIconButon", [_loc2, entityState]);
            } // end if
        }
        else
        {
            gfx.io.GameDelegate.call("battle.damagePanel.onClickToDeviceIconButon", [deviceName, "normal"]);
        } // end else if
    } // End of the function
    var deviceName = "chassis";
} // End of Class
