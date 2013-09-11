/**
 * ...
 * @author sirmax2
 */
package utils
{
    import com.xvm.JSONx;
    
    import com.xvm.misc.DefaultConfig;
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
		
		public static function SimplifyConfig(config:Object):Object
		{
            //return config; // full config
			// clone config
			var cfg:Object = JSONx.parse(JSONx.stringify(config, "", true));
			return _simplifyConfig(cfg, DefaultConfig.config);
		}

		private static function _simplifyConfig(cfg:Object, def:Object):Object
		{
			for (var i:String in cfg)
			{
				if (i == "configVersion" || i == "editorVersion")
					continue;

				var value:* = cfg[i];
				if (value is Array)
				{
					var cfgStr:String = JSONx.stringify(cfg[i], "", true);
					var defStr:String = JSONx.stringify(def[i], "", true);
					if (cfgStr == defStr)
						delete cfg[i];
				}
				else if (typeof value == "object")
				{
					value = _simplifyConfig(cfg[i], def[i]);
					if (value == null)
						delete cfg[i];
				}
				else
				{
//                    if (def == null)
//                        return null;
					if (cfg[i] == def[i])
						delete cfg[i];
				}
			}

			var empty:Boolean = true;
			for (var x:String in cfg)
			{
				empty = false;
				break;
			}
			
			return empty ? null : cfg;
		}
    }
}
