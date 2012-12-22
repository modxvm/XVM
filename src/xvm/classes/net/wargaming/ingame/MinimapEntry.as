import gfx.core.UIComponent;

intrinsic class net.wargaming.ingame.MinimapEntry extends UIComponent
{
    var markMC:MovieClip;
    var entryName; /** ally/enemy/squad/"" */
    var isPostmortem;
    var isDeadPermanent;
    var isDead;
    var vehicleClass;
    
    function init(markerType, entryName, vehicleClass, markLabel);
    function MinimapEntry();
    function lightPlayer(visibility);
    function setDead(isPermanent);
    function setPostmortem(isPostmortem)
    function updateIfEntryIsPlayer();
    //function invalidate();
}