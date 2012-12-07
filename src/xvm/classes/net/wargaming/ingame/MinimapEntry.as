import gfx.core.UIComponent;

intrinsic class net.wargaming.ingame.MinimapEntry extends UIComponent
{
    var markMC:MovieClip;
    var entryName; /** ally/enemy/squad/"" */
    var isPostmortem;
    var isDeadPermanent;
    
    function lightPlayer(visibility);
    function setDead(isPermanent);
    function updateIfEntryIsPlayer();
}