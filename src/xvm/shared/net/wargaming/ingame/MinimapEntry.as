import gfx.core.UIComponent;

intrinsic class net.wargaming.ingame.MinimapEntry extends UIComponent
{
    var markMC:MovieClip;
    var entryName; /** ally/enemy/squad/"" */
    var isPostmortem;
    var isDeadPermanent;
    var isDead;
    var vehicleClass;
    var selfIcon:MovieClip;
    var m_type:String; /** ally enemy points*/
    var teamPoint:MovieClip; /** Clip is present if entry is capture base */
    
    function init(markerType, entryName, vehicleClass, markLabel);
    function MinimapEntry();
    function lightPlayer(visibility);
    function setDead(isPermanent);
    function setPostmortem(isPostmortem)
    function updateIfEntryIsPlayer();
    //function invalidate();
}