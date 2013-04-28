/**
{
  "canSell": true,
  "premium": false,
  "data": 1,
  "level": 5,
  "doubleXPReceived": -1,
  "stat": "undamaged",
  "nation": 2,
  "disabled": false,
  "elite": true,
  "favorite": true,
  "clanLock": null,
  "tankType": "mediumTank",
  "current": 3,
  "id": "(lp0\ncgui.Scaleform.utils.gui_items\nInventoryVehicle\np1\na(S'!\\x04\\t\\x00\\x0e\\x00\\xcb\\x00\\x02\\x00\\t\\x00\\x0b\\x00\\x07\\x19\\x00\\x12\\x00\\x15\\x00'\np2\nI76\n(lp3\nI161\naI163\naI164\naI165\naI166\natp4\na.",
  "exp": 0,
  "image": "../maps/icons/vehicle/usa-M4_Sherman.png",
  "stateLevel": "info",
  "label": "M4 Sherman",
  "inventoryId": 76,
  "compactDescr": 1057
}
 */
class wot.WGDataTypes.CarouselDataItem
{
    var level;
    var nation;
    var tankType;
    var image;
    var label;

    // icon = "../maps/icons/vehicle/contour/usa-M24_Chaffee.tga"
    // return: "M24_Chaffee"
    function get name()
    {
        return image.slice(image.lastIndexOf("/") + 1, image.lastIndexOf(".")).slice(image.indexOf("-") + 1);
    }
}
