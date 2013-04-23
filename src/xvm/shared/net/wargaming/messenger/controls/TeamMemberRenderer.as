intrinsic class net.wargaming.messenger.controls.TeamMemberRenderer extends gfx.controls.Button
{
    var data;
    var vehicleLevelField;
    var commander_icon;
    var status_icon;
    var vehicle_type_icon;
    var textField;
    var vehicleNameField;
    var numberField;
    var owner;

    function configUI();
    function afterSetData();
    function getToolTipData();
    function updateAfterStateChange();
}
