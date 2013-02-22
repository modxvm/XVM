/**
 * Helper class for shared functions used for loading user data in the hangar
 */
import wot.utils.Cache;
import wot.utils.GlobalEventDispatcher;
import wot.utils.StatLoader;
import wot.utils.Utils;

class wot.Helpers.UserDataLoaderHelper
{
    public static function LoadUserData(value, isId, loop)
    {
        if (!loop)
          loop = 0;
        // start loading after random period 50..100 ms
        _global.setTimeout
        (
            function() {
                // avoid concurrent loading
                if (GlobalEventDispatcher.getEventListenersCount("userdata_loaded") == 0)
                {
                    GlobalEventDispatcher.addEventListener("userdata_loaded",  UserDataLoaderHelper.onUserDataLoaded);
                    StatLoader.LoadUserData(value, isId);
                }
                else
                {
                    UserDataLoaderHelper.LoadUserData(value, isId, loop + 1);
                }
            },
            50 + Math.random() * 50;
        );
    }

    private static function onUserDataLoaded(event)
    {
        GlobalEventDispatcher.removeEventListener("userdata_loaded", UserDataLoaderHelper.onUserDataLoaded);
        if (!event.data || !event.data[0])
            return;
        //Logger.addObject(event.data, "data", 3);
        var fixedData = UserDataLoaderHelper.FixData(event.data[0]);

        Cache.Get("INFO#" + event.data[0]._id, function() { return fixedData; });
        Cache.Get("INFO@" + event.data[0].nm, function() { return fixedData; });
        GlobalEventDispatcher.dispatchEvent( { type: "userdata_cached" } );

        //Logger.addObject(stat, "stat", 3);
    }

    private static function FixData(ud)
    {
        // GWR
        ud.r = ud.b > 0 ? Math.round(ud.w / ud.b * 100) : 0;

        // xeff
        if (ud.e != null)
            ud.xeff = Utils.XEFF(ud.e);

        // xwn
        if (ud.wn != null)
            ud.xwn = Utils.XWN(ud.wn);

        return ud;
    }
}
