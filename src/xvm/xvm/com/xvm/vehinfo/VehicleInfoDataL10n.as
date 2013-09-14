/**
 * @author Mr.A
 * @author Pavel Máca
 */
package com.xvm.vehinfo
{
    import com.xvm.Logger;

    public class VehicleInfoDataL10n
    {
        /////////////////////////////////////////////////////////////////
        // PUBLIC STATIC

        // key: "Obj. 907"
        // value: "object_907"
        public static function get data():Object
        {
            try
            {
                if (_localizedNameList == null)
                    initData();
                return _localizedNameList;
            }
            catch (e:Error)
            {
                Logger.add(e.getStackTrace());
            }
            return null;
        }

        /** TODO: for minimap (no need now) & fix issue #484
           // localizedName = "Obj. 907"
           // return: "ussr_Object_907"
           public static function getVehicleNationName(localizedName:String):String
           {
           if (VehicleInfoData2.data[localizedData[localizedName]].nation != null && VehicleInfoData2.data[localizedData[localizedName]].name != null)
           return VehicleInfoData2.data[localizedData[localizedName]].nation + "_" + VehicleInfoData2.data[localizedData[localizedName]].name.split("-").join("_");
           return "";
           }
         */

        /////////////////////////////////////////////////////////////////
        // PRIVATE

        private static var _localizedNameList:Object = null;

        private static function initData():void
        {
            _localizedNameList = {};

            // ~30ms
            for (var tankKey:String in VehicleInfoData2.data)
            {
                if (!VehicleInfoData2.data.hasOwnProperty(tankKey))
                    continue

                var translationKey:String = VehicleInfoData2.data[tankKey].translationKey;

                /** TODO: for minimap (no need now) & fix issue #484
                   if transKey.lastIndexOf("_short") > -1
                   {
                   var name:String = Localization.makeString(transKey.slice(0, -6), { } );
                   _localizedNameList[name] = tankKey;
                   }
                 */

                var shortName:String = App.utils.locale.makeString(translationKey, {});
                _localizedNameList[shortName] = tankKey;
            }
        }
    }
}
