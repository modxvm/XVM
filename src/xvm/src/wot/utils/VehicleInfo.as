/**
 * ...
 * @author sirmax2
 */
import wot.utils.Utils;
import wot.utils.VehicleInfoData;

class wot.utils.VehicleInfo
{
  // icon = ../maps/icons/vehicle/contour/usa-M24_Chaffee.tga
  public static function getName(str: String): String
  {
    // str is icon path?
    if (Utils.endsWith(".png", str))
      str = str.slice(str.lastIndexOf("/") + 1, str.lastIndexOf("."));
    str = str.split("-").join("_");
    str = Utils.trim(str);
    return str;
  }

  public static function getVehicleId(str: String): String
  {
    if (Utils.endsWith(".png", str))
    {
      str = str.slice(str.lastIndexOf("/") + 1, str.lastIndexOf("."));
      str = str.slice(str.indexOf("-") + 1);
      str = Utils.trim(str);
      return str.toUpperCase();
    }
    return null;
  }

  public static function getInfo(str: String): Object
  {
    return VehicleInfoData.data[getName(str)] || null;
  }
}
