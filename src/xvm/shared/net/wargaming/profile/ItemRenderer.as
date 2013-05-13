intrinsic class net.wargaming.profile.ItemRenderer extends gfx.controls.Button // net.wargaming.ComplexListItemRenderer
{
    var data;
    var textField:TextField;
    var fights:TextField;
    var wins:TextField;
    var vehicleClass;
    var vehicleIcon;

    function setup();
    function setData(data);
    function updateAfterStateChange();
}
