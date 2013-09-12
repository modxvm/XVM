/**
 * XVM Config
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm
{
    public class Config
    {
		// instance
		private static var _instance:Config = null;
		private static function get instance():Config
		{
			if (_instance == null)
				_instance = new Config();
			return _instance;
		}
		
        public static function get config():Object
        {
            return instance.config;
        }

        public static function set config(o:Object):void
        {
            instance.config = o;
        }

        // PRIVATE

        private var config:Object;
    }
}
