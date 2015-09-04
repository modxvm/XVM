intrinsic class net.wargaming.BattleStatItemRenderer extends net.wargaming.controls.TextFieldShort
{
    static var IGR_ICON_OFFSET_LEFT;
    static var IGR_ICON_OFFSET_RIGHT;

    var playerName:TextField;
    var col3:TextField;
    var data:Object;
    var iconLoader: net.wargaming.controls.UILoaderAlt;
    var owner;
    var squad;
    var vehicleLevelIcon;
    var vehicleTypeIcon;
    var frags;
    var icoIGR;

    function get selected();

    function updateData();
    function applyData();
    function updateState();
}
