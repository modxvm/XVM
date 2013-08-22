import com.xvm.Comm;
import com.xvm.JSONx;
import com.xvm.Defines;
import com.xvm.Sandbox;
import com.xvm.Strings;

class com.xvm.Logger
{
    public static var counter: Number = 0;

    public static function add(str: String)
    {
        try
        {
            Comm.SyncEncoded(Defines.COMMAND_LOG, "[" + Sandbox.GetCurrentSandboxPrefix() + ":" + Strings.padLeft(String(counter++), 3, '0') + "] " + str);
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
        add((name || "[obj]") + ": " + JSONx.stringifyDepth(obj, depth));
    }
}
