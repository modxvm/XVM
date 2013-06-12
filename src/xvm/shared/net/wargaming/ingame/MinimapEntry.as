import gfx.core.UIComponent;

intrinsic class net.wargaming.ingame.MinimapEntry extends UIComponent
{
    /////////////////////////////////////////////////////////////////
    // XVM
    var xvm_worker:wot.Minimap.MinimapEntry;
    var xvm_attachments:MovieClip;
    /////////////////////////////////////////////////////////////////

    var markMC:MovieClip;
    var entryName; /** ally/enemy/squad/"" */
    var isPostmortem;
    var isDeadPermanent;
    var isDead;
    var vehicleClass;
    var selfIcon:MovieClip;
    var m_type:String; /** ally enemy points*/
    var teamPoint:MovieClip; /** Clip is present if entry is capture base */
    
    function configUI();
    function init(markerType, entryName, vehicleClass, markLabel);
    function showAction(markLabel);
    function update();
    function lightPlayer(visibility);
    function playPlayer();
    static function unhighlightLastEntry();
    function get colorsManager():net.wargaming.managers.ColorSchemeManager;
    function get colorSchemeName():String;
    function setEntryName(value);
    function setDead(isPermanent);
    function setPostmortem(isPostmortem);
    function isTeamPoint();
    function isBackMarker();
    function updateType();
    function updateIfEntryIsPlayer();
    function draw();
    function getMinimap():net.wargaming.ingame.Minimap;
}