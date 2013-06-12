/**
 * ...
 * @author sirmax2
 */
package utils
{
    import com.xvm.JSONx;
    
    import utils.Defines;
    import utils.Utils;

    public class ConfigUtilsEditor
    {
    	/**
    	 * Get config value
    	 */
    	public static function GetValue(path:String, root:Object = null):*
    	{
    		if (root == null)
    			root = Config.s_config;
    		if (!root)
    			return null;

    		var p:Array = path.split("."); // "path.to.value"
    		var valueElement:String = p.pop(); // last element is value

    		for each (var e:String in p)
    		{
    			// Create shild if not exist
    			if (!root.hasOwnProperty(e))
    				return undefined;
    			// Shift root to next child
    			root = root[e];
    		}

    		return root[valueElement];
    	}

    	/**
    	 * Set config value
    	 */
    	public static function SetValue(path:String, value:*, root:Object = null):void
    	{
    		if (root == null)
    			root = Config.s_config;
    		if (!root)
    			return;

    		var p:Array = path.split("."); // "path.to.value"
    		var valueElement:String = p.pop(); // last element is value

    		for each (var e:String in p)
    		{
    			// Create shild if not exist
    			if (!root.hasOwnProperty(e))
    				root[e] = new Object();
    			// Shift root to next child
    			root = root[e];
    		}

    		// Set value
//    		if (value === undefined)
//                delete root[valueElement];
            if (value === null || value === undefined) // FIXIT: why undefined presents?
    			root[valueElement] = null;
    		else if (typeof value == "object")
                root[valueElement] = com.xvm.JSONx.parse(com.xvm.JSONx.stringify(value)); // dereference
            else
                root[valueElement] = value;
    	}

    	public static function SetDefaultValue(path:String):Boolean
    	{
    		var defValue:Object = GetValue(path, DefaultConfig.config);
    		if (defValue == null)
    			return false;

			ConfigUtilsEditor.SetValue(path, defValue);
			ConfigUtils.TuneupConfig();
    		return true;
    	}
    }
}
