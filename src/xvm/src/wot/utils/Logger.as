import wot.utils.Comm;
import wot.utils.Defines;
import wot.utils.Sandbox;
import wot.utils.Utils;

class wot.utils.Logger
{
    public static var counter: Number = 0;

    public static var dummy; // avoid import warning

    public static function add(str: String)
    {
        try
        {
            Comm.SyncEncoded(Defines.COMMAND_LOG, "[" + Sandbox.GetCurrentSandboxPrefix() + ":" + Utils.padLeft(String(counter++), 3, '0') + "] " + str);
        }
        catch (e)
        {
            // quiet
        }
    }

    public static function addObject(obj: Object, name: String, depth: Number)
    {
        if (isNaN(depth) || depth < 1)
            depth = 1;
        if (depth > 10)
            depth = 10;
        add((name || "[obj]") + ": " + com.xvm.JSON.stringifyDepth(obj, depth));
    }
}
