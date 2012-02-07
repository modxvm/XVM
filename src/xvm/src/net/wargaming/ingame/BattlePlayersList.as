class net.wargaming.ingame.BattlePlayersList extends gfx.controls.ScrollingList
{
    var renderers;
    function BattlePlayersList()
    {
        super();
    } // End of the function
    function setPlayerSpeaking(accountDBID, flag)
    {
        var _loc3 = renderers.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            if (renderers[_loc2].data.uid == accountDBID)
            {
                renderers[_loc2].speaking = flag;
                break;
            } // end if
        } // end of for
    } // End of the function
    function configUI()
    {
        super.configUI();
    } // End of the function
} // End of Class
