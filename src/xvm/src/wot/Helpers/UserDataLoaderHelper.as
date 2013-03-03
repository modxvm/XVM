/**
 * Helper class for shared functions used for loading user data in the hangar
 */
import wot.utils.Cache;
import wot.utils.GlobalEventDispatcher;
import wot.utils.StatLoader;
import wot.utils.Utils;

class wot.Helpers.UserDataLoaderHelper
{
    private static var queue:Array = [];
        
    public static function LoadUserData(value, isId)
    {
        //wot.utils.Logger.add("add queue: " + value);
        var found = false;
        for (var i = 0; i < queue.length; ++i)
        {
            if (queue[i].value == value && queue[i].isId == isId)
            {
                found = true;
                break;
            }
        }
        if (!found)
            queue.push({value:value, isId:isId});
        processQueue();
    }

    private static function processQueue()
    {
        if (queue.length == 0)
            return;
        // avoid concurrent loading
        if (GlobalEventDispatcher.getEventListenersCount("userdata_loaded") > 0)
            return;

        var item = queue.shift();
        //wot.utils.Logger.add("process queue: " + item.value);
        GlobalEventDispatcher.addEventListener("userdata_loaded",  UserDataLoaderHelper.onUserDataLoaded);
        StatLoader.LoadUserData(item.value, item.isId);
    }

    private static function onUserDataLoaded(event)
    {
        GlobalEventDispatcher.removeEventListener("userdata_loaded", UserDataLoaderHelper.onUserDataLoaded);
        if (!event.data || !event.data[0])
            return;
        //Logger.addObject(event.data, "data", 3);
        var fixedData = UserDataLoaderHelper.FixData(event.data[0]);

        Cache.Get("INFO#" + event.data[0]._id, function() { return fixedData; });
        Cache.Get("INFO@" + (event.request.isId == true ? event.data[0].nm : event.request.value), function() { return fixedData; });
        GlobalEventDispatcher.dispatchEvent( { type: "userdata_cached" } );

        //Logger.addObject(stat, "stat", 3);

        processQueue();
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
